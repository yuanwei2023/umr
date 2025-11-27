/*
 * Copyright (c) 2025 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Authors: Tom St Denis <tom.stdenis@amd.com>
 *
 */
#include "umr.h"
#include <inttypes.h>

#define MIN(x, y) ((x) < (y) ? (x) : (y))

/**
 * @file access_vram_ai.c
 * @brief VM address translation for AMD GFX9+ (AI/Vega and later) GPU architectures
 *
 * GLOSSARY OF TERMS:
 * ==================
 *
 * VA (Virtual Address)      - The logical address used by GPU shaders and compute kernels
 * PA (Physical Address)     - The actual address in VRAM or system memory
 * PBA (Page Base Address)   - Physical base address stored in PTE/PDE entries
 * MCA (Memory Controller Address) - Physical address as seen by the memory controller
 *
 * PDE (Page Directory Entry) - Entry in a page directory that points to next level page table
 * PTE (Page Table Entry)     - Leaf entry that maps a virtual page to physical memory
 * PDB (Page Directory Block) - A block of page directory entries (512 entries, 9 bits)
 * PTB (Page Table Block)     - A block of page table entries (variable size)
 *
 * PDE-as-PTE                - A PDE with P(te) bit set, treated as final translation (no PTB)
 * PTE-FURTHER               - A PTE with Further bit set, pointing to another level of PTB
 *
 * VMID (VM Identifier)      - Identifies which virtual memory context (0-15)
 *                             Bits [0:7] = actual VMID, Bits [8:15] = hub selection
 * VM Context                - A complete virtual address space with its own page tables
 *
 * FB (Frame Buffer)         - The GPU's local video memory (VRAM)
 * SA (System Aperture)      - Range of addresses that map linearly to system memory
 * ZFB (Zero Frame Buffer)   - APU mode where VRAM appears at address 0 in system memory
 * AGP Aperture              - Address range for accessing system memory from GPU
 *
 * PAGE_TABLE_DEPTH          - Number of page directory levels (0-3)
 *                             0 = flat mapping, 1 = PDE0->PTE, 2+ = multi-level
 * PAGE_TABLE_BLOCK_SIZE     - Log2 of how many 2 MiB blocks each PTB covers
 * (PDE) FRAGMENT_SIZE (FS)  - Log2 of how many 4 KiB blocks each PTE covers (i.e. a page is 2^(12 + PDE0.FS) bytes)
 *                             Unless PTE-FURTHER is enabled then it describes the address span of the PTB the PTE-Further points to.
 *
 * MTYPE (Memory Type)       - Caching behavior: NC (non-cached), RW (read-write),
 *                             CC (cache-coherent), UC (uncached)
 * SAM (System Access Mode)  - Controls how VMID0 addresses are translated:
 *                             0=physical, 1=always VM, 2=inside SA mapped, 3=inside SA unmapped
 *
 * TMZ (Trusted Memory Zone) - Secure memory region for protected content
 * PRT (Partially Resident Texture) - Sparse texture support, allows unmapped pages
 * GCR (GPU Cache Rinse)     - Cache coherency control
 * TFS (Translation Further Offset Address) - Used to add PDE0.PBA to the PTB offset when translating PTE-Further
 */

/* VM Page Table Architecture Constants */
#define VM_PAGE_SIZE_BITS           12      /* 4 KiB base page size (2^12) */
#define VM_PAGE_SIZE                4096    /* 4 KiB in bytes */
#define VM_PDB_ENTRY_BITS           9       /* Number of bits for PDB entries (2^9 = 512 entries) */
#define VM_PDB_ENTRIES              512     /* Number of entries per Page Directory Block */
#define VM_PDB_ENTRY_MASK           511     /* Mask for PDB entry selection (512 - 1) */
#define VM_PTB_ENTRY_SIZE           8       /* Size of each PTE/PDE entry in bytes (both are 8 bytes) */
#define VM_2MB_BLOCK_BITS           21      /* 2 MiB coverage (2^21) */

/* VM Address Field Shifts */
#define VM_PAGE_TABLE_ADDR_LO32_SHIFT  12   /* Shift for low 32-bit page table address register */
#define VM_PAGE_TABLE_ADDR_HI32_SHIFT  44   /* Shift for high 32-bit page table address register */
#define VM_FB_OFFSET_SHIFT          24      /* Shift for frame buffer offset/location registers */
#define VM_SYSTEM_APERTURE_SHIFT    18      /* Shift for system aperture registers */

/* VM Indentation/Formatting */
#define VM_INDENTATION_BASE         18      /* Base indentation for VM decode output */
#define VM_INDENTATION_PER_LEVEL    3       /* Additional indentation per PDE level */

/* VM Memory Types (MTYPE field values) */
#define VM_MTYPE_NC                 0       /* Non-Cached */
#define VM_MTYPE_RW                 1       /* Read-Write */
#define VM_MTYPE_CC                 2       /* Cache Coherent */
#define VM_MTYPE_UC                 3       /* Uncached */

/* VM System Access Mode (SAM) values */
#define VM_SAM_PHYSICAL             0       /* Physical access mode */
#define VM_SAM_ALWAYS_VM            1       /* Always use VM translation */
#define VM_SAM_INSIDE_MAPPED        2       /* Inside SA is mapped, outside unmapped */
#define VM_SAM_INSIDE_UNMAPPED      3       /* Inside SA is unmapped, outside mapped */

/* VM Address Masks */
#define VM_PAGE_OFFSET_MASK         0xFFF   /* Mask for 4K page offset (12 bits) */
#define VM_VMID_MASK                0xFF    /* Mask for VMID (bits 0:7) */
#define VM_HUB_MASK                 0xFF00  /* Mask for hub selection (bits 8:15) */

/* The page table being walked */
struct umr_vm_ai_state {
	struct umr_asic *asic;				/* The ASIC model this decoding is attached to */
	struct umr_vm_pagewalk *vmdata;		/* Optional captured data passed back to the caller (can be NULL) */
	struct umr_ip_block *ip;			/* The 'gfx' IP block used to determine the IP revision repeatedly in the decoding */
	int partition;
	uint64_t va_tally;					/* The tally of VA bits used so far in the translation */

	/* Main parameters of the page table */
	struct {
		uint64_t
			page_table_start_addr,      /* lowest possible address in this VM space, (translations are made relative to this) */
			page_table_end_addr,        /* highest possible address in this VM space */
			page_table_base_addr,       /* The highest level PDE value */
			page_table_block_size,      /* how many 2MiB blocks each PTB covers (log2), e.g., 2^(21 + ptbs) */
			pde0_block_fragment_size;   /* how much space each PTE covers (log2) (bytes == 2^(pbfs + 12))
			                               # of PTE's per PTB is 2^(9 + ptbs - pbfs) */
		int
			page_table_depth;           /* how many levels of translation are needed */
	} page_table;

	/* VM control registers */
	struct {
		uint64_t
			vm_fb_offset,				/* offset added to any non-system linear video ram address (e.g. subtract this from a PBA to get the true linear address)
			                               fb_offset represents the physical base of the carve out on APU based systems. */
			system_aperture_low,		/* system aperture (SA) defines the span of VMID0 space which is linearly mapped */
			system_aperture_high,		/* addresses in this region are treated as a linear address (if the SA mode field is appropriate) */
			fb_top,						/* addresses inside the SA and the frame buffer (FB) are translated as linear addresses starting at 0 (by subtracting fb_bottom) */
			fb_bottom,
			agp_base,					/* in Zero FB mode (zfb) addresses between agp_bot...agp_top are translated by */
			agp_bot,					/* subtracting agp_bot and adding agp_base, then the computed address is treated as a system memory */
			agp_top;					/* address */
		int
			zfb;						/* zero frame buffer mode */
	} vmctrl;

	/* The Page Table Block/Page Table Entry (PTB/PTE) */
	struct {
		uint64_t
			pte_idx,                    /* the selector into the PTB that fetched the PTE */
			pte_entry,                  /* the 64-bit PTE value itself */
			ptb_mask,                   /* mask used to select a PTE in the PTB from the VA (e.g. how big is the PTB) */
			pte_page_mask,              /* the mask used to compute the size of the page */
			addr,                       /* computed address of PTE */
			log2_ptb_entries;           /* log2 of number of PTB entries (how many 2MiB blocks are covered) */
		uint32_t
			pte_block_fragment_size;    /* (PTE-FURTHER only) how many 4K pages does the last layer PTE cover (linearly increases bit width of page mask)
			                               e.g. span is 2^(12 + pte_block_fragment_size) wide per PTE */
		pte_fields_t
			pte_fields;                 /* decoded fields from the PTE */
		int
			further,                    /* is PTE-FURTHER being used */
			pte_is_pde;                 /* is PTE-AS-PDE being used */
	} pte;

