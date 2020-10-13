/*
 * Copyright 2020 Advanced Micro Devices, Inc.
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
#include "umrapp.h"
#include <inttypes.h>

/**
 * access_vram_via_mmio - Access VRAM via direct MMIO control
 */
int umr_access_vram_via_mmio(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en)
{
	uint32_t MM_INDEX, MM_INDEX_HI, MM_DATA;
	uint32_t *out = dst;

	// find registers
	if (asic->family >= FAMILY_NV) {
		MM_INDEX    = umr_find_reg(asic, "mmBIF_BX_PF_MM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "mmBIF_BX_PF_MM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "mmBIF_BX_PF_MM_DATA");
	} else {
		MM_INDEX    = umr_find_reg(asic, "mmMM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "mmMM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "mmMM_DATA");
	}

	if (MM_INDEX == 0xFFFFFFFF    ||
	    MM_INDEX_HI == 0xFFFFFFFF ||
	    MM_DATA == 0xFFFFFFFF) {
		fprintf(stderr, "[BUG]: Cannot find MM access registers for this asic!\n");
		return -1;
	}

	// scale up to byte address
	MM_INDEX *= 4;
	MM_INDEX_HI *= 4;
	MM_DATA *= 4;

	while (size) {
		asic->reg_funcs.write_reg(asic, MM_INDEX, address | 0x80000000, REG_MMIO);
		asic->reg_funcs.write_reg(asic, MM_INDEX_HI, address >> 31, REG_MMIO);
		if (write_en == 0)
			*out++ = asic->reg_funcs.read_reg(asic, MM_DATA, REG_MMIO);
		else
			asic->reg_funcs.write_reg(asic, MM_DATA, *out++, REG_MMIO);
		size -= 4;
		address += 4;
	}
	return 0;
}

/**
 * umr_access_vram_vi - Access GPU mapped memory for SI .. VI platforms
 */
