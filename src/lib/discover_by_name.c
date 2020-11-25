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
	char *name;
	struct umr_asic *(*create)(struct umr_options *option);
} devices[] = {
	{ "arcturus", &umr_create_arcturus },
	{ "bonaire", &umr_create_bonaire },
	{ "carrizo", &umr_create_carrizo },
	{ "dimgrey_cavefish", &umr_create_dimgrey_cavefish },
	{ "fiji", &umr_create_fiji   },
	{ "hainan", &umr_create_hainan },
	{ "hawaii", &umr_create_hawaii },
	{ "kabini", &umr_create_kabini },
	{ "kaveri", &umr_create_kaveri },
	{ "mullins", &umr_create_mullins },
	{ "navi10", &umr_create_navi10 },
	{ "navi12", &umr_create_navi12 },
	{ "navi14", &umr_create_navi14 },
	{ "navy_flounder", &umr_create_navy_flounder },
	{ "oland", &umr_create_oland },
	{ "picasso", &umr_create_picasso },
	{ "polaris10", &umr_create_polaris10 },
	{ "polaris11", &umr_create_polaris11 },
	{ "polaris12", &umr_create_polaris12 },
	{ "pitcairn", &umr_create_pitcairn },
	{ "raven1", &umr_create_raven1 },
	{ "renoir", &umr_create_renoir },
	{ "sienna_cichlid", &umr_create_sienna_cichlid },
	{ "stoney", &umr_create_stoney },
	{ "tahiti", &umr_create_tahiti },
	{ "tonga", &umr_create_tonga  },
	{ "topaz", &umr_create_topaz },
	{ "vangogh", &umr_create_vangogh },
	{ "vega10", &umr_create_vega10 },
	{ "vega12", &umr_create_vega12 },
	{ "vega20", &umr_create_vega20 },
	{ "vegam", &umr_create_vegam },
	{ "verde", &umr_create_verde },
};

/**
 * umr_discover_asic_by_name - Discover an ASIC by common name
 *
 * @options:  The options to bind to the ASIC
 * @name: Name of the ASIC to look for
 *
 * If the @name begins with an '@' then the device is created on
 * they fly from an NPI script specified in the name.
 *
 * Otherwise, the first instance of a device that matches the name
 * specified is found and returned.
 */
struct umr_asic *umr_discover_asic_by_name(struct umr_options *options, char *name)
{
	unsigned x;
	struct umr_asic *asic, *tmp;

	if (name[0] == '@')
		return umr_create_asic_from_script(options, name + 1);

	asic = NULL;
	for (x = 0; x < (sizeof(devices)/sizeof(devices[0])); x++)
		if (!strcmp(devices[x].name, name))
			asic = devices[x].create(options);

	if (asic) {
		asic->did = 0;
		if (options->instance == -1) {
			// try and discover an instance that works
			struct umr_options tmp_opt;
			for (x = 0; x < 16; x++) {
				memset(&tmp_opt, 0, sizeof(tmp_opt));
				tmp_opt.quiet = 1;
				tmp_opt.forcedid = -1;
				tmp_opt.instance = x;
				tmp = umr_discover_asic(&tmp_opt);
				if (tmp) {
					if (!strcmp(tmp->asicname, name)) {
						asic->instance = x;
						umr_close_asic(tmp);
						break;
					}
					umr_close_asic(tmp);
				}
			}
		} else {
			asic->instance = options->instance;
		}
		umr_scan_config(asic, 0);
	} else {
		printf("ERROR: Device %s not found in UMR device table\n", name);
	}

	return asic;
}

