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
#include <umr.h>

static const char *hsa_types[] = {
	"HSA_VENDOR_SPECIFIC",
	"HSA_INVALID",
	"HSA_KERNEL_DISPATCH",
	"HSA_BARRIER_AND",
	"HSA_AGENT_DISPATCH",
	"HSA_BARRIER_OR",
};

#define STR_LOOKUP(str_lut, idx, default) \
	((idx) < sizeof(str_lut) / sizeof(str_lut[0]) ? str_lut[(idx)] : (default))

/**
 * add_shader - Add a shader reference to the current packet
 *
 * @asic:  The ASIC the stream and shaders are bound to
 * @ps: The packet to attach the reference to a shader to
 * @vmid: The VMID of the shader program
 * @shader_addr: The address of the shader program
 * @vm_partition: The specific GC instance the shader is running on
 * @type: The UMR_SHADER_* type the shader is (pixel, vertex, etc)
 * @reg_pairs: The linked list structure containing all of the register writes found in the submission up until this packet
 */
static void add_shader(struct umr_asic *asic,
	struct umr_hsa_stream *ps,
	uint32_t vmid, uint64_t shader_addr, int vm_partition,
	int type, struct umr_shader_reg_pair *reg_pairs)
{
	struct umr_shaders_pgm *pgm;

	if (ps->shader == NULL) {
		// attach the shader to the head
		ps->shader = calloc(1, sizeof(ps->shader[0]));
		pgm = ps->shader;
	} else {
		// walk till the end of the list
		pgm = ps->shader;
		while (pgm->next) {
			pgm = pgm->next;
		}
		pgm->next = calloc(1, sizeof(ps->shader[0]));
		pgm = pgm->next;
	}

//	pgm->aql_packet = ps;
	pgm->vmid = vmid;
	pgm->addr = shader_addr;
	if (!asic->options.no_follow_shader)
		pgm->size = umr_compute_shader_size(asic, vm_partition, pgm);
	else
		pgm->size = 1;
	pgm->type = type;
	pgm->regs = umr_copy_regpairs(reg_pairs);
}

static void parse_kernel_object(struct umr_asic *asic, struct umr_hsa_stream *stream, uint64_t kernel_object, uint64_t kernarg)
{
	struct umr_shader_reg_pair *reg_pair = NULL;
	char gfxname[64], tmp[256];
	int gfx_maj, gfx_min;

	umr_gfx_get_ip_ver(asic, &gfx_maj, &gfx_min);

	// read the kernel_object buffer
	if (umr_read_vram(asic, asic->options.vm_partition, 0,
			kernel_object, 512/8,
			&stream->kernel_dispatch.kernel_object) < 0) {
		asic->err_msg("[ERROR]: Could not read kernel_object from the HSA_KERNEL_DISPATCH packet\n");
		return;
	}

	// initialize fields
	stream->kernel_dispatch.kernel_object_va = kernel_object;
	stream->kernel_dispatch.kernel_code_entry_byte_offset = kernel_object +
		((stream->kernel_dispatch.kernel_object[(128/32)]) |
		((uint64_t)stream->kernel_dispatch.kernel_object[(128/32)+1] << 32ULL));
	stream->kernel_dispatch.kernarg_size = stream->kernel_dispatch.kernel_object[(64/32)];
	stream->kernel_dispatch.kernarg_va = kernarg;
	stream->kernel_dispatch.compute_pgm_rsrc1 = stream->kernel_dispatch.kernel_object[(384/32)];
	stream->kernel_dispatch.compute_pgm_rsrc2 = stream->kernel_dispatch.kernel_object[(416/32)];
	stream->kernel_dispatch.compute_pgm_rsrc3 = stream->kernel_dispatch.kernel_object[(352/32)];

	// find gfx name
	{
		int i;
		char *p;
		for (i = 0; i < asic->no_blocks; i++) {
			if (!memcmp(asic->blocks[i]->ipname, "gfx", 3)) {
				strcpy(gfxname, asic->blocks[i]->ipname);
				// chop off instance
				p = strstr(gfxname, "{");
				if (p) {
					*p = 0;
				}
				break;
			}
		}
	}

	// create shader object to attach to stream
	sprintf(tmp, "%s.%sCOMPUTE_PGM_RSRC1", gfxname, gfx_maj <= 10 ? "mm" : "reg");
	umr_shader_add_reg_pair(&reg_pair, tmp, stream->kernel_dispatch.compute_pgm_rsrc1, 0, kernel_object);
	sprintf(tmp, "%s.%sCOMPUTE_PGM_RSRC2", gfxname, gfx_maj <= 10 ? "mm" : "reg");
	umr_shader_add_reg_pair(&reg_pair, tmp, stream->kernel_dispatch.compute_pgm_rsrc2, 0, kernel_object);
	sprintf(tmp, "%s.%sCOMPUTE_PGM_RSRC3", gfxname, gfx_maj <= 10 ? "mm" : "reg");
	umr_shader_add_reg_pair(&reg_pair, tmp, stream->kernel_dispatch.compute_pgm_rsrc3, 0, kernel_object);
	add_shader(asic, stream, 0, stream->kernel_dispatch.kernel_code_entry_byte_offset, asic->options.vm_partition, UMR_SHADER_COMPUTE, reg_pair);
	umr_free_shader_reg_pairs(reg_pair);

	// copy the kernarg
	stream->kernel_dispatch.kernarg_data = calloc(1, stream->kernel_dispatch.kernarg_size);
	if (stream->kernel_dispatch.kernarg_data) {
		if (umr_read_vram(asic, asic->options.vm_partition, 0,
				stream->kernel_dispatch.kernarg_va, stream->kernel_dispatch.kernarg_size,
				stream->kernel_dispatch.kernarg_data) < 0) {
			asic->err_msg("[ERROR]: Could not read kernarg from the HSA_KERNEL_DISPATCH packet\n");
			return;
		}
	}
}

