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
 * PTE format on AI and PI:
 * 58:57 mtype (AI only)
 * 56 further
 * 54 reserved
 *   But if it is set, then this is actually a PDE with 'P'
 *   bit set, which makes the PDE act like a PTE.
 * 51 prt
 * 48:50 mtype (NV only)
 * 47:12 4k physical page base address
 * 11:7 fragment
 * 6 write
 * 5 read
 * 4 exe
 * 3 tmz (PI+)
 * 2 snooped / coherent
 * 1 system
 * 0 valid
 */
pte_fields_t umr_decode_pte_entry(const struct umr_asic *asic, uint64_t pte_entry)
{
	pte_fields_t pte_fields = { 0 };
	uint64_t is_pde = 0;
	struct umr_ip_block *ip;

	ip = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
	if (!ip) {
		asic->err_msg("[BUG]: Cannot find a 'gfx' IP block in this ASIC\n");
		return pte_fields;
	}

	switch (ip->discoverable.maj) {
		case 9:
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
		case 10:
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
			if (ip->discoverable.min >= 3) {
				pte_fields.llc_noalloc    = (pte_entry >> 58) & 1;
			}
			is_pde                    = pte_fields.further;
			break;
		case 11:
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
			pte_fields.software       = (pte_entry >> 52) & 3;
			pte_fields.pde            = (pte_entry >> 54) & 1;
			pte_fields.further        = (pte_entry >> 56) & 1;
			pte_fields.gcr            = (pte_entry >> 57) & 1;
			pte_fields.llc_noalloc    = (pte_entry >> 58) & 1;
			is_pde                    = pte_fields.further;
			break;
		case 12:
			pte_fields.valid          = pte_entry & 1;
			pte_fields.system         = (pte_entry >> 1) & 1;
			pte_fields.coherent       = (pte_entry >> 2) & 1;
			pte_fields.tmz            = (pte_entry >> 3) & 1;
			pte_fields.execute        = (pte_entry >> 4) & 1;
			pte_fields.read           = (pte_entry >> 5) & 1;
			pte_fields.write          = (pte_entry >> 6) & 1;
			pte_fields.fragment       = (pte_entry >> 7) & 0x1F;
			pte_fields.pa_rsvd        = (pte_entry >> 48) & 0xF;
			pte_fields.software       = (pte_entry >> 52) & 3;
			pte_fields.mtype          = (pte_entry >> 54) & 3;
			pte_fields.prt            = (pte_entry >> 56) & 1;
			pte_fields.gcr            = (pte_entry >> 57) & 1;
			pte_fields.dcc            = (pte_entry >> 58) & 1;
			pte_fields.pte            = (pte_entry >> 63) & 1;
			is_pde                    = !pte_fields.pte;
			break;
	}

	// PTEs hold physical address in 47:12
	// PDEs hold physical address in 47:6, so if this is a PTE-as-PDE (further), need a differnt mask
	if (is_pde)
		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFFFC0ULL;
	else
		pte_fields.page_base_addr = pte_entry & 0xFFFFFFFFF000ULL;

	return pte_fields;
}
