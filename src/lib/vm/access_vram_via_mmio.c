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
 * umr_access_vram_via_mmio - Access VRAM via direct MMIO control registers
 *
 * @asic: Pointer to the ASIC device structure
 * @address: Starting VRAM address to access (in bytes)
 * @size: Number of bytes to read/write (must be 4-byte aligned)
 * @dst: Pointer to destination buffer for reads or source buffer for writes
 * @write_en: Access mode flag (0 = read from VRAM, non-zero = write to VRAM)
 *
 * This function provides low-level VRAM access through MMIO index/data register pairs.
 * On GFX10+ hardware, it uses the BIF_BX_PF registers; on older hardware, it uses
 * the legacy MM_INDEX/MM_DATA registers. The function automatically selects the
 * appropriate register set based on the GFX IP version.
 *
 * The MM_INDEX register is configured with bit 31 set to enable VRAM access mode,
 * while MM_INDEX_HI holds the upper address bits for addressing beyond 2GB.
 *
 * Return: 0 on success
 */
int umr_access_vram_via_mmio(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en)
{
	uint32_t MM_INDEX, MM_INDEX_HI, MM_DATA;
	uint32_t *out = dst;
	int maj, min;

	umr_gfx_get_ip_ver(asic, &maj, &min);

	/* Determine the appropriate MMIO register set based on GFX IP version */
	if (maj >= 10) {
		/* GFX10+ uses BIF (Bus Interface) registers for MMIO access */
		MM_INDEX    = umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "@mmBIF_BX_PF_MM_DATA");
	} else {
		/* Pre-GFX10 uses legacy MM registers for MMIO access */
		MM_INDEX    = umr_find_reg(asic, "@mmMM_INDEX");
		MM_INDEX_HI = umr_find_reg(asic, "@mmMM_INDEX_HI");
		MM_DATA     = umr_find_reg(asic, "@mmMM_DATA");
	}

	if (MM_INDEX == 0xFFFFFFFF    ||
	    MM_INDEX_HI == 0xFFFFFFFF ||
	    MM_DATA == 0xFFFFFFFF) {
	/*
	 * Fallback to hardcoded register offsets if register lookup fails.
	 * These values match the kernel driver's hardcoded register indices.
	 */
		MM_INDEX = 0;
		MM_DATA = 1;
		MM_INDEX_HI = 6;
	}

	/* Convert register indices to byte offsets (each register is 4 bytes) */
	MM_INDEX *= 4;
	MM_INDEX_HI *= 4;
	MM_DATA *= 4;

	/* Process data in 4-byte chunks */
	while (size) {
		/* Set target address with bit 31 set to enable VRAM access mode */
		asic->reg_funcs.write_reg(asic, MM_INDEX, address | 0x80000000, REG_MMIO);
		/* Set upper address bits (for addresses > 2GB) */
		asic->reg_funcs.write_reg(asic, MM_INDEX_HI, address >> 31, REG_MMIO);

		if (write_en == 0) {
			/* Read operation: fetch data from VRAM via MM_DATA register */
			*out++ = asic->reg_funcs.read_reg(asic, MM_DATA, REG_MMIO);
		} else {
			/* Write operation: send data to VRAM via MM_DATA register */
			asic->reg_funcs.write_reg(asic, MM_DATA, *out++, REG_MMIO);
		}

		size -= 4;
		address += 4;
	}
	return 0;
}
