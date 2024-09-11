/*
 * Copyright 2024 Advanced Micro Devices, Inc.
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
#include <sys/types.h>
#include <dirent.h>

int umr_enumerate_device_list(umr_err_output errout, const char *database_path, struct umr_options *global_options, struct umr_asic ***asics, int *no_asics)
{
	struct umr_options options;
	int x;
	DIR *dir;
	struct dirent *de;

	*asics = NULL;
	*no_asics = 0;

	dir = opendir("/sys/bus/pci/drivers/amdgpu");
	if (!dir) {
		errout("[ERROR]: Cannot open path /sys/bus/pci/drivers/amdgpu to enumerate devices.\n");
		return -1;
	}

	*asics = calloc(128, sizeof *asics); // allocate enough pointers for upto 128 devices

	x = 0;
	while (x < 128 && (de  = readdir(dir))) {
		memset(&options, 0, sizeof options);
		if (global_options)
			options = *global_options;
		options.quiet = 1;
		strncpy(options.database_path, database_path, sizeof(options.database_path));
		if (sscanf(de->d_name, "%04x:%02x:%02x.%01x",
				&options.pci.domain, &options.pci.bus, &options.pci.slot,
				&options.pci.func) == 4) {
			// we found a PCI bus address
			(*asics)[x] = umr_discover_asic(&options, errout);
			if ((*asics)[x]) {
				umr_scan_config((*asics)[x], 1);
				++x;
			}
		}
	}
	closedir(dir);
	*no_asics = x;

	return 0;
}

void umr_enumerate_device_list_free(struct umr_asic **asics)
{
	int x;
	for (x = 0; x < 128; x++) {
		if (asics[x]) {
			umr_close_asic(asics[x]);
		}
	}
	free(asics);
}