/**
 * umr_hsa_decode_stream - Decode an array of 32-bit words into an HSA stream
 *
 * @asic: The ASIC the HSA stream is bound to
 * @stream: The array of 32-bit words
 * @nwords: The number of 32-bit words.
 *
 * Returns a pointer to a umr_hsa_stream structure, or NULL on error.
 */
struct umr_hsa_stream *umr_hsa_decode_stream(struct umr_asic *asic, uint32_t *stream, uint32_t nwords, int32_t ip_version)
{
	struct umr_hsa_stream *ms, *oms, *prev_ms = NULL;
	uint32_t n;
	uint16_t t16, *s;
	(void)ip_version;

	oms = ms = calloc(1, sizeof *ms);
	if (!ms)
		goto error;

	// hsa uses 16-bit words a lot so let's view the stream that way
	s = (uint16_t *)stream;
	nwords *= 2;

	while (nwords) {
		// read hsa_packet_header_t
		t16 = *s++;
			ms->header = t16;
			ms->type = t16 & 0xFF;
			ms->barrier = (t16 >> 8) & 1;
			ms->acquire_fence_scope = (t16 >> 9) & 3;
			ms->release_fence_scope = (t16 >> 11) & 3;

		// # of **16-bit** words all packets are 32 words
		ms->nwords = 32;

		// if not enough stream for packet or reach 0, stop parsing
		if (nwords < ms->nwords || !ms->nwords) {
			free(ms);
			if (prev_ms) {
				prev_ms->next = NULL;
			} else {
				oms = NULL;
			}
			return oms;
		}

		ms->words = calloc(ms->nwords - 1, sizeof *(ms->words)); // don't need copy of header
		if (!ms->words)
			goto error;
		for (n = 0; n < ms->nwords - 1; n++) {
			ms->words[n] = *s++;
		}

		// fetch shaders from DISPATCH_KERNEL packets
		if (ms->type == 2) {
			uint64_t kernobj, kernarg;
			kernobj = ms->words[15];
			kernobj |= ((uint64_t)ms->words[16]) << 16;
			kernobj |= ((uint64_t)ms->words[17]) << 32;
			kernobj |= ((uint64_t)ms->words[18]) << 48; // kernel_object pointer
			kernarg = ms->words[19];
			kernarg |= ((uint64_t)ms->words[20]) << 16;
			kernarg |= ((uint64_t)ms->words[21]) << 32;
			kernarg |= ((uint64_t)ms->words[22]) << 48; // kernarg pointer
			parse_kernel_object(asic, ms, kernobj, kernarg);
		}

		nwords -= ms->nwords;
		if (nwords) {
			ms->next = calloc(1, sizeof *(ms->next));
			if (!ms->next)
				goto error;
			prev_ms = ms;
			ms->next->prev = ms;
			ms = ms->next;
		}
	}
	return oms;
error:
	asic->err_msg("[ERROR]: Out of memory\n");
	while (oms) {
		free(oms->words);
		ms = oms->next;
		free(oms);
		oms = ms;
	}
	return NULL;
}

