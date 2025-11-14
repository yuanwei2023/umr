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
 * umr_decode_pde_entry - Decode a Page Directory Entry (PDE)
 * @asic: Pointer to the ASIC structure containing GPU information
 * @pde_entry: 64-bit raw PDE entry value to decode
 *
 * Decodes a Page Directory Entry from the GPU's page table hierarchy.
 * The PDE format varies by GPU architecture generation (GFX9, GFX10, GFX11, GFX12).
 *
 * PDE format on GFX9/GFX10 (AI/Vega/Navi):
 * - Bits 63:59 - Block fragment size (log2 of fragment size)
 * - Bits 58:55 - Reserved (bit 56 indicates PTE with 'further' flag set)
 * - Bit  54    - PDE-is-PTE flag (allows PTE to act as PDE)
 * - Bits 53:48 - Reserved
 * - Bits 47:6  - Physical base address of page table entry (64-byte aligned)
 * - Bit  2     - Cache coherent/snoop flag
 * - Bit  1     - System memory flag
 * - Bit  0     - Valid flag
 *
 * GFX10.3+ additions:
 * - Bit  58    - LLC (Last Level Cache) no-allocate flag
 *
 * GFX11 additions:
 * - Bits 48:50 - Memory type (MTYPE) encoding
 * - Bit  57    - TFS (Translation Further Offset) address flag (offsets a further PTB by the PDE0.PBA)
 *
 * GFX12 changes:
 * - Bits 58:62 - Block fragment size (shifted from bits 59:63)
 * - Bits 48:51 - Physical address reserved bits
 * - Bits 54:55 - MALL (Memory Access at Last Level) reuse policy
 * - Bit  63    - PDE-is-PTE flag (moved from bit 54)
 *
 * Return: Decoded PDE fields structure containing all extracted bit fields
 */
pde_fields_t umr_decode_pde_entry(const struct umr_asic *asic, uint64_t pde_entry)
{
	pde_fields_t pde_fields = { 0 };
	struct umr_ip_block *ip;

	/* Find the GFX IP block to determine the architecture version */
	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
	if (!ip) {
		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
		return pde_fields;
	}

	/* Decode PDE based on GFX architecture major version */
	switch (ip->discoverable.maj) {
		case 9:  /* GFX9: Vega series */
		case 10: /* GFX10: Navi 1x/2x series */
			/* Extract fragment size (bits 63:59) - log2 of block fragment size */
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			/* Extract physical base address (bits 47:6) - 64-byte aligned */
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			/* Extract valid bit (bit 0) - indicates if PDE is valid */
			pde_fields.valid         = pde_entry & 1;
			/* Extract system memory flag (bit 1) - indicates system vs local memory */
			pde_fields.system        = (pde_entry >> 1) & 1;
			/* Extract coherent flag (bit 2) - enables cache coherency/snooping */
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			/* Extract PDE-is-PTE flag (bit 54) - allows PTE to act as PDE */
			pde_fields.pte           = (pde_entry >> 54) & 1;
			/* Extract further flag (bit 56) - indicates continuation of page walk */
			pde_fields.further       = (pde_entry >> 56) & 1;
			/* GFX10.3+ has LLC no-allocate flag */
			if (ip->discoverable.maj == 10 && ip->discoverable.min >= 3) {
				pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
			}
			break;
		case 11: /* GFX11: RDNA3 series */
			/* Similar to GFX10 but with additional fields */
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			/* Extract memory type (bits 48:50) - determines caching behavior */
			pde_fields.mtype         = (pde_entry >> 48) & 7;
			pde_fields.pte           = (pde_entry >> 54) & 1;
			pde_fields.further       = (pde_entry >> 56) & 1;
			/* Extract TFS address flag (bit 57) - Translate Further Offset */
			pde_fields.tfs_addr      = (pde_entry >> 57) & 1;
			/* Extract LLC no-allocate flag (bit 58) */
			pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
			break;
		case 12: /* GFX12: RDNA4 series */
			/* GFX12 has reorganized bit layout */
			/* Fragment size moved to bits 58:62 */
			pde_fields.frag_size     = (pde_entry >> 58) & 0x1F;
			/* Physical base address remains at bits 47:6 */
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			/* Extract PA reserved bits (bits 48:51) */
			pde_fields.pa_rsvd       = (pde_entry >> 48) & 0xF;
			/* Extract MALL reuse policy (bits 54:55) - cache reuse strategy */
			pde_fields.mall_reuse    = (pde_entry >> 54) & 3;
			/* Extract TFS address flag (bit 56) */
			pde_fields.tfs_addr      = (pde_entry >> 56) & 1;
			/* PDE-is-PTE flag moved to bit 63 in GFX12 */
			pde_fields.pte           = (pde_entry >> 63) & 1;
			break;
	}
	return pde_fields;
}