	/* The Page Directory Block/Page Directory Entry (PDB/PDE) */
	struct {
		uint64_t
			pde_idx,                    /* the selector into the PDB that picked this PDE */
			pde_entry,                  /* the 64-bit PDE value itself */
			pde_address,                /* page_base address pulled from the PDE */
			addr;                       /* computed address of the PDE */
		pde_fields_t
			pde_fields,                 /* decoded fields from the latest PDE */
			pde_array[8];               /* array of PDEs from the various levels */
		int
			pde_cnt,                    /* how deep the pde_array[] usage goes */
			pde_was_pte;                /* flagged if this PDE is used as a PTE */
	} pde;

	/* these are the verbatim registers being read to perform the page walk */
	struct {
		uint32_t
			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
			mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32,
			mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32,
			mmVM_CONTEXTx_CNTL,
			mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32,
			mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32,
			mmVGA_MEMORY_BASE_ADDRESS,
			mmVGA_MEMORY_BASE_ADDRESS_HIGH,
			mmMC_VM_FB_OFFSET,
			mmMC_VM_MX_L1_TLB_CNTL,
			mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
			mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
			mmMC_VM_FB_LOCATION_BASE,
			mmMC_VM_FB_LOCATION_TOP,
			mmMC_VM_AGP_BASE,
			mmMC_VM_AGP_BOT,
			mmMC_VM_AGP_TOP;
	} registers;
};

/**
 * @brief Calculate the log2 of the VM space size
 *
 * @param page_table_start_addr The lowest address in the VM space
 * @param page_table_end_addr The highest address in the VM space
 * @return The log2 of the total VM size in bits
 *
 * @details This function calculates the number of bits required to represent the entire
 *          VM address space. It takes the difference between end and start addresses,
 *          rounds up to the next power of two, and returns the log2 value. This is used
 *          to determine how many address bits are needed for page table indexing.
 */
static uint64_t log2_vm_size(uint64_t page_table_start_addr, uint64_t page_table_end_addr)
{
	// Get total number of bytes in VM space.
	uint64_t size_of_vm_bytes = page_table_end_addr - page_table_start_addr;

	// page_table_end_addr is inclusive of the last page. To get true size of VM space,
	// add one more page.
	if (size_of_vm_bytes > UINT64_MAX - VM_PAGE_SIZE) {
		// Overflow case. It's 64 bits.
		return 64;
	} else {
		size_of_vm_bytes += VM_PAGE_SIZE;
	}

	if (size_of_vm_bytes <= 1) {
		return 0;
	}

	// Subtract 1 to achieve ceiling of log2 when checking highest bit instead of floor.
	size_of_vm_bytes -= 1;
	uint64_t num_leading_zeros = 0;
	while (size_of_vm_bytes > 0) {
		size_of_vm_bytes >>= 1;
		num_leading_zeros++;
	}

	return num_leading_zeros;
}

/**
 * @brief Print decoded PDE fields for debugging
 *
 * @param vm Pointer to the VM state structure
 * @param pde_fields The decoded PDE fields to print
 *
 * @details This function outputs the decoded fields from a PDE entry in a human-readable
 *          format. The output format varies depending on the GPU IP version (GFX9, GFX10,
 *          GFX11, or GFX12), as different generations support different PDE field layouts.
 *          Fields typically include valid bit, system/coherent flags, PTE flag, fragment size,
 *          and version-specific fields like MTYPE, TFS address, and LLC no-alloc flags.
 */
static void print_pde_fields(struct umr_vm_ai_state *vm, pde_fields_t pde_fields)
{
	switch (vm->ip->discoverable.maj) {
		case 9:
		case 10:
			if (vm->ip->discoverable.maj == 9 || vm->ip->discoverable.min < 2) {
				vm->asic->mem_funcs.vm_message(
						", PBA==0x%012" PRIx64 ", V=%" PRIu64
						", S=%" PRIu64 ", C=%" PRIu64
						", P=%" PRIu64 ", FS=%" PRIu64 "\n",
						pde_fields.pte_base_addr,
						pde_fields.valid,
						pde_fields.system,
						pde_fields.coherent,
						pde_fields.pte,
						pde_fields.frag_size);
			} else {
				vm->asic->mem_funcs.vm_message(
						", PBA==0x%012" PRIx64 ", V=%" PRIu64
						", S=%" PRIu64 ", C=%" PRIu64
						", P=%" PRIu64 ", FS=%" PRIu64 ", Y=%" PRIu64 "\n",
						pde_fields.pte_base_addr,
						pde_fields.valid,
						pde_fields.system,
						pde_fields.coherent,
						pde_fields.pte,
						pde_fields.frag_size,
						pde_fields.llc_noalloc);
			}
			break;
		case 11:
			vm->asic->mem_funcs.vm_message(
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64
					", MTYPE=%" PRIu64
					", P=%" PRIu64 ", FS=%" PRIu64
					", A=%" PRIu64 ", Y=%" PRIu64 "\n",
					pde_fields.pte_base_addr,
					pde_fields.valid,
					pde_fields.system,
					pde_fields.coherent,
					pde_fields.mtype,
					pde_fields.pte,
					pde_fields.frag_size,
					pde_fields.tfs_addr,
					pde_fields.llc_noalloc);
			break;
		case 12:
			vm->asic->mem_funcs.vm_message(
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64
					", U=%" PRIu64 ", A=%" PRIu64
					", FS=%" PRIu64 ", P=%" PRIu64 "\n",
					pde_fields.pte_base_addr,
					pde_fields.valid,
					pde_fields.system,
					pde_fields.coherent,
					pde_fields.mall_reuse,
					pde_fields.tfs_addr,
					pde_fields.frag_size,
					pde_fields.pte);
			break;
	}
}

/**
 * @brief Print the base root page table entry
 *
 * @param vm Pointer to the VM state structure
 * @param address The virtual address being decoded
 * @param va_mask The mask applied to the virtual address for this level
 *
 */
static void print_base(struct umr_vm_ai_state *vm)
{
	vm->asic->mem_funcs.vm_message("BASE");
	vm->asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64,
			vm->pde.pde_entry,
			vm->page_table.page_table_start_addr);
	print_pde_fields(vm, vm->pde.pde_fields);
}

/**
 * @brief Print a page directory entry during VM address translation
 *
 * @param vm Pointer to the VM state structure
 * @param indentation String containing spaces for indenting output hierarchically
 * @param address The virtual address being decoded
 * @param va_mask The mask applied to the virtual address for this PDE level
 *
 * @details This function prints information about a PDE encountered during page table walk.
 *          Output includes the PDE level number (or PTE-FURTHER if applicable), the physical
 *          address and index of the PDE, the raw PDE value, the masked virtual address, and
 *          all decoded PDE fields. The indentation level reflects the depth in the page table
 *          hierarchy.
 */
static void print_pde(struct umr_vm_ai_state *vm, const char *indentation)
{
	vm->asic->mem_funcs.vm_message("%s ", &indentation[VM_INDENTATION_BASE - (vm->pde.pde_cnt * VM_INDENTATION_PER_LEVEL)]);
	if (vm->pte.pte_is_pde) {
		vm->asic->mem_funcs.vm_message("PTE-FURTHER");
	} else {
		vm->asic->mem_funcs.vm_message("PDE%d", vm->page_table.page_table_depth - vm->pde.pde_cnt);
	}
	vm->asic->mem_funcs.vm_message("@{0x%" PRIx64 "/0x%" PRIx64
			"}=0x%016" PRIx64 ", VA=0x%012" PRIx64,
			vm->pde.addr,
			vm->pde.pde_idx,
			vm->pde.pde_entry,
			vm->va_tally + vm->page_table.page_table_start_addr);
	print_pde_fields(vm, vm->pde.pde_fields);
}

