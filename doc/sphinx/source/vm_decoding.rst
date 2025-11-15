=================
GPU Memory Access
=================

UMR can decode virtual memory addresses as encoded for the GPU
to use.  Currently support for SI through AI (and NV) hardware has been
made public.  The decoder reads the page table data (typically in
VRAM) via the debugfs entry for MMIO and vram.

If a user queue client is selected with the *--user-queue* command
then the page table data is supplied by the client debugfs file and
the VMID chosen doesn't matter.

The VM commands can use the 'verbose' option which prints out useful
information for kernel developers while decoding a virtual address.

------------------------
Virtual Address Decoding
------------------------

Given a VMID and a virtual address the pair can be decoded to
a page address with the following command:

::

	umr --vm-decode vmid@<address> <number_of_pages>

For instance:

::

	umr --vm-decode 1@0x100040000 1

Will decode address and present a decoding that resembles:

::

	[VERBOSE]: mmVM_CONTEXT1_PAGE_TABLE_START_ADDR=0x0
	[VERBOSE]: mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR=0xf4ffee0
	[VERBOSE]: mmVM_CONTEXT1_CNTL=0x4fffedb
	[VERBOSE]: mmMC_VM_FB_LOCATION=0xf4fff400
	[VERBOSE]: PDE=0x000000f4ff9e0001, VA=0x0100000000, PBA==0xf4ff9e0000, V=1
	[VERBOSE]: \-> PTE=0x0000000002720271, VA=0x0000040000, PBA==0x0002720000, V=1, S=0

for SI..VI platforms.  On AI+ platforms it will decode multiple levels
of page tables.

Based on the architecture various VM related registers will be
printed out which instruct the user how the GPU has been programmed.

On AI+ ASICs the VA field indicates the portion of the input virtual address that is involved upto
that level of the decoding (including previous levels).  Whereas, on prior generations
the VA field indicates just the part of the address being translated at each level.

The PBA field indicates the 'page base address' which may point to a PDB, PTB, or page of memory.

The PDE entries have multiple bits that are decoded as follow:

+-----------+----------------------------------+
| **Bit**   | **Meaning**                      |
+-----------+----------------------------------+
|  V        | Valid                            |
+-----------+----------------------------------+
|  S        | Resides in system memory         |
+-----------+----------------------------------+
|  C        | Cached                           |
+-----------+----------------------------------+
|  P        | PTE                              |
+-----------+----------------------------------+

In the above example the address points to a VRAM location at address
0x0002720000 and both the PDE and PTE bits indicate the mapping is
valid.

For AI+ platforms a VMID > 0 decode might resemble something like:

::

	$ umr --user-queue queue=0,client=8 -vm 0@0x7bd82ccb1000 1

	=== VM Decoding of address 0@0x7bd82ccb1000 ===
	mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32=0x0
	mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32=0x0
	mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32=0xffffffff
	mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32=0xf
	mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32=0xdaae6001
	mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32=0x3
	mmGCVM_CONTEXT0_CNTL=0x6
	VMID0.page_table_block_size=0
	VMID0.page_table_depth=3
	mmVGA_MEMORY_BASE_ADDRESS=0x0
	mmVGA_MEMORY_BASE_ADDRESS_HIGH=0x0
	mmMC_VM_FB_OFFSET=0x0
	mmGCMC_VM_MX_L1_TLB_CNTL=0x0
	mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR=0x0
	mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR=0x0
	mmGCMC_VM_FB_LOCATION_BASE=0x8000
	mmGCMC_VM_FB_LOCATION_TOP=0x83fb
	mmGCMC_VM_AGP_BASE=0x0
	mmGCMC_VM_AGP_BOT=0x0
	mmGCMC_VM_AGP_TOP=0x0
	BASE=0x00000003daae6001, VA=0x7b8000000000, PBA==0x0003daae6000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
	\-> PDE2@{0x3daae67b8/f7}=0x00000003daadd001, VA=0x7b8000000000, PBA==0x0003daadd000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
		\-> PDE1@{0x3daaddb00/160}=0x00000003daadc001, VA=0x7bd800000000, PBA==0x0003daadc000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
			\-> PDE0@{0x3daadcb30/166}=0x00000003daae2001, VA=0x7bd82cc00000, PBA==0x0003daae2000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
				\-> PTE@{0x3daae2588/0xb1}=0x80000003da7bd171, VA=0x7bd82ccb1000, PBA==0x0003da7bd000, V=1, S=0, C=0, Z=0, X=1, R=1, W=1, FS=2, SW=0, T=0, G=0, D=0, P=1, MTYPE=NC
					\-> Computed address we will read from: vram:3da7bd000 (MCA:3da7bd000), (reading: 4096 bytes from a 4096 byte page)

	=== Completed VM Decoding ===

Where we see the introduction of the PDB/PTB addressing in the form of *@{address/offset}* where the address is the video
memory address of the PDE or PTE.  The offset is the index (multiply by 8 to get a byte address) from the start of the 
PDB or PTB to where the entry is found.  In the above example PDE2 was found at video memory 0x3daae67b8 which is the 0xf7'th 
PDE entry in that PDB (PBA=0x0003daae6000 + 0xf7 * 8).

