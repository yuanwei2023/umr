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
#include "umr.h"
#include <signal.h>
#include <time.h>
#include <stdarg.h>
#include <ctype.h>

/* Coverage

GFX9
    - KGD N/A
    - KFD compile tested

GFX10
    - KGD N/A
    - KFD COMPUTE queue only

GFX11
    - KGD N/A
    - KFD COMPUTE queue only

GFX12
    - KGD GFX queue tested (on older initial uq patch only)
    - KFD COMPUTE queue only

Notably lacking:
    - KFD SDMA queues on any revision
    - KGD GFX queues against latest umr patches.

*/

static int init_gfx9_queue(struct umr_asic *asic, int x, int *init)
{
    uint32_t *mqdwords = asic->options.user_queue.client_info.queue[x].mqd_words;
    switch (asic->options.user_queue.client_info.queue[x].queue_type) {
    case UMR_QUEUE_GFX:
    case UMR_QUEUE_COMPUTE_PM4:
    case UMR_QUEUE_COMPUTE:
        {
            // GFX9 COMPUTE
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_hqd_pq_base_[lo|hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_hqd_pq_rptr_report_addr_[lo|hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_hqd_pq_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regCP_HQD_PQ_CONTROL", "QUEUE_SIZE", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // TODO: use AQL_CONTROL to see if we need to use say USER_QUEUE_COMPUTE_PM4 ...

            // TODO: ctx_save support?

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_SDMA:
        {
            // GFX9 SDMA queue
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[2] << 32) | mqdwords[1]) << 8; // sdmax_rlcx_rb_base
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[8] << 32) | mqdwords[9]); // sdmax_rlcx_rb_rptr_addr_lo
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[28] << 32) | mqdwords[29]); // sdmax_rlcx_rb_wptr_poll_addr_lo

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // TODO: sort out register in database to tie to
            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regSDMA0_QUEUE0_RB_CNTL", "RB_SIZE", mqdwords[0]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            *init = 1;
        }
        break;
    default:
        asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", (int)asic->options.user_queue.client_info.queue[x].queue_type, __FILE__, __LINE__);
    }
    return 0;
}

static int init_gfx10_queue(struct umr_asic *asic, int x, int *init)
{
    uint32_t *mqdwords = asic->options.user_queue.client_info.queue[x].mqd_words;
    // handle GFX 10.* ASICs
    switch (asic->options.user_queue.client_info.queue[x].queue_type) {
        case UMR_QUEUE_GFX:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_gfx_hqd_base[_hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_gfx_hqd_rptr_addr_[hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_rb_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // parse some fields of CP_GFX_HQD_CNTL (mqdwords[145])
                // 2**(RB_BUFSZ+1)
                asic->options.user_queue.client_info.queue[x].rb_buf_size =
                    1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                        "mmCP_GFX_HQD_CNTL", "RB_BUFSZ", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_COMPUTE_PM4:
    case UMR_QUEUE_COMPUTE:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_hqd_pq_base_[lo|hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_hqd_pq_rptr_report_addr_[lo|hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_hqd_pq_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "mmCP_HQD_PQ_CONTROL", "QUEUE_SIZE", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // GFX10 compute queue

            // TODO: use AQL_CONTROL to see if we need to use say USER_QUEUE_COMPUTE_PM4 ...

            // TODO: ctx_save support?

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_SDMA:
        {
            // GFX10 SDMA queue
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[2] << 32) | mqdwords[1]) << 8; // sdmax_rlcx_rb_base
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[8] << 32) | mqdwords[9]); // sdmax_rlcx_rb_rptr_addr_lo
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[28] << 32) | mqdwords[29]); // sdmax_rlcx_rb_wptr_poll_addr_lo

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // TOOD: sort out GFX10 SDMA control reg name/IP blocl
            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regSDMA0_QUEUE0_RB_CNTL", "RB_SIZE", mqdwords[0]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            *init = 1;
        }
        break;
    default:
        asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", (int)asic->options.user_queue.client_info.queue[x].queue_type, __FILE__, __LINE__);
    }
    return 0;
}

