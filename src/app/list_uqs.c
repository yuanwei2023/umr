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
#include "umr_rumr.h"
#include "umrapp.h"
#include <signal.h>
#include <time.h>
#include <stdarg.h>

/**
 * umr_list_uqs - list the user queues for the user
 */
void umr_list_uqs(struct umr_asic *asic)
{
    struct umr_user_queue *uq, *tq;

    tq = uq = umr_enumerate_user_queue_clients(asic);
    while (uq) {
        int x, first = 1;
        for (x = 0; x < UMR_MAX_MQD_QUEUES; x++) {
            if (uq->client_info.queue[x].mqd_gpu_address) {
                if (first) {
                    asic->std_msg("Client #%s: comm=[%s] tgid=%s type=%s\n",
                        uq->client_line.id, uq->client_line.command, uq->client_line.tgid, uq->client_type == UMR_CLIENT_KFD ? "kfd" : "kgd");
                    first = 0;
                }
                asic->std_msg("%s   queue=%d type=%d mqd_gpu_addr=0x%"PRIx64" rptr=0x%"PRIx64" wptr=0x%"PRIx64"\n",
                    uq->client_info.queue[x].hqd_rptr_value != uq->client_info.queue[x].rb_wptr_poll_value ? "**" : "  ",
                    uq->client_info.queue[x].queue_id, uq->client_info.queue[x].queue_type,
                    uq->client_info.queue[x].mqd_gpu_address,
                    uq->client_info.queue[x].hqd_rptr_value, 
                    uq->client_info.queue[x].rb_wptr_poll_value);
            }
        }
        if (!first && uq->next)
            asic->std_msg("\n");
        uq = uq->next;
    }
    umr_user_queue_free(tq);
}