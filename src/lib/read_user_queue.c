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
 * umr_read_user_queue_buffer - Read the user queue buffer as a ring
 * @asic: The ASIC that has the user queue attached to it.
 * @start: The start offset in dwords
 * @end: The end offset in dwords (end < start is allowed since umr knows the RB_BUZSZ)
 * @buf: Destination buffer to hold the words.
 * @len: [out] The number of dwords copied is stored here.
 *
 * Returns 0 on success.
 */
int umr_read_user_queue_buffer(struct umr_asic *asic, uint32_t start, uint32_t end, uint32_t *buf, uint32_t *len)
{
    uint32_t n;

    *len = 0;
    if (start > end) {
        // read from start to RB_BUZSZ and then 0 to end
        n = asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size - start;
        if (umr_read_vram(asic, asic->options.vm_partition, 0,
            asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr + start * 4, n * 4, buf) < 0) {
                asic->err_msg("[ERROR]: Could not read between 'start' and RB_BUFSZ from user queue buffer.\n");
                return -1;
        }
        if (umr_read_vram(asic, asic->options.vm_partition, 0,
            asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr, end * 4, buf + n * 4) < 0) {
                asic->err_msg("[ERROR]: Could not read between 0 and 'end' from user queue buffer.\n");
                return -1;
        }
        *len = n + end;
        return 0;
    } else {
        // read from start to end
        if (umr_read_vram(asic, asic->options.vm_partition, 0,
            asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr + start * 4, (end - start) * 4, buf) < 0) {
                asic->err_msg("[ERROR]: Could not read between 'start' and 'end' from user queue buffer.\n");
                return -1;
        }
        *len = end - start;
        return 0;
    }
}
