/*
 * Copyright 2019 Advanced Micro Devices, Inc.
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

#include <stdbool.h>

#define MANY_TO_INSTANCE(wgp, simd) (((simd) & 3) | ((wgp) << 2))

/**
 * Scan the given wave slot. Return true and fill in \p pwd if a wave is present.
 * Otherwise, return false.
 *
 * \param cu the CU on <=gfx9, the WGP on >=gfx10
 */
static bool umr_scan_wave_slot(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu,
			       uint32_t simd, uint32_t wave, struct umr_wave_data *pwd)
{
	unsigned thread, num_threads;

	if (asic->family <= FAMILY_AI)
		umr_get_wave_status(asic, se, sh, cu, simd, wave, &pwd->ws);
	else
		umr_get_wave_status(asic, se, sh, MANY_TO_INSTANCE(cu, simd), 0, wave, &pwd->ws);

	if (!pwd->ws.wave_status.valid &&
	    (!pwd->ws.wave_status.halt || pwd->ws.wave_status.value == 0xbebebeef))
		return false;

	pwd->se = se;
	pwd->sh = sh;
	pwd->cu = cu;
	pwd->simd = simd;
	pwd->wave = wave;

	if (!asic->options.skip_gprs) {
		umr_read_sgprs(asic, &pwd->ws, &pwd->sgprs[0]);

		if (asic->family <= FAMILY_AI)
			num_threads = 64;
		else
			num_threads = pwd->ws.ib_sts2.wave64 ? 64 : 32;

		pwd->have_vgprs = 1;
		pwd->num_threads = num_threads;
		for (thread = 0; thread < num_threads; ++thread) {
			if (umr_read_vgprs(asic, &pwd->ws, thread,
					   &pwd->vgprs[256 * thread]) < 0) {
				pwd->have_vgprs = 0;
				break;
			}
		}
	} else {
		pwd->have_vgprs = 0;
	}

	return true;
}

/**
 * Scan for waves within a single SIMD.
 *
 * \param cu the CU instance on <=gfx9, the WGP index on >=gfx10
 * \param simd the SIMD within the CU / WGP
 * \param pppwd points to the pointer-to-pointer-to the last element of a linked
 *              list of wave data structures, with the last element yet to be filled in.
 *              The pointer-to-pointer-to is updated by this function.
 */
static void umr_scan_wave_simd(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu, uint32_t simd,
			       struct umr_wave_data ***pppwd)
{
	uint32_t wave, wave_limit;

	wave_limit = asic->family <= FAMILY_AI ? 10 : 20;

	for (wave = 0; wave < wave_limit; wave++) {
		struct umr_wave_data *pwd = **pppwd;
		if (umr_scan_wave_slot(asic, se, sh, cu, simd, wave, pwd)) {
			pwd->next = calloc(1, sizeof(*pwd));
			if (!pwd->next) {
				fprintf(stderr, "[ERROR]: Out of memory\n");
				return;
			}
			*pppwd = &pwd->next;
		}
	}
}

/**
 * umr_scan_wave_data - Scan for any halted valid waves
 *
 * Returns NULL on error (or no waves found).
 */
struct umr_wave_data *umr_scan_wave_data(struct umr_asic *asic)
{
	uint32_t se, sh, cu, simd;
	struct umr_wave_data *head, **ptail;

	head = calloc(1, sizeof *head);
	if (!head) {
		fprintf(stderr, "[ERROR]: Out of memory\n");
		return NULL;
	}
	ptail = &head;

	for (se = 0; se < asic->config.gfx.max_shader_engines; se++)
	for (sh = 0; sh < asic->config.gfx.max_sh_per_se; sh++)
	for (cu = 0; cu < asic->config.gfx.max_cu_per_sh; cu++) {
		if (asic->family <= FAMILY_AI) {
			umr_get_wave_sq_info(asic, se, sh, cu, &(*ptail)->ws);
			if ((*ptail)->ws.sq_info.busy) {
				for (simd = 0; simd < 4; simd++)
					umr_scan_wave_simd(asic, se, sh, cu, simd, &ptail);
			}
		} else {
			for (simd = 0; simd < 4; simd++) {
				umr_get_wave_sq_info(asic, se, sh, MANY_TO_INSTANCE(cu, simd), &(*ptail)->ws);
				if ((*ptail)->ws.sq_info.busy)
					umr_scan_wave_simd(asic, se, sh, cu, simd, &ptail);
			}
		}
	}

	// drop the pre-allocated tail node
	free(*ptail);
	*ptail = NULL;
	return head;
}