static int init_gfx11_queue(struct umr_asic *asic, int x, int *init)
{
    uint32_t *mqdwords = asic->options.user_queue.client_info.queue[x].mqd_words;
    // handle GFX 11.* ASICs
    switch (asic->options.user_queue.client_info.queue[x].queue_type) {
        case UMR_QUEUE_GFX:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_gfx_hqd_base[_hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_gfx_hqd_rptr_addr_[hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_rb_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // parse some fields of CP_GFX_HQD_CNTL (mqdwords[145])
                // 2**(RB_BUFSZ+1)
                asic->options.user_queue.client_info.queue[x].rb_buf_size =
                    1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                        "regCP_GFX_HQD_CNTL", "RB_BUFSZ", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_COMPUTE_PM4:
    case UMR_QUEUE_COMPUTE:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_hqd_pq_base_[lo|hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_hqd_pq_rptr_report_addr_[lo|hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_hqd_pq_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regCP_HQD_PQ_CONTROL", "QUEUE_SIZE", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // GFX11 compute queue

            // TODO: use AQL_CONTROL to see if we need to use say USER_QUEUE_COMPUTE_PM4 ...

            // TODO: ctx_save support?

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_SDMA:
        {
            // GFX11 SDMA queue
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[2] << 32) | mqdwords[1]) << 8; // sdmax_rlcx_rb_base
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[7] << 32) | mqdwords[8]); // sdmax_rlcx_rb_rptr_addr_lo
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[26] << 32) | mqdwords[27]); // sdmax_rlcx_rb_wptr_poll_addr_lo

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regSDMA0_QUEUE0_RB_CNTL", "RB_SIZE", mqdwords[0]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            *init = 1;
        }
        break;
    default:
        asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", (int)asic->options.user_queue.client_info.queue[x].queue_type, __FILE__, __LINE__);
    }
    return 0;
}

static int init_gfx12_queue(struct umr_asic *asic, int x, int *init)
{
    uint32_t *mqdwords = asic->options.user_queue.client_info.queue[x].mqd_words;
    // handle GFX 12.* ASICs
    switch (asic->options.user_queue.client_info.queue[x].queue_type) {
        case UMR_QUEUE_GFX:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_gfx_hqd_base[_hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_gfx_hqd_rptr_addr_[hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_rb_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // parse some fields of CP_GFX_HQD_CNTL (mqdwords[145])
                // 2**(RB_BUFSZ+1)
                asic->options.user_queue.client_info.queue[x].rb_buf_size =
                    1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                        "regCP_GFX_HQD_CNTL", "RB_BUFSZ", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_COMPUTE_PM4:
    case UMR_QUEUE_COMPUTE:
        {
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_hqd_pq_base_[lo|hi]
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_hqd_pq_rptr_report_addr_[lo|hi]
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_hqd_pq_wptr_poll_addr_[lo|hi]

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regCP_HQD_PQ_CONTROL", "QUEUE_SIZE", mqdwords[145]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;

            // GFX12 compute queue

            // TODO: use AQL_CONTROL to see if we need to use say USER_QUEUE_COMPUTE_PM4 ...

            // TODO: ctx_save support?

            // store the active flag
            asic->options.user_queue.client_info.queue[x].hqd_active = mqdwords[130];
            *init = 1;
        }
        break;
    case UMR_QUEUE_SDMA:
        {
            // GFX12 SDMA queue
            asic->options.user_queue.client_info.queue[x].hqd_base_addr =
                (((uint64_t)mqdwords[2] << 32) | mqdwords[1]) << 8; // sdmax_rlcx_rb_base
            asic->options.user_queue.client_info.queue[x].hqd_rptr_addr =
                (((uint64_t)mqdwords[8] << 32) | mqdwords[7]); // sdmax_rlcx_rb_rptr_addr_lo
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr =
                (((uint64_t)mqdwords[25] << 32) | mqdwords[24]); // sdmax_rlcx_rb_wptr_poll_addr_lo

            // we use VMID 0 here for these reads but at this point VM access has been superceded
            // with the register values we programmed in the state above.
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].hqd_rptr_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].hqd_rptr_value) < 0) {
                asic->err_msg("[ERROR]: Could not read hqd_rptr value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }
            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                    asic->options.user_queue.client_info.queue[x].rb_wptr_poll_addr, 8,
                    &asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value) < 0) {
                asic->err_msg("[ERROR]: Could not read rb_wptr_poll value (try disabling GFXOFF with '-go 0')\n");
                return -1;
            }

            // sort out size of the buffer so we can modulo the rptr/wptr correctly.
            asic->options.user_queue.client_info.queue[x].rb_buf_size =
                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                    "regSDMA0_QUEUE0_RB_CNTL", "RB_SIZE", mqdwords[0]));

            // reduce the wptr/rptr values modulo the size of the queue buffer
            asic->options.user_queue.client_info.queue[x].rb_wptr_poll_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            asic->options.user_queue.client_info.queue[x].hqd_rptr_value %= asic->options.user_queue.client_info.queue[x].rb_buf_size;
            *init = 1;
        }
        break;
    default:
        asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", (int)asic->options.user_queue.client_info.queue[x].queue_type, __FILE__, __LINE__);
    }
    return 0;
}

