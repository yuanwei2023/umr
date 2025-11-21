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
#include <inttypes.h>

/**
 * umr_umsch_decode_stream - Decode an array of UMSCH packets into a UMSCH stream
 *
 * @vmid:  The VMID (or zero) that this array comes from (if say an IB)
 * @stream: An array of DWORDS which contain the umsch packets
 * @nwords:  The number of words in the stream
 *
 * Returns a UMSCH stream if successfully decoded.
 */
struct umr_umsch_stream *umr_umsch_decode_stream(struct umr_asic *asic, int vm_partition, uint64_t from_addr, uint32_t from_vmid, uint32_t *stream, uint32_t nwords, int32_t ip_version)
{
	struct umr_umsch_stream *ops, *ps;

	(void)from_addr;
	(void)from_vmid;
	(void)vm_partition;
	(void)ip_version;
	ps = ops = calloc(1, sizeof *ops);
	if (!ps) {
		asic->err_msg("[ERROR]: Out of memory\n");
		return NULL;
	}

	while (nwords) {
		ps->type = *stream & 0xF;
		ps->opcode = (*stream >> 4) & 0xFF;
		ps->nwords = (*stream >> 12) & 0xFF;
		ps->header_dw = *stream++;

		// UMSCH_API_TYPE_SCHEDULER = 1
		// INVALID = 0
		if (ps->type == 1) {
			switch (ps->opcode) {
				case 0x00: // SET_HW_RSRC
				case 0x01: // SET_SCHEDULING_CONFIG
				case 0x02: // ADD_QUEUE
				case 0x03: // REMOVE_QUEUE
				case 0x04: // PERFORM_YIELD
				case 0x05: // SUSPEND
				case 0x06: // RESUME
				case 0x07: // RESET
				case 0x08: // SET_LOG_BUFFER
				case 0x09: // CHANGE_CONTEXT_PRIORITY
				case 0x0A: // QUERY_SCHEDULER_STATUS
				case 0x0B: // UPDATE_AFFINITY
				case 0x0C: // UPDATE_ROOT_PAGE_TABLE
					ps->nwords = 64; // fixed size of 0x40 dwords
					break;
			}
		}
		else {
			ps->nwords = 4; // invalid type, default to 1 dword
		}

		// grab rest of words
		ps->words = calloc(ps->nwords, sizeof(ps->words[0]));
		memcpy(ps->words, stream, ps->nwords * sizeof(ps->words[0]));

		// advance stream
		stream += ps->nwords - 1; // point to header of packet
		nwords -= ps->nwords; // includes header

		if (nwords) {
			ps->next = calloc(1, sizeof(*ps));
			ps = ps->next;
		}
	}
	return ops;
}

/**
 * umr_free_umsch_stream - Free a umsch stream object
 */
void umr_free_umsch_stream(struct umr_umsch_stream *stream)
{
	while (stream) {
		struct umr_umsch_stream *n;
		n = stream->next;
		if (stream->next_ib)
			umr_free_umsch_stream(stream->next_ib);
		free(stream->words);
		free(stream);
		stream = n;
	}
}

#define BITS(x, a, b) (unsigned long)((x >> (a)) & ((1ULL << ((b)-(a)))-1))

static uint32_t fetch_word(struct umr_asic *asic, struct umr_umsch_stream *stream, uint32_t off)
{
	if (off >= stream->nwords) {
		if (!(stream->invalid))
			asic->err_msg("[ERROR]: UMSCH decoding of opcode (%"PRIx32") went out of bounds.\n", stream->opcode);
		stream->invalid = 1;
		return 0;
	} else {
		return stream->words[off];
	}
}

/**
 * umr_umsch_decode_stream_opcodes - decode a stream of UMSCH packets
 *
 * @asic: The ASIC the UMSCH packets are bound for
 * @ui: The user interface callback that will present the decoded packets to the user
 * @stream: The pre-processed stream of UMSCH packets
 * @ib_addr: The base VM address where the packets came from
 * @ib_vmid: The VMID the IB is mapped into
 * @from_addr: The address of the ring/IB that pointed to this UMSCH IB
 * @from_vmid: The VMID of the ring/IB that pointed to this UMSCH IB
 * @opcodes: The number of opcodes to decode
 * @follow: Follow any chained IBs
 *
 * Returns the address of the first packet that hasn't been decoded.
 */
