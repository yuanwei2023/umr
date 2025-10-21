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

/**
 * umr_access_vram_vi - Access GPU mapped memory for SI .. VI platforms
 */
int umr_access_vram_vi(struct umr_asic *asic, uint32_t vmid,
			      uint64_t address, uint32_t size,
			      void *dst, int write_en, struct umr_vm_pagewalk *vmdata)
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

	(void)vmdata;
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
			vmid,
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
			if (umr_read_vram(asic, -1, UMR_LINEAR_HUB, page_table_base_addr + pde_idx * 8 - vm_fb_base, 8, &pde_entry)) {
				asic->mem_funcs.vm_message("[ERROR]:  Could not read PDE.\n");
				return -1;
			}

			// decode PDE values
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFF000ULL;
			pde_fields.valid         = pde_entry & 1;
			if ((asic->options.no_fold_vm_decode || memcmp(&pde_copy, &pde_fields, sizeof pde_fields)) && asic->options.verbose)
				asic->mem_funcs.vm_message("PDE{0x%"PRIx64"/0x%"PRIx64"}=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 "\n",
						page_table_base_addr + pde_idx * 8 - vm_fb_base,
						pde_idx,
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
			if (umr_read_vram(asic, -1, UMR_LINEAR_HUB, pde_fields.pte_base_addr + pte_idx*8 - vm_fb_base, 8, &pte_entry) < 0)
				return -1;

			// decode PTE values
			pte_fields.page_base_addr = pte_entry & 0xFFFFFFF000ULL;
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			if (asic->options.verbose)
				asic->mem_funcs.vm_message("\\-> PTE{0x%"PRIx64"/0x%"PRIx64"}=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
					pde_fields.pte_base_addr + pte_idx*8 - vm_fb_base,
					pte_idx,
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

			if (umr_read_vram(asic, -1, UMR_LINEAR_HUB, page_table_base_addr + pte_idx * 8 - vm_fb_base, 8, &pte_entry) < 0)
				return -1;

			// decode PTE values
			pte_fields.page_base_addr = pte_entry & 0xFFFFFFF000ULL;
			pte_fields.fragment       = (pte_entry >> 7)  & 0x1F;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.valid          = pte_entry & 1;
			if (asic->options.verbose)
				asic->mem_funcs.vm_message("PTE{0x%" PRIx64 "/0x%" PRIx64"}=0x%016" PRIx64 ", VA=0x%010" PRIx64 ", PBA==0x%010" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
					page_table_base_addr + pte_idx * 8 - vm_fb_base,
					pte_idx,
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
					fprintf(stderr, "[ERROR]: Cannot access system ram at address: 0x%"PRIx64"\n", start_addr);
					return -1;
				}
			} else {
				if (umr_access_vram(asic, -1, UMR_LINEAR_HUB, start_addr, chunk_size, pdst, write_en, NULL) < 0) {
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
	asic->mem_funcs.vm_message("[ERROR]: No valid mapping for 0x%" PRIx32 "@%" PRIx64 "\n", vmid, address);
	return -1;
}