If you are debugging a PTB then more pages can be decoded at once by changing the second argument to the --vm-decode command.

Various ASICs have special memory hubs that can be accessed via the VMID field.  In umr, the bits 8:15 of the VMID indicate the hub:

+-----------+-------------------------+
| **Value** | **Memory Hub**          |
+-----------+-------------------------+
| 0x000     | GFX memory hub          |
+-----------+-------------------------+
| 0x100     | MM memory hub           |
+-----------+-------------------------+
| 0x200     | VC0 MM memory hub       |
+-----------+-------------------------+
| 0x300     | VC1 MM memory hub       |
+-----------+-------------------------+

For instance the command:

::

	umr --vm-decode 0x105@0x12345600 1

Will decode the virtual address 0x12345600 of VMID 5 from the MM
memory hub.  These extra bits can be used for VM reads and writes
as well.

--------------------
Virtual Memory Reads
--------------------

GPU virtual memory may be read with the --vm-read command:

::

	umr --vm-read [<vmid>@]<address> <size>

Here the VMID is optional (and can be specified in decimal or
hexadecimal if included).  If the VMID is omitted then the command
issues a read linearly into VRAM.  If the VMID is included then
the command issues a paged read possibly into VRAM or system memory.
The size is specified only in hexadecimal.

The output of the read is written to 'stdout' in raw binary form
which is meant to be then piped to other commands.  To simply
pretty print the output the 'xxd' command can be used, for instance:

::

	umr --vm-read 0x1000 10 | xxd -e

Will read 0x10 bytes from VRAM at address 0x1000 and pretty print
it to the console.

If the 'verbose' option is specified then the PDE/PTE decoding will
be printed out (to stderr) before the contents of the page
are read (assuming the mapping is valid).

---------------------
Virtual Memory Writes
---------------------

GPU virtual memory may be written with the --vm-write command:

::

	umr --vm-write [<vmid>@]<address> <size>

This command writes binary data read from stdin to the GPU memory.  As in
the case of the --vm-read command if the VMID is omitted then the
writes are performed linearly into VRAM.

--------------------
System Memory Access
--------------------

On newer kernels with a *amdgpu_iomem* debugfs entry system memory
access to memory mapped to the GPU has been made easier.  Additional
modules (e.g., fmem) are no longer required.

For applications using HMM zones UMR will first attempt to use the 
*amdgpu_iomem* debugfs entry and if that fails it will then access the
processes */proc/${pid}/mem* file to access the memory.  This requires
that a user queue is selected first with the *--user-queue* command.  Other
than selecting a queue this transition from using debugfs to procfs is transparent
to the user.  This way UMR supports pages that are both kernel or process bound
in system memory.

For instance, this kfd client application has an HQD ring buffer read pointer located in system memory:

::

	$ umr --user-queue queue=0,client=8 -vm 0x0@0x7bd820400000 1


	=== VM Decoding of address 0@0x7bd820400000 ===
	mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32=0x0
	mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32=0x0
	mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32=0xffffffff
	mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32=0xf
	mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32=0xdaae6001
	mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32=0x3
	mmGCVM_CONTEXT0_CNTL=0x6
	VMID0.page_table_block_size=0
	VMID0.page_table_depth=3
	mmVGA_MEMORY_BASE_ADDRESS=0x0
	mmVGA_MEMORY_BASE_ADDRESS_HIGH=0x0
	mmMC_VM_FB_OFFSET=0x0
	mmGCMC_VM_MX_L1_TLB_CNTL=0x0
	mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR=0x0
	mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR=0x0
	mmGCMC_VM_FB_LOCATION_BASE=0x8000
	mmGCMC_VM_FB_LOCATION_TOP=0x83fb
	mmGCMC_VM_AGP_BASE=0x0
	mmGCMC_VM_AGP_BOT=0x0
	mmGCMC_VM_AGP_TOP=0x0
	BASE=0x00000003daae6001, VA=0x7b8000000000, PBA==0x0003daae6000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
	\-> PDE2@{0x3daae67b8/f7}=0x00000003daadd001, VA=0x7b8000000000, PBA==0x0003daadd000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
		\-> PDE1@{0x3daaddb00/160}=0x00000003daadc001, VA=0x7bd800000000, PBA==0x0003daadc000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
			\-> PDE0@{0x3daadc810/102}=0x00000003da7b9001, VA=0x7bd820400000, PBA==0x0003da7b9000, V=1, S=0, C=0, U=0, A=0, FS=0, P=0
				\-> PTE@{0x3da7b9000/0x0}=0x80c00001929501f7, VA=0x7bd820400000, PBA==0x000192950000, V=1, S=1, C=1, Z=0, X=1, R=1, W=1, FS=3, SW=0, T=0, G=0, D=0, P=1, MTYPE=UC
					\-> Computed address we will read from: sys:192950000, (reading: 4096 bytes from a 4096 byte page)

	=== Completed VM Decoding ===

And despite the PTE having the S bit set to 1 (system memory) we can read it (it is at offset 0x80 into this page) just as easily:

::
	
	$ umr --user-queue queue=0,client=8 -vr 0x0@0x7bd820400080 8 | xxd -e
	00000000: 00001503 00000000                     ........

