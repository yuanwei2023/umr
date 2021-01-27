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


static uint8_t grab8(const uint8_t *d, uint16_t *off, uint16_t size)
{
	if (*off < size)
		return d[(*off)++];
	return 0;
}

static uint16_t grab16(const uint8_t *d, uint16_t *off, uint16_t size)
{
	uint16_t r = 0;
	r = grab8(d, off, size);
	r |= ((uint16_t)grab8(d, off, size)) << 8;
	return r;
}

static uint32_t grab32(const uint8_t *d, uint16_t *off, uint16_t size)
{
	uint32_t r;
	r = grab16(d, off, size);
	r |= ((uint32_t)grab16(d, off, size)) << 16;
	return r;
}

static uint64_t grab64(const uint8_t *d, uint16_t *off, uint16_t size)
{
	uint64_t r;
	r = grab32(d, off, size);
	r |= ((uint64_t)grab32(d, off, size)) << 32;
	return r;
}

static void umr_decode_v1(const uint8_t *d, uint16_t *off, uint16_t size, union umr_gpu_metrics *metrics)
{
	metrics->v1.system_clock_counter = grab64(d, off, size);
	metrics->v1.temperature_edge     = grab16(d, off, size);
	metrics->v1.temperature_hotspot  = grab16(d, off, size);
	metrics->v1.temperature_mem      = grab16(d, off, size);
	metrics->v1.temperature_vrgfx    = grab16(d, off, size);
	metrics->v1.temperature_vrsoc    = grab16(d, off, size);
	metrics->v1.temperature_vrmem    = grab16(d, off, size);
	metrics->v1.average_gfx_activity = grab16(d, off, size);
	metrics->v1.average_umc_activity = grab16(d, off, size);
	metrics->v1.average_mm_activity  = grab16(d, off, size);
	metrics->v1.average_socket_power = grab16(d, off, size);
	metrics->v1.energy_accumulator   = grab32(d, off, size);
	metrics->v1.average_gfxclk_frequency = grab16(d, off, size);
	metrics->v1.average_socclk_frequency = grab16(d, off, size);
	metrics->v1.average_uclk_frequency = grab16(d, off, size);
	metrics->v1.average_vclk0_frequency = grab16(d, off, size);
	metrics->v1.average_dclk0_frequency = grab16(d, off, size);
	metrics->v1.average_vclk1_frequency = grab16(d, off, size);
	metrics->v1.average_dclk1_frequency = grab16(d, off, size);
	metrics->v1.current_gfxclk = grab16(d, off, size);
	metrics->v1.current_socclk = grab16(d, off, size);
	metrics->v1.current_uclk = grab16(d, off, size);
	metrics->v1.current_vclk0 = grab16(d, off, size);
	metrics->v1.current_dclk0 = grab16(d, off, size);
	metrics->v1.current_vclk1 = grab16(d, off, size);
	metrics->v1.current_dclk1 = grab16(d, off, size);
	metrics->v1.throttle_status = grab32(d, off, size);
	metrics->v1.current_fan_speed = grab16(d, off, size);
	metrics->v1.pcie_link_width = grab8(d, off, size);
	metrics->v1.pcie_link_speed = grab8(d, off, size);
}

static void umr_decode_v2(const uint8_t *d, uint16_t *off, uint16_t size, union umr_gpu_metrics *metrics)
{
	unsigned x;

	metrics->v2.system_clock_counter = grab64(d, off, size);
	metrics->v2.temperature_gfx = grab16(d, off, size);
	metrics->v2.temperature_soc = grab16(d, off, size);
	for (x = 0; x < 8; x++)
		metrics->v2.temperature_core[x] = grab16(d, off, size);
	for (x = 0; x < 2; x++)
		metrics->v2.temperature_l3[x] = grab16(d, off, size);
	metrics->v2.average_gfx_activity = grab16(d, off, size);
	metrics->v2.average_mm_activity = grab16(d, off, size);
	metrics->v2.average_socket_power = grab16(d, off, size);
	metrics->v2.average_cpu_power = grab16(d, off, size);
	metrics->v2.average_soc_power = grab16(d, off, size);
	metrics->v2.average_gfx_power = grab16(d, off, size);
	for (x = 0; x < 8; x++)
		metrics->v2.average_core_power[x] = grab16(d, off, size);
	metrics->v2.average_gfxclk_frequency = grab16(d, off, size);
	metrics->v2.average_socclk_frequency = grab16(d, off, size);
	metrics->v2.average_uclk_frequency = grab16(d, off, size);
	metrics->v2.average_fclk_frequency = grab16(d, off, size);
	metrics->v2.average_vclk_frequency = grab16(d, off, size);
	metrics->v2.average_dclk_frequency = grab16(d, off, size);
	metrics->v2.current_gfxclk = grab16(d, off, size);
	metrics->v2.current_socclk = grab16(d, off, size);
	metrics->v2.current_uclk = grab16(d, off, size);
	metrics->v2.current_fclk = grab16(d, off, size);
	metrics->v2.current_vclk = grab16(d, off, size);
	metrics->v2.current_dclk = grab16(d, off, size);
	for (x = 0; x < 8; x++)
		metrics->v2.current_coreclk[x] = grab16(d, off, size);
	for (x = 0; x < 2; x++)
		metrics->v2.current_l3clk[x] = grab16(d, off, size);
	metrics->v2.throttle_status = grab32(d, off, size);
	metrics->v2.fan_pwm = grab16(d, off, size);
	metrics->v2.padding = grab16(d, off, size);
}

int umr_decode_metrics(const uint8_t *pp_table, uint16_t size, union umr_gpu_metrics *metrics)
{
	uint16_t off;

	off = 0;

	// read header
	metrics->hdr.structure_size   = grab16(pp_table, &off, size);
	metrics->hdr.format_revision  = grab8(pp_table, &off, size);
	metrics->hdr.content_revision = grab8(pp_table, &off, size);

	switch (metrics->hdr.format_revision) {
		case 1: umr_decode_v1(pp_table, &off, size, metrics); break;
		case 2: umr_decode_v2(pp_table, &off, size, metrics); break;
		default: fprintf(stderr, "[ERROR]: Unknown PP table format: 0x%"PRIx8"\n", metrics->hdr.format_revision); 
				 return -1;
	}

	return 0;
}
