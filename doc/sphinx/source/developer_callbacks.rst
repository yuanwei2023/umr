====================================
ASIC callbacks (MMIO, memory, waves)
====================================

Most of the ``libumrcore`` logic talks to hardware only through function
pointers stored on ``struct umr_asic`` in ``umr.h``.  The stock ``umr``
CLI discovers the ASIC, reads kernel ``debugfs`` configuration via
``umr_scan_config()``, and **then** assigns the Linux low-level helpers from
``src/lib/lowlevel/linux/`` (see ``get_asic()`` in ``src/app/main.c``).
Other programs (for example the remote client in ``src/lib/rumr/``,
the devcoredump path, or the test harness) replace some or all of the
same pointers with their own implementations.

This page summarizes what each callback group is for, what the core
library expects, and where to find working examples.

Split backends (guest UMR, RumR, custom RPC)
--------------------------------------------

If UMR cannot reach registers or VRAM directly (virtualization, blocked
MMIO, security policy), a common pattern is to **implement the same
function pointers** and forward each call to another process or machine
that owns the GPU.  The in-tree reference for that split is **RumR**:
``src/lib/rumr/client.c`` on the UMR side and ``src/lib/rumr/umr_server.c``
(and related files in ``src/lib/rumr/``) on the peer.  Treat RumR as a
worked example of serialization and ordering, not as the only transport—you
can swap the wire for virtio, vsock, or a vendor channel while keeping the
same callback contracts.

API shape (``src/umr.h``)
-------------------------

The hardware-facing hooks live as nested structures on ``struct umr_asic``.
The members below are the ones you normally populate after discovery; see
``src/umr.h`` for the full structure (options, file descriptors, PCI, XGMI,
and so on).

::

	struct umr_asic {
		/* ... discovery, blocks, options, fds, ... */
		struct umr_memory_access_funcs mem_funcs;
		struct umr_register_access_funcs reg_funcs;
		struct umr_wave_access_funcs wave_funcs;
		struct umr_shader_disasm_funcs shader_disasm_funcs;
		struct umr_read_gpr_funcs gpr_read_funcs;
		struct umr_mmio_accel_data *mmio_accel;
		struct umr_read_ring_func ring_func;
		uint32_t mmio_accel_size;
		int (*err_msg)(const char *fmt, ...);
		int (*std_msg)(const char *fmt, ...);
	};

The callback tables themselves are plain C structs of function pointers
(plus a shared ``void *data`` for backend state).  The following is an
abridged copy of the public API layout—field names and signatures match the
``struct umr_memory_access_funcs`` through ``struct umr_read_ring_func``
declarations in ``src/umr.h``:

::

	struct umr_memory_access_funcs {
		int (*access_sram)(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en);
		int (*access_linear_vram)(struct umr_asic *asic, uint64_t address, uint32_t size, void *data, int write_en);
		uint64_t (*gpu_bus_to_cpu_address)(struct umr_asic *asic, uint64_t dma_addr);
		int (*vm_message)(const char *fmt, ...);
		void (*va_addr_decode)(pde_fields_t *pdes, int num_pde, pte_fields_t pte);
		int (*read_vram)(struct umr_asic *asic, int partition, uint32_t vmid, uint64_t address, uint32_t size, void *data);
		void *data;
	};

	struct umr_register_access_funcs {
		uint32_t (*read_reg)(struct umr_asic *asic, uint64_t addr, enum regclass type);
		int (*write_reg)(struct umr_asic *asic, uint64_t addr, uint32_t value, enum regclass type);
		void *data;
	};

	struct umr_wave_access_funcs {
		int (*get_wave_status)(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws);
		int (*get_wave_sq_info)(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws);
		void *data;
	};

	struct umr_shader_disasm_funcs {
		int (*disasm)(struct umr_asic *asic, uint8_t *inst, unsigned inst_bytes, uint64_t PC, char ***disasm_text);
		void *data;
	};

	struct umr_read_gpr_funcs {
		void *data;
		int (*read_vgprs)(struct umr_asic *asic, struct umr_wave_data *wd, uint32_t thread, uint32_t *dst);
		int (*read_sgprs)(struct umr_asic *asic, struct umr_wave_data *wd, uint32_t *dst);
	};

	struct umr_read_ring_func {
		void *data;
		void *(*read_ring_data)(struct umr_asic *asic, char *ringname, uint32_t *ringsize);
	};

