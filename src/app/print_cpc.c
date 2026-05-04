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
#include "print_cpc.h"

#define ME1 1
#define ME2 2
#define MES 3
#define MAX_NUM_ME 4
#define ME1_MASK (1 << ME1)
#define ME2_MASK (1 << ME2)
#define MES_MASK (1 << MES)

#define H(x) if (col) { printf("\n"); }; col = 0; printf("\n\n%s:\n", x);
#define X_REG32_4COL(fmt, reg_name) if (col == 0 || col++ == 4) { col = 1; printf("\n\t"); } printf("%s" fmt "%s: %s%08x%s | ", GREEN, reg_name_without_prefix(reg_name), RST, BLUE, read_banked_reg(asic, reg_name), RST);
#define X_LIT32_4COL(fmt, fmt_arg, value) if (col == 0 || col++ == 4) { col = 1; printf("\n\t"); } printf("%s" fmt "%s: %s%08x%s | ", GREEN, fmt_arg, RST, BLUE, value, RST);
#define X_LIT32_8COL(fmt, fmt_arg, value) if (col == 0 || col++ == 8) { col = 1; printf("\n\t%s" fmt "%s: ", GREEN, fmt_arg, RST); } printf("%s%08x%s | ", BLUE, value, RST);
#define X_LIT64_4COL(fmt, fmt_arg, value) if (col == 0 || col++ == 4) { col = 1; printf("\n\t"); } printf("%s" fmt "%s: %s%016lx%s | ", GREEN, fmt_arg, RST, BLUE, value, RST);

static uint32_t read_banked_reg(struct umr_asic *asic, const char *name)
{
	return umr_read_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, (char *)name);
}

static uint32_t write_banked_reg(struct umr_asic *asic, const char *name, uint32_t value)
{
	return umr_write_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, (char *)name, value);
}

static const char *reg_name_without_prefix(const char *name) {
	const char *prefixes[] = {"mmCP_HQD_", "regCP_HQD_", "mmCP_", "regCP_", "mmCOMPUTE_", "regCOMPUTE_", "mm", "reg"};

	for (size_t i = 0; i < ARRAY_SIZE(prefixes); i++) {
		size_t prefix_len = strlen(prefixes[i]);

		if (strncmp(name, prefixes[i], prefix_len) == 0) {
			return name + prefix_len;
		}
	}

	return name;
}

