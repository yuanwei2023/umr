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

int umr_print_gpu_metrics(struct umr_asic *asic, int delay)
{
	FILE *f = NULL;
	uint8_t *pp_data = NULL;
	uint32_t size;
	char pp_name[128];
	int r;

	snprintf(pp_name, sizeof(pp_name), "/sys/class/drm/card%d/device/gpu_metrics", asic->instance);
	f = fopen(pp_name, "rb");
	if (!f) {
		asic->err_msg("[ERROR]:  Cannot open gpu_metrics file %s\n", pp_name);
		return -1;
	}
	if (fseek(f, 0, SEEK_END) < 0) {
		asic->err_msg("[ERROR]:  Cannot seek in gpu_metrics debugfs file\n");
		fclose(f);
		return -1;
	}
	size = ftell(f);
	if (size > 0) {
		fseek(f, 0, SEEK_SET);
		pp_data = calloc(size, sizeof *pp_data);
		if (!pp_data) {
			asic->err_msg("[ERROR]: Out of memory\n");
			fclose(f);
			return -1;
		}
	} else {
		asic->err_msg("[ERROR]: Could not seek in gpu_metrics file\n");
		fclose(f);
		return -1;
	}

	r = 0;
	do {
		struct umr_key_value *kv;
		int x;
		if (fread(pp_data, 1, size, f) == size) {
			kv = umr_dump_metrics(asic, pp_data, size);
			if (!kv) {
				r = -1;
				goto error;
			}
			for (x = 0; x < kv->used; x++) {
				asic->std_msg("%-30s: %s\n", kv->keys[x].name, kv->keys[x].value);
			}
			free(kv);
			if (delay) {
				usleep(abs(delay) * 1000UL);
				fseek(f, 0, SEEK_SET);
			}
		} else {
			asic->err_msg("[ERROR]: Could not access gpu_metrics file\n");
			goto error;
		}
	} while (delay);
error:
	fclose(f);
	free(pp_data);
	return r;
}
