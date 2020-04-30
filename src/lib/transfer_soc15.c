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

static const struct {
	char *aka[8];
} common_names[] = {
	{ { "DCN", "DCE", "DMU", NULL } },
	{ { "UVD", "UVD0", "VCN", NULL } },
	{ { "NBIF", "NBIO", "NBIF0", "NBIO0", NULL } },
	{ { NULL } },
};

/** try_substitutes - Try different IP block names
 *
 * Over various ASIC generations IP block names change even if they
 * use the same IP block.
 */
static int try_substitutes(struct umr_ip_offsets_soc15 *ip, char *ipname)
{
	int x, y, z;

	// find ipname in aka list
	for (y = x = 0; common_names[x].aka[0]; x++)
		for (y = 0; common_names[x].aka[y]; y++)
			if (!strcmp(ipname, common_names[x].aka[y]))
				goto out;
out:
	if (common_names[x].aka[y] == NULL)
		return -1;

	// now try to find one of common_names[x].aka[...] in the ip offsets
	for (y = 0; common_names[x].aka[y]; y++)
		for (z = 0; ip[z].name; z++)
			if (!strcmp(common_names[x].aka[y], ip[z].name)) {
//				fprintf(stderr, "[NOTE]: Substituting %s for %s\n", common_names[x].aka[y], ipname);
				return z;
			}
	return -1;
}

int umr_transfer_soc15_to_reg(struct umr_options *options, struct umr_ip_offsets_soc15 *ip, char *ipname, const struct umr_reg_soc15 *regs, struct umr_ip_block *dst)
{
	return umr_transfer_soc15_to_reg_ex(options, ip, ipname, regs, dst, 0);
}

/**
 * umr_transfer_soc15_to_reg_ex - Compute register offset
 *
 * For AI+ hardware the SOC15 interface offsets registers by
 * potentially relocating IP blocks in the address map.  This will
 * apply an offset table to an array of registers and assign them to an
 * IP block.
 */
int umr_transfer_soc15_to_reg_ex(struct umr_options *options, struct umr_ip_offsets_soc15 *ip, char *ipname, const struct umr_reg_soc15 *regs, struct umr_ip_block *dst, int inst)
{
	int x, y;

	(void)options;

	// Try to find exact match for IP block in offset table
	for (y = -1, x = 0; ip[x].name; x++)
		if (!strcmp(ip[x].name, ipname)) {
			y = x;
			break;
		}

	// sometimes they are renamed for newer ASICs so try to find
	// an "also known as" substitute
	if (y == -1)
		y = try_substitutes(ip, ipname);
	x = y;

	if (x == -1) {
		fprintf(stderr, "[BUG]: IP '%s' not found in offset table\n", ipname);
		return -1;
	}

	// start copying them
	for (y = 0; y < dst->no_regs; y++) {
		if (regs[y].type == REG_MMIO)
			dst->regs[y].addr = regs[y].addr + ip[x].offset[regs[y].idx][inst];
		else
			dst->regs[y].addr = regs[y].addr;
		dst->regs[y].bits = regs[y].bits;
		dst->regs[y].no_bits = regs[y].no_bits;
		dst->regs[y].regname = regs[y].regname;
		dst->regs[y].type = regs[y].type;
		dst->regs[y].bit64 = regs[y].bit64;
	}
	return 0;
}