Kernel-doc comments above each field in ``umr.h`` remain the canonical
description of parameters and return values.

--------------
Where to start
--------------

1. Discover or construct an ASIC with the database loaded (typically
   ``umr_discover_asic()`` or an equivalent that fills ``asic->blocks``).
2. Install callbacks **before any code path that dispatches through**
   ``asic->reg_funcs``, ``asic->mem_funcs``, ``asic->wave_funcs``, or
   ``asic->gpr_read_funcs``.  Examples include VM translation
   (``umr_access_vram()``), named register access, wave dumps, and the
   **VRAM binary IP discovery table** helpers in ``src/lib/discover/discovery_table.c``
   (which call ``access_linear_vram`` / ``read_reg`` / ``umr_read_vram`` as
   appropriate).  Do **not** assume ``umr_scan_config()`` is the first such
   consumer: in the stock CLI it reads ``debugfs``/sysfs directly and is
   invoked **before** the Linux callbacks are assigned in ``main.c``—your
   integration may differ if you hook ``scan_config`` or add early probes
   that already use the callback tables.
3. Point ``asic->err_msg`` and ``asic->std_msg`` at valid logging hooks
   wherever code may call them; many paths report failures only through
   ``err_msg``.  Discovery code often sets ``err_msg`` early—leaving it
   NULL in custom paths that still call ``asic->err_msg`` will crash.
4. For the usual DRM-backed Linux path, mirror the assignments in
   ``src/app/main.c`` (CLI) or ``src/app/gui/commands.c`` (GUI).  Test
   harness, devcoredump, and ``umr_discover_asic_by_discovery_table``-only
   flows may assign callbacks in a different order; follow the closest
   in-tree analogue to your entry point.

The authoritative field comments live next to the structs in
``src/umr.h`` (search for ``struct umr_memory_access_funcs`` and the
sibling typedefs).

ASIC file descriptors and ``NULL`` pointers
-------------------------------------------

The stock Linux helpers keep open file descriptors on ``asic->fd`` (MMIO,
VRAM, wave/GPR, DRM, etc.) and the callbacks use those handles internally.
A remote or stub backend might leave most of ``asic->fd`` unset and still
implement the function tables entirely over RPC; there is no requirement
that every ``fd`` field be valid if your callbacks never read them.
Conversely, the core library generally **does not** treat unset function
pointers as optional at every call site—assume a NULL ``read_reg`` or
``access_linear_vram`` is a bug unless you have verified the specific
commands you run never touch that path.

The tree does not document reentrancy or locking for these hooks; if your
backend performs blocking I/O to a host, serialize or document thread
requirements for your embedding environment.

umr_register_access_funcs
=========================

These are the **MMIO / SMU / PCIe-style register** accessors used whenever
code needs a 32-bit register read or write.

``read_reg(asic, addr, type)``
   ``addr`` is a **byte** offset for ``REG_MMIO`` (the Linux helper
   ``umr_read_reg()`` in ``src/lib/lowlevel/linux/mmio.c`` documents the
   ioctl/debugfs paths and bank handling).  The full ``enum regclass`` is
   defined in ``umr.h`` (``REG_MMIO``, ``REG_DIDT``, ``REG_SMC``,
   ``REG_PCIE``, ``REG_SMN``); each is dispatched in ``umr_read_reg()`` /
   ``umr_write_reg()``—see that file for address units and side paths per
   class.  Some kernel-doc lines on the struct only mention a subset; trust
   ``mmio.c`` plus the enum for completeness.

