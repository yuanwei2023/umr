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
 * umr_get_ip_revision - Retrieve the discoverable IP version info from a block by name partial match
 *
 * @asic: The ASIC to search for the IP block
 * @ipname: The IP name to partial match
 * @maj: Optionally retrieve the major version (if not NULL)
 * @min: Optionally retrieve the minor version (if not NULL)
 * @rev: Optionally retrieve the revision version (if not NULL)
 *
 * Returns 0 if the block was found, -1 if not.
 */
int umr_get_ip_revision(struct umr_asic *asic, const char *ipname, int *maj, int *min, int *rev)
{
	int x;

	for (x = 0; x < asic->no_blocks; x++) {
		if (strstr(asic->blocks[x]->ipname, ipname)) {
			if (maj) {
				*maj = asic->blocks[x]->discoverable.maj;
			}
			if (min) {
				*min = asic->blocks[x]->discoverable.min;
			}
			if (rev) {
				*rev = asic->blocks[x]->discoverable.rev;
			}
			return 0;
		}
	}
	return -1;
}
