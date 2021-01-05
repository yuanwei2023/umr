/*
 * Copyright 2020 Advanced Micro Devices, Inc.
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

static struct umr_ip_offsets_soc15 arct_offs[] = {
#include "arct.i"
	{ NULL },
};

struct umr_asic *umr_create_arcturus(struct umr_options *options)
{
	return
		umr_create_asic_helper("arcturus", FAMILY_AI,
			umr_create_gfx90(arct_offs, options),
			umr_create_hdp40(arct_offs, options),
			umr_create_oss420(arct_offs, options),
			umr_create_thm90(arct_offs, options),
			umr_create_mp90(arct_offs, options),
			umr_create_mmhub941(arct_offs, options),
			umr_create_sdma0422(arct_offs, options),
			umr_create_sdma1422(arct_offs, options),
			umr_create_sdma2422(arct_offs, options),
			umr_create_sdma3422(arct_offs, options),
			umr_create_sdma4422(arct_offs, options),
			umr_create_sdma5422(arct_offs, options),
			umr_create_sdma6422(arct_offs, options),
			umr_create_sdma7422(arct_offs, options),
			umr_create_ex_umc612(arct_offs, options, 0),
			umr_create_ex_umc612(arct_offs, options, 1),
			umr_create_ex_umc612(arct_offs, options, 2),
			umr_create_ex_umc612(arct_offs, options, 3),
			umr_create_ex_umc612(arct_offs, options, 4),
			umr_create_ex_vcn250(arct_offs, options, 0),
			umr_create_ex_vcn250(arct_offs, options, 1),
			NULL);
}