/**
 * @brief Print a page table entry during VM address translation
 *
 * @param vm Pointer to the VM state structure
 * @param indentation String containing spaces for indenting output hierarchically (NULL for simplified output)
 * @param address The virtual address being decoded
 * @param va_mask The mask applied to the virtual address for this PTE
 *
 * @details This function prints detailed information about a PTE encountered at the leaf level
 *          of the page table walk. Output includes the PTE type (PTE or PDE-as-PTE), physical
 *          address and index, raw PTE value, virtual address, page base address, and all decoded
 *          PTE fields including valid bit, system/coherent flags, permissions (read/write/execute),
 *          TMZ, fragment size, PRT, and memory type. The memory type is decoded into human-readable
 *          strings (NC/RW/CC/UC). Output format varies by GPU generation (GFX9/10/11/12).
 */
static void print_pte(struct umr_vm_ai_state *vm, const char *indentation)
{
	if (indentation == NULL) {
		vm->asic->mem_funcs.vm_message("\\-> PTE");
	} else {
		vm->asic->mem_funcs.vm_message("%s ",
				&indentation[VM_INDENTATION_BASE - (vm->pde.pde_cnt * VM_INDENTATION_PER_LEVEL)]);
		if (vm->pde.pde_was_pte) {
			vm->asic->mem_funcs.vm_message("PDE%d-as-PTE", vm->page_table.page_table_depth - vm->pde.pde_cnt);
		} else {
			vm->asic->mem_funcs.vm_message("PTE");
		}
	}
	vm->asic->mem_funcs.vm_message("@{0x%" PRIx64 "/0x%" PRIx64"}",
			vm->pte.addr, vm->pte.pte_idx);

	switch (vm->ip->discoverable.maj) {
		case 9:
			vm->asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
					", FS=%" PRIu64 ", T=%" PRIu64 ", MTYPE=",
					vm->pte.pte_entry,
					vm->va_tally + vm->page_table.page_table_start_addr,
					vm->pte.pte_fields.page_base_addr,
					vm->pte.pte_fields.valid,
					vm->pte.pte_fields.system,
					vm->pte.pte_fields.coherent,
					vm->pte.pte_fields.tmz,
					vm->pte.pte_fields.execute,
					vm->pte.pte_fields.read,
					vm->pte.pte_fields.write,
					vm->pte.pte_fields.fragment,
					vm->pte.pte_fields.prt,
					vm->pte.pte_fields.mtype);
			break;
		case 10:
			vm->asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
					", FS=%" PRIu64 ", T=%" PRIu64 ", G=%" PRIu64 ", MTYPE=",
					vm->pte.pte_entry,
					vm->va_tally + vm->page_table.page_table_start_addr,
					vm->pte.pte_fields.page_base_addr,
					vm->pte.pte_fields.valid,
					vm->pte.pte_fields.system,
					vm->pte.pte_fields.coherent,
					vm->pte.pte_fields.tmz,
					vm->pte.pte_fields.execute,
					vm->pte.pte_fields.read,
					vm->pte.pte_fields.write,
					vm->pte.pte_fields.fragment,
					vm->pte.pte_fields.prt,
					vm->pte.pte_fields.gcr,
					vm->pte.pte_fields.mtype);
			break;
		case 11:
			vm->asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
					", FS=%" PRIu64 ", T=%" PRIu64 ", SW=%" PRIu64
					", G=%" PRIu64 ", Y=%" PRIu64 ", MTYPE=",
					vm->pte.pte_entry,
					vm->va_tally + vm->page_table.page_table_start_addr,
					vm->pte.pte_fields.page_base_addr,
					vm->pte.pte_fields.valid,
					vm->pte.pte_fields.system,
					vm->pte.pte_fields.coherent,
					vm->pte.pte_fields.tmz,
					vm->pte.pte_fields.execute,
					vm->pte.pte_fields.read,
					vm->pte.pte_fields.write,
					vm->pte.pte_fields.fragment,
					vm->pte.pte_fields.prt,
					vm->pte.pte_fields.software,
					vm->pte.pte_fields.gcr,
					vm->pte.pte_fields.llc_noalloc);
			break;
		case 12:
			vm->asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
					", PBA==0x%012" PRIx64 ", V=%" PRIu64
					", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
					", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
					", FS=%" PRIu64 ", SW=%" PRIu64 ", T=%" PRIu64
					", G=%" PRIu64 ", D=%" PRIu64 ", P=%" PRIu64
					", MTYPE=",
					vm->pte.pte_entry,
					vm->va_tally + vm->page_table.page_table_start_addr,
					vm->pte.pte_fields.page_base_addr,
					vm->pte.pte_fields.valid,
					vm->pte.pte_fields.system,
					vm->pte.pte_fields.coherent,
					vm->pte.pte_fields.tmz,
					vm->pte.pte_fields.execute,
					vm->pte.pte_fields.read,
					vm->pte.pte_fields.write,
					vm->pte.pte_fields.fragment,
					vm->pte.pte_fields.software,
					vm->pte.pte_fields.prt,
					vm->pte.pte_fields.gcr,
					vm->pte.pte_fields.dcc,
					vm->pte.pte_fields.pte);
			break;
	}

	switch (vm->pte.pte_fields.mtype) {
		case VM_MTYPE_NC:
			vm->asic->mem_funcs.vm_message("NC\n");
			break;
		case VM_MTYPE_RW:
			vm->asic->mem_funcs.vm_message("RW\n");
			break;
		case VM_MTYPE_CC:
			vm->asic->mem_funcs.vm_message("CC\n");
			break;
		case VM_MTYPE_UC:
			vm->asic->mem_funcs.vm_message("UC\n");
			break;
		default:
			vm->asic->mem_funcs.vm_message("[ERROR]: Error decoding PTE mtype: Unknown (%" PRIu64")\n",
					vm->pte.pte_fields.mtype);
			break;
	}
}

/**
 * @brief Prepares PTE configuration when transitioning from PDE to PTE level
 *
 * This function is called when transitioning from processing a PDE (Page Directory Entry)
 * to the first PTE (Page Table Entry) or PTE-Further level in the page table walk.
 * It extracts and applies the Fragment Size (FS) field from PDE0, which controls both
 * the page size covered by each PTE and the address span of the Page Table Block (PTB).
 *
 * @param vm Pointer to the VM address translation state structure
 *
 * @details
 * The function computes key PTB parameters based on the Fragment Size:
 *
 * - pde0_block_fragment_size: Fragment Size field from PDE0 (log2 of 4 KiB blocks per PTE)
 *   * FS = 0: Each PTE covers 4 KiB (2^12 bytes)
 *   * FS = 9: Each PTE covers 2 MiB (2^21 bytes)
 *
 * - page_table_block_size: Number of 2 MiB regions covered by a PTB
 *   * PTBS = 0: PTB covers 2 MiB
 *   * PTBS = 9: PTB covers 1024 MiB (1 GiB)
 *
 * - log2_ptb_entries: Number of PTEs in the PTB = 2^(9 + PTBS - FS)
 *   * Example: PTBS=0, FS=0: 2^9 = 512 PTEs (covering 2 MiB / 4 KiB pages)
 *   * Example: PTBS=9, FS=9: 2^9 = 512 PTEs (covering 1 GiB / 2 MiB pages)
 *
 * - ptb_mask: Bitmask for extracting PTE index within PTB
 * - pte_page_mask: Bitmask for extracting page offset within a single PTE's coverage
 */
static void prepare_pde_to_pte(struct umr_vm_ai_state *vm, int current_depth, uint64_t total_vm_bits)
{
	vm->page_table.pde0_block_fragment_size = vm->pde.pde_fields.frag_size;

	uint64_t start_bit = vm->page_table.pde0_block_fragment_size + VM_PAGE_SIZE_BITS;
	uint64_t end_bit = vm->page_table.page_table_block_size + VM_2MB_BLOCK_BITS;

	if (current_depth != 0) {
		start_bit = MIN(VM_PDB_ENTRY_BITS * (current_depth - 1) + vm->page_table.page_table_block_size + VM_2MB_BLOCK_BITS, (uint64_t)total_vm_bits);
		end_bit = MIN(VM_PDB_ENTRY_BITS * current_depth + vm->page_table.page_table_block_size + VM_2MB_BLOCK_BITS, (uint64_t)total_vm_bits);
	}

	vm->pte.log2_ptb_entries = end_bit - start_bit;
	vm->pte.ptb_mask = (1ULL << vm->pte.log2_ptb_entries) - 1;
	vm->pte.pte_page_mask = (1ULL << start_bit) - 1;
}

