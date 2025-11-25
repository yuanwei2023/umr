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

#define PX(x, y) if (col++ == 4) { col = 1; fprintf(output, "\n\t"); } fprintf(output, "%s%20s%s: %s%08lx%s | ", GREEN, bits[y].regname, RST, BLUE, (unsigned long)umr_wave_data_get_bits(asic, wd, wd->reg_names[x], bits[y].regname), RST);
#define X(x) if (col++ == 4) { col = 1; fprintf(output, "\n\t"); } fprintf(output, "%s%20s%s: %s%08lx%s | ", GREEN, wd->reg_names[x], RST, BLUE, (unsigned long)wd->ws.reg_values[x], RST);

#define H(x) if (col) { fprintf(output, "\n"); }; col = 0; fprintf(output, "\n\n%s:\n\t", x);
#define Hv(x, y) if (col) { fprintf(output, "\n"); }; col = 0; fprintf(output, "\n\n%s[%08lx]:\n\t", x, (unsigned long)y);

#define NUM_OPCODE_WORDS 16

void umr_print_waves(struct umr_asic *asic)
{
	uint32_t x, y, thread;
	uint64_t pgm_addr, shader_addr;
	struct umr_wave_data *wd = NULL, *owd = NULL;
	int first = 1, col = 0, ring_halted = 0, use_ring = 1;
	struct umr_shaders_pgm *shader = NULL;
	struct umr_packet_stream *stream = NULL;
	struct {
		uint32_t vmid, size;
		uint64_t addr;
	} ib_addr;
	int start = -1, stop = -1;
	int gfx_maj, gfx_min;
	FILE *output = NULL;
	char *wavefront_desc;
	int no_bits;
	struct umr_bitfield *bits;
	char linebuf[256];
	struct umr_shader_reg_pair *regs;

	umr_gfx_get_ip_ver(asic, &gfx_maj, &gfx_min);

	if (asic->options.halt_waves) {
		if (umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT, 100) != 0) {
			fprintf(stderr, "[WARNING]: Halting waves failed.\n");
		}
	} else {
		fprintf(stderr, "[WARNING]: Wave listing is unreliable if waves aren't halted; use -O halt_waves\n");
	}

	// attach to a PM4 stream "of some providence" so we can find shaders which is handy
	// since without knowing the start address of the shader we have to guess and guessing can
	// go wrong...
	if (strcmp(asic->options.ring_name, "none")) {
		if (!strcmp(asic->options.ring_name, "uq")) {
			// user wants to attach to the user queue for wave debugging
			if (asic->options.user_queue.state.active) {
				uint32_t start=0, end=0, *buf=NULL, len;
				uint32_t rt;
				ib_addr.vmid = 0; // doesn't matter
				buf = calloc(asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size, sizeof *buf);
				if (!asic->options.use_full_user_queue) {
					if (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value == asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value) {
						asic->err_msg("[ERROR]: The user queue's RPTR and WPTR are equal.  You can try using -O use_full_user_queue instead to read the entire queue.\n");
						// free the buffer so we don't decode garbage
						free(buf);
						buf = NULL;
					} else {
						start = asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value;
						end = asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value;
					}
				} else {
					start = 0;
					end = asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value;
				}
				// AQL RPTR/WPTR is in terms of 64-byte (16 dword) packets
				// we need to do AQL math in 32-bit word terms because other
				// queues are all in terms of 32-bits
				if (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type == UMR_QUEUE_COMPUTE) {
					start = (start * 16) % asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;
					end = (end * 16) % asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;

					// enable disasm_early_term because they don't use the same terminals as mesa
					asic->options.disasm_early_term = 1;
				}
				if (buf) {
					// read the user queue like a ring
					if (umr_read_user_queue_buffer(asic, start, end, buf, &len)) {
						asic->err_msg("[ERROR]: Could not read user queue packet stream.\n");
						free(buf);
						goto cleanup;
					}
					ib_addr.size = len;
					// decode the stream copied from the queue
					switch (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type) {
						case UMR_QUEUE_COMPUTE_PM4:
						case UMR_QUEUE_GFX: rt = UMR_RING_PM4; break;
						case UMR_QUEUE_COMPUTE: rt = UMR_RING_HSA; break;
						default:
							asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type, __FILE__, __LINE__);
							free(buf);
							goto cleanup;
					}
					stream = umr_packet_decode_buffer(asic, NULL, 0, ib_addr.addr, buf, ib_addr.size, rt, NULL);
					free(buf);
					if (!stream) {
						asic->err_msg("[ERROR]: Could not decode packet stream fetched from the user queue.");
						goto cleanup;
					}
					// flag to the rest of the function that we're good to go.
					use_ring = 0;
					ring_halted = 1;
				}
			} else {
				asic->err_msg("[ERROR]: User queue is not attached, did you forget to use --user-queue on the command line?\n");
				goto cleanup;
			}
		} else if (sscanf(asic->options.ring_name, "%"SCNx32"@%"SCNx64".%"SCNx32, &ib_addr.vmid, &ib_addr.addr, &ib_addr.size) == 3) {
			// the user can specify an IB VM address directly as vmid@addr.length
			use_ring = 0;
		}

		if (asic->options.halt_waves) {
			// warn users if they don't specify a ring on gfx10 hardware
			if (gfx_maj >= 10 && !asic->options.ring_name[0])
				fprintf(stderr, "[WARNING]: On gfx10+ the default ring name 'gfx' is not valid.  Please specify one on the command line.\n");

			if (use_ring && !umr_ring_is_halted(asic, asic->options.ring_name[0] ? asic->options.ring_name : "gfx"))
				fprintf(stderr, "[WARNING]: Rings are not halted!\n");
			else
				ring_halted = 1;
		}

		// always disasm if disasm_anyways is enabled
		if (asic->options.disasm_anyways)
			ring_halted = 1;

		// if we don't have a stream yet we should initialize one
		if (!stream) {
			if (use_ring) {
				// read a kernel ring
				stream = umr_packet_decode_ring(asic, NULL, asic->options.ring_name[0] ? asic->options.ring_name : "gfx", 0, &start, &stop, UMR_RING_GUESS, NULL);
			} else {
				// read a VM buffer
				stream = umr_packet_decode_vm_buffer(asic, NULL, ib_addr.vmid, ib_addr.addr, ib_addr.size / 4, UMR_RING_PM4, NULL);
			}
		}
	} else {
		// user wants to attach to no stream
		ring_halted = 0;
		stream = NULL;
	}

	owd = wd = umr_scan_wave_data(asic);

	output = tmpfile();
	while (wd) {
		uint64_t pc;
		uint32_t vmid;
		uint32_t shader_size = NUM_OPCODE_WORDS*4;

		first = 0;
		wavefront_desc = umr_wave_data_describe_wavefront(asic, wd);
		fprintf(output, "\n------------------------------------------------------\n%s\n", wavefront_desc);
		free(wavefront_desc);

		if (wd->tainted) {
			fprintf(output, "[WARNING]: THIS WAVE DATA IS POSSIBLY TAINTED BY A RACE CONDITION\n");
		}

		H("Main Registers");
		for (x = 0; wd->reg_names[x]; x++) {
			X(x);
		}
		fprintf(output, "\n\n");

		if (asic->options.bitfields) {
			H("Register Bits");
			for (x = 0; wd->reg_names[x]; x++) {
				umr_wave_data_get_bit_info(asic, wd, wd->reg_names[x], &no_bits, &bits);
				Hv(wd->reg_names[x], wd->ws.reg_values[x]);
				for (y = 0; y < (uint32_t)no_bits; y++) {
					PX(x, y);
				}
			}
			fprintf(output, "\n\n");
		}

		if (umr_wave_data_get_flag_halt(asic, wd) || umr_wave_data_get_flag_fatal_halt(asic, wd)) {
			for (x = 0; x < umr_wave_data_num_of_sgprs(asic, wd); x += 4)
				fprintf(output, ">SGPRS[%s%u%s..%s%u%s] = { %s%08lx%s, %s%08lx%s, %s%08lx%s, %s%08lx%s }\n",
					YELLOW, (unsigned)(x), RST,
					YELLOW, (unsigned)(x + 3), RST,
					BLUE, (unsigned long)wd->sgprs[x], RST,
					BLUE, (unsigned long)wd->sgprs[x+1], RST,
					BLUE, (unsigned long)wd->sgprs[x+2], RST,
					BLUE, (unsigned long)wd->sgprs[x+3], RST);

			if (umr_wave_data_get_flag_trap_en(asic, wd) || umr_wave_data_get_flag_priv(asic, wd)) {
				for (y = 0, x = 0x6C; x < (16 + 0x6C); x += 4) {
					fprintf(output, ">%s[%s%u%s..%s%u%s] = { %s%08lx%s, %s%08lx%s, %s%08lx%s, %s%08lx%s }\n",
						(x < (0x6C + 4) && gfx_maj <= 8) ? "TBA/TMA" : "TTMP",
						YELLOW, (unsigned)(y), RST,
						YELLOW, (unsigned)(y + 3), RST,
						BLUE, (unsigned long)wd->sgprs[x], RST,
						BLUE, (unsigned long)wd->sgprs[x+1], RST,
						BLUE, (unsigned long)wd->sgprs[x+2], RST,
						BLUE, (unsigned long)wd->sgprs[x+3], RST);

					// restart numbering on SI..VI with TTMP0
					y += 4;
					if (x == 0x6C && gfx_maj <= 8)
						y = 0;
				}
			}

			if (wd->have_vgprs) {
				unsigned granularity = asic->parameters.vgpr_granularity; // default is blocks of 4 VGPRs
				uint32_t vgpr_size, exec_lo, exec_hi;
				vgpr_size = umr_wave_data_get_bits(asic, wd, "ixSQ_WAVE_GPR_ALLOC", "VGPR_SIZE");
				exec_lo = umr_wave_data_get_value(asic, wd, "ixSQ_WAVE_EXEC_LO");
				exec_hi = umr_wave_data_get_value(asic, wd, "ixSQ_WAVE_EXEC_HI");
				fprintf(output, "\n");
				for (x = 0; x < ((vgpr_size + 1) << granularity); ++x) {
					if (x % 16 == 0) {
						if (x == 0)
							fprintf(output, "VGPRS:       ");
						else
							fprintf(output, "             ");
						for (thread = 0; thread < 64; ++thread) {
							unsigned live = thread < 32 ? (exec_lo & (1u << thread))
											: (exec_hi & (1u << (thread - 32)));
							fprintf(output, live ? " t%02u     " : " (t%02u)   ", thread);
						}
						fprintf(output, "\n");
					}

					fprintf(output, "    [%s%3u%s] = {", YELLOW, x, RST);
					for (thread = 0; thread < 64; ++thread) {
						unsigned live = thread < 32 ? (exec_lo & (1u << thread))
										: (exec_hi & (1u << (thread - 32)));
						fprintf(output, " %s%08x%s", live ? BLUE : RST, wd->vgprs[thread * 256 + x], RST);
					}
					fprintf(output, " }\n");
				}
			}

			/* always dump shaders */
			umr_wave_data_get_shader_pc_vmid(asic, wd, &vmid, &pc);
			pgm_addr = pc;

			fprintf(output, ring_halted ? "\n\nPGM_MEM:" : "\n\nPGM_MEM (guess based on PC):");
			regs = NULL;
			shader = NULL;
			if (ring_halted && stream)
				shader = umr_packet_find_shader(asic, stream, vmid, pgm_addr);

			if (shader) {
				regs = shader->regs;

				// we found a shader so we can actually use real start addresses
				fprintf(output, " (found shader at: %s%u%s@0x%s%llx%s of %s%u%s bytes)",
					BLUE, shader->vmid, RST,
					YELLOW, (unsigned long long)shader->addr, RST,
					BLUE, shader->size, RST);
			} else if (	asic->options.user_queue.state.active &&
						asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type == UMR_QUEUE_COMPUTE) {
				// if !shader and compute_AQL mode, then try using queue_packet_id) to look up the AQL packet and find the RSRC regs from there
				uint32_t queue_packet_id, x;
				struct umr_hsa_stream *hsa = stream->stream.hsa;

				// TODO: right now umr only binds to one queue, the wave here might not be from the current queue attached

				// figure out the queue_packet_id based on gfx version
				switch (gfx_maj) {
					case 9:
						if (gfx_min < 4) {
							// < gfx940
							queue_packet_id = wd->sgprs[0x6C + 6] & ((1UL << 24) - 1);
						} else {
							// gfx940
							queue_packet_id = (wd->sgprs[0x6C + 11] >> 6) & ((1UL << 24) - 1);
						}
						break;
					case 10:
					case 11:
						queue_packet_id = wd->sgprs[0x6C + 6] & ((1UL << 24) - 1);
						break;
					case 12:
						queue_packet_id = wd->sgprs[0x6C + 8] & ((1UL << 24) - 1);
						break;
					default:
						asic->err_msg("[BUG]: Unsupported GFX major %d in printing waves when finding queue_packet_id\n", gfx_maj);
						goto cleanup;
				}

				// look for an AQL that matches stream[idx] == rptr - queue_packet_id
				x = queue_packet_id - asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value; // TODO: use_full_queue will break this
				while (hsa && x--) {
					hsa = hsa->next;
				}
				if (hsa && hsa->shader) {
					regs = hsa->shader->regs;
				}
			}

			// print regs
			if (regs) {
				fprintf(output, "\n   %sShader registers:\n", shader ? "" : "Found DISPATCH_KERNEL, ");
				while (regs) {
					fprintf(output, "      %s(%"PRIu32"@0x%"PRIx64") == 0x%"PRIx32"\n", regs->regname, regs->vmid, regs->addr, regs->value);
					if (asic->options.bitfields) {
						struct umr_reg *reg = NULL;
						if (strstr(regs->regname, "."))
							reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, strstr(regs->regname, ".") + 1);
						if (reg && reg->no_bits > 1) {
							int k;
							for (k = 0; k < reg->no_bits; k++) {
								uint32_t v;
								v = (1UL << (reg->bits[k].stop + 1 - reg->bits[k].start)) - 1;
								v &= (regs->value >> reg->bits[k].start);
								fprintf(output, "         %s[%u:%u] == 0x%"PRIx32"\n",
									reg->bits[k].regname, reg->bits[k].start, reg->bits[k].stop, v);
							}
						}
					}
					regs = regs->next;
				}
				fprintf(output, "\n");
			}

			if (shader) {
				// start decoding a bit before PC if possible
				if (!(asic->options.full_shader) && (shader->addr + ((NUM_OPCODE_WORDS*4)/2) < pgm_addr))
					pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
				else
					pgm_addr = shader->addr;
				if (asic->options.full_shader)
					shader_size = shader->size;
				if ((pgm_addr + shader_size) > (shader->addr + shader->size))
					shader_size = (shader->addr + shader->size) - pgm_addr;
				shader_addr = shader->addr;
				free(shader);
				shader = NULL;
			} else {
				// shader wasn't found (or we have no stream attached) so we just back up a few words as a guess.
				pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
				shader_addr = pgm_addr;
				fprintf(output, "\n");
			}
			umr_vm_disasm(asic, output, asic->options.vm_partition, vmid, shader_addr, pc, shader_size,
					  pgm_addr - shader_addr, NULL);
		}
		wd = wd->next;
	}

	if (first)
		fprintf(output, "No active waves! (or GFXOFF was not disabled)\n");

cleanup:
	wd = owd;
	while (wd) {
		owd = wd->next;
		free(wd);
		wd = owd;
	}

	if (stream)
		umr_packet_free(stream);

	if (asic->options.halt_waves)
		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME, 0);

	// dump output to stdout
	if (output) {
		fseek(output, 0, SEEK_SET);
		while (fgets(linebuf, sizeof linebuf, output)) {
			fputs(linebuf, stdout);
		}
		fclose(output);
	}
}
