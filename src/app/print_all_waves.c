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
#include "umrapp.h"

void umr_print_all_waves(struct umr_asic *asic)
{
    int pass, x, xcd, ovmp;
    unsigned ver;

    ovmp = asic->options.vm_partition;
    for (pass = 0; pass < 2; pass++) {
        for (x = 0; x < asic->no_blocks; x++) {
            if (memcmp(asic->blocks[x]->ipname, "gfx", 3) == 0) {
                if (sscanf(asic->blocks[x]->ipname, "gfx%x{%d}", &ver, &xcd) == 2) {
                    asic->options.vm_partition = xcd;
                } else {
                    asic->options.vm_partition = -1;
                }
                umr_print_waves(asic, pass);
            }
        }
    }
    asic->options.vm_partition = ovmp;
}