static uint32_t fetch_word(struct umr_asic *asic, struct umr_hsa_stream *stream, uint32_t off)
{
	if (off >= stream->nwords) {
		if (!(stream->invalid))
			asic->err_msg("[ERROR]: HSA decoding of type (%"PRIx32") went out of bounds.\n", stream->type);
		stream->invalid = 1;
		return 0;
	} else {
		return stream->words[off];
	}
}

/**
 * umr_hsa_decode_stream_opcodes - decode a stream of HSA packets
 *
 * @asic: The ASIC the HSA packets are bound for
 * @ui: The user interface callback that will present the decoded packets to the user
 * @stream: The pre-processed stream of HSA packets
 * @ib_addr: The base VM address where the packets came from
 * @ib_vmid: The VMID the IB is mapped into
 * @from_addr: The address of the ring/IB that pointed to this HSA IB
 * @from_vmid: The VMID of the ring/IB that pointed to this HSA IB
 * @opcodes: The number of opcodes to decode
 * @follow: Follow any chained IBs
 *
 * Returns the address of the first packet that hasn't been decoded.
 */
struct umr_hsa_stream *umr_hsa_decode_stream_opcodes(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_hsa_stream *stream, uint64_t ib_addr, uint32_t ib_vmid, unsigned long opcodes)
{
	const char* opcode_name;
	uint32_t i, j;
	uint64_t t64;

// todo: from_* and size
	ui->start_ib(ui, ib_addr, ib_vmid, 0, 0, 0, 0);
	while (stream && opcodes-- && stream->nwords) {
		opcode_name = STR_LOOKUP(hsa_types, stream->type, "HSA_UNK");
		if (stream->type != 1) // start only if not INVALID
			ui->start_opcode(ui, ib_addr, ib_vmid, 0, stream->type, 0, stream->nwords, opcode_name, stream->header, stream->words);

		// recall HSA is viewed as 16-bit words which is also use
		// negative "field_size" values
		// even though fetch_word(asic, stream, ) is 32-bits we only store
		// 16-bits per entry
		i = 0;
		ib_addr += 2; // skip over header
		switch (stream->type) {
			case 1: // INVALID
				// allow heuristic decoding of INVALID packets because the CP
				// stamps packets as invalid as they're decoded

				// only continue if heuristic decoding and user queues are enabled
				if (!(asic->options.aql_heuristic && asic->options.user_queue.state.active)) {
					ui->start_opcode(ui, ib_addr-2, ib_vmid, 0, stream->type, 0, stream->nwords, "HSA_INVALID", stream->header, stream->words);
					break;
				}

				// read the 64-bit word from offset 0x20 and 0x28 that should be a kernel_object and kernarg_address let's see if the top 32-bits
				// align with say the HQD base address
				t64 = ((uint64_t)fetch_word(asic, stream, 15)) | ((uint64_t)fetch_word(asic, stream, 16)<<16ULL) | ((uint64_t)fetch_word(asic, stream, 17)<<32ULL) | ((uint64_t)fetch_word(asic, stream, 18)<<48ULL);
				if ((t64 >> 32ULL) != (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr >> 32ULL)) {
					ui->start_opcode(ui, ib_addr-2, ib_vmid, 0, stream->type, 0, stream->nwords, "HSA_INVALID", stream->header, stream->words);
					break;
				}

				t64 = ((uint64_t)fetch_word(asic, stream, 19)) | ((uint64_t)fetch_word(asic, stream, 20)<<16ULL) | ((uint64_t)fetch_word(asic, stream, 21)<<32ULL) | ((uint64_t)fetch_word(asic, stream, 22)<<48ULL);
				if ((t64 >> 32ULL) != (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr >> 32ULL)) {
					ui->start_opcode(ui, ib_addr-2, ib_vmid, 0, stream->type, 0, stream->nwords, "HSA_INVALID", stream->header, stream->words);
					break;
				}
				ui->start_opcode(ui, ib_addr-2, ib_vmid, 0, stream->type, 0, stream->nwords, "HSA_KERNEL_DISPATCH (heuristic)", stream->header, stream->words);
				// fall through
			case 2: // kernel dispatch
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "setup_dimensions", fetch_word(asic, stream, i) & 3, NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "workgroup_size_x", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "workgroup_size_y", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "workgroup_size_z", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved0", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "grid_size_x", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "grid_size_y", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "grid_size_z", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "private_segment_size", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "group_segment_size", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "kernel_object", t64, NULL, 16, -64); i += 4;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "kernarg_address", t64, NULL, 16, -64); i += 4;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved2", t64, NULL, 16, -64); i += 4;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "completion_signal", t64, NULL, 16, -64); i += 4;
				break;
			case 4: // agent dispatch
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "type", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved0", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "return_address", t64, NULL, 16, -64); i += 4;
				for (j = 0; j < 4; j++) {
					char str[32];
					t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
					sprintf(str, "arg[%"PRIu32"]", j);
					ui->add_field(ui, ib_addr + 2 * i, ib_vmid, str, t64, NULL, 16, -64); i += 4;
				}
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved2", t64, NULL, 16, -64); i += 4;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "completion_signal", t64, NULL, 16, -64); i += 4;
				break;
			case 3: // barrier and test
			case 5: // barrier or test (these have the same decoding)
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved0", fetch_word(asic, stream, i), NULL, 10, -16); ++i;
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved1", ((uint32_t)fetch_word(asic, stream, i)) | ((uint32_t)fetch_word(asic, stream, i+1)<<16UL), NULL, 10, -32);
				i += 2;
				for (j = 0; j < 5; j++) {
					char str[32];
					t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
					sprintf(str, "dep_signal[%"PRIu32"]", j);
					ui->add_field(ui, ib_addr + 2 * i, ib_vmid, str, t64, NULL, 16, -64); i += 4;
				}
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "reserved2", t64, NULL, 16, -64); i += 4;
				t64 = ((uint64_t)fetch_word(asic, stream, i)) | ((uint64_t)fetch_word(asic, stream, i+1)<<16ULL) | ((uint64_t)fetch_word(asic, stream, i+2)<<32ULL) | ((uint64_t)fetch_word(asic, stream, i+3)<<48ULL);
				ui->add_field(ui, ib_addr + 2 * i, ib_vmid, "completion_signal", t64, NULL, 16, -64); i += 4;
				break;
		}

		if (stream->invalid)
			break;

		if (stream->shader) {
			struct umr_shaders_pgm *pgm = stream->shader;
			while (pgm) {
				ui->add_shader(ui, asic, ib_addr-2, ib_vmid, pgm);
				pgm = pgm->next;
			}
			if (stream->kernel_dispatch.kernarg_data)
				ui->add_data(ui, asic, ib_addr-2, ib_vmid, (uint64_t)stream->kernel_dispatch.kernarg_data, stream->kernel_dispatch.kernarg_size, UMR_DATABLOCK_AQL_KERNARG, 0);
		}

		ib_addr += 2 * (stream->nwords - 1);
		stream = stream->next;
	}
	ui->done(ui);
	(void)i; // silence warnings
	return stream;
}

