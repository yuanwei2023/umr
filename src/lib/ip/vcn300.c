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

#include "vcn300_bits.i"

static const struct umr_reg_soc15 vcn300_registers[] = {
#include "vcn300_regs.i"
};

struct umr_ip_block *umr_create_ex_vcn300(struct umr_ip_offsets_soc15 *soc15_offsets, struct umr_options *options, int inst)
{
	struct umr_ip_block *ip;

	ip = calloc(1, sizeof *ip);
	if (!ip)
		return NULL;

	switch (inst) {
		case 0: ip->ipname = "vcn300{0}"; break;
		case 1: ip->ipname = "vcn300{1}"; break;
	}
	ip->no_regs = sizeof(vcn300_registers)/sizeof(vcn300_registers[0]);
	ip->regs = calloc(ip->no_regs, sizeof(ip->regs[0]));
	if (!ip->regs) {
		free(ip);
		return NULL;
	}

	if (umr_transfer_soc15_to_reg_ex(options, soc15_offsets, "VCN", vcn300_registers, ip, inst)) {
		free(ip);
		return NULL;
	}

	return ip;
}