``write_reg(asic, addr, value, type)``
   Same addressing rules as ``read_reg``.  Return ``0`` on success and a
   negative value on failure if your backend can detect errors.

``data``
   Opaque context (client state, test fixture, file handles, etc.).

**Callers:** register print/dump paths, wave indirect register sequences in
``src/lib/scan_waves.c``, VM page walking that reads GPU page tables,
discovery helpers, and many IP-specific tools.

**Implementations and wiring:**

* ``src/lib/lowlevel/linux/mmio.c`` — ``umr_read_reg``, ``umr_write_reg``
* ``src/lib/lowlevel/linux/devcoredump.c`` — ``umr_devcoredump_read_reg``
  (snapshot ASIC)
* ``src/lib/testing_harness.c`` — harness ``read_reg`` / ``write_reg``
* ``src/lib/rumr/client.c`` — remote ``read_reg`` / ``write_reg``
* ``src/lib/discover/discovery_table.c`` — VRAM-backed **binary** discovery
  table reads (not the sysfs IP-discovery import in
  ``discover_by_ip_table.c``); uses ``reg_funcs`` / memory accessors when
  those paths run

After you assign ``reg_funcs``, the CLI also calls ``umr_create_mmio_accel()``
(see ``src/lib/create_mmio_accel.c``) to build a sorted table of MMIO
registers from the **database** only (no hardware read).  It speeds up
lookups by address; backends that do not need it may omit the call.  It is
safe to invoke whenever ``asic->blocks`` is populated.

umr_memory_access_funcs
=========================

These back **system RAM** and **linear VRAM** used by VM decoding, IB
follow, discovery tables, and similar features.

``access_sram(asic, address, size, dst, write_en)``
   Read or write bytes in **GPU-visible system memory** (GTT or CPU
   mappings as appropriate for your transport).  Used heavily from the
   VM walkers in ``src/lib/vm/access_vram_*.c``.

``access_linear_vram(asic, address, size, data, write_en)``
   Read or write bytes in **linear VRAM** (offset from the start of the
   local device's VRAM; XGMI concatenation is handled above this layer in
   ``umr_access_vram()`` in ``src/lib/vm/read_vram.c``).

``gpu_bus_to_cpu_address(asic, dma_addr)``
   Map a bus/DMA address for a **system** page to a CPU-usable address for
   ``access_sram``.  The Linux implementation returns a physical address for
   mmap'd GTT tracking; custom transports may use an opaque cookie instead,
   provided ``access_sram`` interprets ``address`` the same way (there is
   no single reserved sentinel in the core—keep the pair self-consistent).

``vm_message(fmt, ...)``
   Verbose VM decode output; often wired to ``printf`` or a no-op when
   quiet.

``va_addr_decode(pdes, num_pde, pte)``
   **Optional.**  If non-NULL, the VM decoder calls it after decoding PDEs
   and a PTE so a GUI or log can attach extra formatting (see
   ``src/lib/vm/access_vram_ai.c``).

``read_vram(asic, partition, vmid, address, size, data)``
   **Optional.**  If non-NULL, ``umr_access_vram()`` uses it for **reads**
   (``write_en == 0``) before falling back to page walking and linear
   access.  Used for devcoredump-backed ASICs where page tables are not
   walked the same way as live hardware.

``data``
   Opaque context.

**Implementations and call paths:**

* ``src/lib/lowlevel/linux/mem.c`` — ``umr_access_sram``,
  ``umr_access_linear_vram``
* ``src/lib/vm/read_vram.c`` — ``umr_access_vram`` (orchestrates VM hubs,
  optional ``read_vram`` shortcut)
* ``src/lib/vm/access_vram_ai.c``, ``src/lib/vm/access_vram_vi.c`` —
  page walks calling into ``access_sram`` / ``access_linear_vram``
* ``src/lib/vm/access_vram_via_mmio.c`` — linear VRAM when only PCI BAR
  access is available