/**
 * umr_parse_clientid -- Parse the user_queue structure fields against debugfs
 * This allows UMR to bind to a specific user queue for debugging command submissions
 * that don't go through the kernel rings.
 *
 * This begins with the "clientid" field in the structure which specifies what to bind to.
 * It has the rough form of 'client.queue' where both fields have multiple presentations.
 *
 * client string format (in any order):
 * clienttype,client,queue
 *
 * Where clientype is
 *    - kfd, for KFD queues
 *    - kgd, for KGD queues
 *
 * where client is
 *    - client=number, a client id
 *    - pid=number, a PID
 *    - comm=string, a command name
 *
 * where queue is
 *    - queue=number, a queue id
 *    - type=string, a queue type by string (gfx, compute, sdma)
 *    - active=string, first active by type (see type=)
 *
 * for instance: "kfd,comm=ollama,queue=2"
 */
struct umr_user_queue umr_parse_clientid(struct umr_asic *asic, const char *cid)
{
    int client_named = 0, use_name = 0, use_pid = 0, use_type = 0, found = 0, x;
    int gfx_maj, gfx_min;
    uint64_t queueid = 0, tmp;
    char p[256], pp[256], str[256], path[512];
    const char *ps, *pps;
    FILE *f;
    struct umr_user_queue retq = { 0 }, tmpq = { 0 };

    // save the current queue because we'll need to override it
    retq.state.qidx = -1;
    tmpq = asic->options.user_queue;

    // default the queue index to -1 to indicate invalid
    asic->options.user_queue.state.qidx = -1;

    // if this is a rumr client we send the request remotely
    if (asic->options.rumr_active) {
        int r = rumr_client_user_queue_parse(asic);
        if (!r) {
            retq = asic->options.user_queue;
            asic->options.user_queue = tmpq;
            return retq;
        } else {
            asic->err_msg("[ERROR]: Could not fetch user queue info over rumr tunnel.\n");
            return retq;
        }
    }

