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
 * umr_gfx_get_ip_ver - Get the version of the GC/GFX IP block
 *
 * @asic: The ASIC to query
 * @maj: Where to store the major revision
 * @min: Where to store the minor revision
 *
 * Returns -1 on error.
 */
int umr_gfx_get_ip_ver(struct umr_asic *asic, int *maj, int *min)
{
	struct umr_ip_block *ip;

	// try by GC version
	ip = umr_find_ip_block(asic, "gfx", 0); // for multi instance
	if (!ip)
		ip = umr_find_ip_block(asic, "gfx", -1); // for single instance

	if (ip) {
		*maj = ip->discoverable.maj;
		*min = ip->discoverable.min;
		return 0;
	}
	return -1;
}