void umr_print_cpc(struct umr_asic *asic)
{
	uint32_t rs64_en, me_present_mask, me_dc_mask, mqd_size_dw;
	uint32_t pipes_per_me[MAX_NUM_ME] = {0};
	uint32_t queues_per_pipe_per_me[MAX_NUM_ME] = {0};
	queue_mem_reg *queue_mem_regs = NULL;
	const char **global_regs = NULL, **pipe_regs = NULL, **dc_regs = NULL, **queue_regs = NULL, **utcl1_err_names = NULL;
	int maj, min, rev, queue_mem_regs_num, utcl1_err_names_num, col = 0;
	struct umr_options opts;

	rs64_en = asic->family >= FAMILY_GFX11;
	opts = asic->options;

	asic->options.use_bank = 2;

	umr_gfx_get_ip_ver(asic, &maj, &min, &rev);

	switch (maj) {
		case 9:
			me_present_mask = ME1_MASK | ME2_MASK;
			me_dc_mask = ME1_MASK;
			pipes_per_me[ME1] = 4;
			pipes_per_me[ME2] = 2;
			queues_per_pipe_per_me[ME1] = 8;
			queues_per_pipe_per_me[ME2] = 1;
			global_regs = gfx900_global_regs;
			pipe_regs = gfx900_pipe_regs;
			queue_regs = gfx900_queue_regs;
			utcl1_err_names = gfx900_utcl1_err_names;
			utcl1_err_names_num = gfx900_utcl1_err_names_num;
			queue_mem_regs = gfx900_queue_mem_regs;
			queue_mem_regs_num = gfx900_queue_mem_regs_num;
			mqd_size_dw = 0x200;
			switch (min) {
			case 0:
				dc_regs = gfx900_dc_regs;
				break;
			case 1:
				dc_regs = gfx910_dc_regs;
				break;
			case 2:
				dc_regs = gfx921_dc_regs;
				break;
			case 4:
				if (rev == 2) {
					dc_regs = gfx942_dc_regs;
				} else {
					dc_regs = gfx943_dc_regs;
					queue_regs = gfx943_queue_regs;
				}
				break;
			}
			break;
		case 10:
			me_present_mask = ME1_MASK | ME2_MASK;
			me_dc_mask = ME1_MASK;
			pipes_per_me[ME1] = 4;
			pipes_per_me[ME2] = 2;
			queues_per_pipe_per_me[ME1] = 4;
			queues_per_pipe_per_me[ME2] = 1;
			global_regs = gfx900_global_regs;
			pipe_regs = gfx900_pipe_regs;
			utcl1_err_names = gfx900_utcl1_err_names;
			utcl1_err_names_num = gfx900_utcl1_err_names_num;
			queue_mem_regs = gfx900_queue_mem_regs;
			queue_mem_regs_num = gfx900_queue_mem_regs_num;
			queue_regs = gfx1010_queue_regs;
			mqd_size_dw = 0x200;
			if (min == 1) {
				dc_regs = gfx1010_dc_regs;
			} else {
				dc_regs = gfx1030_dc_regs;
			}
			break;
		case 11:
			me_present_mask = ME1_MASK | MES_MASK;
			me_dc_mask = ME1_MASK;
			pipes_per_me[ME1] = 4;
			pipes_per_me[MES] = 2;
			queues_per_pipe_per_me[ME1] = 4;
			queues_per_pipe_per_me[MES] = 1;
			global_regs = gfx900_global_regs;
			pipe_regs = gfx1100_pipe_regs;
			dc_regs = gfx1100_dc_regs;
			utcl1_err_names = gfx900_utcl1_err_names;
			utcl1_err_names_num = gfx900_utcl1_err_names_num;
			queue_mem_regs = gfx900_queue_mem_regs;
			queue_mem_regs_num = gfx900_queue_mem_regs_num;
			queue_regs = gfx1100_queue_regs;
			mqd_size_dw = 0x200;
			break;
		case 12:
			me_present_mask = ME1_MASK | MES_MASK;
			me_dc_mask = ME1_MASK;
			pipes_per_me[MES] = 2;
			queues_per_pipe_per_me[MES] = 1;
			global_regs = gfx900_global_regs;
			pipe_regs = gfx1100_pipe_regs;
			if (min == 1) {
				pipes_per_me[ME1] = 4;
				queues_per_pipe_per_me[ME1] = 8;
				utcl1_err_names = gfx1210_utcl1_err_names;
				utcl1_err_names_num = gfx1210_utcl1_err_names_num;
				dc_regs = gfx1210_dc_regs;
				queue_mem_regs = gfx1210_queue_mem_regs;
				queue_mem_regs_num = gfx1210_queue_mem_regs_num;
				queue_regs = gfx1210_queue_regs;
				mqd_size_dw = 0x400;
			} else {
				pipes_per_me[ME1] = 2;
				queues_per_pipe_per_me[ME1] = 4;
				utcl1_err_names = gfx900_utcl1_err_names;
				utcl1_err_names_num = gfx900_utcl1_err_names_num;
				dc_regs = gfx1200_dc_regs;
				queue_mem_regs = gfx900_queue_mem_regs;
				queue_mem_regs_num = gfx900_queue_mem_regs_num;
				queue_regs = gfx1200_queue_regs;
				mqd_size_dw = 0x200;
			}
			break;
		default:
			asic->err_msg("[ERROR]: Unsupported ASIC call in umr_print_cpc().\n");
			return;
	}

	H("Global Registers");

	for (int x = 0; global_regs[x]; x++) {
		X_REG32_4COL("%20s", global_regs[x]);
	}

	printf("\n\n");

	for (uint32_t me = ME1; me < MAX_NUM_ME; me++) {
		if (! (me_present_mask & (1 << me)))
			continue;

		asic->options.bank.srbm.me = me;

		for (uint32_t pipe = 0; pipe < pipes_per_me[me]; ++pipe) {
			asic->options.bank.srbm.pipe = pipe;

			printf("------------------------------------------------------\n");
			printf("me%d.pipe%d\n", me, pipe);

			col = 0;
			H("Pipe Registers");

			for (int x = 0; pipe_regs[x]; x++) {
				if (((strstr(pipe_regs[x], "MEC1") || strstr(pipe_regs[x], "ME1")) && me != ME1) ||
					((strstr(pipe_regs[x], "MEC2") || strstr(pipe_regs[x], "ME2")) && me != ME2) ||
					((strstr(pipe_regs[x], "ME3") || strstr(pipe_regs[x], "MES")) && me != MES) ||
					(strstr(pipe_regs[x], "MEC_RS64") && me == MES))
				{
					continue;
				}

				X_REG32_4COL("%20s", pipe_regs[x]);
			}

			H("Pipe UTCL1 Error Registers");

			for (int x = 0; x < utcl1_err_names_num; x++) {
				write_banked_reg(asic, "mmCP_HPD_UTCL1_CNTL", x);

				col = 0;
				X_LIT32_4COL("%20s", utcl1_err_names[x], read_banked_reg(asic, "mmCP_HPD_UTCL1_ERROR"));
				X_REG32_4COL("%20s", "mmCP_HPD_UTCL1_ERROR_ADDR");
			}

			const char *header_reg_names[] = {NULL, "mmCP_MEC_ME1_HEADER_DUMP", "mmCP_MEC_ME2_HEADER_DUMP", "mmCP_MES_HEADER_DUMP"};

			H("Pipe Headers");

			for (int x = 0; x < 8; x++) {
				X_LIT32_8COL("%s", "HEADER", read_banked_reg(asic, header_reg_names[me]));
			}

			if (me_dc_mask & (1 << me)) {
				H("Pipe DC registers");

				for (int x = 0; dc_regs[x]; x++) {
					X_REG32_4COL("%25s", dc_regs[x]);
				}
			}

			printf("\n\n");

			for (uint32_t queue = 0; queue < queues_per_pipe_per_me[me]; ++queue) {
				asic->options.bank.srbm.me = me;
				asic->options.bank.srbm.pipe = pipe;
				asic->options.bank.srbm.queue = queue;

				if (read_banked_reg(asic, "mmCP_HQD_ACTIVE") & 0x1) {
					printf("------------------------------------------------------\n");
					printf("me%d.pipe%d.queue%d\n", me, pipe, queue);

					col = 0;
					H("Queue Memory Registers");

					for (int i = 0; i < queue_mem_regs_num; i++) {
						queue_mem_reg *qmr = &queue_mem_regs[i];

						uint32_t addr_lo = read_banked_reg(asic, qmr->addr_lo_name);
						uint32_t addr_hi = read_banked_reg(asic, qmr->addr_hi_name);
						uint64_t addr = (((uint64_t)addr_hi << 0x20) | addr_lo) << qmr->addr_shift;

						col = 0;
						X_LIT64_4COL("%20s", qmr->addr_display_name, addr);

						for (int x = 0; qmr->other_regs[x]; x++) {
							X_REG32_4COL("%20s", qmr->other_regs[x]);
						}
					}

					H("Queue Other Registers");

					for (int x = 0; queue_regs[x]; x++) {
						X_REG32_4COL("%25s", queue_regs[x]);
					}

					H("MQD");

					uint32_t mqd_mem[mqd_size_dw];
					uint64_t mqd_addr =	read_banked_reg(asic, "mmCP_MQD_BASE_ADDR")
						| ((uint64_t)read_banked_reg(asic, "mmCP_MQD_BASE_ADDR_HI") << 32);

					if (umr_read_vram(asic, asic->options.vm_partition, 0, mqd_addr, mqd_size_dw * sizeof(uint32_t), mqd_mem) == 0) {
						for (uint32_t x = 0; x < mqd_size_dw; x++) {
							X_LIT32_8COL("0x%03x", x, mqd_mem[x]);
						}
					}

					printf("\n\n");
				}
			}
		}
	}

	if (! rs64_en) {
		printf("------------------------------------------------------");

		col = 0;
		H("Scratch Memory");

		umr_write_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmCP_CPC_SCRATCH_INDEX", 0);

		for (int x = 0; x < 1024; x++) {
			X_LIT32_8COL("0x%03x", x, read_banked_reg(asic, "mmCP_CPC_SCRATCH_DATA"));
		}

		printf("\n");
	}

	asic->options = opts;
}
