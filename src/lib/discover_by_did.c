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

static int find_first_did(long did, long start_instance)
{
	char name[128], device[256];
	FILE *f, *f2;

	int x;

	for (x = start_instance; x < 16; x++) {
		snprintf(name, sizeof(name)-1, "/sys/kernel/debug/dri/%d/name", x);
		f = fopen(name, "r");
		if (f) {
			unsigned tmp_did;
			int r;

			r = fscanf(f, "%*s %s", name);
			fclose(f);

			if (r != 1)
				return -1;

			// strip off dev= for kernels > 4.7
			if (strstr(name, "dev="))
				memmove(name, name+4, strlen(name)-3);

			snprintf(device, sizeof(device)-1, "/sys/bus/pci/devices/%s/device", name);
			f2 = fopen(device, "r");
			if (f2) {
				if (fscanf(f, "0x%04x", &tmp_did) == 1 && tmp_did == did) {
					fclose(f2);
					return x;
				}
				fclose(f2);
			}
		}
	}
	return -1;
}

/**
 * umr_discover_asic_by_did - Find an ASIC device by the PCI DID
 *
 * @options: Options to bind to device
 * @did: The PCI Device ID to search for
 *
 * This will search the DID table for a specified ASIC that matches
 * the given @did and then search the DRI entries for the first
 * instance that matches.  Optionally @options->instance can be set
 * to indicate which device you want to look for.
 */
struct umr_asic *umr_discover_asic_by_did(struct umr_options *options, long did)
{
	struct umr_asic *asic;
	FILE *f;
	char linebuf[128], lname[128];
	uint32_t ldid;

	f = umr_database_open(options->database_path, "pci.did");
	if (!f) {
		fprintf(stderr, "[ERROR]: Can't find pci.did file in database\n");
		return NULL;
	}

	asic = NULL;
	while (fgets(linebuf, sizeof linebuf, f)) {
		sscanf(linebuf, "%"SCNx32" %s", &ldid, lname);
		if (ldid == did) {
			asic = umr_database_read_asic(options, lname);
			break;
		}
	}
	fclose(f);

	if (asic) {
		asic->did = did;
		asic->instance = find_first_did(did, options->instance);
		umr_scan_config(asic, 0);

		// set all file handles to -1 (so a call to close_asic won't close handle 0)
		asic->fd.mmio = -1;
		asic->fd.didt = -1;
		asic->fd.pcie = -1;
		asic->fd.smc = -1;
		asic->fd.sensors = -1;
		asic->fd.wave = -1;
		asic->fd.vram = -1;
		asic->fd.gpr = -1;
		asic->fd.drm = -1;
		asic->fd.iova = -1;
		asic->fd.iomem = -1;
		asic->fd.gfxoff = -1;
	} else {
		if (!options->quiet && !options->dev_name[0])
			printf("ERROR: Device 0x%04lx not found in UMR device table\n", did);
	}

	return asic;
}

