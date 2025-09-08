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

/**
 * umr_parse_clientid -- Parse the user_queue structure fields against debugfs
 * This allows UMR to bind to a specific user queue for debugging command submissions
 * that don't go through the kernel rings.
 *
 * This begins with the "clientid" field in the structure which specifies what to bind to.
 * It has the rough form of 'client.queue' where both fields have multiple presentations.
 *
 * The 'client' part can be specified as:
 *    - a number e.g. '17' to specify DRI client 17
 *    - as a process (comm) name with a '@' prefix, e.g. '@glmark2'
 *    - as a PID with a '=' prefix, e.g. '=2314'
 *
 * The 'queue' part can be specified as:
 *    - a number, e.g. '1' to specify queue-1
 *    - a type, e.g. '@0' to specify the first gfx queue (1 for compute)
 *    - a leading '-' (after the period) means first hqd_active queue
 *
 * Together you can have clientid strings like:
 *    - '17.1' => client 17 queue 1
 *    - '@glmark2.1' => queue 1 of first instance of glmark2 found
 *    - '=2314.@0' => the first gfx queue of the PID 2314.
 *    - '=2314.-@0' => the first hqd_active gfx queue of PID 2314
 */

int umr_parse_clientid(struct umr_asic *asic)
{
    int use_name = 0, use_pid = 0, use_type = 0, use_active = 0, found = 0, x;
    int gfx_maj, gfx_min;
    uint64_t queueid, tmp;
    char *p, *pp, str[256], path[512];
    FILE *f;

    // if this is a rumr client we send the request remotely
    if (asic->options.rumr_active) {
        return rumr_client_user_queue_parse(asic);
    }

    // are we hunting for a procname or client id number?
    strcpy(str, asic->options.user_queue.clientid);
    p = str;
    if (str[0] == '@') {
        // procname, let's parse it out
        ++p;
        use_name = 1;
    } else  if (str[0] == '=') {
        // pidname, let's parse it out
        ++p;
        use_pid = 1;
    }

    // look for queue id
    pp = strstr(p, ".");
    if (!pp) {
        asic->err_msg("[ERROR]: Invalid clientid syntax should be of the form 'clientid.queueid'\n");
        return -1;
    }
    *pp = 0; // split string in two
    ++pp;

    // handle modifiers in any order
    while (*pp && !isdigit(*pp)) {
        if (*pp == '-') {
            // if they specify a leading - in the queueid it means only use active queues
            use_active = 1;
        } else if (*pp == '@') {
            // if they specify the queue id with a prefixed @ means we want to match queue type not id.
            use_type = 1;
        } else {
            asic->err_msg("[ERROR]: Invalid character in user queue id field [%c]\n", *pp);
        }
        ++pp;
    }
    queueid = atoi(pp);

    // now p points to the procname or clientid and pp points to the queueid
    sprintf(path, "/sys/kernel/debug/dri/%d/clients", asic->instance);
    f = fopen(path, "r");
    if (!f) {
        asic->err_msg("[ERROR]: Could not open clients file for device instance %d\n", asic->instance);
        return -1;
    }

    // scan file for the target client
    fgets(path, sizeof path, f); // skip first line
    while (fgets(path, sizeof path, f)) {
        sscanf(path, "%s %s %s %s %s %s %s %s %s",
            asic->options.user_queue.client_line.command, asic->options.user_queue.client_line.tgid,
            asic->options.user_queue.client_line.dev, asic->options.user_queue.client_line.master,
            asic->options.user_queue.client_line.a, asic->options.user_queue.client_line.uid,
            asic->options.user_queue.client_line.magic, asic->options.user_queue.client_line.name,
            asic->options.user_queue.client_line.id);
        if ((use_name && !strcmp(p, asic->options.user_queue.client_line.command)) ||
            (use_pid && atoi(p) == atoi(asic->options.user_queue.client_line.tgid)) ||
            (!use_name && !use_pid && atoi(p) == atoi(asic->options.user_queue.client_line.id))) {
            // found the entry
            found = 1;
            break;
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
                return -1;
            }
            fclose(f);
        } else {
            asic->err_msg("[ERROR]: Could not open client's proc_info file from %s\n", path);
            return -1;
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
                return -1;
            }
            fclose(f);
        } else {
            asic->err_msg("[ERROR]: Could not open client's vm_pagetable_info file from %s\n", path);
            return -1;
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
        for (queueno = 1; queueno < 256; queueno++) {
            if (total_queues == UMR_MAX_MQD_QUEUES)
                break;
            sprintf(path, "/sys/kernel/debug/dri/client-%s/queue-%d/mqd_info", asic->options.user_queue.client_line.id, queueno);
            f = fopen(path, "r");
            if (f) {
                if (fscanf(f, "queue_type: %"SCNu32"\nmqd_gpu_address: %"SCNx64,
                    &asic->options.user_queue.client_info.queue[total_queues].queue_type,
                    &asic->options.user_queue.client_info.queue[total_queues].mqd_gpu_address) == 2) {
                    if (umr_read_vram(asic, asic->options.vm_partition, 0,
                            asic->options.user_queue.client_info.queue[total_queues].mqd_gpu_address, 512*4,
                            &asic->options.user_queue.client_info.queue[total_queues].mqd_words) < 0) {
                        asic->err_msg("[ERROR]: Could not read the MQD from memory for %s\n", path);
                    }
                    asic->options.user_queue.client_info.queue[total_queues].queue_id = queueno;
                    ++total_queues;
                } else {
                    asic->err_msg("[ERROR]: Could not parse the MQD info file %s\n", path);
                }
                fclose(f);
            }
        }
    } else {
        asic->err_msg("[ERROR]: The client '%s' was not found for this device.\n", asic->options.user_queue.clientid);
        memset(&asic->options.user_queue, 0, sizeof asic->options.user_queue);
        return -1;
    }

    // enable VM translations using the queue state
    // at this point all VM page walks/read/writes will use the values programmed into user_queue.state.registers
    asic->options.user_queue.state.active = 1;

    // parse the MQD and HQD to setup the address/rptr/wptr of the command packets
    for (x = 0; x < UMR_MAX_MQD_QUEUES; x++) {
        if (asic->options.user_queue.client_info.queue[x].mqd_gpu_address) {
            // match the desired queue ID or type
            if ((!use_type && (queueid == asic->options.user_queue.client_info.queue[x].queue_id)) ||
                (use_type && (queueid == asic->options.user_queue.client_info.queue[x].queue_type))) {
                // setup state ...
                int init = 0;

                // shorthand access to the MQD words read above
                uint32_t *mqdwords = asic->options.user_queue.client_info.queue[x].mqd_words;

                if (gfx_maj == 12) {
                    // handle GFX 12.* ASICs
                    if (asic->options.user_queue.client_info.queue[x].queue_type == 0) {
                        // GFX12 graphics queue
                        // skip if we only want active ones
                        if (use_active && !(mqdwords[130] & 1)) {
                            continue;
                        }

                        asic->options.user_queue.state.submission.hqd_base_addr =
                            (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_gfx_hqd_base[_hi]
                        asic->options.user_queue.state.submission.hqd_rptr_addr =
                            (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_gfx_hqd_rptr_addr_[hi]
                        asic->options.user_queue.state.submission.rb_wptr_poll_addr =
                            (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_rb_wptr_poll_addr_[lo|hi]

                        // we use VMID 0 here for these reads but at this point VM access has been superceded
                        // with the register values we programmed in the state above.
                        if (umr_read_vram(asic, asic->options.vm_partition, 0,
                                asic->options.user_queue.state.submission.hqd_rptr_addr, 8,
                                &asic->options.user_queue.state.submission.hqd_rptr_value) < 0) {
                            asic->err_msg("[ERROR]: Could not read hqd_rptr value\n");
                            return -1;
                        }
                        if (umr_read_vram(asic, asic->options.vm_partition, 0,
                                asic->options.user_queue.state.submission.rb_wptr_poll_addr, 8,
                                &asic->options.user_queue.state.submission.rb_wptr_poll_value) < 0) {
                            asic->err_msg("[ERROR]: Could not read rb_wptr_poll value\n");
                            return -1;
                        }

                        // parse some fields of CP_GFX_HQD_CNTL (mqdwords[145])
                            // 2**(RB_BUFSZ+1)
                            asic->options.user_queue.state.submission.rb_buf_size =
                                1 << (1 + umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
                                    "regCP_GFX_HQD_CNTL", "RB_BUFSZ", mqdwords[145]));

                        // reduce the wptr/rptr values modulo the size of the queue buffer
                        asic->options.user_queue.state.submission.rb_wptr_poll_value %= asic->options.user_queue.state.submission.rb_buf_size;
                        asic->options.user_queue.state.submission.hqd_rptr_value %= asic->options.user_queue.state.submission.rb_buf_size;

                        // store the active flag
                        asic->options.user_queue.state.submission.hqd_active = mqdwords[130];
                        asic->options.user_queue.state.submission.queueid = asic->options.user_queue.client_info.queue[x].queue_id;
                        asic->options.user_queue.state.submission.queuetype = asic->options.user_queue.client_info.queue[x].queue_type;

                        init = 1;
                    } else if (asic->options.user_queue.client_info.queue[x].queue_type == 1) {
                        // GFX12 compute queue
                        // skip if we only want active ones
                        if (use_active && !(mqdwords[130] & 1)) {
                            continue;
                        }

                            asic->options.user_queue.state.submission.hqd_base_addr =
                            (((uint64_t)mqdwords[137] << 32) | mqdwords[136]) << 8; // cp_hqd_pq_base_[lo|hi]
                        asic->options.user_queue.state.submission.hqd_rptr_addr =
                            (((uint64_t)mqdwords[140] << 32) | mqdwords[139]); // cp_hqd_pq_rptr_report_addr_[lo|hi]
                        asic->options.user_queue.state.submission.rb_wptr_poll_addr =
                            (((uint64_t)mqdwords[142] << 32) | mqdwords[141]); // cp_hqd_pq_wptr_poll_addr_[lo|hi]

                        // we use VMID 0 here for these reads but at this point VM access has been superceded
                        // with the register values we programmed in the state above.
                        if (umr_read_vram(asic, asic->options.vm_partition, 0,
                                asic->options.user_queue.state.submission.hqd_rptr_addr, 8,
                                &asic->options.user_queue.state.submission.hqd_rptr_value) < 0) {
                            asic->err_msg("[ERROR]: Could not read hqd_rptr value\n");
                            return -1;
                        }
                        if (umr_read_vram(asic, asic->options.vm_partition, 0,
                                asic->options.user_queue.state.submission.rb_wptr_poll_addr, 8,
                                &asic->options.user_queue.state.submission.rb_wptr_poll_value) < 0) {
                            asic->err_msg("[ERROR]: Could not read rb_wptr_poll value\n");
                            return -1;
                        }

                        // TODO: sort out size of the buffer so we can modulo the rptr/wptr correctly.

                        // store the active flag
                        asic->options.user_queue.state.submission.hqd_active = mqdwords[130];

                        init = 1;
                    }
                }

                // we're done
                if (init) {
                    break;
                } else {
                    asic->err_msg("[BUG]: Could not initialize user queue state with hqd information.\n");
                    return -1;
                }
            }
        }
    }
    return 0;
}