static int umr_access_vram_vi(struct umr_asic *asic, uint32_t vmid,
			      uint64_t address, uint32_t size,
			      void *dst, int write_en)
{
	uint64_t start_addr, page_table_start_addr, page_table_base_addr,
		 page_table_block_size, pte_idx, pde_idx, pte_entry, pde_entry,
		 vm_fb_base, vm_fb_offset, pde_mask, pte_mask;
	uint32_t chunk_size, tmp;
	int page_table_depth;
	struct {
		uint64_t
			frag_size,
			pte_base_addr,
			valid;
	} pde_fields, pde_copy;
	struct {
		uint64_t
			page_base_addr,
			fragment,
			system,
			valid;
	} pte_fields;
	struct {
		uint32_t
			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR,
			mmVM_CONTEXTx_CNTL,
			mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR,
			mmMC_VM_FB_LOCATION,
			mmMC_VM_FB_OFFSET;
	} registers;
	char buf[64];
	unsigned char *pdst = dst;

	memset(&registers, 0, sizeof registers);
	memset(&pde_copy, 0xff, sizeof pde_copy);

	/*
	 * PTE format on VI:
	 * 63:40 reserved
	 * 39:12 4k physical page base address
	 * 11:7 fragment
	 * 6 write
	 * 5 read
	 * 4 exe
	 * 3 reserved
	 * 2 snooped
	 * 1 system
	 * 0 valid
	 *
	 * PDE format on VI:
	 * 63:59 block fragment size
	 * 58:40 reserved
	 * 39:1 physical base address of PTE
	 * bits 5:1 must be 0.
	 * 0 valid
	 */

	// read vm registers
	sprintf(buf, "mmVM_CONTEXT%d_PAGE_TABLE_START_ADDR", vmid ? 1 : 0);
		registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR = umr_read_reg_by_name(asic, buf);
		page_table_start_addr = (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR << 12;

	sprintf(buf, "mmVM_CONTEXT%d_CNTL", vmid ? 1 : 0);
		tmp = registers.mmVM_CONTEXTx_CNTL = umr_read_reg_by_name(asic, buf);
		page_table_depth      = umr_bitslice_reg_by_name(asic, buf, "PAGE_TABLE_DEPTH", tmp);
		page_table_block_size       = umr_bitslice_reg_by_name(asic, buf, "PAGE_TABLE_BLOCK_SIZE", tmp);

	sprintf(buf, "mmVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR", vmid);
		registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR = umr_read_reg_by_name(asic, buf);
		page_table_base_addr  = (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR << 12;

	registers.mmMC_VM_FB_LOCATION = umr_read_reg_by_name(asic, "mmMC_VM_FB_LOCATION");
	vm_fb_base  = ((uint64_t)registers.mmMC_VM_FB_LOCATION & 0xFFFF) << 24;

	registers.mmMC_VM_FB_OFFSET = umr_read_reg_by_name(asic, "mmMC_VM_FB_OFFSET");
	vm_fb_offset  = ((uint64_t)registers.mmMC_VM_FB_OFFSET & 0xFFFF) << 22;

	if (asic->options.verbose)
		asic->mem_funcs.vm_message(
				"mmVM_CONTEXT%d_PAGE_TABLE_START_ADDR=0x%" PRIx32 "\n"
				"mmVM_CONTEXT%d_PAGE_TABLE_BASE_ADDR=0x%" PRIx32 "\n"
				"mmVM_CONTEXT%d_CNTL=0x%" PRIx32 "\n"
				"mmMC_VM_FB_LOCATION=0x%" PRIx32 "\n"
				"mmMC_VM_FB_OFFSET=0x%" PRIx32 "\n",
			vmid ? 1 : 0,
			registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR,
			vmid ? 1 : 0,
			registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR,
			vmid ? 1 : 0,
			registers.mmVM_CONTEXTx_CNTL,
			registers.mmMC_VM_FB_LOCATION,
			registers.mmMC_VM_FB_OFFSET);

	address -= page_table_start_addr;

	do {
		if (page_table_depth == 1) {
			// decode addr into pte and pde selectors...
			pde_mask = ((1ULL << (40 - 12 - 9 - page_table_block_size)) - 1);
			pte_mask = ((1ULL << (9 + page_table_block_size)) - 1);

			pde_idx = (address >> (12 + 9 + page_table_block_size)) & pde_mask;
			pte_idx = (address >> 12) & pte_mask;

			// shift masks so we can use them later
			pte_mask <<= 12;
			pde_mask <<= (12 + 9 + page_table_block_size);

			// read PDE entry
			if (umr_read_vram(asic, UMR_LINEAR_HUB, page_table_base_addr + pde_idx * 8 - vm_fb_base, 8, &pde_entry)) {
				asic->mem_funcs.vm_message("[ERROR]:  Could not read PDE.\n");
				return -1;
			}

			// decode PDE values
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFF000ULL;
			pde_fields.valid         = pde_entry & 1;
			if ((asic->options.no_fold_vm_decode || memcmp(&pde_copy, &pde_fields, sizeof pde_fields)) && asic->options.verbose)
				asic->mem_funcs.vm_message("PDE=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 "\n",
						pde_entry,
						address & pde_mask,
						pde_fields.pte_base_addr,
						pde_fields.valid);
			memcpy(&pde_copy, &pde_fields, sizeof pde_fields);

			if (!pde_fields.valid) {
				if (pdst)
					goto invalid_page;

				// if we are vm-decode'ing just jump
				// to the next page
				start_addr = address & 0xFFF; // grab page offset so we can advance to next page
				goto next_page;
			}

			// now read PTE entry for this page
			if (umr_read_vram(asic, UMR_LINEAR_HUB, pde_fields.pte_base_addr + pte_idx*8 - vm_fb_base, 8, &pte_entry) < 0)
				return -1;

			// decode PTE values
			pte_fields.page_base_addr = pte_entry & 0xFFFFFFF000ULL;
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			if (asic->options.verbose)
				asic->mem_funcs.vm_message("\\-> PTE=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
					pte_entry,
					address & pte_mask,
					pte_fields.page_base_addr,
					pte_fields.valid,
					pte_fields.system);

			if (pdst && !pte_fields.valid)
				goto invalid_page;

			// compute starting address
			start_addr = asic->mem_funcs.gpu_bus_to_cpu_address(asic, pte_fields.page_base_addr) + (address & 0xFFF);

			if (!pte_fields.system)
				start_addr = start_addr - vm_fb_offset;

		} else {
			// depth == 0 == PTE only
			pte_idx = (address >> 12);

			if (umr_read_vram(asic, UMR_LINEAR_HUB, page_table_base_addr + pte_idx * 8 - vm_fb_base, 8, &pte_entry) < 0)
				return -1;

			// decode PTE values
			pte_fields.page_base_addr = pte_entry & 0xFFFFFFF000ULL;
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			if (asic->options.verbose)
				asic->mem_funcs.vm_message("PTE=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
					pte_entry,
					address & ~((uint64_t)0xFFF),
					pte_fields.page_base_addr,
					pte_fields.valid,
					pte_fields.system);

			if (pdst && !pte_fields.valid)
				goto invalid_page;

			// compute starting address
			start_addr = asic->mem_funcs.gpu_bus_to_cpu_address(asic, pte_fields.page_base_addr) + (address & 0xFFF);
		}

next_page:
		// read upto 4K from it
		if (((start_addr & 0xFFF) + size) & ~0xFFF) {
			chunk_size = 0x1000 - (start_addr & 0xFFF);
		} else {
			chunk_size = size;
		}

		// allow destination to be NULL to simply use decoder
		if (pdst) {
			if (pte_fields.system) {
				int r;
				r = asic->mem_funcs.access_sram(asic, start_addr, chunk_size, pdst, write_en);
				if (r < 0) {
					fprintf(stderr, "[ERROR]: Cannot access system ram, perhaps CONFIG_STRICT_DEVMEM is set in your kernel config?\n");
					fprintf(stderr, "[ERROR]: Alternatively download and install /dev/fmem\n");
					return -1;
				}
			} else {
				if (umr_access_vram(asic, UMR_LINEAR_HUB, start_addr, chunk_size, pdst, write_en) < 0) {
					fprintf(stderr, "[ERROR]: Cannot access VRAM\n");
					return -1;
				}
			}
			pdst += chunk_size;
		}
		size -= chunk_size;
		address += chunk_size;
	} while (size);
	return 0;

invalid_page:
	asic->mem_funcs.vm_message("[ERROR]: No valid mapping for %u@%" PRIx64 "\n", vmid, address);
	return -1;
}

/**
 * umr_access_vram_ai - Access GPU mapped memory for GFX9+ platforms
 */
static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
			      uint64_t address, uint32_t size,
			      void *dst, int write_en)
{
	uint64_t start_addr, page_table_start_addr, page_table_base_addr,
		 page_table_block_size, pte_idx, pde_idx, pte_entry, pde_entry,
		 pde_address, vm_fb_offset,
		 va_mask, offset_mask, system_aperture_low, system_aperture_high,
		 fb_top, fb_bottom, pte_page_mask, agp_base, agp_bot, agp_top, prev_addr;
	uint32_t chunk_size, tmp, pde0_block_fragment_size;
	int pde_cnt, current_depth, page_table_depth, zfb, further;
	struct {
		uint32_t
			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
			mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
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
	struct {
		uint64_t
			frag_size,
			pte_base_addr,
			valid,
			system,
			cache,
			pte;
	} pde_fields, pde_array[8];
	struct {
		uint64_t
			page_base_addr,
			fragment,
			system,
			valid,
			prt,
			further;
	} pte_fields;
	char buf[64];
	unsigned char *pdst = dst;
	char *hub, *vm0prefix, *regprefix;
	unsigned hubid;
	static const char *indentation = "               \\->";

	memset(&registers, 0, sizeof registers);
	memset(&pde_array, 0xff, sizeof pde_array);

	/*
	 * PTE format on AI:
	 * 47:12 4k physical page base address
	 * 11:7 fragment
	 * 6 write
	 * 5 read
	 * 4 exe
	 * 3 reserved
	 * 2 snooped
	 * 1 system
	 * 0 valid
	 *
	 * PDE format on AI:
	 * 63:59 block fragment size
	 * 58:40 reserved
	 * 47:6 physical base address of PTE
	 * 2 cache coherent/snoop
	 * 1 system
	 * 0 valid
	 */

	hubid = vmid & 0xFF00;
	vmid &= 0xFF;

	vm0prefix = regprefix = "";
	switch (hubid) {
		case UMR_MM_VC0:
			hub = "mmhub";
			if (asic->family == FAMILY_AI) {
				regprefix = "VML2VC0_";
				vm0prefix = "VMSHAREDVC0_";
			}
			break;
		case UMR_MM_VC1:
			hub = "mmhub";
			if (asic->family == FAMILY_AI) {
				regprefix = "VML2VC1_";
				vm0prefix = "VMSHAREDVC1_";
			}
			break;
		case UMR_MM_HUB:
			hub = "mmhub";
			if (asic->family == FAMILY_NV)
				vm0prefix = regprefix = "MM";
			break;
		case UMR_GFX_HUB:
			hub = "gfx";
			if (asic->family == FAMILY_NV)
				vm0prefix = regprefix = "GC";
			break;
		case UMR_USER_HUB:
			hub = asic->options.hub_name;
			break;
		default:
			fprintf(stderr, "[ERROR]: Invalid hub specified in umr_read_vram_ai()\n");
			return -1;
	}

	// read vm registers
	if (vmid == 0) {
		// only need system aperture registers if we're using VMID 0
		sprintf(buf, "mm%sMC_VM_SYSTEM_APERTURE_HIGH_ADDR", vm0prefix);
			registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR = umr_read_reg_by_name_by_ip(asic, hub, buf);
		sprintf(buf, "mm%sMC_VM_SYSTEM_APERTURE_LOW_ADDR", vm0prefix);
			registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR = umr_read_reg_by_name_by_ip(asic, hub, buf);
		system_aperture_low = ((uint64_t)registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR) << 18;
		system_aperture_high = ((uint64_t)registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR) << 18;
		sprintf(buf, "mm%sMC_VM_MX_L1_TLB_CNTL", vm0prefix);
			registers.mmMC_VM_MX_L1_TLB_CNTL = umr_read_reg_by_name_by_ip(asic, hub, buf);
	}

	sprintf(buf, "mm%sMC_VM_FB_LOCATION_BASE", vm0prefix);
		registers.mmMC_VM_FB_LOCATION_BASE = umr_read_reg_by_name_by_ip(asic, hub, buf);
		fb_bottom = ((uint64_t)registers.mmMC_VM_FB_LOCATION_BASE) << 24;
	sprintf(buf, "mm%sMC_VM_FB_LOCATION_TOP", vm0prefix);
		registers.mmMC_VM_FB_LOCATION_TOP = umr_read_reg_by_name_by_ip(asic, hub, buf);
		fb_top = ((uint64_t)registers.mmMC_VM_FB_LOCATION_TOP) << 24;

	// check if we are in ZFB mode
	if (fb_top < fb_bottom)
		zfb = 1;
	else
		zfb = 0;

	if (zfb) {
		sprintf(buf, "mm%sMC_VM_AGP_BASE", regprefix);
			registers.mmMC_VM_AGP_BASE = umr_read_reg_by_name_by_ip(asic, hub, buf);
			agp_base = ((uint64_t)registers.mmMC_VM_AGP_BASE) << 24;
		sprintf(buf, "mm%sMC_VM_AGP_BOT", regprefix);
			registers.mmMC_VM_AGP_BOT = umr_read_reg_by_name_by_ip(asic, hub, buf);
			agp_bot = ((uint64_t)registers.mmMC_VM_AGP_BOT) << 24;
		sprintf(buf, "mm%sMC_VM_AGP_TOP", regprefix);
			registers.mmMC_VM_AGP_TOP = umr_read_reg_by_name_by_ip(asic, hub, buf);
			agp_top = (((uint64_t)registers.mmMC_VM_AGP_TOP) << 24) | 0xFFFFFFULL;
	} else {
		agp_base = agp_bot = agp_top = 0;
	}

	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_LO32", regprefix, vmid);
		registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
		page_table_start_addr = (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32 << 12;
	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32", regprefix, vmid);
		registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
		page_table_start_addr |= (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32 << 44;

	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_CNTL", regprefix, vmid);
		tmp = registers.mmVM_CONTEXTx_CNTL = umr_read_reg_by_name_by_ip(asic, hub, buf);
		page_table_depth      = umr_bitslice_reg_by_name_by_ip(asic, hub, buf, "PAGE_TABLE_DEPTH", tmp);
		page_table_block_size = umr_bitslice_reg_by_name_by_ip(asic, hub, buf, "PAGE_TABLE_BLOCK_SIZE", tmp);

	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_LO32", regprefix, vmid);
		registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
		page_table_base_addr  = (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32 << 0;
	sprintf(buf, "mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_BASE_ADDR_HI32", regprefix, vmid);
		registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32 = umr_read_reg_by_name_by_ip(asic, hub, buf);
		page_table_base_addr  |= (uint64_t)registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32 << 32;

	if (page_table_base_addr == 0xFFFFFFFFFFFFFFFFULL)
		asic->mem_funcs.vm_message(
			"PAGE_TABLE_BASE_ADDRESS read as all F's likely indicates that the ASIC is powered off (possibly via gfxoff)\n"
			"On GFX 10+ parts with gfxoff enabled a hang can occur, please disable with '--gfxoff 0'\n");

	// update addresses for APUs
	if (!strcmp(asic->asicname, "raven1")) {
		registers.mmVGA_MEMORY_BASE_ADDRESS = umr_read_reg_by_name(asic, "mmVGA_MEMORY_BASE_ADDRESS");
		registers.mmVGA_MEMORY_BASE_ADDRESS_HIGH = umr_read_reg_by_name(asic, "mmVGA_MEMORY_BASE_ADDRESS_HIGH");
		sprintf(buf, "mm%sMC_VM_FB_OFFSET", regprefix);
		registers.mmMC_VM_FB_OFFSET = umr_read_reg_by_name_by_ip(asic, hub, buf);
		vm_fb_offset      = (uint64_t)registers.mmMC_VM_FB_OFFSET << 24;
	} else {
		vm_fb_offset = 0;
	}

	if (asic->options.verbose) {
		asic->mem_funcs.vm_message("\n\n=== VM Decoding of address %d@0x%" PRIx64 " ===\n", vmid, address);
		asic->mem_funcs.vm_message(
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_LO32=0x%" PRIx32 "\n"
				"mm%sVM_CONTEXT%" PRIu32 "_PAGE_TABLE_START_ADDR_HI32=0x%" PRIx32 "\n"
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
			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_LO32,
			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_START_ADDR_HI32,
			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_LO32,
			regprefix, vmid, registers.mmVM_CONTEXTx_PAGE_TABLE_BASE_ADDR_HI32,
			regprefix, vmid, registers.mmVM_CONTEXTx_CNTL,
			vmid, page_table_block_size,
			vmid, page_table_depth,
			registers.mmVGA_MEMORY_BASE_ADDRESS,
			registers.mmVGA_MEMORY_BASE_ADDRESS_HIGH,
			registers.mmMC_VM_FB_OFFSET,
			vm0prefix, registers.mmMC_VM_MX_L1_TLB_CNTL,
			vm0prefix, registers.mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
			vm0prefix, registers.mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
			vm0prefix, registers.mmMC_VM_FB_LOCATION_BASE,
			vm0prefix, registers.mmMC_VM_FB_LOCATION_TOP,
			regprefix, registers.mmMC_VM_AGP_BASE,
			regprefix, registers.mmMC_VM_AGP_BOT,
			regprefix, registers.mmMC_VM_AGP_TOP
			);
	}

	// transform page_table_base
	page_table_base_addr -= vm_fb_offset;

	// convert some defaults to actual values AFTER printing out to user
	// page_table_block_size of 0 means 9 (512 entries)
	if (!page_table_block_size)
		page_table_block_size = 9;
	pde0_block_fragment_size = 0;

	if (vmid == 0) {
		uint32_t sam;

		sprintf(buf, "mm%sMC_VM_MX_L1_TLB_CNTL", vm0prefix);
		sam = umr_bitslice_reg_by_name_by_ip(asic, hub, buf, "SYSTEM_ACCESS_MODE", registers.mmMC_VM_MX_L1_TLB_CNTL);

#if 0
		if (asic->options.verbose)
			asic->mem_funcs.vm_message("SYSTEM_ACCESS_MODE == %" PRIu32 "\n", sam);

		if (asic->options.verbose)
			asic->mem_funcs.vm_message("%" PRIx64 ", %" PRIx64 ", %" PRIx64 ", %" PRIx64 ", %" PRIx64 ", %" PRIx64 "\n", system_aperture_low, address, system_aperture_high, fb_bottom, fb_top, vm_fb_offset);
#endif

		// addresses in VMID0 need special handling w.r.t. PAGE_TABLE_START_ADDR
		switch (sam) {
			case 0: // physical access
				return (dst) ? umr_access_vram(asic, UMR_LINEAR_HUB, address, size, dst, write_en) : 0;
			case 1: // always VM access
				break;
			case 2: // inside system aperture is mapped, otherwise unmapped
				if (!(address >= system_aperture_low && address < system_aperture_high)) {
					if (address >= fb_bottom && address < fb_top)
						//return (dst) ? umr_access_vram(asic, UMR_LINEAR_HUB, address - fb_bottom + vm_fb_offset, size, dst, write_en) : 0;
						return (dst) ? asic->mem_funcs.access_sram(asic, address - fb_bottom + vm_fb_offset, size, dst, write_en) : 0;
					else
						return (dst) ? umr_access_vram(asic, UMR_LINEAR_HUB, address, size, dst, write_en) : 0;
				}
				break;
			case 3: // inside system aperture is unmapped, otherwise mapped
				if (address >= system_aperture_low && address < system_aperture_high) {
					if (address >= fb_bottom && address < fb_top)
						//return (dst) ? umr_access_vram(asic, UMR_LINEAR_HUB, address - fb_bottom + vm_fb_offset, size, dst, write_en) : 0;
						return (dst) ? asic->mem_funcs.access_sram(asic, address - fb_bottom + vm_fb_offset, size, dst, write_en) : 0;
					else
						return (dst) ? umr_access_vram(asic, UMR_LINEAR_HUB, address, size, dst, write_en) : 0;
				}
				break;
			default:
				asic->mem_funcs.vm_message("[WARNING]: Unhandled SYSTEM_ACCESS_MODE mode [%" PRIu32 "]\n", sam);
				break;
		}
	}

	// fallthrough, and/or VMIDs for >= 1 are always mapped
	address -= page_table_start_addr;

	do {
		pde_entry = page_table_base_addr;

		// defaults in case we have to bail out before fully decoding to a PTE
		pde_cnt = 0;
		pte_page_mask = (1ULL << 12) - 1;
		further = 0;

		if (page_table_depth >= 1) {
			// decode PDE values
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFF000ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.cache         = (pde_entry >> 2) & 1;
			pde_fields.pte           = (pde_entry >> 54) & 1;

			// AI+ supports more than 1 level of PDEs so we iterate for all of the depths
			pde_address = pde_fields.pte_base_addr;

			// TODO: Should "page_table_block_size" just be 9 to account for potential PTB1 selectors?
			va_mask = ((uint64_t)511 << ((page_table_depth)*9 + (12 + pde0_block_fragment_size + page_table_block_size)));

			if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose)
				asic->mem_funcs.vm_message("BASE=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 "\n",
						pde_entry,
						address & va_mask,
						pde_fields.pte_base_addr,
						pde_fields.valid,
						pde_fields.system,
						pde_fields.cache,
						pde_fields.pte);
			memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);

			current_depth = page_table_depth;
			while (current_depth) {
				// PDE selectors are 9 bits and they start from the top PDE2 down to PDE0 (or sooner if PDE-is-PTE is asserted)
				// So we drop from 48 down to PDE0 and then add back 9 bits for every level above that we are.
				pde_idx = address >> ((48 - (9 * page_table_depth)) + (9 * (current_depth - 1)));
				// mask only 9 bits
				pde_idx &= (1ULL << 9) - 1;

				// TODO: redo va_mask
				va_mask = ((uint64_t)511 << ((page_table_depth - pde_cnt)*9 + (12 + pde0_block_fragment_size + page_table_block_size)));

				// read PDE entry
				prev_addr = pde_address + pde_idx * 8;
				if (pde_fields.system == 0) {
					uint64_t pde_addr = prev_addr;
					int r;

					// if in ZFB mode translate VRAM addresses as necessary
					if (zfb && (pde_addr >= agp_bot && pde_addr < agp_top)) {
						pde_addr = (pde_addr - agp_bot) + agp_base;
						r = asic->mem_funcs.access_sram(asic, pde_addr, 8, &pde_entry, 0);
						if (r < 0) {
							asic->mem_funcs.vm_message("[ERROR]: Could not read PDE from ZFB (SYSTEM RAM)\n");
							return -1;
						}
					} else {
						if (umr_read_vram(asic, UMR_LINEAR_HUB, pde_addr, 8, &pde_entry) < 0) {
							asic->mem_funcs.vm_message("[ERROR]: Could not read PDE from VRAM\n");
							return -1;
						}
					}
				} else {
					int r;
					r = asic->mem_funcs.access_sram(asic, prev_addr, 8, &pde_entry, 0);
					if (r < 0) {
						asic->mem_funcs.vm_message("[ERROR]: Could not read PDE from SYSTEM RAM: %" PRIx64 "\n", pde_address + pde_idx * 8);
						return -1;
					}
				}

				// decode PDE values
				pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
				pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFF000ULL;
				pde_fields.valid         = pde_entry & 1;
				pde_fields.system        = (pde_entry >> 1) & 1;
				pde_fields.cache         = (pde_entry >> 2) & 1;
				pde_fields.pte           = (pde_entry >> 54) & 1;
				if (current_depth == 1) {
					pde0_block_fragment_size = pde_fields.frag_size;
					// page_table_block_size is the number of entries in a PTB that spans 2MB
					page_table_block_size = 21 - (12 + pde0_block_fragment_size);
					pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
					if (asic->options.verbose)
						asic->mem_funcs.vm_message("pde0.pte = %u\npde0.block_fragment_size = %u\npage_table_block_size = %u\n",
							(unsigned)pde_fields.pte,
							(unsigned)pde0_block_fragment_size,
							(unsigned)page_table_block_size);
				}
				if (!pde_fields.pte) {
					if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose) {
						asic->mem_funcs.vm_message("%s PDE%d@{0x%" PRIx64 "/%" PRIx64 "}=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 "\n",
								&indentation[15-pde_cnt*3],
								page_table_depth - pde_cnt,
								prev_addr,
								pde_idx,
								pde_entry,
								address & va_mask,
								pde_fields.pte_base_addr,
								pde_fields.valid,
								pde_fields.system,
								pde_fields.cache,
								pde_fields.pte,
								pde_fields.frag_size);
						memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
					}
				} else {
					pte_entry = pde_entry;
					pte_idx = 0;
					goto pde_is_pte;
				}

				if (!pde_fields.system)
					pde_fields.pte_base_addr -= vm_fb_offset;

				if (!pde_fields.valid) {
					if (pdst)
						goto invalid_page;
					// jump to next page if in
					// vm-decode mode
					pte_fields.prt = 0;
					pte_fields.valid = 0;
					pte_fields.system = 0;
					start_addr = address & 0xFFF; // grab page offset so we can advance to next page
					goto next_page;
				}

				// for the next round the address we're decoding is the phys address in the currently decoded PDE
				--current_depth;
				pde_address = pde_fields.pte_base_addr;
			}

			// read PTE selector (to select from PTB0)
			// TODO:  support for page_table_block_size > 9
			pte_idx = (address >> (12 + pde0_block_fragment_size)) & ((1ULL << page_table_block_size) - 1);
pte_further:
			// now read PTE entry for this page
			prev_addr = pde_fields.pte_base_addr + pte_idx*8;
			if (pde_fields.system == 0) {
				uint64_t pte_addr = prev_addr;
				int r;

				// if in ZFB mode translate VRAM addresses as necessary
				if (zfb && (pte_addr >= agp_bot && pte_addr < agp_top)) {
					pte_addr = (pte_addr - agp_bot) + agp_base;
					r = asic->mem_funcs.access_sram(asic, pte_addr, 8, &pte_entry, 0);
					if (r < 0) {
						asic->mem_funcs.vm_message("[ERROR]: Cannot read PTE entry at SYSRAM address %" PRIx64, pte_addr);
						return -1;
					}
				} else {
					if (umr_read_vram(asic, UMR_LINEAR_HUB, pte_addr, 8, &pte_entry) < 0) {
						asic->mem_funcs.vm_message("[ERROR]: Cannot read PTE entry at VRAM address %" PRIx64, pte_addr);
						return -1;
					}
				}
			} else {
				int r;
				r = asic->mem_funcs.access_sram(asic, prev_addr, 8, &pte_entry, 0);
				if (r < 0)
					return -1;
			}

			// decode PTE values
pde_is_pte:
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			pte_fields.prt            = (pte_entry >> 61) & 1;
			pte_fields.further        = (pte_entry >> 56) & 1;
			pte_fields.page_base_addr = pte_entry & (pte_fields.further ? 0xFFFFFFFFFFC0ULL : 0xFFFFFFFFF000ULL);

			if (asic->options.verbose)
				asic->mem_funcs.vm_message("%s %s@{0x%" PRIx64 "/%" PRIx64"}==0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 ", F=%" PRIu64 "\n",
					&indentation[15-pde_cnt*3],
					(pte_fields.further) ? "PTE-FURTHER" : "PTE",
					prev_addr,
					pte_idx,
					pte_entry,
					address & (((1ULL << page_table_block_size) - 1) << (12 + pde0_block_fragment_size)),
					pte_fields.page_base_addr,
					pte_fields.valid,
					pte_fields.system,
					pte_fields.prt,
					pte_fields.fragment,
					pte_fields.further);

			if (pte_fields.further) {
				if (page_table_block_size == 9) {
					// this case doesn't make sense unless we support PTBS > 9
					asic->mem_funcs.vm_message("[ERROR]: PTE.further is set and *CNTL.PAGE_TABLE_BLOCK_SIZE is 9...\n");
					return -1;
				} else {
					pte_idx = (address >> 12) & ((1ULL << pde0_block_fragment_size) - 1);
					pte_page_mask = (1ULL << 12) - 1;

					// grab PTE base address from the PTE that has the F bit set.
					pde_fields.pte_base_addr = pte_fields.page_base_addr;
					further = 1;
					goto pte_further;
				}
			}

			if (!pte_fields.system)
				pte_fields.page_base_addr -= vm_fb_offset;

			if (pdst && !pte_fields.prt && !pte_fields.valid)
				goto invalid_page;

			// compute starting address
			// this also accounts for PDE-is-PTE masking since current_depth > 0 at this point
			// if we are processing a PTE leaf node then the page size is 12 bits
			if (!further)
				offset_mask = (1ULL << ((current_depth * 9) + (12 + pde0_block_fragment_size))) - 1;
			else
				offset_mask = (1ULL << 12) - 1; // offset masks are always 12-bits wide with PTE.further set

			start_addr = asic->mem_funcs.gpu_bus_to_cpu_address(asic, pte_fields.page_base_addr) + (address & offset_mask);
		} else {
			// in AI+ the BASE_ADDR is treated like a PDE entry...
			// decode PDE values
			pde_fields.frag_size     = (page_table_base_addr >> 59) & 0x1F;
			pde0_block_fragment_size = pde_fields.frag_size;
			pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;
			pde_fields.pte_base_addr = page_table_base_addr & 0xFFFFFFFFF000ULL;
			pde_fields.system        = (page_table_base_addr >> 1) & 1;
			pde_fields.valid         = page_table_base_addr & 1;

			if ((asic->options.no_fold_vm_decode || memcmp(&pde_array[0], &pde_fields, sizeof pde_fields)) && asic->options.verbose)
				asic->mem_funcs.vm_message("PDE=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", FS=%" PRIu64 "\n",
						page_table_base_addr,
						pde_fields.pte_base_addr,
						pde_fields.valid,
						pde_fields.system,
						pde_fields.frag_size);
			memcpy(&pde_array[0], &pde_fields, sizeof pde_fields);

			if (!pde_fields.valid)
				return -1;

			// PTE addr = baseaddr[47:6] + (logical - start) >> fragsize)
			pte_idx = (address >> (12 + pde0_block_fragment_size));

			if (umr_read_vram(asic, UMR_LINEAR_HUB, pde_fields.pte_base_addr + pte_idx * 8, 8, &pte_entry) < 0)
				return -1;

			// decode PTE values
			pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL;
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			pte_fields.prt            = 0;

			if (asic->options.verbose)
				asic->mem_funcs.vm_message("\\-> PTE=0x%016" PRIx64 ", VA=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", F=%" PRIu64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
					pte_entry,
					address & ~((uint64_t)0xFFF),
					pte_fields.page_base_addr,
					pte_fields.fragment,
					pte_fields.valid,
					pte_fields.system);

			if (pdst && !pte_fields.valid)
				goto invalid_page;

			// compute starting address
			start_addr = asic->mem_funcs.gpu_bus_to_cpu_address(asic, pte_fields.page_base_addr) + (address & 0xFFF);
		}

next_page:
		// read upto 4K from it
		// FIXME: Support page sizes >4KB
		if (((start_addr & pte_page_mask) + size) & ~pte_page_mask) {
			chunk_size = (1 + pte_page_mask) - (start_addr & pte_page_mask);
		} else {
			chunk_size = size;
		}
		if (asic->options.verbose) {
			asic->mem_funcs.vm_message("%s Computed address we will read from: %s:%" PRIx64 " (reading: %" PRIu32 " bytes)\n",
										&indentation[15-pde_cnt*3-3],
										pte_fields.system ? "sys" : "vram",
										start_addr,
										chunk_size);
		}
		// allow destination to be NULL to simply use decoder
		if (pte_fields.valid) {
			if (pdst) {
				if (pte_fields.system) {
					int r;
					r = asic->mem_funcs.access_sram(asic, start_addr, chunk_size, pdst, write_en);
					if (r < 0) {
						fprintf(stderr, "[ERROR]: Cannot access system ram, perhaps CONFIG_STRICT_DEVMEM is set in your kernel config?\n");
						fprintf(stderr, "[ERROR]: Alternatively download and install /dev/fmem\n");
						return -1;
					}
				} else {
					uint64_t new_addr = start_addr;
					int r;
					// if in zfb mode apply vram/agp offset as necessary
					if (zfb && (new_addr >= agp_bot && new_addr < agp_top)) {
						new_addr = (new_addr - agp_bot) + agp_base;
						r = asic->mem_funcs.access_sram(asic, new_addr, chunk_size, pdst, write_en);
						if (r < 0) {
							fprintf(stderr, "[ERROR]: Cannot access system ram, perhaps CONFIG_STRICT_DEVMEM is set in your kernel config?\n");
							fprintf(stderr, "[ERROR]: Alternatively download and install /dev/fmem\n");
							return -1;
						}
					} else {
						if (umr_access_vram(asic, UMR_LINEAR_HUB, new_addr, chunk_size, pdst, write_en) < 0) {
							fprintf(stderr, "[ERROR]: Cannot access VRAM\n");
							return -1;
						}
					}
				}
				pdst += chunk_size;
			}
		} else {
			if (asic->options.verbose && pte_fields.prt)
				asic->mem_funcs.vm_message("Page is set as PRT so we cannot read/write it, skipping ahead.\n");

			if (pdst)
				pdst += chunk_size;
		}
		size -= chunk_size;
		address += chunk_size;
	} while (size);
	if (asic->options.verbose)
		asic->mem_funcs.vm_message("\n=== Completed VM Decoding ===\n");
	return 0;

invalid_page:
	asic->mem_funcs.vm_message("[ERROR]: No valid mapping for %u@%" PRIx64 "\n", vmid, address);
	return -1;
}

/** round_up_pot -- Round up value to next power of two */
static uint64_t round_up_pot(uint64_t x)
{
	uint64_t y = (64ULL * 1024 * 1024); // start at 64MiB
	while (y < x)
		y <<= 1;
	return y;
}

/**
 * umr_access_vram - Access GPU mapped memory
 *
 * @vmid:	The VMID that the address belongs to.  The bits 8:15
 * 			indicate which hub the memory belongs to:
 *
 * 				UMR_LINEAR_HUB: The memory is a physical address in the VRAM
 * 				UMR_GFX_HUB: The memory is a virtual address controlled by the GFX hub
 * 				UMR_MM_HUB: The memory is a virtual address controlled by the MM hub
 *
 *			The bits 0:7 indicate which VM to access (if any).
 *
 * @address: The address of the memory to access must be word aligned
 * @size:  The number of bytes to read
 * @data:  The buffer to read from/write to
 * @write_en:  Set to 0 to read, non-zero to write
 *
 * Returns -1 on error.
 */
int umr_access_vram(struct umr_asic *asic, uint32_t vmid, uint64_t address, uint32_t size, void *data, int write_en)
{
	// only aligned reads
	if ((address & 3) || (size & 3)) {
		fprintf(stderr, "[ERROR]:  The address and size must be a multiple of 4 to access VRAM\n");
		return -1;
	}

	// only aligned destinations
	if (((intptr_t)data) & 3) {
		fprintf(stderr, "[BUG]: vram read destination is not 4-byte aligned\n");
		return -1;
	}

	// read/write from process space
	if ((vmid & 0xFF00) == UMR_PROCESS_HUB) {
		if (!write_en)
			memcpy(data, (char *)address, size);
		else
			memcpy((char *)address, data, size);
		return 0;
	}

	// mask VM addresses
	if ((vmid & 0xFF00) != UMR_LINEAR_HUB && asic->family > FAMILY_VI)
		address &= 0xFFFFFFFFFFFFULL;

	if ((vmid & 0xFF00) == UMR_LINEAR_HUB) {
		// if we are using xgmi let's find the device for this address
		if (asic->options.use_xgmi) {
			int n;
			uint64_t addr = address;

			// copy callbacks so that sysram/vram accesses
			// go through callbacks when we use other nodes
			if (!asic->config.xgmi.callbacks_applied)
				umr_apply_callbacks(asic, &asic->mem_funcs, &asic->reg_funcs);

			for (n = 0; asic->config.xgmi.nodes[n].asic; n++) {
				// if remaining address is within this nodes VRAM size use it
				if (addr < asic->config.xgmi.nodes[n].asic->config.vram_size) {
					asic = asic->config.xgmi.nodes[n].asic;
					address = addr;
					break;
				} else {
					// otherwise subtract this vram size from the address and go to the next device
					addr -= round_up_pot(asic->config.xgmi.nodes[n].asic->config.vram_size);
				}
			}
			// now {asic, address} are the device and it's relative address
			// that corresponds to the hive address the caller passed
		}

		// use callback for linear access if applicable
		return asic->mem_funcs.access_linear_vram(asic, address, size, data, write_en);
	}

	switch (asic->family) {
		case FAMILY_SI:
		case FAMILY_CIK:
		case FAMILY_VI:
			return umr_access_vram_vi(asic, vmid, address, size, data, write_en);
		case FAMILY_AI:
		case FAMILY_NV:
			return umr_access_vram_ai(asic, vmid, address, size, data, write_en);
		default:
			fprintf(stderr, "[BUG]: Unsupported ASIC family type for umr_read_vram()\n");
			return -1;
	}

	return 0;
}
