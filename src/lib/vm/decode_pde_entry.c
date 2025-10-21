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

/*
 * PDE format on AI:
 * 63:59 block fragment size
 * 58:55 reserved
 *   But if bit 56 is set, this is a PTE with 'further' set,
 *   which makes it act like a PDE.
 * 54 pde-is-pte
 * 53:48 reserved
 * 47:6 physical base address of PTE
 * 2 cache coherent/snoop
 * 1 system
 * 0 valid
 */
pde_fields_t umr_decode_pde_entry(const struct umr_asic *asic, uint64_t pde_entry)
{
	pde_fields_t pde_fields = { 0 };
	struct umr_ip_block *ip;

	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
	if (!ip) {
		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
		return pde_fields;
	}

	switch (ip->discoverable.maj) {
		case 9:
		case 10:
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			pde_fields.pte           = (pde_entry >> 54) & 1;
			pde_fields.further       = (pde_entry >> 56) & 1;
			if (ip->discoverable.maj == 10 && ip->discoverable.min >= 3) {
				pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
			}
			break;
		case 11:
			pde_fields.frag_size     = (pde_entry >> 59) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			pde_fields.mtype         = (pde_entry >> 48) & 7;
			pde_fields.pte           = (pde_entry >> 54) & 1;
			pde_fields.further       = (pde_entry >> 56) & 1;
			pde_fields.tfs_addr      = (pde_entry >> 57) & 1;
			pde_fields.llc_noalloc   = (pde_entry >> 58) & 1;
			break;
		case 12:
			pde_fields.frag_size     = (pde_entry >> 58) & 0x1F;
			pde_fields.pte_base_addr = pde_entry & 0xFFFFFFFFFFC0ULL;
			pde_fields.valid         = pde_entry & 1;
			pde_fields.system        = (pde_entry >> 1) & 1;
			pde_fields.coherent      = (pde_entry >> 2) & 1;
			pde_fields.pa_rsvd       = (pde_entry >> 48) & 0xF;
			pde_fields.mall_reuse    = (pde_entry >> 54) & 3;
			pde_fields.tfs_addr      = (pde_entry >> 56) & 1;
			pde_fields.pte           = (pde_entry >> 63) & 1;
			break;
	}
	return pde_fields;
}
