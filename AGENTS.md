# AGENTS.md — UMR repository map

This file is for humans and coding agents: where things live and what they are for.

**UMR** (User Mode Register debugger) is a userspace diagnostic and debugging tool for AMD GPUs (AMdgpu, with some driverless/PCI paths). Primary language: C, with optional C++ GUI. Build: CMake. Authoritative human docs: `README`, [Read the Docs](https://umr.readthedocs.io/en/main/).

---

## Repository root

| Path | Role |
|------|------|
| `CMakeLists.txt` | Top-level CMake: version, options (`UMR_NO_DRM`, `UMR_NO_LLVM`, `UMR_NO_GUI`, …), `UMR_DB_DIR` (install path for register database), subprojects. |
| `cmake_modules/` | CMake helpers: `GitVersion.cmake`, `FindPCIAccess.cmake`. |
| `LICENSE` | License text. |
| `README` | Main project documentation (build, usage, mailing list). |
| `README.CENTOS` | CentOS-specific notes. |
| `README.TESTVECTOR` | Test vector / harness documentation. |
| `PKGBUILD` | Arch Linux packaging. |

---

## `database/` — shipped register / ASIC definitions

Runtime data consumed by the **umrdatabase** library (see `src/lib/database/`).

- **`database/ip/`** — Per-IP `.reg` files (register layouts and metadata for many IP blocks/revisions).
- **Root of `database/`** — Per-ASIC `.asic` / `.soc15` files, `pci.did`, and related discovery glue.

CMake installs this tree to `${CMAKE_INSTALL_DATADIR}/umr/database/` (see `src/app/CMakeLists.txt`). `UMR_DB_DIR` is defined at configure time in the root `CMakeLists.txt`.

---

## `src/` — application, library, and tests

### `src/` — public headers (selected)

Shared API and packet/layout headers used across app and `lib`:

- `umr.h` — Core umbrella / main API surface.
- `umrapp.h` — Application-facing pieces.
- `umr_*` headers — Domains: `umr_discovery.h`, `umr_database_discovery.h`, `umr_vm.h`, `umr_mmio.h`, `umr_waves.h`, `umr_metrics.h`, `umr_clock.h`, `umr_ih.h`, `umr_rumr.h`, `umr_test_harness.h`, `umr_packet*.h` (PM4, SDMA, MQD, VCN, VPE, MES, HSA, UMSCH, …).

### `src/app/` — `umr` executable and GUI

- **`main.c`** — CLI entry and subcommands.
- **Many `*.c` tools** — Registers, rings, waves, power, clocks, discovery, scan, scriptware, server, etc.
- **`umr_gui.cpp`** + **`gui/`** — GUI when `UMR_GUI` is enabled: **ImGui** + **OpenGL** (Glad) with an **SDL** backend (panels, commands, buffers, traces).
- **`inc/`** — App-local headers (e.g. SMU PPTable, CPC helpers).
- **`CMakeLists.txt`** — App target(s), install rules (binary, `database/`, optional headers).

### `src/lib/` — core libraries

CMake builds several static libraries that the `umr` binary links together:

- **`umrcore`** — Built from top-level `src/lib/*.c` plus **object exports** from `umrdatabase`, `umrpacket`, `umrvm`, `umrrumr`, and `umrdiscover` (single logical core, split for modularity and installable sub-libraries).
- **`umrlow`** — Linux-only low-level I/O in `lowlevel/linux/` (linked separately from `umrcore`; see `src/app/CMakeLists.txt`).

**parson** (JSON) is linked from **`umrdatabase`**, **`umrdiscover`**, **`umrpacket`**, **`umrvm`**, **`umrrumr`**, and the **`umrapp`** static library—not only the database sources.

The subdirectories below are the main places to extend parsing, discovery, or hardware access.

#### `src/lib/database/` → library **umrdatabase**

Loads the on-disk register database under `database/`. `open.c` tries, in order: `filename` as given; optional caller `path` + `filename`; `UMR_DATABASE_PATH`; `UMR_DB_DIR` (configure-time); then `${UMR_SOURCE_DIR}/database/` (root CMake sets `UMR_SOURCE_DIR` to `CMAKE_SOURCE_DIR`).

| File (concept) | Role |
|----------------|------|
| `open.c` | Locate and open DB files (text/binary). |
| `read_asic.c`, `read_ip.c`, `read_soc15.c` | Parse `.asic`, per-IP `.reg`, and `.soc15` layouts into in-memory structures. |
| `scan.c`, `match.c` | Walk and match IP blocks / revisions against the open ASIC description. |
| `free_scan.c` | Tear down scan results. |

Linked into **`umrcore`** as objects and also built as **`umrdatabase`** for install when packaging the development bits.

#### `src/lib/discover/` → library **umrdiscover**

Maps a live GPU (or test fixture) to the correct database entry: how UMR decides *which* `.asic` / IP set applies.

| File | Role |
|------|------|
| `discover_by_did.c` | Discovery using PCI device ID and kernel debugfs (`/sys/kernel/debug/dri/...`). |
| `discover_by_name.c` | Match by marketing / codename strings where applicable. |
| `discover_by_ip_table.c` | Match using the IP instance/revision table (SOC15-style layout). |
| `discovery_table.c` | Shared table construction / helpers used by the strategies above. |

#### `src/lib/packet/` → library **umrpacket**

Decodes **IB / ring packet streams** for different engines. `packet_stream.c` is the common entry/dispatch layer; engine-specific code lives in subfolders (each has its own `CMakeLists.txt` object library pulled into `umrpacket`):

| Subdir | Role |
|--------|------|
| `pm4/` | GFX **PM4** streams: `read_pm4_stream.c`, opcode decode (`pm4_decode_opcodes.c`), `pm4_lite.c` for lighter paths. |
| `sdma/` | **SDMA** packets: stream reader and `sdma_decode_opcodes.c`. |
| `vcn/` | **VCN** encode/decode IBs: separate read paths, dec parsers, encoder opcode tables (`vcn_enc_opcodes.c`, `vcn_dec_parser.c`, …). |
| `vpe/` | **VPE** (Video Processing Engine): `read_vpe_stream.c`, `vpe_decode_opcodes.c`. |
| `mes/` | **MES** (Micro Engine Scheduler) stream decoding (`read_mes_stream.c`). |
| `hsa/` | **HSA** AQL / dispatch style streams (`read_hsa_stream.c`). |
| `umsch/` | **UMSCH** unified scheduler IB path (`read_umsch_stream.c`). |

#### `src/lib/vm/` → library **umrvm**

User-visible **VRAM** access and **page table walking** (how guest or CPU virtual addresses map to physical VRAM for dumps and VM debugging).

| File | Role |
|------|------|
| `read_vram.c` | High-level read path orchestration. |
| `access_vram_ai.c`, `access_vram_vi.c`, `access_vram_via_mmio.c` | Architecture/family-specific ways to reach VRAM (AI vs VI families, MMIO fallback). |
| `decode_pde_entry.c`, `decode_pte_entry.c` | Parse page directory/table entries for the active VM hierarchy. |

#### `src/lib/rumr/` → library **umrrumr**

**Remote UMR**: talk to another machine or process that owns the GPU (or a serial-attached ASIC), so local tools can drive a remote session.

| File | Role |
|------|------|
| `client.c` | Client side of the remote protocol. |
| `umr_server.c` | Server side that exposes UMR operations over the wire. |
| `tcp_comm.c` | TCP framing / transport. |
| `buffer.c` | Shared buffering for streamed data. |
| `rumr_serial_asic.c` | Serial-line ASIC access variant. |

#### `src/lib/lowlevel/` → **`umrlow`** (under `lowlevel/linux/`)

Platform-specific glue; today this means **`lowlevel/linux/`** only. Produces **`umrlow`**, linked by the main `umr` binary (and tests) *in addition to* `umrcore`.

| File (representative) | Role |
|------------------------|------|
| `mmio.c`, `mem.c` | Low-level memory / MMIO access paths tied to the running kernel/driver. |
| `query_drm.c`, `discover.c`, `enumerate_devices.c` | DRM queries, GPU discovery, device listing. |
| `umr_read_ring_data.c`, `read_gprwave.c` | Ring buffer reads, wave GPR access. |
| `umr_clock.c`, `read_sensor.c`, `gfxoff.c` | Clocks, sensors, GfxOff-related queries. |
| `umr_shader_disasm.c` | LLVM-backed shader disassembly entry (honours `UMR_NO_LLVM`). |
| `devcoredump.c` | Devcore / crash dump integration. |
| `build_discovery_entry_table.c`, `parse_clientid.c` | Build or parse discovery tables / client IDs from the driver. |
| `umr_free_asic.c` | Release ASIC-bound low-level state. |

If a future port added another OS, it would likely live as a sibling of `linux/` under `lowlevel/`.

#### `src/lib/import/`

**Headers only** — small definitions pulled in to align with other AMD trees without taking a runtime dependency on those repos:

- `discovery.h`, `soc15_hw_ip.h` — SOC15 / IP discovery constants and structures.
- `ac_vcn_dec.h`, `ac_vcn_enc.h` — VCN-related shared definitions used by packet/decode paths.

#### `src/lib/` top-level `*.c` (inside **umrcore**, not in a subdir)

Cross-cutting logic that is not split into the libraries above:

- **ASIC lifecycle**: `close_asic.c`, `free_asic_blocks.c`, `create_mmio_accel.c`, `apply_callbacks.c`.
- **Registers / IP lookup**: `find_ip.c`, `find_reg.c`, `mmio.c`, `apply_bank_address.c`, `bitfield_print.c`, `scan_config.c`.
- **Waves / queues**: `scan_waves.c`, `read_user_queue.c`, `mqd_decode.c`, `sq_cmd_halt_waves.c`, `ring_is_halted.c`.
- **Shaders / IH / metrics**: `shader_disasm.c` (core side), `ih_decode_vectors.c`, `decode_metrics.c`.
- **Harness / tooling**: `testing_harness.c` (drives `test/` fixtures and `.th` vectors).
- **Misc**: `get_gfx_version.c`, `get_ip_rev.c`, `version.c`.

`src/lib/CMakeLists.txt` is the hub: it `add_subdirectory`s **six** trees (`database`, `lowlevel`, `rumr`, `vm`, `packet`, `discover`). Five of those produce object libraries merged into **`umrcore`**; **`lowlevel`** builds **`umrlow`** on its own. The same file lists the top-level `src/lib/*.c` sources for **`umrcore`**.

### `src/test/` — CTest / unit-style tests

Single **`umrtest`** executable (`src/test/CMakeLists.txt`) built from `test_framework.{c,h}`, `test_mmio.c`, `test_vm.c`, and optionally `test_server.c` / GUI pieces when server or GUI options are enabled—not separate `test_*` install binaries. Pulled in from `src/CMakeLists.txt` by default; set **`UMR_INSTALL_TEST`** to install it.

---

## `test/` — integration / golden tests (non-CMake tree)

- **`test/runtest.sh`** — Driver script for harness-based runs.
- **`test/kat/`** — Known-answer tests: `.cmd`, `.txt`, `.answer*` fixtures (e.g. ring stream / VCN cases).
- **`test/vm/`** — VM-related **`.envdef`** fixtures for direct-VM and ASIC-specific scenarios.

See `README.TESTVECTOR` and `src/lib/testing_harness.c` for how harnesses relate to these files.

---

## `doc/` — documentation artifacts

- **`doc/umr.1`** — Man page source.
- **`doc/sphinx/`** — Sphinx/RST manual (`source/*.rst`, images, `conf.py`, `Makefile`).
- **`doc/CMakeLists.txt`** — Optional doc install/build wiring from CMake.

---

## `scripts/` — shell helpers

- **`build_auto.sh`**, **`report.sh`**, **`diff_ip.sh`**, **`dids.sh`**, **`is_apu.sh`** — Build, reporting, IP / DID utilities, and APU detection.
- **`umr-completion.bash`** — Bash completion.
- **`scripts/diag/`** — Diagnostic wrappers (`diag_functions.sh`, dump/wait scripts).

---

## `demo/` — small standalone examples

- **`demo/dgpu_pwm/`** — Example program + Makefile.
- **`demo/test_harness/`** — Example `.th` harness file.

---

## `comp/` — tiny standalone tool

`compiler.c` + `Makefile` — auxiliary compile helper (not the main CMake build).

---

## Build and install (quick reference)

From repo root:

```bash
cmake -B build-dir -S .
cmake --build build-dir
cmake --install build-dir
```

Major CMake options are documented in `README` (`UMR_NO_LLVM`, `UMR_NO_DRM`, `UMR_NO_GUI`, static builds, etc.).

---

## When editing code, prefer locality

- **CLI / new subcommand** → `src/app/` (+ `src/app/CMakeLists.txt` if new sources).
- **Register DB / new IP files** → `database/ip/` or new `.asic`/`.soc15` under `database/` (+ discovery if needed).
- **Hardware access / kernel interface** → `src/lib/lowlevel/linux/`.
- **Shared decoding / MMIO / waves** → `src/lib/*.c` or the appropriate `src/lib/<module>/` library.
- **User-facing API headers** → `src/umr*.h` (keep includes stable if exported with `UMR_INSTALL_DEV`).

If this map drifts from the tree, update this file in the same change as large moves or renames.
