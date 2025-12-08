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
#include "umrapp.h"

#define AMDGPU_INFO_VBIOS			0x1B
#define AMDGPU_INFO_VBIOS_INFO			0x3
int umr_print_vbios_info(struct umr_asic *asic)
{
	char fname[64];
	int r;
	struct umr_vbios_info vbios_info;

	if (asic->fd.drm < 0) {
		snprintf(fname, sizeof(fname)-1, "/dev/dri/card%d", asic->instance);
		asic->fd.drm = open(fname, O_RDWR);
	}

	if (asic->fd.drm != -1) {
		r = umr_query_drm_vbios(asic, AMDGPU_INFO_VBIOS, AMDGPU_INFO_VBIOS_INFO,
				&vbios_info, sizeof(vbios_info));
		if (!r) {
			asic->std_msg("vbios name          : %s\n", vbios_info.name);
			asic->std_msg("vbios pn            : %s\n", vbios_info.vbios_pn);
			asic->std_msg("vbios version       : %d\n", vbios_info.version);
			asic->std_msg("vbios ver_str       : %s\n", vbios_info.vbios_ver_str);
			asic->std_msg("vbios date          : %s\n", vbios_info.date);
		}
		close(asic->fd.drm);
		asic->fd.drm = -1;
		return r;
	} else {
		asic->err_msg("[ERROR]: Could not open DRM file to read VBIOS info\n");
		return -1;
	}
}
