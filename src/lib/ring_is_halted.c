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

/**
 * umr_ring_is_halted - Try to determine if a ring is actually halted
 *
 * @asic: The ASIC the ring is attached to.
 * @ringname: The name of the ring we want to check if it's halted.
 *
 * Returns 1 if it's halted, 0 or otherwise.
 */
int umr_ring_is_halted(struct umr_asic *asic, char *ringname)
{
	uint32_t *ringdata, ringsize;
	int n;

	if (!strcmp(ringname, "none"))
		return 1;

	if (!strcmp(ringname, "uq")) {
		int tries = 0;
		uint64_t rptr, wptr;

		// read initial values
		if (umr_read_vram(asic, asic->options.vm_partition, 0,
				asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_addr, 8,
				&rptr) < 0) {
			asic->err_msg("[ERROR]: Could not read hqd_rptr value\n");
			return -1;
		}
		if (umr_read_vram(asic, asic->options.vm_partition, 0,
				asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_addr, 8,
				&wptr) < 0) {
			asic->err_msg("[ERROR]: Could not read rb_wptr_poll value\n");
			return -1;
		}

		asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;
		asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value %= asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;

		// bail out if no packets left
		if (wptr == rptr)
			return 0;

		// re-read the RPTR/WPTR out of the queue and check if RPTR != WPTR
		do {
			if (umr_read_vram(asic, asic->options.vm_partition, 0,
					asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_addr, 8,
					&asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value) < 0) {
				asic->err_msg("[ERROR]: Could not read hqd_rptr value\n");
				return -1;
			}
			if (umr_read_vram(asic, asic->options.vm_partition, 0,
					asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_addr, 8,
					&asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value) < 0) {
				asic->err_msg("[ERROR]: Could not read rb_wptr_poll value\n");
				return -1;
			}

			asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;
			asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value %= asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;

			// if the wptr or rptr moved the queue is obviously not halted.
			if ((rptr != asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value) ||
				(wptr != asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value)) {
					return 0;
			}
			usleep(5);
		} while (++tries < 100);
		return 1;
	} else {
		// read ring data and reduce indeices modulo ring size
		// since the kernel returned values might be unwrapped.
		for (n = 0; n < 100; n++) {
			ringdata = asic->ring_func.read_ring_data(asic, ringname, &ringsize);
			if (!ringdata) {
				return 0;
			}
			ringsize /= 4;
			ringdata[0] %= ringsize;
			ringdata[1] %= ringsize;
			if (ringdata[0] == ringdata[1]) {
				free(ringdata);
				return 0;
			}
			free(ringdata);
			usleep(5);
		}
	}

	return 1;
}