    ps = cid;
    memset(p, 0, sizeof p);
    memset(pp, 0, sizeof pp);
    while (*ps) {
        // find next comma or end of string
        pps = strstr(ps,",");
        if (!pps) {
            pps = ps + strlen(ps);
        }

        memset(str, 0, sizeof str);
        memcpy(str, ps, (int)(pps - ps));
        ps = pps;
        if (*ps == ',')
            ++ps;

        // process token
        if (!strcmp(str, "kfd")) {
            asic->options.user_queue.client_type = UMR_CLIENT_KFD;
            client_named = 1;
        } else if (!strcmp(str, "kgd")) {
            asic->options.user_queue.client_type = UMR_CLIENT_KGD;
            client_named = 1;
        } else if (!memcmp(str, "client=", 7)) {
            strcpy(p, strstr(str, "=") + 1);
        } else if (!memcmp(str, "pid=", 4)) {
            strcpy(p, strstr(str, "=") + 1);
            use_pid = 1;
        } else if (!memcmp(str, "comm=", 5)) {
            strcpy(p, strstr(str, "=") + 1);
            use_name = 1;
        } else if (!memcmp(str, "queue=", 6)) {
            strcpy(pp, strstr(str, "=") + 1);
            queueid = atoi(pp);
        } else if (!memcmp(str, "type=", 5)) {
            pps = strstr(str, "=") + 1;
            if (!strcmp(pps, "gfx")) {
                queueid = UMR_QUEUE_GFX;
            } else if (!strcmp(pps, "compute")) {
                queueid = UMR_QUEUE_COMPUTE;
            } else if (!strcmp(pps, "sdma")) {
                queueid = UMR_QUEUE_SDMA;
            }
            use_type = 1;
        } else {
            asic->err_msg("[WARNING]: Unknown client option '%s' in client string\n", str);
        }
    }

    // BY THIS POINT
    // p => client id, command name, or pid
    // pp => queue id, type
    // use_type, use_name, use_pid must be initialized.

    // now p points to the procname or clientid and pp points to the queueid
    sprintf(path, "/sys/kernel/debug/dri/%d/clients", asic->instance);
    f = fopen(path, "r");
    if (!f) {
        asic->err_msg("[ERROR]: Could not open clients file for device instance %d\n", asic->instance);
        goto error;
    }

    // scan file for the target client
    if (fgets(path, sizeof path, f)) {
        while (fgets(path, sizeof path, f)) {
            if (sscanf(path, "%s %s %s %s %s %s %s %s %s",
                asic->options.user_queue.client_line.command, asic->options.user_queue.client_line.tgid,
                asic->options.user_queue.client_line.dev, asic->options.user_queue.client_line.master,
                asic->options.user_queue.client_line.a, asic->options.user_queue.client_line.uid,
                asic->options.user_queue.client_line.magic, asic->options.user_queue.client_line.name,
                asic->options.user_queue.client_line.id) == 9) {
                if ((use_name && !strcmp(p, asic->options.user_queue.client_line.command)) ||
                    (use_pid && atoi(p) == atoi(asic->options.user_queue.client_line.tgid)) ||
                    (!use_name && !use_pid && atoi(p) == atoi(asic->options.user_queue.client_line.id))) {
                    // found the entry
                    found = 1;
                    if (!client_named) {
                        // try to auto detect the client type
                        FILE *cf;
                        char buf[256], str[256];
                        // a KFD client is one where the PID is found in kfd/mqds as "Process ${tgid}"
                        asic->options.user_queue.client_type = UMR_CLIENT_KGD;
                        cf = fopen("/sys/kernel/debug/kfd/mqds", "r");
                        if (cf) {
                            sprintf(str, "Process %s", asic->options.user_queue.client_line.tgid);
                            while(fgets(buf, sizeof buf, cf)) {
                                if (strstr(buf, str)) {
                                    asic->options.user_queue.client_type = UMR_CLIENT_KFD;
                                    break;
                                }
                            }
                            fclose(cf);
                        }
                    }
                    break;
                }
            } else {
                asic->err_msg("[ERROR]: Could not parse 'clients' file from debugfs.  Could be your kernel is too old.\n");
                goto error;
            }
        }
    }
    fclose(f);

