/*
 * Copyright 2021 Advanced Micro Devices, Inc.
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

static struct umr_ip_offsets_soc15 navi14_offs[] = {
#include "navi14.i"
	{ NULL },
};

struct umr_asic *umr_create_navi14(struct umr_options *options)
{
	return
		umr_create_asic_helper("navi14", FAMILY_NV,
			umr_create_athub200(navi14_offs, options),
			umr_create_clk1100(navi14_offs, options),
			umr_create_dcn200(navi14_offs, options),
			umr_create_gfx1010(navi14_offs, options),
			umr_create_hdp500(navi14_offs, options),
			umr_create_mmhub200(navi14_offs, options),
			umr_create_mp1100(navi14_offs, options),
			umr_create_nbio230(navi14_offs, options),
			umr_create_oss50(navi14_offs, options),
			umr_create_smu1100(navi14_offs, options),
			umr_create_thm1102(navi14_offs, options),
			umr_create_vcn200(navi14_offs, options),
			NULL);
}