/**
 * @brief Accesses memory at a translated physical address (PDEs, PTEs, or user pages)
 *
 * This function reads or writes data at a translated physical address from either
 * GPU video memory (VRAM) or system memory (SRAM), depending on the system flag.
 * It handles page table entries (PDEs and PTEs) as well as user page data.
 * It also handles special cases like Zero Frame Buffer (ZFB) mode where VRAM addresses
 * may need to be translated to system memory addresses.
 *
 * @param vm Pointer to the VM address translation state structure
 * @param addr Physical address to access (must be appropriately aligned)
 * @param sys Memory location flag:
 *            - 0: Data is located in VRAM (video memory)
 *            - 1: Data is located in system memory
 * @param name Descriptive name for the data type (e.g., "PDE", "PTE", "user page") used in error messages
 * @param dst Pointer to buffer where data will be read to or written from
 * @param len Number of bytes to access
 * @param write_en Access mode:
 *                 - 0: Read operation
 *                 - Non-zero: Write operation
 *
 * @return Returns 0 on success, -1 on access failure
 *
 * @details
 * The function performs the following operations:
 *
 * - If sys == 0 (VRAM location):
 *   * Checks if ZFB mode is active and address is in AGP aperture range
 *   * If in ZFB mode: Translates VRAM address to system memory and accesses SRAM
 *   * Otherwise: Accesses directly from VRAM using umr_access_vram()
 *
 * - If sys == 1 (System memory location):
 *   * Accesses directly from system memory using access_sram()
 */
static int access_translated_address(struct umr_vm_ai_state *vm, uint64_t addr, int sys, char *name, void *dst, uint32_t len, int write_en)
{
	if (sys == 0) {
		if (vm->vmctrl.zfb && (addr >= vm->vmctrl.agp_bot && addr < vm->vmctrl.agp_top)) {
			/* ZFB mode: translate VRAM address to system memory */
			addr = (addr - vm->vmctrl.agp_bot) + vm->vmctrl.agp_base;
			if (vm->asic->mem_funcs.access_sram(vm->asic, addr, len, dst, write_en) < 0) {
				vm->asic->mem_funcs.vm_message("[ERROR]: Cannot read %s entry at SYSRAM address %" PRIx64, name, addr);
				return -1;
			}
		} else {
			if (umr_access_vram(vm->asic, vm->partition, UMR_LINEAR_HUB, addr, len, dst, write_en, NULL) < 0) {
				vm->asic->mem_funcs.vm_message("[ERROR]: Cannot read %s entry at VRAM address %" PRIx64, name, addr);
				return -1;
			}
		}
	} else {
		/* System memory: access directly SRAM */
		if (vm->asic->mem_funcs.access_sram(vm->asic, addr, len, dst, write_en) < 0) {
			vm->asic->mem_funcs.vm_message("[ERROR]: Cannot read %s entry at SYSRAM address %" PRIx64, name, addr);
			return -1;
		}
	}
	return 0;
}

/**
 * @brief Access GPU mapped memory for GFX9+ platforms
 *
 * This function is responsible for accessing GPU-mapped memory on AMD GPUs with GFX9 and later architectures.
 * It handles virtual to physical address translation using page tables, which may span multiple levels depending on the configuration.
 *
 * @param asic Pointer to the UMR ASIC structure representing the GPU.
 * @param partition The VM partition to be used (refers to different INST of VM register blocks).
 * @param vmid The VMID that the address belongs to. Bits 8:15 indicate which hub the memory belongs to:
 *             - UMR_LINEAR_HUB: The memory is a physical address in VRAM.
 *             - UMR_GFX_HUB: The memory is a virtual address controlled by the GFX hub.
 *             - UMR_MM_HUB: The memory is a virtual address controlled by the MM hub.
 *             Bits 0:7 indicate which VM to access (if any).
 * @param address The address of the memory to access, must be word aligned.
 * @param size The number of bytes to read or write.
 * @param dst Pointer to the buffer to read from/write to.
 * @param write_en Set to 0 to read, non-zero to write.
 * @param vmdata Optional pointer to a structure for capturing page walk data.
 *
 * @return Returns 0 on success, -1 on error.
 *
 * @details
 * The function performs the following steps:
 * 1. Reads various VM context registers to determine the configuration of the page tables.
 * 2. Decodes the virtual address using the page table hierarchy (PDBs and PTBs) based on the PAGE_TABLE_DEPTH and PAGE_TABLE_BLOCK_SIZE settings.
 * 3. Handles different cases for PDEs and PTEs, including when a PDE acts as a PTE (further bit set).
 * 4. Translates the virtual address to a physical address using the decoded page table entries.
 * 5. Reads from or writes to the computed physical address in VRAM or system memory based on the PTE settings.
 * 6. Captures detailed information about the page walk process if `vmdata` is provided, which can be useful for debugging and analysis.
 */
