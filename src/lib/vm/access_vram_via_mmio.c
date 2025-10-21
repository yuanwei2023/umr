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
 * access_vram_via_mmio - Access VRAM via direct MMIO control
 */
int umr_access_vram_via_mmio(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en)
{
	uint32_t MM_INDEX, MM_INDEX_HI, MM_DATA;
	uint32_t *out = dst;
	int maj, min;

	umr_gfx_get_ip_ver(asic, &maj, &min);

	// find registers
	if (maj >= 10) {
		MM_INDEX    = umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "@mmBIF_BX_PF_MM_DATA");
	} else {
		MM_INDEX    = umr_find_reg(asic, "@mmMM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "@mmMM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "@mmMM_DATA");
	}

	if (MM_INDEX == 0xFFFFFFFF    ||
	    MM_INDEX_HI == 0xFFFFFFFF ||
	    MM_DATA == 0xFFFFFFFF) {
		// the kernel kinda hardcodes these
		MM_INDEX = 0;
		MM_DATA = 1;
		MM_INDEX_HI = 6;
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