    // we found the client now let's read it into memory
    if (found) {
        int total_queues = 0, queueno = 1;

        // ok we found the client-id let's read proc_info
        sprintf(path, "/sys/kernel/debug/dri/client-%s/proc_info", asic->options.user_queue.client_line.id);
        f = fopen(path, "r");
        if (f) {
            if (fscanf(f, "pid: %"SCNu32"\ncomm: %s",
                    &asic->options.user_queue.client_info.proc_info.pid,
                    asic->options.user_queue.client_info.proc_info.comm) != 2) {
                asic->err_msg("[ERROR]: Could not parse proc_info file %s\n", path);
                fclose(f);
                goto error;
            }
            fclose(f);
        } else {
            asic->err_msg("[ERROR]: Could not open client's proc_info file from %s\n", path);
            goto error;
        }

        // parse the vm_pagetable_info file
        sprintf(path, "/sys/kernel/debug/dri/client-%s/vm_pagetable_info", asic->options.user_queue.client_line.id);
        f = fopen(path, "r");
        if (f) {
            if (fscanf(f, "pd_address: %"SCNx64"\nmax_pfn: %"SCNx64"\nnum_level: %"SCNx32"\nblock_size: %"SCNx32"\nfragment_size: %"SCNx32,
                    &asic->options.user_queue.client_info.vm_pagetable_info.pd_address,
                    &asic->options.user_queue.client_info.vm_pagetable_info.max_pfn,
                    &asic->options.user_queue.client_info.vm_pagetable_info.num_level,
                    &asic->options.user_queue.client_info.vm_pagetable_info.block_size,
                    &asic->options.user_queue.client_info.vm_pagetable_info.fragment_size) != 5) {
                asic->err_msg("[ERROR]: Could not parse vm_pagetable_info file %s\n", path);
                fclose(f);
                goto error;
            }
            fclose(f);
        } else {
            asic->err_msg("[ERROR]: Could not open client's vm_pagetable_info file from %s\n", path);
            goto error;
        }

		umr_gfx_get_ip_ver(asic, &gfx_maj, &gfx_min);

        // disable VM translations using the queue state (in case the caller has called this more than once)
        // at this point all VM page walks/read/writes will use live MMIO registers to access VM context registers.
        asic->options.user_queue.state.active = 0;

        // we can initialize a few registers...
        // use max_pfn to compute a mask for the VA span.
        tmp = ((asic->options.user_queue.client_info.vm_pagetable_info.max_pfn) - 1) & 0xFFFFFFFFFFFFULL;
        asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_LO32 = tmp & 0xFFFFFFFF;
        asic->options.user_queue.state.registers.PAGE_TABLE_END_ADDR_HI32 = (tmp >> 32ULL) & 0xF;
        tmp &= asic->options.user_queue.client_info.vm_pagetable_info.pd_address;
        asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_LO32 = tmp & 0xFFFFFFFF;
        asic->options.user_queue.state.registers.PAGE_TABLE_BASE_ADDR_HI32 = tmp >> 32ULL;

        // now read upto UMR_MAX_MQD_QUEUES from the dir of the form queue-${queueno}/
        if (asic->options.user_queue.client_type == UMR_CLIENT_KGD) {
            // we're reading queues for this client based on the kgd debugfs tree
            for (queueno = 1; queueno < 256; queueno++) {
                if (total_queues == UMR_MAX_MQD_QUEUES)
                    break;
                sprintf(path, "/sys/kernel/debug/dri/client-%s/queue-%d/mqd_info", asic->options.user_queue.client_line.id, queueno);
                f = fopen(path, "r");
                if (f) {
                    uint32_t queue_type;
                    if (fscanf(f, "queue_type: %"SCNu32"\nmqd_gpu_address: %"SCNx64,
                        &queue_type,
                        &asic->options.user_queue.client_info.queue[total_queues].mqd_gpu_address) == 2) {
                        int mqd_type = -1;

                        switch (queue_type) {
                            case 0:
                                asic->options.user_queue.client_info.queue[total_queues].queue_type = UMR_QUEUE_GFX;
                                mqd_type = UMR_MQD_ENGINE_GFX;
                                break;
                            case 1:
                                asic->options.user_queue.client_info.queue[total_queues].queue_type = UMR_QUEUE_COMPUTE;
                                mqd_type = UMR_MQD_ENGINE_COMPUTE;
                                break;
                            case 2:
                                asic->options.user_queue.client_info.queue[total_queues].queue_type = UMR_QUEUE_SDMA;
                                mqd_type = UMR_MQD_ENGINE_SDMA0;
                                break;
                            default:
                                asic->err_msg("[BUG]: Unsupported client queue type [%"PRIu32"]\n", queue_type);
                        }
                        asic->options.user_queue.client_info.queue[total_queues].queue_id = queueno;
                        if (mqd_type != -1) {
                            asic->options.user_queue.client_info.queue[total_queues].mqd_size = umr_mqd_decode_size(mqd_type, asic->family);
                            if (umr_read_vram(asic, asic->options.vm_partition, 0,
                                    asic->options.user_queue.client_info.queue[total_queues].mqd_gpu_address,
                                    asic->options.user_queue.client_info.queue[total_queues].mqd_size*4,
                                    &asic->options.user_queue.client_info.queue[total_queues].mqd_words) < 0) {
                                asic->err_msg("[ERROR]: Could not read the MQD from memory for %s\n", path);
                            }
                        }
                        ++total_queues;
                    } else {
                        asic->err_msg("[ERROR]: Could not parse the MQD info file %s\n", path);
                    }
                    fclose(f);
                }
            }
        } else if (asic->options.user_queue.client_type == UMR_CLIENT_KFD) {
            // we're reading queues for this client based on the kfd debugfs tree
            memset(&asic->options.user_queue.client_info.queue, 0, sizeof(asic->options.user_queue.client_info.queue));
            f = fopen("/sys/kernel/debug/kfd/mqds", "r");
            if (f) {
                char line[512];
                uint32_t t[9];
                uint32_t pid, pasid;

                // start at -1 since the first queue increments this before storing data
                total_queues = -1;

                // scan for a line matching the PID/tgid
                while (fgets(line, sizeof(line) - 1, f)) {
                    if (sscanf(line, "Process %"SCNu32" PASID %"SCNu32":", &pid, &pasid) == 2) {
                        if (pid == strtoul(asic->options.user_queue.client_line.tgid, NULL, 10)) {
                            // this KFD queue matches the PID, so let's copy any Compute queues found here
                            while (fgets(line, sizeof(line) - 1, f)) {
                                if (!memcmp(line, "  Compute", 9)) {
                                    // TODO: match the device 'asic' actually refers to, right now we just parse all queues in for the PID
                                    // start a new queue
                                    ++total_queues;
                                    asic->options.user_queue.client_info.queue[total_queues].queue_type = UMR_QUEUE_COMPUTE;
                                    asic->options.user_queue.client_info.queue[total_queues].queue_id = total_queues;
                                    asic->options.user_queue.client_info.queue[total_queues].mqd_size = umr_mqd_decode_size(UMR_MQD_ENGINE_COMPUTE, asic->family);
                                } else if (!memcmp(line, "  SDMA", 6)) {
                                    ++total_queues;
                                    asic->options.user_queue.client_info.queue[total_queues].queue_type = UMR_QUEUE_SDMA;
                                    asic->options.user_queue.client_info.queue[total_queues].queue_id = total_queues;
                                    asic->options.user_queue.client_info.queue[total_queues].mqd_size = umr_mqd_decode_size(UMR_MQD_ENGINE_SDMA0, asic->family);
                                } else if (total_queues >= 0 && sscanf(line, "%"SCNx32": %"SCNx32" %"SCNx32" %"SCNx32" %"SCNx32" %"SCNx32" %"SCNx32" %"SCNx32" %"SCNx32,
                                    &t[0], &t[1], &t[2], &t[3], &t[4], &t[5], &t[6], &t[7], &t[8]) == 9) {
                                    // store the line of data in the mqd struct
                                    if (((t[0]/4)+7) >= UMR_MAX_MQD_SIZE) {
                                        asic->err_msg("[BUG]: Reading MQD from KFD 'mqds' file resulted in offset (%"PRIu32") beyond UMR_MAX_MQD_SIZE\n", t[0]/4);
                                    } else {
                                        memcpy(&asic->options.user_queue.client_info.queue[total_queues].mqd_words[t[0]/4], &t[1], 32);
                                    }
                                } else {
                                    break;
                                }
                            }
                        }
                        // TODO: should we break here? or parse in all queues for a given PID?
                    }
                }
                // resolve MQD addresses for compute queues
                for (queueno = 0; queueno < total_queues; queueno++) {
                    if (asic->options.user_queue.client_info.queue[queueno].queue_type == UMR_QUEUE_COMPUTE) {
                        asic->options.user_queue.client_info.queue[queueno].mqd_gpu_address =
                            ((uint64_t)asic->options.user_queue.client_info.queue[queueno].mqd_words[129] << 32ULL) |
                            asic->options.user_queue.client_info.queue[queueno].mqd_words[128];
                    } else if (asic->options.user_queue.client_info.queue[queueno].queue_type == UMR_QUEUE_SDMA) {
                        asic->options.user_queue.client_info.queue[queueno].mqd_gpu_address =
                            ((uint64_t)asic->options.user_queue.client_info.queue[queueno].mqd_words[45] << 32ULL) |
                            asic->options.user_queue.client_info.queue[queueno].mqd_words[44];
                    }
                }
            } else {
                asic->err_msg("[ERROR]: Could not open /sys/kernel/debug/kfd/mqds\n");
            }
            fclose(f);
        }
    } else {
        asic->err_msg("[ERROR]: The client '%s' was not found for this device.\n", asic->options.user_queue.clientid);
        memset(&asic->options.user_queue, 0, sizeof asic->options.user_queue);
        goto error;
    }