int umr_access_vram_ai(struct umr_asic *asic, int partition,
				  uint32_t vmid, uint64_t address, uint32_t size,
			      void *dst, int write_en, struct umr_vm_pagewalk *vmdata)
{
	struct umr_vm_ai_state vm;
	uint64_t start_addr, va_mask, offset_mask = 0;
	uint32_t chunk_size;
	int current_depth;

	char buf[64];
	unsigned char *pdst = dst;
	char *hub, *vm0prefix, *regprefix;
	unsigned hubid;
	static const char *indentation = "                  \\->";

	memset(&vm, 0, sizeof vm);
	vm.asic = asic;
	vm.vmdata = vmdata;
	vm.partition = partition;
	vm.ip = umr_find_ip_block(vm.asic, "gfx", vm.asic->options.vm_partition);
	if (!vm.ip) {
		vm.asic->mem_funcs.vm_message("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
		return -1;
	}

	// if we are using user queues then save the VA in case we are using rumr
	if (vm.asic->options.user_queue.state.active) {
		vm.asic->options.user_queue.state.va = address;
	}

	// if we are capturing pagewalk data capture the inputs
	if (vm.vmdata) {
		vm.vmdata->va = address;
		vm.vmdata->vmid = vmid;
	}

	/*
	 * figure out the register prefix, in newer hardware a MM or GC
	 * prefix is added depending on which hub is being used.
	 * also determine which hub is being used.
	 */
	hubid = vmid & VM_HUB_MASK; /* the HUB selection from the caller is bits 8:15 of the vmid passed in */
	vmid &= VM_VMID_MASK; /* the actual VMID is bits 0:7 */
	vm0prefix = regprefix = "";
	switch (hubid) {
		case UMR_MM_VC0:
			hub = "mmhub";
			if (vm.asic->family == FAMILY_AI) {
				regprefix = "VML2VC0_";
				vm0prefix = "VMSHAREDVC0_";
			}
			break;
		case UMR_MM_VC1:
			hub = "mmhub";
			if (vm.asic->family == FAMILY_AI) {
				regprefix = "VML2VC1_";
				vm0prefix = "VMSHAREDVC1_";
			}
			break;
		case UMR_MM_HUB:
			hub = "mmhub";
			if (vm.asic->family >= FAMILY_NV)
				vm0prefix = regprefix = "MM";
			break;
		case UMR_GFX_HUB:
			hub = "gfx";
			if (vm.asic->family >= FAMILY_NV)
				vm0prefix = regprefix = "GC";
			break;
		case UMR_USER_HUB:
			hub = vm.asic->options.hub_name;
			break;
		default:
			vm.asic->mem_funcs.vm_message("[ERROR]: Invalid hub specified in umr_read_vram_ai()\n");
			return -1;
	}

	/* read vm registers */
	if (vm.asic->options.user_queue.state.active == 0 && vmid == 0) {
		/* only need system aperture registers (SAM) if we're using VMID 0 */
		sprintf(buf, "mm%sMC_VM_SYSTEM_APERTURE_HIGH_ADDR", vm0prefix);
			vm.registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		sprintf(buf, "mm%sMC_VM_SYSTEM_APERTURE_LOW_ADDR", vm0prefix);
			vm.registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		vm.vmctrl.system_aperture_low = ((uint64_t)vm.registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR) << VM_SYSTEM_APERTURE_SHIFT;
		vm.vmctrl.system_aperture_high = ((uint64_t)vm.registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR + 1) << VM_SYSTEM_APERTURE_SHIFT;
		sprintf(buf, "mm%sMC_VM_MX_L1_TLB_CNTL", vm0prefix);
			vm.registers.mmMC_VM_MX_L1_TLB_CNTL = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
	}

	sprintf(buf, "mm%sMC_VM_FB_LOCATION_BASE", vm0prefix);
		vm.registers.mmMC_VM_FB_LOCATION_BASE = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		vm.vmctrl.fb_bottom = ((uint64_t)vm.registers.mmMC_VM_FB_LOCATION_BASE) << VM_FB_OFFSET_SHIFT;
	sprintf(buf, "mm%sMC_VM_FB_LOCATION_TOP", vm0prefix);
		vm.registers.mmMC_VM_FB_LOCATION_TOP = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		vm.vmctrl.fb_top = ((uint64_t)vm.registers.mmMC_VM_FB_LOCATION_TOP + 1) << VM_FB_OFFSET_SHIFT;

	/* check if we are in ZFB mode */
	if (vm.vmctrl.fb_top < vm.vmctrl.fb_bottom) {
		vm.vmctrl.zfb = 1;
	} else {
		vm.vmctrl.zfb = 0;
	}

	if (vm.vmctrl.zfb) {
		sprintf(buf, "mm%sMC_VM_AGP_BASE", regprefix);
			vm.registers.mmMC_VM_AGP_BASE = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			vm.vmctrl.agp_base = ((uint64_t)vm.registers.mmMC_VM_AGP_BASE) << VM_FB_OFFSET_SHIFT;
		sprintf(buf, "mm%sMC_VM_AGP_BOT", regprefix);
			vm.registers.mmMC_VM_AGP_BOT = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			vm.vmctrl.agp_bot = ((uint64_t)vm.registers.mmMC_VM_AGP_BOT) << VM_FB_OFFSET_SHIFT;
		sprintf(buf, "mm%sMC_VM_AGP_TOP", regprefix);
			vm.registers.mmMC_VM_AGP_TOP = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			vm.vmctrl.agp_top = (((uint64_t)vm.registers.mmMC_VM_AGP_TOP + 1) << VM_FB_OFFSET_SHIFT) | 0xFFFFFFULL;
	} else {
		vm.vmctrl.agp_base = vm.vmctrl.agp_bot = vm.vmctrl.agp_top = 0;
	}

	/* initialize local copy of context registers */
		if (vm.asic->options.user_queue.state.active) {
			/* If we are bound to a client space (e.g., --user-queue) for a user queue let's copy from that structure */
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_START_ADDR_LO32;
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_START_ADDR_HI32;
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_LO32;
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_HI32;
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_LO32;
			vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32 = vm.asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_HI32;
			vm.page_table.page_table_depth = vm.asic->options.user_queue.client_info.vm_pagetable_info.num_level;
			vm.page_table.page_table_block_size = vm.asic->options.user_queue.client_info.vm_pagetable_info.block_size - VM_PDB_ENTRY_BITS; /* 0 == 9-bit block size */

			/* we aren't using VMIDs but we still need to get the layout of the register so we just jam VMID 8 in there... */
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_CNTL", regprefix, 8);
			vm.registers.mmVM_CONTEXTx_CNTL =
				umr_bitslice_compose_value_by_name_by_ip_by_instance(vm.asic, hub, partition, buf, "PAGE_TABLE_DEPTH", vm.page_table.page_table_depth) |
				umr_bitslice_compose_value_by_name_by_ip_by_instance(vm.asic, hub, partition, buf, "PAGE_TABLE_BLOCK_SIZE", vm.page_table.page_table_block_size);
		} else {
			/* we're not bound to a client space so let's read the context registers from MMIO space */
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_LO32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_LO32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_HI32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_CNTL", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_CNTL = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
				vm.page_table.page_table_depth      = umr_bitslice_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf, "PAGE_TABLE_DEPTH", vm.registers.mmVM_CONTEXTx_CNTL);
				vm.page_table.page_table_block_size = umr_bitslice_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf, "PAGE_TABLE_BLOCK_SIZE", vm.registers.mmVM_CONTEXTx_CNTL);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_LO32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
			sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_HI32", regprefix, vmid);
				vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32 = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		}

	if (vm.vmdata) {
		vm.vmdata->page_table_depth = vm.page_table.page_table_depth;
		vm.vmdata->page_table_block_size = vm.page_table.page_table_block_size;
	}

	/* setup all the state variables. */
		vm.page_table.page_table_start_addr = (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32 << VM_PAGE_TABLE_ADDR_LO32_SHIFT;
		vm.page_table.page_table_start_addr |= (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 << VM_PAGE_TABLE_ADDR_HI32_SHIFT;
		vm.page_table.page_table_end_addr = (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32 << VM_PAGE_TABLE_ADDR_LO32_SHIFT;
		vm.page_table.page_table_end_addr |= (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32 << VM_PAGE_TABLE_ADDR_HI32_SHIFT;
		vm.page_table.page_table_base_addr  = (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32 << 0;
		vm.page_table.page_table_base_addr  |= (uint64_t)vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32 << 32;

	/*
	 * for some firmwares when in GFXOFF power off state the registers
	 * read back as all F's
	 */
	if (vm.page_table.page_table_base_addr == 0xFFFFFFFFFFFFFFFFULL) {
		vm.asic->mem_funcs.vm_message(
			"PAGE_TABLE_BASE_ADDRESS read as all F's likely indicates that the ASIC is powered off (possibly via gfxoff)\n"
			"On GFX 10+ parts with gfxoff enabled a hang can occur, please disable with '--gfxoff 0'\n");
	}

	/* update addresses for APUs */
	if (vm.asic->is_apu) {
		if (umr_find_reg(vm.asic, "@mmVGA_MEMORY_BASE_ADDRESS") != 0xFFFFFFFF) {
			vm.registers.mmVGA_MEMORY_BASE_ADDRESS = umr_read_reg_by_name(vm.asic, "mmVGA_MEMORY_BASE_ADDRESS");
			vm.registers.mmVGA_MEMORY_BASE_ADDRESS_HIGH = umr_read_reg_by_name(vm.asic, "mmVGA_MEMORY_BASE_ADDRESS_HIGH");
		}
	}

	sprintf(buf, "mm%sMC_VM_FB_OFFSET", regprefix);
		vm.registers.mmMC_VM_FB_OFFSET = umr_read_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf);
		vm.vmctrl.vm_fb_offset      = (uint64_t)vm.registers.mmMC_VM_FB_OFFSET << VM_FB_OFFSET_SHIFT;

	if (vm.asic->options.verbose) {
		if (vm.asic->options.user_queue.state.active) {
			vm.asic->mem_funcs.vm_message("\n\n=== VM Decoding of address 0x%" PRIx64 " from user queue '%s' ===\n", address, vm.asic->options.user_queue.clientid);
		} else {
			vm.asic->mem_funcs.vm_message("\n\n=== VM Decoding of address %d@0x%" PRIx64 " ===\n", vmid, address);
		}
		vm.asic->mem_funcs.vm_message(
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_LO32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_LO32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_END_ADDR_HI32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_LO32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_HI32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_CNTL=0x%" PRIx32 "\n"
				"VMID%" PRIu32 ".page_table_block_size=%" PRIu64 "\n"
				"VMID%" PRIu32 ".page_table_depth=%d\n"
				"mmVGA_MEMORY_BASE_ADDRESS=0x%" PRIx32 "\n"
				"mmVGA_MEMORY_BASE_ADDRESS_HIGH=0x%" PRIx32 "\n"
				"mmMC_VM_FB_OFFSET=0x%" PRIx32 "\n"
				"mm%sMC_VM_MX_L1_TLB_CNTL=0x%" PRIx32 "\n"
				"mm%sMC_VM_SYSTEM_APERTURE_LOW_ADDR=0x%" PRIx32 "\n"
				"mm%sMC_VM_SYSTEM_APERTURE_HIGH_ADDR=0x%" PRIx32 "\n"
				"mm%sMC_VM_FB_LOCATION_BASE=0x%" PRIx32 "\n"
				"mm%sMC_VM_FB_LOCATION_TOP=0x%" PRIx32 "\n"
				"mm%sMC_VM_AGP_BASE=0x%" PRIx32 "\n"
				"mm%sMC_VM_AGP_BOT=0x%" PRIx32 "\n"
				"mm%sMC_VM_AGP_TOP=0x%" PRIx32 "\n",
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_LO32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_END_ADDR_HI32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32,
			regprefix, vmid, vm.registers.mmVM_CONTEXTx_CNTL,
			vmid, vm.page_table.page_table_block_size,
			vmid, vm.page_table.page_table_depth,
			vm.registers.mmVGA_MEMORY_BASE_ADDRESS,
			vm.registers.mmVGA_MEMORY_BASE_ADDRESS_HIGH,
			vm.registers.mmMC_VM_FB_OFFSET,
			vm0prefix, vm.registers.mmMC_VM_MX_L1_TLB_CNTL,
			vm0prefix, vm.registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
			vm0prefix, vm.registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
			vm0prefix, vm.registers.mmMC_VM_FB_LOCATION_BASE,
			vm0prefix, vm.registers.mmMC_VM_FB_LOCATION_TOP,
			regprefix, vm.registers.mmMC_VM_AGP_BASE,
			regprefix, vm.registers.mmMC_VM_AGP_BOT,
			regprefix, vm.registers.mmMC_VM_AGP_TOP
			);
	}

	/* in a flat depth==0 tree the PTB is the address span */
	if (vm.page_table.page_table_depth == 0) {
		vm.page_table.page_table_block_size = log2_vm_size(vm.page_table.page_table_start_addr, vm.page_table.page_table_end_addr) - VM_2MB_BLOCK_BITS;
	}

	/*
	 * the PAGE_TABLE_BASE_ADDR_* registers form the first level
	 * PDE value.  It is not read from a Page Directory Block (PDB)
	 */
	vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.page_table.page_table_base_addr);
	if (!vm.pde.pde_fields.system) {
		/* transform page_table_base (only if first PDB or the PTB is in VRAM) */
		vm.page_table.page_table_base_addr -= vm.vmctrl.vm_fb_offset;
	}

	/*
	 * if we are using VMID 0 we need to apply any address translations
	 * as specified by the System Aperature registers
	 */
	if (vm.asic->options.user_queue.state.active == 0 && vmid == 0) {
		uint32_t sam;

		sprintf(buf, "mm%sMC_VM_MX_L1_TLB_CNTL", vm0prefix);
		sam = umr_bitslice_reg_by_name_by_ip_by_instance(vm.asic, hub, partition, buf, "SYSTEM_ACCESS_MODE", vm.registers.mmMC_VM_MX_L1_TLB_CNTL);

		/* addresses in VMID0 need special handling w.r.t. PAGE_TABLE_START_ADDR */
		switch (sam) {
			case VM_SAM_PHYSICAL: /* physical access */
				return (dst) ? umr_access_vram(vm.asic, partition, UMR_LINEAR_HUB, address, size, dst, write_en, NULL) : 0;
			case VM_SAM_ALWAYS_VM: /* always VM access */
				break;
			case VM_SAM_INSIDE_MAPPED: /* inside system aperture is mapped, otherwise unmapped */
				if (!(address >= vm.vmctrl.system_aperture_low && address < vm.vmctrl.system_aperture_high)) {
					if (address >= vm.vmctrl.fb_bottom && address < vm.vmctrl.fb_top) {
						return (dst) ? umr_access_vram(vm.asic, partition, UMR_LINEAR_HUB, address - vm.vmctrl.fb_bottom, size, dst, write_en, NULL) : 0;
					} else {
						return (dst) ? umr_access_vram(vm.asic, partition, UMR_LINEAR_HUB, address, size, dst, write_en, NULL) : 0;
					}
				}
				break;
			case VM_SAM_INSIDE_UNMAPPED: /* inside system aperture is unmapped, otherwise mapped */
				if (address >= vm.vmctrl.system_aperture_low && address < vm.vmctrl.system_aperture_high) {
					if (vm.asic->options.verbose)
						vm.asic->std_msg("[VERBOSE]: Address is inside SAM\n[VERBOSE]: address: 0x%"PRIx64 ", system_apperture_low: 0x%"PRIx64 ", system_aperture_high: 0x%"PRIx64 ", fb_bottom: 0x%"PRIx64  ", fb_top: 0x%"PRIx64 "\n", address, vm.vmctrl.system_aperture_low, vm.vmctrl.system_aperture_high, vm.vmctrl.fb_bottom, vm.vmctrl.fb_top);
					if (address >= vm.vmctrl.fb_bottom && address < vm.vmctrl.fb_top) {
						return (dst) ? umr_access_vram(vm.asic, partition, UMR_LINEAR_HUB, address - vm.vmctrl.fb_bottom, size, dst, write_en, NULL) : 0;
					} else {
						return (dst) ? umr_access_vram(vm.asic, partition, UMR_LINEAR_HUB, address, size, dst, write_en, NULL) : 0;
					}
				}
				break;
			default:
				vm.asic->mem_funcs.vm_message("[WARNING]: Unhandled SYSTEM_ACCESS_MODE mode [%" PRIu32 "]\n", sam);
				break;
		}
	}

	/* Addresses after this point should be virtual and within the span of the root page table. */
	if (address < vm.page_table.page_table_start_addr || address > (vm.page_table.page_table_end_addr + VM_PAGE_OFFSET_MASK)) {
		vm.asic->mem_funcs.vm_message("[ERROR]: Address %u@%" PRIx64 " is not in range of memory spanned by root page table of VM context\n",
								   vmid, address);
		return -1;
	}

	/*
	 * fallthrough, and/or VMIDs for >= 1 are always mapped.
	 * Translated addresses are relative to the start of the page table so
	 * we subtract that from the VA first.
	*/
	address -= vm.page_table.page_table_start_addr;

	do { /* for all pages being accessed ... */

		/* reset the VA tally used to incrementally print out how much of the VA was consumed
		 * at every level of the translation.
		 */
		vm.va_tally = 0;

		/* the first PDE is the PAGE_TABLE_BASE_ADDR_* registers */
		vm.pde.pde_entry = vm.page_table.page_table_base_addr;

		// defaults in case we have to bail out before fully decoding to a PTE
		memset(&vm.pte, 0, sizeof vm.pte);
		vm.pde.pde_cnt = 0;
		vm.pte.ptb_mask = (1ULL << VM_PDB_ENTRY_BITS) - 1;
		vm.pte.pte_page_mask = (1ULL << VM_PAGE_SIZE_BITS) - 1;
		vm.pte.further = 0;
		vm.pde.pde_was_pte = 0;

		// decode the first PDE into it's component fields
		vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.pde.pde_entry);

		// The address of the next PDB/PTB is specified by the
		// page base address field of PDE's
		vm.pde.pde_address = vm.pde.pde_fields.pte_base_addr;

		/*
		 * Size of the first PDB depends on the total coverage of the
		 * page table and the PAGE_TABLE_BLOCK_SIZE.
		 * Entire table takes ceil(log2(total_vm_size)) bits
		 * All PDBs except the first one take 9 bits each
		 * The PTB covers at least 2 MiB (21 bits)
		 * And PAGE_TABLE_BLOCK_SIZE is log2(num 2MiB ranges PTB covers)
		 * As such, the formula for the size of the first PDB is:
		 *                       PDB1, PDB0, etc.      PTB covers at least 2 MiB
		 *                                        Block size can make it cover more
		 *   total_vm_bits - (9 * num_middle_pdbs) - (page_table_block_size + 21)
		 */
		int total_vm_bits = log2_vm_size(vm.page_table.page_table_start_addr, vm.page_table.page_table_end_addr);
		int top_pdb_bits = total_vm_bits - (VM_PDB_ENTRY_BITS * ((vm.page_table.page_table_depth?vm.page_table.page_table_depth:1) - 1)) - (vm.page_table.page_table_block_size + VM_2MB_BLOCK_BITS);

		// the VA mask for the top-most PDB
		va_mask = ((1ULL << top_pdb_bits) - 1) << (total_vm_bits - top_pdb_bits);

		// add this portion of the VA to the tally
		vm.va_tally |= address & va_mask;
		if ((vm.asic->options.no_fold_vm_decode || memcmp(&vm.pde.pde_fields, &vm.pde.pde_array[vm.pde.pde_cnt], sizeof vm.pde.pde_fields)) && vm.asic->options.verbose) {
			print_base(&vm);
		}
		memcpy(&vm.pde.pde_array[vm.pde.pde_cnt++], &vm.pde.pde_fields, sizeof vm.pde.pde_fields);
		if (vm.vmdata) {
			vm.vmdata->pde_idx[vm.vmdata->levels] = vm.pde.pde_idx;
			vm.vmdata->pde_va_mask[vm.vmdata->levels] = vm.va_tally + vm.page_table.page_table_start_addr;
			vm.vmdata->pde_fields[vm.vmdata->levels] = vm.pde.pde_fields;
			vm.vmdata->pde[vm.vmdata->levels++] = vm.pde.pde_entry;
		}

		current_depth = vm.page_table.page_table_depth;
		/* Walk every default level of the translation
		 * For flat tables this while loop is skipped.
		 */
		while (current_depth) {
			/*
			 * Every middle PDB has 512 entries, so shift a further 9 bits
			 * for every layer beyond the first one.
			 */
			int amount_to_shift = (total_vm_bits - top_pdb_bits) - ((vm.page_table.page_table_depth - current_depth)*VM_PDB_ENTRY_BITS);
			vm.pde.pde_idx = address >> amount_to_shift;

			/*
			 * Middle layers need the upper bits masked out after the right-shift.
			 * For the top-most layer, the va_mask is set above the while loop,
			 * so we can skip re-setting it here.
			 */
			if (current_depth != vm.page_table.page_table_depth) {
				vm.pde.pde_idx &= VM_PDB_ENTRY_MASK;
				va_mask = (uint64_t)VM_PDB_ENTRY_MASK << amount_to_shift;
			}

			/* read PDE entry from the PDE base address + PDE selector * 8
			* (Note: VM_PTB_ENTRY_SIZE works for both PTEs and PDEs as both are 8 bytes) */
			vm.pde.addr = vm.pde.pde_address + vm.pde.pde_idx * VM_PTB_ENTRY_SIZE;
			if (access_translated_address(&vm, vm.pde.addr, vm.pde.pde_fields.system, "PDE", &vm.pde.pde_entry, VM_PTB_ENTRY_SIZE, 0) < 0) {
				return -1;
			}
			vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.pde.pde_entry);			/* if the PDE isn't a PTE then print it out (if needed) */
			if (!vm.pde.pde_fields.pte) {
				vm.va_tally |= address & va_mask;
				if ((vm.asic->options.no_fold_vm_decode || memcmp(&vm.pde.pde_fields, &vm.pde.pde_array[vm.pde.pde_cnt], sizeof vm.pde.pde_fields)) && vm.asic->options.verbose) {
					vm.pte.pte_is_pde = 0;
					print_pde(&vm, indentation);
				}
				memcpy(&vm.pde.pde_array[vm.pde.pde_cnt++], &vm.pde.pde_fields, sizeof vm.pde.pde_fields);
				/* capture page walk data if requested */
				if (vm.vmdata) {
					vm.vmdata->pde_idx[vm.vmdata->levels] = vm.pde.pde_idx;
					vm.vmdata->pde_va_mask[vm.vmdata->levels] = vm.va_tally  + vm.page_table.page_table_start_addr;
					vm.vmdata->pde[vm.vmdata->levels] = vm.pde.pde_entry;
					vm.vmdata->pde_fields[vm.vmdata->levels++] = vm.pde.pde_fields;
				}
			} else {
				/*
				* This PDE has the P(te) bit set and should be treated as a PTE
				* so let's copy it over and jump ship
				*/
				vm.pte.pte_entry = vm.pde.pde_entry;
				vm.pte.pte_idx = vm.pde.pde_idx;
				vm.pte.addr = vm.pde.addr;
				vm.pde.pde_was_pte = 1;
				/* we're done decoding PDEs let's get ready to decode a PTE */
				prepare_pde_to_pte(&vm, current_depth, total_vm_bits);
				goto pde_is_pte;
			}

			/*
			* if the address is in VRAM then offset it by the
			* VM_FB_OFFSET value
			*/
			if (!vm.pde.pde_fields.system) {
				vm.pde.pde_fields.pte_base_addr -= vm.vmctrl.vm_fb_offset;
			}

			if (!vm.pde.pde_fields.valid) {
				// always bail decoding if the PDE is marked invalid
				goto invalid_page;
			}

			/* for the next round the address we're decoding is the phys address in the currently decoded PDE */
			--current_depth;
			vm.pde.pde_address = vm.pde.pde_fields.pte_base_addr;
		} /* while (current_depth) */

		/* At this point we traversed all the default PDE levels and are
		 * ready to process a PTE or PTE-Further so let's get ready to decode a PTE */
		prepare_pde_to_pte(&vm, current_depth, total_vm_bits);

		/*
		 * If we fall through to here, we are pointing into PTB, so pull out
		 * the index and mask.
		 * At minimum, each PTE is 4 KiB (12 bits)
		 * PDE0.BFS tells us how many of these 4 KiB page each PTE covers
		 * So add those bits in.
		 * We also calculated the PTE mask up above, to know how many PTEs are in this PTB
		 */
		vm.pte.pte_idx = (address >> (VM_PAGE_SIZE_BITS + vm.page_table.pde0_block_fragment_size)) & vm.pte.ptb_mask;
pte_further: // we jump here if a PTE-Further was found (from a PTE-as-PDE) so we need to do 2nd PTE fetch/decode stage
		/*
		 * now read PTE entry for this page which is located
		 * at the pte_base_addr of the last level of PDE decoded
		 * plus 8 times the PTE selector into the PTB
		 */
		vm.pte.addr = vm.pde.pde_fields.pte_base_addr + (vm.pte.pte_idx * VM_PTB_ENTRY_SIZE);
		if (access_translated_address(&vm, vm.pte.addr, vm.pde.pde_fields.system, "PTE", &vm.pte.pte_entry, VM_PTB_ENTRY_SIZE, 0) < 0) {
			return -1;
		}	
pde_is_pte:  // we jump here if a PDE was marked as a PTE
		/*
		 * at this point we have the PTE for this page in
		 * the struct pte_entry
		 */
		vm.pte.pte_fields = umr_decode_pte_entry(vm.asic, vm.pte.pte_entry);

		/*
		 * How many bits in the address are used to index into the PTB?
		 * If further is set, that means we jumped back to pde_is_pte,
		 * and the va_mask was properly set down there.
		 */
		if (!vm.pte.further) {
			/* total_vm_bits are all the bits in the VM space
			 * We want to ignore the top-most PDB, which uses top_pdb_bits
			 * We also want to ignore lower PDBs, which use 9 bits each
			 */
			int bits_to_use = vm.page_table.page_table_block_size + VM_2MB_BLOCK_BITS;

			/* At a minimum, we want to ignore the bottom 12 bits for a 4 KiB page */
			int lower_bits_to_ignore = VM_PAGE_SIZE_BITS;

			if (vm.pde.pde_fields.pte) {
				/*
				 * We are in here because we're in PDE{N} with P bit. N is current_depth - 1.
				 *
				 * vm.page_table.page_table_block_size + VM_2MB_BLOCK_BITS is the coverage of PTB.
				 *
				 * Each level above PTB (in this case, N + 1 levels) adds an additional 9 bits
				 * of coverage of the block the PDE-as-PTE is in.
				 */
				bits_to_use = MIN(VM_PDB_ENTRY_BITS * current_depth + vm.page_table.page_table_block_size + VM_2MB_BLOCK_BITS, (uint64_t)total_vm_bits);

				/*
				 * We are in here because we're in PDE{N} with P bit. N is current_depth - 1.
				 *
				 * In this case the coverage of the entry is just the coverage of a PDE{N}.
				 */
				lower_bits_to_ignore = MIN(VM_PDB_ENTRY_BITS * (current_depth - 1) + vm.page_table.page_table_block_size + VM_2MB_BLOCK_BITS, (uint64_t)total_vm_bits);
			} else {
				/*
				 * If we are at an actual PTE, then based on PDE0.BFS, we want to ignore
				 * some of the lowest bits.
				 * If PDE0.BFS=0, the bottom 12 bits are used to index within the page
				 * If PDE0.BFS=9, the bottom 21 bits are used to index within the page
				 * etc.  These are the bits we want to ignore, and we already put 12 in.
				 */
				lower_bits_to_ignore += vm.page_table.pde0_block_fragment_size;
			}
			va_mask = (1ULL << bits_to_use) - 1;
			va_mask = va_mask & ~((1ULL << lower_bits_to_ignore) - 1);
		}

		vm.pte.pte_is_pde = vm.pte.pte_fields.further && vm.pte.pte_fields.valid;
		vm.pte.pte_block_fragment_size = 0;
		vm.pte.pte_fields.pte_mask = va_mask;

		if (vm.ip->discoverable.maj >= 12 && !vm.pte.pte_fields.pte && vm.pte.pte_fields.valid) {
			vm.pte.pte_is_pde = 1;
		}

		if (vm.asic->options.verbose) {
			if (vm.pte.pte_is_pde) {
				vm.pde.addr = vm.pte.addr;
				vm.pde.pde_idx = vm.pte.pte_idx;
				vm.pde.pde_entry = vm.pte.pte_entry;
				vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.pte.pte_entry);
				vm.va_tally |= address & va_mask;
				print_pde(&vm, indentation);
			} else {
				vm.va_tally |= address & va_mask;
				print_pte(&vm, indentation);
			}
		}

		if (vm.pte.pte_is_pde) {
			/*
			 * If further bit is set, PTE is a PDE, so set pde_fields to PTE
			 * decoded as a PDE.
			 */
			if (vm.ip->discoverable.maj >= 11 && vm.pde.pde_fields.tfs_addr && current_depth == 0 && !vm.pde.pde_was_pte) {
				/*
				 * When PDE0 had TFS bit set, real address of PTB for PTE-as-PDE
				 * to point is PDE0.PBA + PTE-as-PDE.PBA.
				 */
				uint64_t tmp_addr = vm.pde.pde_fields.pte_base_addr;
				vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.pte.pte_entry);
				vm.pde.pde_fields.pte_base_addr += tmp_addr;
			} else {
				vm.pde.pde_fields = umr_decode_pde_entry(vm.asic, vm.pte.pte_entry);
				if (!vm.pde.pde_fields.system) {
					vm.pde.pde_fields.pte_base_addr -= vm.vmctrl.vm_fb_offset;
				}
			}

			/*
			 * Going to go one more layer deep, so now we need the Further-PTE's
			 * block_fragment_size. This tells us how many 4K pages each
			 * last-layer-PTE covers.
			 */
			vm.pte.pte_block_fragment_size = vm.pde.pde_fields.frag_size;

			/*
			 * Each entry covers the Further-PTE.block_fragment_size numbers
			 * of 4K pages so we can potentially ignore some low-order bits.
			 */
			int last_level_ptb_bits = VM_PAGE_SIZE_BITS + vm.pte.pte_block_fragment_size;
			vm.pte.pte_idx = address >> last_level_ptb_bits;

			/*
			 * The total size covered by the last-layer-PTB is a function of
			 * pde0_block_fragment_size, which tells us how many 4K entries the
			 * PTB covers.
			 * So number of bits needed to index the entries in the final PTE is:
			 */
			uint32_t num_entry_bits = vm.page_table.pde0_block_fragment_size - vm.pte.pte_block_fragment_size;
			/* Clamp the index to the new last-level PTB's size. */
			vm.pte.pte_idx &= ((1 << num_entry_bits) - 1);

			uint32_t upper_mask = (1ULL << (VM_PAGE_SIZE_BITS + vm.page_table.pde0_block_fragment_size)) - 1;
			vm.pte.pte_page_mask = (1ULL << last_level_ptb_bits) - 1;
			va_mask &= (upper_mask & ~vm.pte.pte_page_mask);

			vm.pde.pde_cnt++;
			vm.pte.further = 1;
			/* Jump back to translate from PTB pointed to by this PTE-as-PDE. */
			goto pte_further;
		}

		// Adjust the page base address if this is not a system page relative to the FB offset
		if (!vm.pte.pte_fields.system) {
			vm.pte.pte_fields.page_base_addr -= vm.vmctrl.vm_fb_offset;
		}

		// if the page is not marked valid and not a partially resident texture page then treat it
		// as invalid
		if (pdst && !vm.pte.pte_fields.prt && !vm.pte.pte_fields.valid) {
			goto invalid_page;
		}

		/* compute starting address */
		if (vm.pde.pde_was_pte && current_depth) {
			/* Each PTB covers 2^page_table_block_size * 2^21 bytes (2MiB). Each non-zero level of PDB has 2^9 PDEs. 
			 * We can end up here if a PDE has the PTE bit set and we bailed early in the page table walk
			 */
			offset_mask = (1ULL << ((current_depth - 1) * VM_PDB_ENTRY_BITS + (VM_2MB_BLOCK_BITS + vm.page_table.page_table_block_size))) - 1;
		} else if (!vm.pte.further) {
			offset_mask = (1ULL << ((current_depth * VM_PDB_ENTRY_BITS) + (VM_PAGE_SIZE_BITS + vm.page_table.pde0_block_fragment_size))) - 1;
		} else {
			offset_mask = (1ULL << (VM_PAGE_SIZE_BITS + vm.pte.pte_block_fragment_size)) - 1;
		}

		uint64_t page_start_addr = vm.asic->mem_funcs.gpu_bus_to_cpu_address(vm.asic, vm.pte.pte_fields.page_base_addr);
		start_addr = page_start_addr + (address & offset_mask);
		if (vm.vmdata) {
			vm.vmdata->pte_idx = vm.pte.pte_idx;
			vm.vmdata->pte_va_mask = vm.va_tally + vm.page_table.page_table_start_addr;
			vm.vmdata->pte_offset = address & offset_mask;
			vm.vmdata->pte = vm.pte.pte_entry;
			vm.vmdata->pte_fields = vm.pte.pte_fields;
			vm.vmdata->pte_page_mask = offset_mask;
			vm.vmdata->pte_start_addr = start_addr;
		}

		/* Compute the chunk size we can access from this page.
		 * If the size requested goes beyond the current page boundary
		 * then limit the chunk size to the page boundary.
		 */
		uint64_t page_end_addr = page_start_addr + vm.pte.pte_page_mask + 1;
		if (start_addr + size > page_end_addr) {
			chunk_size = page_end_addr - start_addr;
		} else {
			chunk_size = size;
		}

		if (vm.asic->options.verbose) {
			if (vm.pte.pte_fields.system == 1) {
				if (vm.vmdata) {
					vm.vmdata->sys_or_vram = 1;
					vm.vmdata->phys = start_addr;
				}
				vm.asic->mem_funcs.vm_message(
					"%s Computed address we will read from: %s:%" PRIx64
					", (reading: %" PRIu32 " bytes from a %" PRIu32 " byte page)\n",
					&indentation[VM_INDENTATION_BASE - (vm.pde.pde_cnt * VM_INDENTATION_PER_LEVEL) - VM_INDENTATION_PER_LEVEL],
					"sys",
					start_addr,
					chunk_size,
					offset_mask + 1);
			} else {
				if (vm.vmdata) {
					vm.vmdata->sys_or_vram = 0;
					vm.vmdata->phys = start_addr + vm.vmctrl.vm_fb_offset;
				}
				vm.asic->mem_funcs.vm_message(
					"%s Computed address we will read from: %s:%" PRIx64
					" (MCA:%" PRIx64"), (reading: %" PRIu32 " bytes from a %" PRIu64 " byte page)\n",
					&indentation[VM_INDENTATION_BASE - (vm.pde.pde_cnt * VM_INDENTATION_PER_LEVEL) - VM_INDENTATION_PER_LEVEL],
					"vram",
					start_addr,
					start_addr + vm.vmctrl.vm_fb_offset,
					chunk_size,
					offset_mask + 1);
			}
		}
		/* allow destination to be NULL to simply use decoder */
		if (vm.pte.pte_fields.valid) {
			if (pdst) {
				if (access_translated_address(&vm, start_addr, vm.pte.pte_fields.system, "user page", pdst, chunk_size, write_en) < 0) {
					return -1;
				}
				pdst += chunk_size;
			}
		} else {
			if (vm.asic->options.verbose && vm.pte.pte_fields.prt)
				vm.asic->mem_funcs.vm_message("Page is set as PRT so we cannot read/write it, skipping ahead.\n");

			if (pdst) {
				pdst += chunk_size;
			}
		}
		size -= chunk_size;
		address += chunk_size;
		/*
		 * only capture PDE/PTE of the first page we decode
		 * note this assumes there are no registers to read from vmdata once we enter
		 * this do/while loop.
		 */
		vm.vmdata = NULL;
	} while (size); /* loop for all pages being requested */

	if (vm.asic->options.verbose) {
		vm.asic->mem_funcs.vm_message("\n=== Completed VM Decoding ===\n");
	}

	if (vm.asic->mem_funcs.va_addr_decode) {
		vm.asic->mem_funcs.va_addr_decode(vm.pde.pde_array, vm.pde.pde_cnt, vm.pte.pte_fields);
	}

	return 0;

invalid_page:
	if (vm.asic->options.user_queue.state.active) {
		vm.asic->mem_funcs.vm_message("[ERROR]: No valid mapping for 0x%" PRIx64 " from user queue '%s'n", address, vm.asic->options.user_queue.clientid);
	} else {
		vm.asic->mem_funcs.vm_message("[ERROR]: No valid mapping for %d@0x%" PRIx64 "\n", vmid, address);
	}
	return -1;
}
