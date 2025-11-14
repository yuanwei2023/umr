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
 * umr_decode_pte_entry - Decode a Page Table Entry into its component fields
 * @asic: Pointer to the ASIC structure containing hardware configuration
 * @pte_entry: Raw 64-bit PTE entry value to decode
 *
 * Decodes a hardware page table entry (PTE) into a structured format based on
 * the GPU generation. The PTE format varies across different GPU IP versions:
 *
 * GFX9 (Vega/AI): Bits 57:56 contain mtype, bit 56 is 'further' flag
 * GFX10 (Navi): Bits 48:50 contain mtype, added GCR flag at bit 57
 * GFX11: Added software bits [53:52], LLC no-alloc at bit 58
 * GFX12: Reorganized with mtype at bits 55:54, PTE flag at bit 63
 *
 * Common PTE bit layout (variations noted per generation):
 * Bit  0:      valid - Entry is valid
 * Bit  1:      system - System memory access
 * Bit  2:      coherent - Cache coherency enabled (snooped)
 * Bit  3:      tmz - Trusted Memory Zone (PI+)
 * Bit  4:      execute - Execution permission
 * Bit  5:      read - Read permission
 * Bit  6:      write - Write permission
 * Bits 11:7:   fragment - Fragment size encoding
 * Bits 47:12:  Physical page base address (4KB aligned)
 * Bit  51:     prt - Partially Resident Texture
 * Bit  54:     pde - When set in GFX9/10/11, indicates PDE with P-bit
 * Bit  56:     further - PDE acting as PTE (GFX9/10/11)
 *
 * Note: On GFX9-11, bit 54 being set indicates a PDE with the 'P' bit set,
 * which makes the PDE act like a PTE for large page mappings.
 *
 * Return: A pte_fields_t structure with all decoded fields, or zeroed
 *         structure if the GFX IP block cannot be found.
 */
pte_fields_t umr_decode_pte_entry(const struct umr_asic *asic, uint64_t pte_entry)
{
	pte_fields_t pte_fields = { 0 };
	uint64_t is_pde = 0;
	struct umr_ip_block *ip;

	/* Find the GFX IP block to determine the GPU generation */
	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
	if (!ip) {
		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
		return pte_fields;
	}

	/* Decode PTE fields based on GPU generation (IP major version) */
	switch (ip->discoverable.maj) {
		case 9: /* GFX9: Vega, AI, Raven */
			pte_fields.valid          = pte_entry & 1;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.coherent       = (pte_entry >> 2) & 1;
			pte_fields.tmz            = (pte_entry >> 3) & 1;
			pte_fields.execute        = (pte_entry >> 4) & 1;
			pte_fields.read           = (pte_entry >> 5) & 1;
			pte_fields.write          = (pte_entry >> 6) & 1;
			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
			pte_fields.prt            = (pte_entry >> 51) & 1;
			pte_fields.pde            = (pte_entry >> 54) & 1;
			pte_fields.further        = (pte_entry >> 56) & 1;
			pte_fields.mtype          = (pte_entry >> 57) & 3;
			is_pde                    = pte_fields.further;
			break;
		case 10: /* GFX10: Navi1x, Navi2x */
			pte_fields.valid          = pte_entry & 1;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.coherent       = (pte_entry >> 2) & 1;
			pte_fields.tmz            = (pte_entry >> 3) & 1;
			pte_fields.execute        = (pte_entry >> 4) & 1;
			pte_fields.read           = (pte_entry >> 5) & 1;
			pte_fields.write          = (pte_entry >> 6) & 1;
			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
			pte_fields.mtype          = (pte_entry >> 48) & 3;
			pte_fields.prt            = (pte_entry >> 51) & 1;
			pte_fields.pde            = (pte_entry >> 54) & 1;
			pte_fields.further        = (pte_entry >> 56) & 1;
			pte_fields.gcr            = (pte_entry >> 57) & 1;
			/* GFX10.3+ adds LLC no-allocate flag */
			if (ip->discoverable.min >= 3) {
				pte_fields.llc_noalloc    = (pte_entry >> 58) & 1;
			}
			is_pde                    = pte_fields.further;
			break;
		case 11: /* GFX11: RDNA3 */
			pte_fields.valid          = pte_entry & 1;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.coherent       = (pte_entry >> 2) & 1;
			pte_fields.tmz            = (pte_entry >> 3) & 1;
			pte_fields.execute        = (pte_entry >> 4) & 1;
			pte_fields.read           = (pte_entry >> 5) & 1;
			pte_fields.write          = (pte_entry >> 6) & 1;
			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
			pte_fields.mtype          = (pte_entry >> 48) & 3;
			pte_fields.prt            = (pte_entry >> 51) & 1;
			pte_fields.software       = (pte_entry >> 52) & 3; /* Software-defined bits */
			pte_fields.pde            = (pte_entry >> 54) & 1;
			pte_fields.further        = (pte_entry >> 56) & 1;
			pte_fields.gcr            = (pte_entry >> 57) & 1; /* Graphics Cache Rinse  */
			pte_fields.llc_noalloc    = (pte_entry >> 58) & 1; /* LLC no-allocate */
			is_pde                    = pte_fields.further;
			break;
		case 12: /* GFX12: RDNA4 */
			pte_fields.valid          = pte_entry & 1;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.coherent       = (pte_entry >> 2) & 1;
			pte_fields.tmz            = (pte_entry >> 3) & 1;
			pte_fields.execute        = (pte_entry >> 4) & 1;
			pte_fields.read           = (pte_entry >> 5) & 1;
			pte_fields.write          = (pte_entry >> 6) & 1;
			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
			pte_fields.pa_rsvd        = (pte_entry >> 48) & 0xF; /* Physical address reserved bits */
			pte_fields.software       = (pte_entry >> 52) & 3; /* Software-defined bits */
			pte_fields.mtype          = (pte_entry >> 54) & 3; /* Memory type moved to bits 55:54 */
			pte_fields.prt            = (pte_entry >> 56) & 1;
			pte_fields.gcr            = (pte_entry >> 57) & 1;
			pte_fields.dcc            = (pte_entry >> 58) & 1; /* Delta Color Compression */
			pte_fields.pte            = (pte_entry >> 63) & 1; /* PTE flag: 1=PTE, 0=PDE */
			is_pde                    = !pte_fields.pte; /* Inverted logic for GFX12 */
			break;
	}

	/*
	 * Extract physical page base address:
	 * - PTEs use bits [47:12] for 4KB-aligned page address (mask: 0xFFFFFFFFF000)
	 * - PDEs use bits [47:6] for 64B-aligned address (mask: 0xFFFFFFFFFFC0)
	 *
	 * When 'further' bit is set (GFX9-11) or 'pte' bit is 0 (GFX12),
	 * the entry is a PDE and needs the coarser alignment mask.
	 */
	if (is_pde) {
		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL; /* 64B aligned for PDEs */
	} else {
		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL; /* 4KB aligned for PTEs */
	}

	return pte_fields;
}