    // enable VM translations using the queue state
    // at this point all VM page walks/read/writes will use the values programmed into user_queue.state.registers
    asic->options.user_queue.state.active = 1;

    // parse the MQD and HQD to setup the address/rptr/wptr of the command packets
    for (x = 0; x < UMR_MAX_MQD_QUEUES; x++) {
        if (asic->options.user_queue.client_info.queue[x].mqd_gpu_address) {
            int init = 0, r = -1;

            if (gfx_maj == 9) {
                r = init_gfx9_queue(asic, x, &init);
            } else if (gfx_maj == 10) {
                r = init_gfx10_queue(asic, x, &init);
            } else if (gfx_maj == 11) {
                r = init_gfx11_queue(asic, x, &init);
            } else if (gfx_maj == 12) {
                r = init_gfx12_queue(asic, x, &init);
            } else {
                asic->err_msg("[BUG]: The gfx maj %d is not currently supported by umr for user queues\n", gfx_maj);
                goto error;
            }
            if (r < 0) {
                goto error;
            }
            // we're done
            if (init) {
                if ((!use_type && (queueid == asic->options.user_queue.client_info.queue[x].queue_id)) ||
                    (use_type && (queueid == asic->options.user_queue.client_info.queue[x].queue_type))) {
                        asic->options.user_queue.state.qidx = x;
                }
            }
        }
    }