struct umr_umsch_stream *umr_umsch_decode_stream_opcodes(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_umsch_stream *stream,
						       uint64_t ib_addr, uint32_t ib_vmid, uint64_t from_addr, uint64_t from_vmid, unsigned long opcodes, int follow)
{
	uint32_t n, m, j;
	struct umr_umsch_stream *os = stream;

	struct {
		uint32_t MAX_VCN0_INSTANCES,
				 MAX_VCN1_INSTANCES,
				 MAX_VCN_INSTANCES,
				 MAX_VPE_INSTANCES,
				 UMSCH_MAX_HWIP_SEGMENT,
				 AMD_PRIORITY_NUM_LEVELS;
	} params;

	// for 4.0.5
	params.MAX_VCN0_INSTANCES = 1;
	params.MAX_VCN1_INSTANCES = 1;
	params.MAX_VCN_INSTANCES = 2;
	params.MAX_VPE_INSTANCES = 1;
	params.UMSCH_MAX_HWIP_SEGMENT = 8;
	params.AMD_PRIORITY_NUM_LEVELS = 4;

	(void)from_addr;
	(void)from_vmid;
	(void)follow;

	n = 0;
	while (os) {
		n += os->nwords;
		os = os->next;
	}

	ui->start_ib(ui, ib_addr, ib_vmid, from_addr, from_vmid, n, 0);

	while (stream && opcodes--) {

		m = 4; // used for ib_addr offset so we skip the header
		// check if type is valid (UMSCH_API_TYPE_SCHEDULER = 1) since stream can include invalid data
		if (stream->type == 1) {
			switch (stream->opcode) {
				case 0x00: // SET_HW_RSRC
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "SET_HW_RESOURCES", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "vmid_mask_mm_vcn", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "vmid_mask_mm_vpe", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "collaboration_mask_vpe", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "engine_mask", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "logging_vmid", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					for (j = 0; j < params.MAX_VCN0_INSTANCES; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "vcn0_hqd_mask", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					for (j = 0; j < params.MAX_VCN1_INSTANCES; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "vcn1_hqd_mask", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					for (j = 0; j < params.MAX_VCN_INSTANCES; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "vcn_hqd_mask", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					for (j = 0; j < params.MAX_VPE_INSTANCES; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "vpe_hqd_mask", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					ui->add_field(ui, ib_addr + m, ib_vmid, "g_sch_ctx_gpu_mc_ptr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					for (j = 0; j < params.UMSCH_MAX_HWIP_SEGMENT; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "mmhub_base", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					ui->add_field(ui, ib_addr + m, ib_vmid, "mmhub_version", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					for (j = 0; j < params.UMSCH_MAX_HWIP_SEGMENT; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "osssys_base", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32);
						m += 4;
					}
					ui->add_field(ui, ib_addr + m, ib_vmid, "osssys_version", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "vcn_version", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "vpe_version", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;

					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;

					ui->add_field(ui, ib_addr + m, ib_vmid, "disable_reset", BITS(fetch_word(asic, stream, (m>>2)-1), 0, 1), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "disable_umsch_log", BITS(fetch_word(asic, stream, (m>>2)-1), 1, 2), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "enable_level_process_quantum_check", BITS(fetch_word(asic, stream, (m>>2)-1), 2, 3), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "is_vcn0_enabled", BITS(fetch_word(asic, stream, (m>>2)-1), 3, 4), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "is_vcn1_enabled", BITS(fetch_word(asic, stream, (m>>2)-1), 4, 5), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "use_rs64mem_for_proc_ctx_csa", BITS(fetch_word(asic, stream, (m>>2)-1), 5, 6), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "enable_umsch_stb", BITS(fetch_word(asic, stream, (m>>2)-1), 6, 7), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "reserved", BITS(fetch_word(asic, stream, (m>>2)-1), 7, 31), NULL, 16, 32);
					m += 4;
					break;
				case 0x01: // SET_SCHEDULING_CONFIG
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "SET_SCHEDULING_CONFIG", stream->header_dw, stream->words);
					for (j = 0; j < params.AMD_PRIORITY_NUM_LEVELS; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "grace_period_other_levels", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					}
					for (j = 0; j < params.AMD_PRIORITY_NUM_LEVELS; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "process_quantum_for_level", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					}
					for (j = 0; j < params.AMD_PRIORITY_NUM_LEVELS; j++) {
						ui->add_field(ui, ib_addr + m, ib_vmid, "process_grace_period_same_level", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					}
					ui->add_field(ui, ib_addr + m, ib_vmid, "normal_yield_percent", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x02: // ADD_QUEUE
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "ADD_QUEUE", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_id", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "page_table_base_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_va_start", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_va_end", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_quantum", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_quantum", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "inprocess_context_priority", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_global_priority_level", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "doorbell_offset_0", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "doorbell_offset_1", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "vcn0Affinity", BITS(fetch_word(asic, stream, (m>>2)-1), 0, 2), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "vcn1Affinity", BITS(fetch_word(asic, stream, (m>>2)-1), 2, 4), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "reserved", BITS(fetch_word(asic, stream, (m>>2)-1), 4, 31), NULL, 16, 32);
					m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "mqd_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "h_context", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "h_queue", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "engine_type", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "vm_context_cntl", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "is_context_suspended", BITS(fetch_word(asic, stream, (m>>2)-1), 0, 1), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "collaboration_mode", BITS(fetch_word(asic, stream, (m>>2)-1), 1, 2), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "mqd_type", BITS(fetch_word(asic, stream, (m>>2)-1), 2, 4), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "reserved", BITS(fetch_word(asic, stream, (m>>2)-1), 4, 31), NULL, 16, 32);
					m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "fence_signal_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					break;
				case 0x03: // REMOVE_QUEUE
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "REMOVE_QUEUE", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "doorbell_offset_0", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "doorbell_offset_1", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x04: // PERFORM_YIELD
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "PERFORM_YIELD", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "dummy", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x05: // SUSPEND
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "SUSPEND", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "suspend_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "suspend_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x06: // RESUME
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "RESUME", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "resume_option", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "engine_type", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x07: // RESET
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "RESET", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "reset_option", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "doorbell_offset_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "engine_type", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x08: // SET_LOG_BUFFER
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "SET_LOG_BUFFER", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "log_type", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "logging_buffer_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "number_of_entries", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "interrupt_entry", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x09: // CHANGE_CONTEXT_PRIORITY
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "CHANGE_CONTEXT_PRIORITY", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "inprocess_context_priority", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_global_priority_level", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_quantum", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x0A: // QUERY_SCHEDULER_STATUS
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "QUERY_SCHEDULER_STATUS", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "subopcode", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "proc_csa_array_size_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "ctx_csa_array_size_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "healthy_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "data[20]", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x0B: // UPDATE_AFFINITY
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "UPDATE_AFFINITY", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "vcn0Affinity", BITS(fetch_word(asic, stream, (m>>2)-1), 0, 2), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "vcn1Affinity", BITS(fetch_word(asic, stream, (m>>2)-1), 2, 4), NULL, 16, 32);
					ui->add_field(ui, ib_addr + m, ib_vmid, "reserved", BITS(fetch_word(asic, stream, (m>>2)-1), 4, 31), NULL, 16, 32);
					m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "context_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				case 0x0C: // UPDATE_ROOT_PAGE_TABLE
					ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "UPDATE_ROOT_PAGE_TABLE", stream->header_dw, stream->words);
					ui->add_field(ui, ib_addr + m, ib_vmid, "page_table_base_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_csa_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "process_csa_array_index", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_addr", ((uint64_t)fetch_word(asic, stream, (m>>2)-1)) | ((uint64_t)fetch_word(asic, stream, (m>>2)) << 32), NULL, 16, 64); m += 8;
					ui->add_field(ui, ib_addr + m, ib_vmid, "api_completion_fence_value", fetch_word(asic, stream, (m>>2)-1), NULL, 16, 32); m += 4;
					break;
				default:
					if (!stream->nwords && !stream->header_dw) {
						ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, "UMSCH_UNK", stream->header_dw, stream->words);
					}
					else if (ui->unhandled)
						ui->unhandled(ui, asic, ib_addr, ib_vmid, stream, UMR_RING_UMSCH);
					break;
			}
		}
		else {
			if (ui->unhandled)
				ui->unhandled(ui, asic, ib_addr, ib_vmid, stream, UMR_RING_UMSCH);
			break;
		}

		if (stream->invalid)
			break;

		ib_addr += (stream->nwords) * 4;
		stream = stream->next;
	}
	ui->done(ui);
	(void)m; // silence warnings
	return stream;
}
