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
 * umr_print_uq_info - print out the decoded UQ/MQD/HQD values
 */
void umr_print_uq_info(struct umr_asic *asic)
{
    int x;
    char *queue_names[] = { "gfx", "compute", "compute_pm4", "sdma" };

    if (!asic->options.user_queue.clientid[0]) {
        asic->std_msg("[WARNING]: No user queue information was found.\n");
        return;
    }

    asic->std_msg("User Queue info for client: '%s' (qidx=%d)\n", asic->options.user_queue.clientid, asic->options.user_queue.state.qidx);
    asic->std_msg("\tcommand: %s\n", asic->options.user_queue.client_line.command);
    asic->std_msg("\ttgid: %s\n", asic->options.user_queue.client_line.tgid);
    asic->std_msg("\tdev: %s\n", asic->options.user_queue.client_line.dev);
    asic->std_msg("\tmaster: %s\n", asic->options.user_queue.client_line.master);
    asic->std_msg("\ta: %s\n", asic->options.user_queue.client_line.a);
    asic->std_msg("\tuid: %s\n", asic->options.user_queue.client_line.uid);
    asic->std_msg("\tmagic: %s\n", asic->options.user_queue.client_line.magic);
    asic->std_msg("\tname: %s\n", asic->options.user_queue.client_line.name);
    asic->std_msg("\tid: %s\n\n", asic->options.user_queue.client_line.id);

    asic->std_msg("\tpid: %"PRIu32", comm: %s\n\n",
        asic->options.user_queue.client_info.proc_info.pid,
        asic->options.user_queue.client_info.proc_info.comm);

    asic->std_msg("\tpd_address: 0x%"PRIx64"\n\tmax_pfn: 0x%"PRIx64"\n\tnum_level: 0x%"PRIx32"\n\tblock_size: 0x%"PRIx32"\n\tfragment_size: 0x%"PRIx32"\n\n",
        asic->options.user_queue.client_info.vm_pagetable_info.pd_address,
        asic->options.user_queue.client_info.vm_pagetable_info.max_pfn,
        asic->options.user_queue.client_info.vm_pagetable_info.num_level,
        asic->options.user_queue.client_info.vm_pagetable_info.block_size,
        asic->options.user_queue.client_info.vm_pagetable_info.fragment_size);

    asic->std_msg(
        "\tRegisters:\n\t\tPAGE_TABLE_START_ADDR_LO32: 0x%"PRIx32"\n\t\tPAGE_TABLE_START_ADDR_HI32: 0x%"PRIx32"\n\t\t"
        "PAGE_TABLE_END_ADDR_LO32: 0x%"PRIx32"\n\t\tPAGE_TABLE_END_ADDR_HI32: 0x%"PRIx32"\n\t\t"
        "PAGE_TABLE_BASE_ADDR_LO32: 0x%"PRIx32"\n\t\tPAGE_TABLE_BASE_ADDR_HI32: 0x%"PRIx32"\n\n",
        asic->options.user_queue.state.registers.PAGE_TABLE_START_ADDR_LO32,
        asic->options.user_queue.state.registers.PAGE_TABLE_START_ADDR_HI32,
		asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_LO32,
		asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_HI32,
		asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_LO32,
		asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_HI32);

    for (x = 0; x < UMR_MAX_MQD_QUEUES; x++) {
        if (asic->options.user_queue.client_info.queue[x].mqd_gpu_address) {
            char **mqd_txt;
            uint32_t qt;

            asic->std_msg("Queue #%d:\n\tqueue_id: %"PRIu32"\n", x, asic->options.user_queue.client_info.queue[x].queue_id);
            asic->std_msg("\tqueue_type: %"PRIu32" (%s)\n",
                asic->options.user_queue.client_info.queue[x].queue_type,
                asic->options.user_queue.client_info.queue[x].queue_type > 3 ? "UNK" : queue_names[asic->options.user_queue.client_info.queue[x].queue_type]);
            asic->std_msg("\tmqd_gpu_address: 0x%"PRIx64"\n", asic->options.user_queue.client_info.queue[x].mqd_gpu_address);

            asic->std_msg(
                "\tHQD state:\n\t\thqd_base_addr: 0x%"PRIx64"\n\t\thqd_rptr_addr: 0x%"PRIx64" (0x%"PRIx64")\n\t\t"
                "rb_wptr_poll_addr: 0x%"PRIx64" (0x%"PRIx64")\n\t\thqd_active: 0x%"PRIx64"\n\t\trb_buf_size: 0x%"PRIx64
                "\n\n\tMQD Contents (%"PRIu32" words):\n",
                asic->options.user_queue.client_info.queue[x].hqd_base_addr,
                asic->options.user_queue.client_info.queue[x].hqd_rptr_addr,
                asic->options.user_queue.client_info.queue[x].hqd_rptr_value,
                asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr,
                asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value,
                asic->options.user_queue.client_info.queue[x].hqd_active,
                asic->options.user_queue.client_info.queue[x].rb_buf_size,
                asic->options.user_queue.client_info.queue[x].mqd_size);

            switch (asic->options.user_queue.client_info.queue[x].queue_type) {
		        case UMR_QUEUE_COMPUTE_PM4:
                case UMR_QUEUE_COMPUTE: qt = UMR_MQD_ENGINE_COMPUTE; break;
                case UMR_QUEUE_GFX: qt = UMR_MQD_ENGINE_GFX; break;
                case UMR_QUEUE_SDMA: qt = UMR_MQD_ENGINE_SDMA0; break;
                default:
                    asic->err_msg("[BUG]: Invalid queue type [%d] in --print-uq\n", (int)asic->options.user_queue.client_info.queue[x].queue_type);
                    return;
            }
            mqd_txt = umr_mqd_decode_data(
                qt,
                asic->family,
                asic->options.user_queue.client_info.queue[x].mqd_words,
                "*");

            if (mqd_txt) {
                int y;
                for (y = 0; mqd_txt[y]; y++) {
                    asic->std_msg("\t\tqueue.%"PRIu32".%s\n", asic->options.user_queue.client_info.queue[x].queue_id, mqd_txt[y]);
                    free(mqd_txt[y]);
                }
                free(mqd_txt);
            }

            asic->std_msg("\n");
        }
    }
}