* ``src/lib/discover/discovery_table.c`` — reads discovery blobs from VRAM
* ``src/lib/rumr/client.c`` — network-backed SRAM/VRAM accessors
* ``src/lib/lowlevel/linux/devcoredump.c`` — ``umr_devcoredump_read_vram``
  wired to ``mem_funcs.read_vram``
* ``src/lib/testing_harness.c`` — fixture memory

umr_wave_access_funcs
=====================

Wave tooling selects a (SE, SH, CU, SIMD, wave) and asks for decoded **SQ
wave** state.

.. rubric:: Wave-related structs

The wave callbacks take or produce the types below.  They are declared in
``src/umr.h`` immediately before ``struct umr_wave_access_funcs`` and
``struct umr_read_gpr_funcs`` (same header as the ``struct umr_asic`` callback
fields).  The comments in the header mirror what the stock Linux helpers
fill in.

::

	/* This captures wave data for a specific engine/wave/etc */
	struct umr_wave_status {
		struct {
			uint32_t
				busy,
				wave_level;
		} sq_info;

		uint32_t reg_values[64];
	};

	/* This captures *all* active/halted waves */
	struct umr_wave_data {
		uint32_t vgprs[64 * 256], sgprs[1024], num_threads;
		int se, sh, cu, simd, wave, have_vgprs, tainted;
		const char **reg_names;
		struct umr_wave_status ws;
		struct umr_wave_thread *threads;
		struct umr_wave_data *next;
	};

``get_wave_status`` writes decoded SQ wave registers into ``ws.reg_values[]``
(and related interpretation is done by helpers such as
``umr_parse_wave_data_gfx()`` in ``src/lib/scan_waves.c`` / declarations in
``src/umr_waves.h``).  ``get_wave_sq_info`` only needs to update
``ws.sq_info``.

``struct umr_wave_data`` is the unit the scanner and GPR callbacks pass
around: coordinates in ``se`` … ``wave``, optional ``reg_names``, embedded
``ws``, GPR payload in ``vgprs[]`` / ``sgprs[]``, and a ``next`` pointer when
``umr_scan_wave_data()`` builds a list.  The ``threads`` member points at
``struct umr_wave_thread``; that tag is only referenced by pointer in the
public headers (incomplete type), so downstream code should treat it as
opaque unless you match whatever the in-tree wave sources expect.

``get_wave_status(asic, se, sh, cu, simd, wave, ws)``
   Fill ``ws`` (including ``reg_values[]``) for that wave.  The stock
   implementation reads raw DWORDs through the SQ indirect path and parses
   them; see ``umr_get_wave_status()`` in ``src/lib/lowlevel/linux/read_gprwave.c``.
   Return ``0`` on success, negative on failure.

``get_wave_sq_info(asic, se, sh, cu, ws)``
   Fill the ``ws.sq_info`` sub-structure (busy mask, wave level, etc.).
   The Linux default delegates to the VI+ helper chain from the same file.

**Callers:** ``src/lib/scan_waves.c`` (wave listing, GPR capture).

**Implementations:**

* ``src/lib/lowlevel/linux/read_gprwave.c`` — ``umr_get_wave_status``,
  ``umr_get_wave_sq_info`` (and raw/indirect helpers used on the way in)
* ``src/lib/scan_waves.c`` — ``umr_get_wave_status_via_mmio`` when IOCTL
  wave access is unavailable

For **MMIO-only** machines (no wave IOCTL), ``src/app/main.c`` swaps in
``umr_get_wave_status_via_mmio`` instead of ``umr_get_wave_status``.

umr_read_gpr_funcs (GPRs)
=========================

Used together with wave status when dumping GPRs:

* ``read_sgprs(asic, wd, dst)``
* ``read_vgprs(asic, wd, thread, dst)``

