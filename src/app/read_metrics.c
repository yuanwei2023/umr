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
#include "umrapp.h"

#define p_u8(a, b) printf("\t%30s == %"PRIu8"\n", #b, a b)
#define p_u16(a, b) printf("\t%30s == %"PRIu16"\n", #b, a b)
#define p_u32(a, b) printf("\t%30s == %"PRIu32"\n", #b, a b)
#define p_u64(a, b) printf("\t%30s == %"PRIu64"\n", #b, a b)
#define p_u16_i(a, b, c) printf("\t%26s[%2d] == %"PRIu16"\n", #b, c, a b[c])


static void print_v1(union umr_gpu_metrics *metrics)
{
	p_u64(metrics->v1., system_clock_counter);
	p_u16(metrics->v1., temperature_edge    );
	p_u16(metrics->v1., temperature_hotspot );
	p_u16(metrics->v1., temperature_mem     );
	p_u16(metrics->v1., temperature_vrgfx   );
	p_u16(metrics->v1., temperature_vrsoc   );
	p_u16(metrics->v1., temperature_vrmem   );
	p_u16(metrics->v1., average_gfx_activity);
	p_u16(metrics->v1., average_umc_activity);
	p_u16(metrics->v1., average_mm_activity );
	p_u16(metrics->v1., average_socket_power);
	p_u32(metrics->v1., energy_accumulator);
	p_u16(metrics->v1., average_gfxclk_frequency);
	p_u16(metrics->v1., average_socclk_frequency);
	p_u16(metrics->v1., average_uclk_frequency);
	p_u16(metrics->v1., average_vclk0_frequency);
	p_u16(metrics->v1., average_dclk0_frequency);
	p_u16(metrics->v1., average_vclk1_frequency);
	p_u16(metrics->v1., average_dclk1_frequency);
	p_u16(metrics->v1., current_gfxclk);
	p_u16(metrics->v1., current_socclk);
	p_u16(metrics->v1., current_uclk);
	p_u16(metrics->v1., current_vclk0);
	p_u16(metrics->v1., current_dclk0);
	p_u16(metrics->v1., current_vclk1);
	p_u16(metrics->v1., current_dclk1);
	p_u32(metrics->v1., throttle_status);
	p_u16(metrics->v1., current_fan_speed);
	p_u8(metrics->v1., pcie_link_width);
	p_u8(metrics->v1., pcie_link_speed);
}

static void print_v2(union umr_gpu_metrics *metrics)
{
	unsigned x;
	p_u64(metrics->v2., system_clock_counter);
	p_u16(metrics->v2., temperature_gfx);
	p_u16(metrics->v2., temperature_soc);
	for (x = 0; x < 8; x++)
		p_u16_i(metrics->v2., temperature_core, x);
	for (x = 0; x < 2; x++)
		p_u16_i(metrics->v2., temperature_l3, x);
	p_u16(metrics->v2., average_gfx_activity);
	p_u16(metrics->v2., average_mm_activity);
	p_u16(metrics->v2., average_socket_power);
	p_u16(metrics->v2., average_cpu_power);
	p_u16(metrics->v2., average_soc_power);
	p_u16(metrics->v2., average_gfx_power);
	for (x = 0; x < 8; x++)
		p_u16_i(metrics->v2., average_core_power, x);
	p_u16(metrics->v2., average_gfxclk_frequency);
	p_u16(metrics->v2., average_socclk_frequency);
	p_u16(metrics->v2., average_uclk_frequency);
	p_u16(metrics->v2., average_fclk_frequency);
	p_u16(metrics->v2., average_vclk_frequency);
	p_u16(metrics->v2., average_dclk_frequency);
	p_u16(metrics->v2., current_gfxclk);
	p_u16(metrics->v2., current_socclk);
	p_u16(metrics->v2., current_uclk);
	p_u16(metrics->v2., current_fclk);
	p_u16(metrics->v2., current_vclk);
	p_u16(metrics->v2., current_dclk);
	for (x = 0; x < 8; x++)
		p_u16_i(metrics->v2., current_coreclk, x);
	for (x = 0; x < 2; x++)
		p_u16_i(metrics->v2., current_l3clk, x);
	p_u32(metrics->v2., throttle_status);
	p_u16(metrics->v2., fan_pwm);
	p_u16(metrics->v2., padding);
}


int umr_print_gpu_metrics(struct umr_asic *asic)
{
	union umr_gpu_metrics metrics;
	FILE *f;
	uint8_t *pp_data;
	uint16_t size;
	char pp_name[128];
	int r;

	snprintf(pp_name, sizeof(pp_name), "/sys/class/drm/card%d/device/gpu_metrics", asic->instance);
	f = fopen(pp_name, "rb");
	if (!f) {
		fprintf(stderr, "[ERROR]:  Cannot open gpu_metrics file %s\n", pp_name);
		return -1;
	}
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	fseek(f, 0, SEEK_SET);
	pp_data = calloc(1, size);
	if (!pp_data) {
		fprintf(stderr, "[ERROR]: Out of memory\n");
		fclose(f);
		return -1;
	}

	fread(pp_data, 1, size, f);
	r = umr_decode_metrics(pp_data, size, &metrics);
	fclose(f);
	if (r)
		goto error;

	switch (metrics.hdr.format_revision) {
		case 1: print_v1(&metrics); break;
		case 2: print_v2(&metrics); break;
	}
error:
	free(pp_data);
	return r;
}