/**
 * umr_free_hsa_stream - Free a hsa stream object
 */
void umr_free_hsa_stream(struct umr_hsa_stream *stream)
{
	while (stream) {
		struct umr_hsa_stream *n;
		struct umr_shaders_pgm *pgm;
		pgm = stream->shader;
		while (pgm) {
			struct umr_shaders_pgm *next = pgm->next;
			free(pgm->regs);
			free(pgm);
			pgm = next;
		}
		n = stream->next;
		free(stream->kernel_dispatch.kernarg_data);
		free(stream);
		stream = n;
	}
}

/**
 * umr_find_shader_in_hsa_stream - Find a shader in a PM4 stream
 *
 * @stream: A previously captured PM4 stream from a ring
 * @vmid:  The VMID of the shader to look for
 * @addr: An address inside the shader to match
 *
 * Returns a pointer to a copy of a shader object if found or
 * NULL if not.  Note:  If you free the PM4 stream it came from
 * this object becomes invalid so you must free() this first,
 * then free the PM4 stream.
 */
struct umr_shaders_pgm *umr_find_shader_in_hsa_stream(struct umr_asic *asic, struct umr_hsa_stream *stream, unsigned vmid, uint64_t addr)
{
	struct umr_shaders_pgm *p, *pp;

	p = NULL;
	while (stream) {
		// compare shader if any
		if (stream->shader) {
			struct umr_shaders_pgm *pgm = stream->shader;

			while (pgm) {
				if ((pgm->vmid == vmid || asic->options.user_queue.state.active) && // only compare VMIDs if user queues aren't used
					(addr >= pgm->addr) &&
					(addr < (pgm->addr + pgm->size))) {
						p = pgm;
						break;
					}
				pgm = pgm->next;
			}
			if (p) {
				break;
			}
		}
		if (p) {
			break;
		}
		stream = stream->next;
	}

	if (p) {
		pp = calloc(1, sizeof(struct umr_shaders_pgm));
		*pp = *p;
		return pp;
	}

	return NULL;
}