``wd`` is a populated ``struct umr_wave_data``; the callbacks fill the
arrays pointed to by the core.  Linux maps these to ``umr_read_sgprs`` /
``umr_read_vgprs`` (ioctl path) or the ``*_via_mmio`` variants when
``options.no_kernel`` is set—again see ``src/app/main.c``.

**Implementations:**

* ``src/lib/lowlevel/linux/read_gprwave.c`` — ``umr_read_sgprs``,
  ``umr_read_vgprs``
* ``src/lib/scan_waves.c`` — ``umr_read_sgprs_via_mmio``,
  ``umr_read_vgprs_via_mmio``

Related ASIC fields
===================

``struct umr_read_ring_func`` with ``read_ring_data`` is not MMIO, but it
is usually assigned alongside the above (ring dumps in
``src/lib/packet/packet_stream.c``; implementation
``src/lib/lowlevel/linux/umr_read_ring_data.c``).

``struct umr_shader_disasm_funcs`` supplies optional LLVM-backed
disassembly (``src/lib/lowlevel/linux/umr_shader_disasm.c``,
``src/lib/shader_disasm.c``); builds with ``UMR_NO_LLVM`` may leave it unset
or stubbed.

XGMI / multi-GPU
================

When the ASIC participates in an XGMI hive, ``umr_apply_callbacks()`` in
``src/lib/apply_callbacks.c`` copies the same **memory and register**
function tables onto peer ``struct umr_asic`` nodes so each device in the
hive shares consistent access.  Install your callbacks on the primary ASIC,
then call ``umr_apply_callbacks()`` if you use that path.  Wave, GPR, ring,
and shader-disasm tables are **not** copied by that helper; if peers need
identical behaviour for those, assign them explicitly on each node.

Source files (quick reference)
==============================

* **Header / layout:** ``src/umr.h`` (structs and ``struct umr_asic`` fields)
* **Default wiring (after discover):** ``src/app/main.c``,
  ``src/app/gui/commands.c``
* **Registers:** ``src/lib/lowlevel/linux/mmio.c``,
  ``src/lib/create_mmio_accel.c``
* **System RAM / linear VRAM:** ``src/lib/lowlevel/linux/mem.c``
* **VM orchestration:** ``src/lib/vm/read_vram.c``,
  ``src/lib/vm/access_vram_ai.c``, ``src/lib/vm/access_vram_vi.c``
* **Waves / GPRs:** ``src/lib/scan_waves.c``,
  ``src/lib/lowlevel/linux/read_gprwave.c``
* **Rings:** ``src/lib/packet/packet_stream.c``,
  ``src/lib/lowlevel/linux/umr_read_ring_data.c``
* **Alternate backends:** ``src/lib/rumr/client.c``,
  ``src/lib/rumr/umr_server.c`` (host side of RumR),
  ``src/lib/lowlevel/linux/devcoredump.c``,
  ``src/lib/testing_harness.c``
* **XGMI callback fan-out:** ``src/lib/apply_callbacks.c``

Checklist for a new backend
===========================

* Implement ``read_reg`` / ``write_reg`` with correct **byte** addresses for
  ``REG_MMIO`` and correct semantics for every other ``enum regclass`` value
  your workload can emit (see ``mmio.c``).
* Implement ``access_sram`` and ``access_linear_vram`` (or a working
  ``read_vram`` override) so VM decode and IB follow can reach memory.
* Wire ``vm_message`` to your logger; implement ``gpu_bus_to_cpu_address``
  consistently with ``access_sram``.
* If you need waves, implement ``get_wave_status`` and ``get_wave_sq_info``,
  then GPR reads if you expose wave dumps.
* Set ``err_msg`` / ``std_msg`` before any path that logs through them;
  assign ``data`` pointers on each struct, and copy the pattern from
  ``main.c`` or ``rumr_client_connect()`` for ordering and optional features.
* For multi-GPU / XGMI, decide whether ``umr_apply_callbacks()`` is enough
  (memory + register only) or whether wave/GPR/ring hooks need manual
  replication to peer ASIC structs.