    retq = asic->options.user_queue;
error:
    asic->options.user_queue = tmpq;
    return retq;
}

/**
    umr_init_clientid - Initialize the ASIC model to connect to a specified client

    Uses the client string from asic->options.user_queue.clientid
 */
int umr_init_clientid(struct umr_asic *asic)
{
    char cid[256];

    // Copy from test harness if enabled
	if (asic->options.test_log && !asic->options.test_log_fd) {
		umr_test_harness_get_userqueue(asic, (uint8_t *)&asic->options.user_queue);
    } else {
        // read from live system
        strcpy(cid, asic->options.user_queue.clientid);
        asic->options.user_queue = umr_parse_clientid(asic, cid);

        // Store user queue selected to the test harness
        if (asic->options.test_log && asic->options.test_log_fd) {
            uint8_t *p = (uint8_t *)&asic->options.user_queue;
            unsigned x;
            fprintf(asic->options.test_log_fd, "USERQUEUE = {");
            for (x = 0; x < sizeof(asic->options.user_queue); x++) {
                fprintf(asic->options.test_log_fd, "%02"PRIx8, p[x]);
            }
            fprintf(asic->options.test_log_fd, "}\n");
        }
    }
    // done
    return asic->options.user_queue.state.qidx == -1 ? -1 : 0;
}

