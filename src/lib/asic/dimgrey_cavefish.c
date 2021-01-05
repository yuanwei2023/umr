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

static struct umr_ip_offsets_soc15 dimgrey_cavefish_offs[] = {
#include "dimgrey_cavefish.i"
	{ NULL },
};

struct umr_asic *umr_create_dimgrey_cavefish(struct umr_options *options)
{
	return
		umr_create_asic_helper("dimgrey_cavefish", FAMILY_NV,
			umr_create_athub210(dimgrey_cavefish_offs, options),
			umr_create_gfx1030(dimgrey_cavefish_offs, options),
			umr_create_hdp500(dimgrey_cavefish_offs, options),
			umr_create_mmhub200(dimgrey_cavefish_offs, options),
			umr_create_mp1100(dimgrey_cavefish_offs, options),
			umr_create_oss50(dimgrey_cavefish_offs, options),
			umr_create_ex_umc870(dimgrey_cavefish_offs, options, 0),
			umr_create_ex_vcn300(dimgrey_cavefish_offs, options, 0),
			umr_create_dcn300(dimgrey_cavefish_offs, options),
			NULL);
}