struct umr_user_queue *umr_enumerate_user_queue_clients(struct umr_asic *asic)
{
    struct umr_user_queue *lq = NULL, *tq;
    char path[512], buf[512];
    FILE *f = NULL, *cf = NULL;

    lq = calloc(1, sizeof *lq);
    if (!lq)
        goto error;

    // now p points to the procname or clientid and pp points to the queueid
    sprintf(path, "/sys/kernel/debug/dri/%d/clients", asic->instance);
    f = fopen(path, "r");
    if (!f) {
        asic->err_msg("[ERROR]: Could not open clients file for device instance %d\n", asic->instance);
        goto error;
    }

    // scan file for the target client
    if (fgets(path, sizeof path, f)) {
        while (fgets(path, sizeof path, f)) {
            int kgd_mode = 1;
            struct {
                char command[256], tgid[32], dev[32], master[32], a[32], uid[32], magic[32], name[256], id[32];
            } client_line;

            if (sscanf(path, "%s %s %s %s %s %s %s %s %s",
                client_line.command, client_line.tgid,
                client_line.dev, client_line.master,
                client_line.a, client_line.uid,
                client_line.magic, client_line.name,
                client_line.id) != 9) {
                asic->err_msg("[ERROR]: Could not parse 'clients' file.  Could be that your kernel is too old.\n");
                goto error;
            }

            // a KFD client is one where the PID is found in kfd/mqds as "Process ${tgid}"
            cf = fopen("/sys/kernel/debug/kfd/mqds", "r");
            if (cf) {
                sprintf(path, "Process %s", client_line.tgid);
                while(fgets(buf, sizeof buf, cf)) {
                    if (strstr(buf, path)) {
                        kgd_mode = 0;
                        break;
                    }
                }
                fclose(cf);
            }

            // parse the client
            sprintf(buf, "%s,client=%d,queue=0", kgd_mode ? "kgd" : "kfd", atoi(client_line.id));
            tq = lq->prev;
            *lq = umr_parse_clientid(asic, buf);
            lq->prev = tq;

            // advance the list
            lq->next = calloc(1, sizeof *lq);
            if (lq->next) {
                lq->next->prev = lq;
                lq = lq->next;
            } else {
                goto error;
            }
        }
    }
    fclose(f);

    // last entry is always redundant so remove
    if (lq->prev) {
        lq = lq->prev;
        free(lq->next);
        lq->next = NULL;
    }

    while (lq->prev)
        lq = lq->prev;
    return lq;
error:
    if (f)
        fclose(f);
    while (lq && lq->prev)
        lq = lq->prev;
    while (lq) {
        tq = lq->next;
        free(lq);
        lq = tq;
    }
    return NULL;
}

void umr_user_queue_free(struct umr_user_queue *uq)
{
    struct umr_user_queue *tq;
    while (uq && uq->prev)
        uq = uq->prev;
    while (uq) {
        tq = uq->next;
        free(uq);
        uq = tq;
    }
}