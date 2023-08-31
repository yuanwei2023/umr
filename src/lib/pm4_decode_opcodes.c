/*
 * Copyright 2022 Advanced Micro Devices, Inc.
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

static const char *pm4_pkt3_opcode_names[] = {
	"UNK", // 00
	"UNK", // 01
	"UNK", // 02
	"UNK", // 03
	"UNK", // 04
	"UNK", // 05
	"UNK", // 06
	"UNK", // 07
	"UNK", // 08
	"UNK", // 09
	"UNK", // 0a
	"UNK", // 0b
	"UNK", // 0c
	"UNK", // 0d
	"UNK", // 0e
	"UNK", // 0f
	"PKT3_NOP", // 10
	"UNK", // 11
	"PKT3_CLEAR_STATE", // 12
	"UNK", // 13
	"UNK", // 14
	"PKT3_DISPATCH_DIRECT", // 15
	"UNK", // 16
	"UNK", // 17
	"UNK", // 18
	"UNK", // 19
	"UNK", // 1a
	"UNK", // 1b
	"UNK", // 1c
	"PKT3_ATOMIC_GDS", // 1d
	"PKT3_ATOMIC_MEM", // 1e
	"UNK", // 1f
	"UNK", // 20
	"UNK", // 21
	"PKT3_COND_EXEC", // 22
	"UNK", // 23
	"UNK", // 24
	"UNK", // 25
	"UNK", // 26
	"PKT3_DRAW_INDEX_2", // 27
	"PKT3_CONTEXT_CONTROL", // 28
	"UNK", // 29
	"UNK", // 2a
	"UNK", // 2b
	"UNK", // 2c
	"PKT3_DRAW_INDEX_AUTO", // 2d
	"UNK", // 2e
	"PKT3_NUM_INSTANCES", // 2f
	"UNK", // 30
	"UNK", // 31
	"UNK", // 32
	"PKT3_INDIRECT_BUFFER_CONST", // 33
	"UNK", // 34
	"UNK", // 35
	"UNK", // 36
	"PKT3_WRITE_DATA", // 37
	"UNK", // 38
	"UNK", // 39
	"UNK", // 3a
	"UNK", // 3b
	"PKT3_WAIT_REG_MEM", // 3c
	"UNK", // 3d
	"UNK", // 3e
	"PKT3_INDIRECT_BUFFER_CIK", // 3f
	"PKT3_COPY_DATA", // 40
	"UNK", // 41
	"PKT3_PFP_SYNC_ME", // 42
	"PKT3_SURFACE_SYNC", // 43
	"UNK", // 44
	"UNK", // 45
	"PKT3_EVENT_WRITE", // 46
	"PKT3_EVENT_WRITE_EOP", // 47
	"UNK", // 48
	"PKT3_RELEASE_MEM", // 49
	"PKT3_PREAMBLE_CNTL", // 4a
	"UNK", // 4b
	"PKT3_DISPATCH_MESH_INDIRECT_MULTI", // 4c
	"PKT3_DISPATCH_TASKMESH_GFX", // 4d
	"UNK", // 4e
	"UNK", // 4f
	"PKT3_DMA_DATA", // 50
	"PKT3_CONTEXT_REG_RMW", // 51
	"UNK", // 52
	"UNK", // 53
	"UNK", // 54
	"UNK", // 55
	"UNK", // 56
	"UNK", // 57
	"PKT3_ACQUIRE_MEM", // 58
	"UNK", // 59
	"UNK", // 5a
	"UNK", // 5b
	"UNK", // 5c
	"UNK", // 5d
	"PKT3_LOAD_UCONFIG_REG", // 5e
	"PKT3_LOAD_SH_REG", // 5f
	"PKT3_LOAD_CONFIG_REG", // 60
	"PKT3_LOAD_CONTEXT_REG", // 61
	"UNK", // 62
	"PKT3_LOAD_SH_REG_INDEX", // 63
	"UNK", // 64
	"UNK", // 65
	"UNK", // 66
	"UNK", // 67
	"PKT3_SET_CONFIG_REG", // 68
	"PKT3_SET_CONTEXT_REG", // 69
	"UNK", // 6a
	"UNK", // 6b
	"UNK", // 6c
	"UNK", // 6d
	"UNK", // 6e
	"UNK", // 6f
	"UNK", // 70
	"UNK", // 71
	"UNK", // 72
	"UNK", // 73
	"UNK", // 74
	"UNK", // 75
	"PKT3_SET_SH_REG", // 76
	"UNK", // 77
	"UNK", // 78
	"PKT3_SET_UCONFIG_REG", // 79
	"PKT3_SET_UCONFIG_REG_INDEX", // 7a
	"UNK", // 7b
	"UNK", // 7c
	"UNK", // 7d
	"UNK", // 7e
	"UNK", // 7f
	"PKT3_LOAD_CONST_RAM", // 80
	"PKT3_WRITE_CONST_RAM", // 81
	"UNK", // 82
	"PKT3_DUMP_CONST_RAM", // 83
	"PKT3_INCREMENT_CE_COUNTER", // 84
	"UNK", // 85
	"PKT3_WAIT_ON_CE_COUNTER", // 86
	"UNK", // 87
	"UNK", // 88
	"UNK", // 89
	"UNK", // 8a
	"PKT3_SWITCH_BUFFER", // 8b
	"UNK", // 8c
	"UNK", // 8d
	"UNK", // 8e
	"UNK", // 8f
	"PKT3_FRAME_CONTROL", // 90
	"PKT3_INDEX_ATTRIBUTES_INDIRECT", // 91
	"UNK", // 92
	"UNK", // 93
	"UNK", // 94
	"UNK", // 95
	"UNK", // 96
	"UNK", // 97
	"UNK", // 98
	"UNK", // 99
	"PKT3_DMA_DATA_FILL_MULTI", // 9a
	"PKT3_SET_SH_REG_INDEX", // 9b
	"UNK", // 9c
	"UNK", // 9d
	"UNK", // 9e
	"PKT3_LOAD_CONTEXT_REG_INDEX", // 9f
	"PKT3_SET_RESOURCES", // a0
	"PKT3_MAP_PROCESS", // a1
	"PKT3_MAP_QUEUES", // a2
	"PKT3_UNMAP_QUEUES", // a3
	"PKT3_QUERY_STATUS", // a4
	"PKT3_MES_RUN_LIST", // a5
	"UNK", // a6
	"UNK", // a7
	"UNK", // a8
	"PKT3_DISPATCH_TASK_STATE_INIT", // a9
	"PKT3_DISPATCH_TASKMESH_DIRECT_ACE", // aa
	"UNK", // ab
	"UNK", // ac
	"PKT3_DISPATCH_TASKMESH_INDIRECT_MULTI_ACE", // ad
	"UNK", // ae
	"UNK", // af
	"UNK", // b0
	"UNK", // b1
	"UNK", // b2
	"UNK", // b3
	"UNK", // b4
	"UNK", // b5
	"UNK", // b6
	"UNK", // b7
	"UNK", // b8
	"UNK", // b9
	"UNK", // ba
	"UNK", // bb
	"UNK", // bc
	"UNK", // bd
	"UNK", // be
	"UNK", // bf
	"UNK", // c0
	"UNK", // c1
	"UNK", // c2
	"UNK", // c3
	"UNK", // c4
	"UNK", // c5
	"UNK", // c6
	"UNK", // c7
	"UNK", // c8
	"UNK", // c9
	"UNK", // ca
	"UNK", // cb
	"UNK", // cc
	"UNK", // cd
	"UNK", // ce
	"UNK", // cf
	"UNK", // d0
	"UNK", // d1
	"UNK", // d2
	"UNK", // d3
	"UNK", // d4
	"UNK", // d5
	"UNK", // d6
	"UNK", // d7
	"UNK", // d8
	"UNK", // d9
	"UNK", // da
	"UNK", // db
	"UNK", // dc
	"UNK", // dd
	"UNK", // de
	"UNK", // df
	"UNK", // e0
	"UNK", // e1
	"UNK", // e2
	"UNK", // e3
	"UNK", // e4
	"UNK", // e5
	"UNK", // e6
	"UNK", // e7
	"UNK", // e8
	"UNK", // e9
	"UNK", // ea
	"UNK", // eb
	"UNK", // ec
	"UNK", // ed
	"UNK", // ee
	"UNK", // ef
	"UNK", // f0
	"UNK", // f1
	"UNK", // f2
	"UNK", // f3
	"UNK", // f4
	"UNK", // f5
	"UNK", // f6
	"UNK", // f7
	"UNK", // f8
	"UNK", // f9
	"UNK", // fa
	"UNK", // fb
	"UNK", // fc
	"UNK", // fd
	"UNK", // fe
	"UNK", // ff
};

static const struct {
	char *name;
	unsigned event_no;
} vgt_event_tags[] = {
	{ "SAMPLE_STREAMOUTSTATS1", 1 },
	{ "SAMPLE_STREAMOUTSTATS2", 2 },
	{ "SAMPLE_STREAMOUTSTATS3", 3 },
	{ "CACHE_FLUSH_TS", 4 },
	{ "CACHE_FLUSH", 6 },
	{ "CS_PARTIAL_FLUSH", 7 },
	{ "VGT_STREAMOUT_RESET", 10 },
	{ "END_OF_PIPE_INCR_DE", 11 },
	{ "END_OF_PIPE_IB_END", 12 },
	{ "RST_PIX_CNT", 13 },
	{ "VS_PARTIAL_FLUSH", 15 },
	{ "PS_PARTIAL_FLUSH", 16 },
	{ "CACHE_FLUSH_AND_INV_TS_EVENT", 20 },
	{ "ZPASS_DONE", 21 },
	{ "CACHE_FLUSH_AND_INV_EVENT", 22 },
	{ "PERFCOUNTER_START", 23 },
	{ "PERFCOUNTER_STOP", 24 },
	{ "PIPELINESTAT_START", 25 },
	{ "PIPELINESTAT_STOP", 26 },
	{ "PERFCOUNTER_SAMPLE", 27 },
	{ "SAMPLE_PIPELINESTAT", 30 },
	{ "SAMPLE_STREAMOUTSTATS", 32 },
	{ "RESET_VTX_CNT", 33 },
	{ "VGT_FLUSH", 36 },
	{ "BOTTOM_OF_PIPE_TS", 40 },
	{ "DB_CACHE_FLUSH_AND_INV", 42 },
	{ "FLUSH_AND_INV_DB_DATA_TS", 43 },
	{ "FLUSH_AND_INV_DB_META", 44 },
	{ "FLUSH_AND_INV_CB_DATA_TS", 45 },
	{ "FLUSH_AND_INV_CB_META", 46 },
	{ "CS_DONE", 47 },
	{ "PS_DONE", 48 },
	{ "FLUSH_AND_INV_CB_PIXEL_DATA", 49 },
	{ "THREAD_TRACE_START", 51 },
	{ "THREAD_TRACE_STOP", 52 },
	{ "THREAD_TRACE_FLUSH", 54 },
	{ "THREAD_TRACE_FINISH", 55 },
	{ NULL, 0 },
};

int umr_gfx_get_ip_ver(struct umr_asic *asic, int *maj, int *min)
{
	struct umr_ip_block *ip;

	// try by GC version
	ip = umr_find_ip_block(asic, "gfx", 0); // for multi instance
	if (!ip)
		ip = umr_find_ip_block(asic, "gfx", -1); // for single instance

	if (ip) {
		*maj = ip->discoverable.maj;
		*min = ip->discoverable.min;
		return 0;
	}
	return -1;
}

static char *vgt_event_decode(unsigned tag)
{
	unsigned x;
	for (x = 0; vgt_event_tags[x].name; x++) {
		if (vgt_event_tags[x].event_no == tag)
			return vgt_event_tags[x].name;
	}
	return "<unknown event>";
}

#define BITS(x, a, b) (unsigned long)((x >> (a)) & ((1ULL << ((b)-(a)))-1))

const char *umr_pm4_opcode_to_str(uint32_t header)
{
       return pm4_pkt3_opcode_names[(header >> 8) & 0xFF];
}

static void decode_pkt0(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_pm4_stream *stream, uint64_t ib_addr, uint32_t ib_vmid)
{
	uint32_t n;
	for (n = 0; n < stream->n_words; n++)
		ui->add_field(ui, ib_addr + 4 * (n + 1), ib_vmid, umr_reg_name(asic, stream->pkt0off + n), stream->words[n], NULL, 16, 32);
}

// for packets 0x5E, 0x5F, 0x60, 0x61
static void load_X_reg(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_pm4_stream *stream, uint64_t ib_addr, uint32_t ib_vmid)
{
	char *str, tmpstr[256];
	uint32_t str_size, *data, j, k, m, n, reg_base;
	uint64_t base_addr;

	switch (stream->opcode) {
		case 0x5E: reg_base = 0xC000; break; // LOAD_UCONFIG_REG
		case 0x5F: reg_base = 0x2C00; break; // LOAD_SH_REG
		case 0x60: reg_base = 0x2000; break; // LOAD_CONFIG_REG
		case 0x61: reg_base = 0xA000; break; // LOAD_CONTEXT_REG
	}

	base_addr = stream->words[0] & ~2UL;
	base_addr |= ((uint64_t)stream->words[1]) << 32;

	ui->add_field(ui, ib_addr + 4, ib_vmid, "BASE_ADDR_LO", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
	ui->add_field(ui, ib_addr + 8, ib_vmid, "BASE_ADDR_HI", stream->words[1], NULL, 16, 32);

	for (n = 2; n < stream->n_words; n += 2) {
		k = BITS(stream->words[n], 0, 16); // REG_OFFSET
		m = BITS(stream->words[n + 1], 0, 14); // NUM_DWORDS

		if (!asic->options.no_follow_loadx) {
			str_size = 4096;
			str = calloc(1, str_size);
			if (!str) {
				asic->err_msg("[ERROR]: Out of memory");
				return;
			}
			strcat(str, "\n");

			// fetch data
			data = calloc(sizeof data[0], m);
			if (!data) {
				asic->err_msg("[ERROR]: Out of memory");
				free(str);
				return;
			}

			if (!umr_read_vram(asic, asic->options.vm_partition, ib_vmid, base_addr + 4 * k, 4 * m, data)) {
				// turn into data string
				for (j = 0; j < m; j++) {
					snprintf(tmpstr, sizeof tmpstr, "#%4"PRIx32":%s <= 0x%"PRIx32"\n", k + j, umr_reg_name(asic, reg_base + k + j), data[j]);
					while (strlen(tmpstr) + strlen(str) >= str_size) {
						char *tmp;
						str_size += 4096;
						tmp = realloc(str, str_size);
						if (!tmp) {
							asic->err_msg("[ERROR]: Out of memory\n");
							free(data);
							free(str);
							return;
						}
						str = tmp;
					}
					strcat(str, tmpstr);
				}
			}
			free(data);
		} else {
			str = NULL;
		}

		ui->add_field(ui, ib_addr + 12 + ((n - 2) * 4), ib_vmid, "REG_OFFSET", k, umr_reg_name(asic, reg_base + k), 16, 32);
		ui->add_field(ui, ib_addr + 16 + ((n - 2) * 4), ib_vmid, "NUM_DWORD", m, str, 10, 32);
		free(str);
	}
}

static void decode_pkt3(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_pm4_stream *stream, uint64_t ib_addr, uint32_t ib_vmid)
{
	static char *op_3c_functions[] = { "true", "<", "<=", "==", "!=", ">=", ">", "reserved",
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };
	static char *op_37_engines[] = { "ME", "PFP", "CE", "DE" };
	static char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved",
									 "preemption meta memory", NULL, NULL, NULL, NULL, NULL, NULL, NULL };
	static char *op_40_mem_sel[] = { "mem-mapped reg", "memory", "tc_l2", "gds", "perfcounters", "immediate data", "atomic return data", "gds_atomic_return_data_0",
									 "gds_atomic_return_data1", "gpu_clock_count", "system_clock_count", NULL, NULL, NULL, NULL, NULL };
	static char *op_84_cntr_sel[] = { "invalid", "ce", "cs", "ce and cs" };
	static char *op_7a_index_str[] = { "default", "prim_type", "index_type", "num_instance", "multi_vgt_param", "reserved", "reserved", "reserved",
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };

	switch (stream->opcode) {
		case 0x10: // NOP
			if (stream->n_words == 0)
				break;
			if (stream->words[0] == 0x1337F77D) { // magic value for comments
				uint32_t pktlen = stream->words[1] - 1; // number of words in NOP sequence
				uint32_t pkttype = stream->words[2];
				char *str;

				ui->add_field(ui, ib_addr + 4, ib_vmid, "COMMENT_PACKET_LEN", pktlen, NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "COMMENT_PACKET_TYPE", pkttype, NULL, 10, 32);
				switch (pkttype) {
					case 7:
						str = calloc(1, 1 + pktlen * 4 - 12);
						if (str) {
							memcpy(str, &stream->words[3], pktlen * 4 - 12);
							ui->add_field(ui, ib_addr + 12, ib_vmid, "COMMENT_STRING", 0, str, 0, 0);
							free(str);
						}	
						break;
				}
			} else if (stream->words[0] == 0x3337F77D) { // magic value for BINARY data
				uint32_t n;

				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + (4 * n), ib_vmid, "BINARY DATA", stream->words[n], NULL, 16, 32);
				}
			}
			break;
		case 0x12: // CLEAR_STATE
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CMD", BITS(stream->words[0], 0, 4), NULL, 10, 32);
			break;
		case 0x15: // DISPATCH_DIRECT
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DIM_X", stream->words[0], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DIM_Y", stream->words[1], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DIM_Z", stream->words[2], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "INITIATOR", stream->words[3], NULL, 10, 32);
			break;
		case 0x1d: // ATOMIC_GDS
			// TODO: fill in
			break;
		case 0x1e: // ATOMIC_MEM
			// TODO: fill in
			break;
		case 0x22: // COND_EXEC
			ui->add_field(ui, ib_addr + 4, ib_vmid, "GPU_ADDR_LO32", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "GPU_ADDR_HI32", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "EXEC_COUNT", BITS(stream->words[3], 0, 14), NULL, 16, 32);
			break;
		case 0x27: // DRAW_INDEX_2
			ui->add_field(ui, ib_addr + 4, ib_vmid, "MAX_SIZE", stream->words[0], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "INDEX_BASE_LO", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "INDEX_BASE_HI", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "INDEX_COUNT", stream->words[3], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "DRAW_INITIATOR", stream->words[4], NULL, 10, 32);
			break;
		case 0x28: // CONTEXT_CONTROL
			ui->add_field(ui, ib_addr + 4, ib_vmid, "LOAD_EN", BITS(stream->words[0], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "LOAD_CS", BITS(stream->words[0], 24, 25), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "LOAD_GFX", BITS(stream->words[0], 16, 17), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "LOAD_MULTI", BITS(stream->words[0], 1, 2), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "LOAD_SINGLE", BITS(stream->words[0], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SHADOW_EN", BITS(stream->words[1], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SHADOW_CS", BITS(stream->words[1], 24, 25), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SHADOW_GFX", BITS(stream->words[1], 16, 17), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SHADOW_MULTI", BITS(stream->words[1], 1, 2), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SHADOW_SINGLE", BITS(stream->words[1], 0, 1), NULL, 10, 32);
			break;
		case 0x2D: // DRAW_INDEX_AUTO
			ui->add_field(ui, ib_addr + 4, ib_vmid, "INDEX_COUNT", stream->words[0], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DRAW_INITIATOR", stream->words[1], NULL, 10, 32);
			break;
		case 0x2F: // NUM_INSTANCES
			ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_INSTANCES", stream->words[0], NULL, 16, 32);
			break;
		case 0x33: // INDIRECT_BUFFER_CONST
		case 0x3F: // INDIRECT_BUFFER_CIK
			if (stream->opcode == 0x3F && stream->n_words == 13) {
				// COND packet
				ui->add_field(ui, ib_addr + 4, ib_vmid, "MODE", BITS(stream->words[0], 0, 2), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "FUNCTION", BITS(stream->words[0], 8, 11), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "COMPARE_ADDR_LO", BITS(stream->words[1], 3, 32), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "COMPARE_ADDR_HI", stream->words[2], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "MASK_LO", stream->words[3], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "MASK_HI", stream->words[4], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "REFERENCE_LO", stream->words[5], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 28, ib_vmid, "REFERENCE_HI", stream->words[6], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 32, ib_vmid, "IB_BASE1_LO", BITS(stream->words[7], 2, 32), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 36, ib_vmid, "IB_BASE1_HI", stream->words[8], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 40, ib_vmid, "IB_SIZE1", BITS(stream->words[9], 0, 20), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 40, ib_vmid, "CACHE_POLICY1", BITS(stream->words[9], 28, 30), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 44, ib_vmid, "IB_BASE2_LO", BITS(stream->words[10], 2, 32), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 48, ib_vmid, "IB_BASE2_HI", stream->words[11], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "IB_SIZE2", BITS(stream->words[12], 0, 20), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "CACHE_POLICY2", BITS(stream->words[12], 28, 30), NULL, 10, 32);
			} else {
				// not COND packet
				ui->add_field(ui, ib_addr + 4, ib_vmid, "IB_BASE_LO", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "SWAP", BITS(stream->words[0], 0, 2), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "IB_BASE_HI", BITS(stream->words[1], 0, 16), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_SIZE", BITS(stream->words[2], 0, 20), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_VMID", BITS(stream->words[2], 24, 28), NULL, 10, 32);
				if (asic->family >= FAMILY_AI) {
					ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_ENA", BITS(stream->words[2], 21, 22), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_RESUME", BITS(stream->words[2], 30, 31), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10, 32);
				}
			}
			break;
		case 0x37: // WRITE_DATA
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE", BITS(stream->words[0], 30, 32), op_37_engines[BITS(stream->words[0], 30, 32)], 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "WR_CONFIRM", BITS(stream->words[0], 20, 21), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "WR_ONE_ADDR", BITS(stream->words[0], 16, 17), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_SEL", BITS(stream->words[0], 8, 12), op_37_dst_sel[BITS(stream->words[0], 8, 12)],  10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DST_ADDR_LO", BITS(stream->words[1], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DST_ADDR_HI", stream->words[2], NULL, 16, 32);
			if (BITS(stream->words[0], 8, 12) == 0) { // mem-mapped reg
				uint32_t n;
				uint64_t reg_addr = ((uint64_t)stream->words[2] << 32) | stream->words[1];
				for (n = 3; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 16 + (n - 3) * 4, ib_vmid, umr_reg_name(asic, reg_addr), stream->words[n], NULL, 16, 32);
					reg_addr += 1;
				}
			}
			break;
		case 0x3C: // WAIT_REG_MEM
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE", BITS(stream->words[0], 8, 9), BITS(stream->words[0], 8, 9) ? "PFP" : "ME", 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "MEMSPACE", BITS(stream->words[0], 4, 5), BITS(stream->words[0], 4, 5) ? "MEM" : "REG", 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "OPERATION", BITS(stream->words[0], 6, 8), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "FUNCTION", BITS(stream->words[0], 0, 4), op_3c_functions[BITS(stream->words[0], 0, 4)], 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "POLL_ADDRESS_LO", BITS(stream->words[1], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SWAP", BITS(stream->words[1], 0, 2), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "POLL_ADDRESS_HI", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "REFERENCE", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "MASK", stream->words[4], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "POLL INTERVAL", stream->words[5], NULL, 16, 32);
			break;
		case 0x40: // PKT3_COPY_DATA
			ui->add_field(ui, ib_addr + 4, ib_vmid, "SRC_SEL", BITS(stream->words[0], 0, 4), op_40_mem_sel[BITS(stream->words[0], 0, 4)], 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_SEL", BITS(stream->words[0], 8, 12), op_40_mem_sel[BITS(stream->words[0], 8, 12)], 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "SRC_CACHE_POLICY", BITS(stream->words[0], 13, 15), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COUNT_SEL", BITS(stream->words[0], 16, 17), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "WR_CONFIRM", BITS(stream->words[0], 20, 21), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_CACHE_POLICY", BITS(stream->words[0], 25, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "PQ_EXE_STATUS", BITS(stream->words[0], 29, 30), NULL, 10, 32);

			switch (BITS(stream->words[0], 0, 4)) {
				case 0: ui->add_field(ui, ib_addr + 8, ib_vmid, "SRC_REG_OFFSET", BITS(stream->words[1], 0, 18), umr_reg_name(asic, BITS(stream->words[1], 0, 18)), 16, 32); break;
				case 5: ui->add_field(ui, ib_addr + 8, ib_vmid, "IMM_DATA", stream->words[1], NULL, 16, 32); break;
				default: ui->add_field(ui, ib_addr + 8, ib_vmid, "SRC_ADDR_LO", BITS(stream->words[1], 2, 32) << 2, NULL, 16, 32); break;
			}

			if (BITS(stream->words[0], 0, 4) == 5 && BITS(stream->words[0], 16, 17) == 1)
				ui->add_field(ui, ib_addr + 12, ib_vmid, "IMM_DATA_HI", stream->words[2], NULL, 16, 32);
			else
				ui->add_field(ui, ib_addr + 12, ib_vmid, "SRC_DATA_HI", stream->words[2], NULL, 16, 32);

			switch (BITS(stream->words[0], 0, 4)) {
				case 0: ui->add_field(ui, ib_addr + 16, ib_vmid, "DST_REG_OFFSET", BITS(stream->words[3], 0, 18), umr_reg_name(asic, BITS(stream->words[3], 0, 18)), 16, 32); break;
				default: ui->add_field(ui, ib_addr + 16, ib_vmid, "DST_ADDR_LO", stream->words[3], NULL, 16, 32); break;
			}
			ui->add_field(ui, ib_addr + 20, ib_vmid, "DST_ADDR_HI", stream->words[4], NULL, 16, 32);
			break;
		case 0x42: // PFP_SYNC_ME
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DUMMY_DATA", stream->words[0], NULL, 16, 32);
			break;
		case 0x43: // SURFACE_SYNC
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE", BITS(stream->words[0], 31, 32), BITS(stream->words[0], 31, 32) ? "ME" : "PFP", 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COHER_CNTL", BITS(stream->words[0], 0, 29), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "COHER_SIZE", stream->words[1], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "COHER_BASE", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "POLL_INTERVAL", stream->words[3], NULL, 10, 32);
			break;
		case 0x46: // EVENT_WRITE
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_TYPE", BITS(stream->words[0], 0, 6), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_INDEX", BITS(stream->words[0], 8, 12), NULL, 10, 32);
			if (stream->n_words > 2) {
				ui->add_field(ui, ib_addr + 8, ib_vmid, "ADDRESS_LO", BITS(stream->words[1], 3, 32) << 3, NULL, 16, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDRESS_HI", stream->words[2], NULL, 16, 32);
			}
			break;
		case 0x47: // EVENT_WRITE_EOP
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_TYPE", BITS(stream->words[0], 0, 6), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_INDEX", BITS(stream->words[0], 8, 12), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "INV_L2", BITS(stream->words[0], 20, 21), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "ADDRESS_LO", BITS(stream->words[1], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDRESS_HI", BITS(stream->words[2], 0, 16), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DATA_SEL", BITS(stream->words[2], 29, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "INT_SEL", BITS(stream->words[2], 24, 26), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DATA_LO", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "DATA_HI", stream->words[4], NULL, 16, 32);
			break;
		case 0x49: // RELEASE_MEM
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_TYPE", BITS(stream->words[0], 0, 6), vgt_event_decode(BITS(stream->words[0], 0, 6)), 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EVENT_INDEX", BITS(stream->words[0], 8, 12), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TCL1_VOL_ACTION_ENA", BITS(stream->words[0], 12, 13), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_VOL_ACTION_ENA", BITS(stream->words[0], 13, 14), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_WB_ACTION_ENA", BITS(stream->words[0], 15, 16), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TCL1_ACTION_ENA", BITS(stream->words[0], 16, 17), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_ACTION_ENA", BITS(stream->words[0], 17, 18), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_NC_ACTION_ENA", BITS(stream->words[0], 19, 20), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_WC_ACTION_ENA", BITS(stream->words[0], 20, 21), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TC_MD_ACTION_ENA", BITS(stream->words[0], 21, 22), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CACHE_POLICY", BITS(stream->words[0], 25, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "EXECUTE", BITS(stream->words[0], 28, 29), NULL, 10, 32);

			ui->add_field(ui, ib_addr + 8, ib_vmid, "DST_SEL", BITS(stream->words[1], 16, 18), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "INT_SEL", BITS(stream->words[1], 24, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DATA_SEL", BITS(stream->words[1], 29, 32), NULL, 10, 32);

			ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDR_LO", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "ADDR_HI", stream->words[3], NULL, 16, 32);

			if (BITS(stream->words[1], 24, 27) == 5 ||
			    BITS(stream->words[1], 24, 27) == 6) {
				ui->add_field(ui, ib_addr + 20, ib_vmid, "CMP_DATA_LO", stream->words[4], NULL, 16, 32);
			} else if (BITS(stream->words[1], 29, 32) == 5) {
				ui->add_field(ui, ib_addr + 20, ib_vmid, "DW_OFFSET", BITS(stream->words[4], 0, 16), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "NUM_WORDS", BITS(stream->words[4], 16, 32), NULL, 10, 32);
			} else {
				ui->add_field(ui, ib_addr + 20, ib_vmid, "DATA_LO", stream->words[4], NULL, 16, 32);
			}

			if (BITS(stream->words[1], 24, 27) == 5 ||
			    BITS(stream->words[1], 24, 27) == 6)
				ui->add_field(ui, ib_addr + 24, ib_vmid, "CMP_DATA_HI", stream->words[5], NULL, 16, 32);
			else
				ui->add_field(ui, ib_addr + 24, ib_vmid, "DATA_HI", stream->words[5], NULL, 16, 32);

			if (asic->family >= FAMILY_AI)
				ui->add_field(ui, ib_addr + 28, ib_vmid, "INT_CTXID", stream->words[6], NULL, 16, 32);
			break;
		case 0x4A: // PREABMLE_CNTL
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COMMAND", BITS(stream->words[0], 28, 32), NULL, 16, 32);
			break;
		case 0x4C: // DISPATCH_MESH_INDIRECT_MULTI
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DATA_OFFSET", stream->words[0], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "XYZ_DIM_LOC", BITS(stream->words[1], 0, 16), umr_reg_name(asic, BITS(stream->words[1], 0, 16) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "RING_ENTRY_LOC", BITS(stream->words[1], 16, 32), umr_reg_name(asic, BITS(stream->words[1], 16, 32) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "USE_VGPRS", BITS(stream->words[2], 28, 29), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "THREAD_TRACE_MARKER_ENABLE", BITS(stream->words[2], 29, 30), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "COUNT_INDIRECT_ENABLE", BITS(stream->words[2], 30, 31), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DRAW_INDEX_ENABLE", BITS(stream->words[2], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "COUNT", stream->words[3], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "COUNT_ADDR_LO", BITS(stream->words[4], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "COUNT_ADDR_HI", stream->words[5], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 28, ib_vmid, "STRIDE", stream->words[6], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 32, ib_vmid, "DRAW_INITIATOR", stream->words[7], NULL, 10, 32);
			break;
		case 0x4D: // DISPATCH_TASKMESH_GFX
			ui->add_field(ui, ib_addr + 4, ib_vmid, "XYZ_DIM_LOC", BITS(stream->words[0], 0, 16), umr_reg_name(asic, BITS(stream->words[0], 0, 16) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "RING_ENTRY_LOC", BITS(stream->words[0], 16, 32), umr_reg_name(asic, BITS(stream->words[0], 16, 32) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "THREAD_TRACE_MARKER_ENABLE", BITS(stream->words[1], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DRAW_INITIATOR", stream->words[2], NULL, 16, 32);
			break;
		case 0x50: // DMA_DATA
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", BITS(stream->words[0], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "SRC_CACHE_POLICY", BITS(stream->words[0], 13, 15), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_SEL", BITS(stream->words[0], 20, 22), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_CACHE_POLICY", BITS(stream->words[0], 25, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "SRC_SEL", BITS(stream->words[0], 29, 31), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CP_SYNC", BITS(stream->words[0], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "SRC_ADDR_LO_OR_DATA", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "SRC_ADDR_HI", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DST_ADDR_LO", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "DST_ADDR_HI", stream->words[4], NULL, 16, 32);
			if (asic->family <= FAMILY_VI) {
				ui->add_field(ui, ib_addr + 24, ib_vmid, "BYTE_COUNT", BITS(stream->words[5], 0, 26), NULL, 10, 32);
			} else {
				ui->add_field(ui, ib_addr + 24, ib_vmid, "BYTE_COUNT", BITS(stream->words[5], 0, 21), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "DIS_WC", BITS(stream->words[5], 21, 22), NULL, 10, 32);
			}
			ui->add_field(ui, ib_addr + 24, ib_vmid, "SAS", BITS(stream->words[5], 26, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "DAS", BITS(stream->words[5], 27, 28), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "SAIC", BITS(stream->words[5], 28, 29), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "DAIC", BITS(stream->words[5], 29, 30), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "RAW_WAIT", BITS(stream->words[5], 30, 31), NULL, 10, 32);
			if (asic->family <= FAMILY_VI)
				ui->add_field(ui, ib_addr + 24, ib_vmid, "DIS_WC", BITS(stream->words[5], 31, 32), NULL, 10, 32);
			break;
		case 0x51: // CONTEXT_REG_RMW
			ui->add_field(ui, ib_addr + 4, ib_vmid, "REG", stream->words[0], umr_reg_name(asic, stream->words[0]), 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "MASK", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DATA", stream->words[2], NULL, 16, 32);
			break;
		case 0x58: // ACQUIRE_MEM
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE", BITS(stream->words[0], 31, 32), BITS(stream->words[0], 31, 32) ? "ME" : "PFP", 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COHER_CNTL", BITS(stream->words[0], 0, 30), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "CP_COHER_SIZE", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "CP_COHER_SIZE_HI", BITS(stream->words[2], 0, 8), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "CP_COHER_BASE", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "CP_COHER_BASE_HI", BITS(stream->words[4], 0, 8), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "POLL_INTERVAL", BITS(stream->words[5], 0, 16), NULL, 10, 32);
			break;
		case 0x5E: // LOAD_UCONFIG_REG
		case 0x5F: // LOAD_SH_REG
		case 0x60: // LOAD_CONFIG_REG
		case 0x61: // LOAD_CONTEXT_REG
			load_X_reg(asic, ui, stream, ib_addr, ib_vmid);
			break;
		case 0x63: // LOAD_SH_REG_INDEX
			if (BITS(stream->words[0], 0, 1))
				ui->add_field(ui, ib_addr + 4, ib_vmid, "INDEX", 1, NULL, 10, 32);
			else
				ui->add_field(ui, ib_addr + 4, ib_vmid, "MEM_ADDR_LO", BITS(stream->words[0], 0, 31) & ~0x3UL, NULL, 16, 32);
			if (BITS(stream->words[0], 0, 1))
				ui->add_field(ui, ib_addr + 8, ib_vmid, "SH_BASE_ADDR", stream->words[1], NULL, 16, 32);
			else
				ui->add_field(ui, ib_addr + 8, ib_vmid, "MEM_ADDR_HI", stream->words[1], NULL, 16, 32);
			if (!BITS(stream->words[2], 31, 32))
				ui->add_field(ui, ib_addr + 12, ib_vmid, "REG", BITS(stream->words[2], 0, 16), umr_reg_name(asic, 0x2C00 + BITS(stream->words[2], 0, 16)), 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "NUM_DWORDS", stream->words[3], NULL, 10, 32);
			break;
		case 0x68: // SET_CONFIG_REG
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0x2000;
				uint32_t n;
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, "REG", stream->words[n], umr_reg_name(asic, addr), 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x69: // SET_CONTEXT_REG
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0xA000;
				uint32_t n;
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, "REG", stream->words[n], umr_reg_name(asic, addr), 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x76: // SET_SH_REG
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0x2C00;
				uint32_t n;
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, "REG", stream->words[n], umr_reg_name(asic, addr), 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x79: // SET_UCONTEXT_REG
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0xC000;
				uint32_t n;
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, "REG", stream->words[n], umr_reg_name(asic, addr), 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x7A: // SET_UCONFIG_REG_INDEX
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0xC000;
				uint32_t n;
				ui->add_field(ui, ib_addr + 4, ib_vmid, "INDEX", BITS(stream->words[0], 28, 32), op_7a_index_str[BITS(stream->words[0], 28, 32)], 10, 32);
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, "REG", stream->words[n], umr_reg_name(asic, addr), 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x80: // LOAD_CONST_RAM
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ADDR_LO", stream->words[0], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "ADDR_HI", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "NUM_DW", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "START_ADDR", BITS(stream->words[3], 0, 16), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "CACHE_POLICY", BITS(stream->words[3], 25, 27), NULL, 10, 32);
			break;
		case 0x81: // WRITE_CONST_RAM
			{
				uint32_t addr = BITS(stream->words[0], 0, 16);
				uint32_t n;
				char buf[32];
				for (n = 1; n < stream->n_words; n++) {
					sprintf(buf, "CONST_RAM[%lx]", (unsigned long)addr);
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, buf, stream->words[n], NULL, 16, 32);
					addr += 4;
				}
			}
			break;
		case 0x83: // DUMP_CONST_RAM
			ui->add_field(ui, ib_addr + 4, ib_vmid, "OFFSET", BITS(stream->words[0], 0, 16), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CACHE_POLICY", BITS(stream->words[0], 25, 26), BITS(stream->words[0], 25, 26) ? "stream" : "lru", 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "INC_CE", BITS(stream->words[0], 30, 31), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "INC_CS", BITS(stream->words[0], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "NUM_DW", BITS(stream->words[1], 0, 15), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDR_LO", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "ADDR_HI", stream->words[3], NULL, 16, 32);
			break;
		case 0x84: // INCREMENT_CE_COUNTER
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CNTRSEL", BITS(stream->words[0], 0, 2), op_84_cntr_sel[BITS(stream->words[0], 0, 2)], 10, 32);
			break;
		case 0x86: // WAIT_ON_CE_COUNTER
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COND_ACQUIRE_MEM", BITS(stream->words[0], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "FORCE_SYNC", BITS(stream->words[0], 1, 2), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "MEM_VOLATILE", BITS(stream->words[0], 27, 28), NULL, 10, 32);
			break;
		case 0x8B: // SWITCH_BUFFER
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DUMMY", stream->words[0], NULL, 16, 32);
			break;
		case 0x90: // FRAME_CONTROL
			ui->add_field(ui, ib_addr + 4, ib_vmid, "TMZ", BITS(stream->words[0], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "COMMAND", BITS(stream->words[0], 28, 32), NULL, 10, 32);
			break;
		case 0x91: // INDEX_ATTRIBUTES_INDIRECT
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ATTRIBUTE_BASE_LO", BITS(stream->words[0], 4, 32) << 4, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "ATTRIBUTE_BASE_HI", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "ATTRIBUTE_INDEX", BITS(stream->words[2], 0, 16), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "INDEX_BASE_LO", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "INDEX_BASE_HI", stream->words[4], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "INDEX_BUFFER_SIZE", stream->words[5], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 28, ib_vmid, "INDEX_TYPE", stream->words[6], NULL, 10, 32);
			break;
		case 0x9A: // DMA_DATA_FILL_MULTI
			ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", BITS(stream->words[0], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "MEMLOG_CLEAR", BITS(stream->words[0], 10, 11), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_SEL", BITS(stream->words[0], 20, 22), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DST_CACHE_POLICY", BITS(stream->words[0], 25, 27), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "SRC_SEL", BITS(stream->words[0], 29, 31), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CP_SYNC", BITS(stream->words[0], 31, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "BYTE_STRIDE", stream->words[1], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DMA_COUNT", stream->words[2], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DST_ADDR_LO", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "DST_ADDR_HI", stream->words[4], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "BYTE_COUNT", BITS(stream->words[5], 0, 26), NULL, 10, 32);
			break;
		case 0x9B: // SET_SH_REG_INDEX
			{
				uint64_t addr = BITS(stream->words[0], 0, 16) + 0x2C00;
				uint32_t n;
				ui->add_field(ui, ib_addr + 4, ib_vmid, "INDEX", BITS(stream->words[0], 28, 32), NULL, 10, 32);
				for (n = 1; n < stream->n_words; n++) {
					ui->add_field(ui, ib_addr + 4 + 4 * n, ib_vmid, umr_reg_name(asic, addr), stream->words[n], NULL, 16, 32);
					addr += 1;
				}
			}
			break;
		case 0x9F: // LOAD_CONTEXT_REG_INDEX
			{
				uint32_t index = BITS(stream->words[0], 0, 1);
				if (index)
					ui->add_field(ui, ib_addr + 4, ib_vmid, "INDEX", index, NULL, 10, 32);
				else
					ui->add_field(ui, ib_addr + 4, ib_vmid, "MEM_ADDR_LO", BITS(stream->words[0], 0, 32) & ~0x3UL, NULL, 16, 32);
				if (index)
					ui->add_field(ui, ib_addr + 8, ib_vmid, "CONTEXT_BASE_ADDR", stream->words[1], NULL, 16, 32);
				else
					ui->add_field(ui, ib_addr + 8, ib_vmid, "MEM_ADDR_HI", stream->words[1], NULL, 16, 32);
				if (BITS(stream->words[2], 31, 32))
					ui->add_field(ui, ib_addr + 12, ib_vmid, "REG", BITS(stream->words[2], 0, 16), umr_reg_name(asic, 0xA000 + BITS(stream->words[2], 0, 16)), 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "NUM_DWORDS", BITS(stream->words[3], 0, 14), NULL, 10, 32);
				if (BITS(stream->words[2], 31, 32)) {
					uint32_t n;
					uint32_t addr = 0xA000 + BITS(stream->words[2], 0, 16);
					for (n = 4; n < stream->n_words; n++)
						ui->add_field(ui, ib_addr + n * 4, ib_vmid, umr_reg_name(asic, addr + n - 4), stream->words[n], NULL, 16, 32);
				}
			}
			break;
		case 0xA0: // SET_RESOURCES
			ui->add_field(ui, ib_addr + 4, ib_vmid, "VMID_MASK", BITS(stream->words[0], 0, 16), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "UNMAP_LATENCY", BITS(stream->words[0], 16, 24), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_TYPE", BITS(stream->words[0], 29, 32), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "QUEUE_MASK_LO", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "QUEUE_MASK_HI", stream->words[2], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "GWS_MASK_LO", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "GWS_MASK_HI", stream->words[4], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "OAC_MASK", BITS(stream->words[5], 0, 16), NULL, 16, 32);
			ui->add_field(ui, ib_addr + 28, ib_vmid, "GDS_HEAP_BASE", BITS(stream->words[6], 0, 6), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 28, ib_vmid, "GDS_HEAP_SIZE", BITS(stream->words[6], 11, 17), NULL, 10, 32);
			break;
		case 0xA1: // PKT3_MAP_PROCESS
			if (asic->family <= FAMILY_VI) {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "PASID", BITS(stream->words[0], 0, 16), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "DIQ_ENABLE", BITS(stream->words[0], 24, 25), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "PAGE_TABLE_BASE", BITS(stream->words[1], 0, 28), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "SH_MEM_BASES", stream->words[2], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "SH_MEM_APE1_BASE", stream->words[3], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "SH_MEM_APE1_LIMIT", stream->words[4], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "SH_MEM_CONFIG", stream->words[5], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 28, ib_vmid, "GDS_ADDR_LO", stream->words[6], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 32, ib_vmid, "GDS_ADDR_HI", stream->words[7], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 36, ib_vmid, "NUM_GWS", BITS(stream->words[8], 0, 6), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 36, ib_vmid, "NUM_OAC", BITS(stream->words[8], 8, 12), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 36, ib_vmid, "GDS_SIZE", BITS(stream->words[8], 16, 22), NULL, 10, 32);
			} else {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "PASID", BITS(stream->words[0], 0, 16), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "DEBUG_VMID", BITS(stream->words[0], 18, 22), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "DEBUG_FLAG", BITS(stream->words[0], 22, 23), NULL, 10, 32);
				if (asic->family < FAMILY_NV)
					ui->add_field(ui, ib_addr + 4, ib_vmid, "TMZ", BITS(stream->words[0], 23, 24), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "DIQ_ENABLE", BITS(stream->words[0], 24, 25), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "PROCESS_QUANTUM", BITS(stream->words[0], 25, 32), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32", stream->words[1], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 12, ib_vmid, "VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32", stream->words[2], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "SH_MEM_BASES", stream->words[3], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "SH_MEM_CONFIG", stream->words[4], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "SQ_SHADER_TBA_LO", stream->words[5], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 28, ib_vmid, "SQ_SHADER_TBA_HI", stream->words[6], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 32, ib_vmid, "SQ_SHADER_TMA_LO", stream->words[7], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 36, ib_vmid, "SQ_SHADER_TMA_HI", stream->words[8], NULL, 16, 32);
				// offset 40 is reserved...
				ui->add_field(ui, ib_addr + 44, ib_vmid, "GDS_ADDR_LO", stream->words[10], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 48, ib_vmid, "GDS_ADDR_HI", stream->words[11], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "NUM_GWS", BITS(stream->words[12], 0, 6), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "SDMA_ENABLE", BITS(stream->words[12], 7, 8), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "NUM_OAC", BITS(stream->words[12], 8, 12), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "GDS_SIZE", BITS(stream->words[12], 16, 22), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 52, ib_vmid, "NUM_QUEUES", BITS(stream->words[12], 22, 32), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 56, ib_vmid, "COMPLETION_SIGNAL_LO32", stream->words[13], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 60, ib_vmid, "COMPLETION_SIGNAL_HI32", stream->words[14], NULL, 16, 32);
			}
			break;
		case 0xA2: // PKT3_MAP_QUEUES
			if (asic->family <= FAMILY_VI) {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_SEL", BITS(stream->words[0], 4, 6), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "VMID", BITS(stream->words[0], 8, 12), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "VIDMEM", BITS(stream->words[0], 16, 18), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "ALLOC_FORMAT", BITS(stream->words[0], 24, 26), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", BITS(stream->words[0], 26, 29), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_QUEUES", BITS(stream->words[0], 29, 32), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET", BITS(stream->words[1], 2, 23), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "QUEUE", BITS(stream->words[1], 26, 32), NULL, 10, 32);
				{
					uint32_t n;
					for (n = 2; n + 4 <= stream->n_words; n += 4) {
						ui->add_field(ui, ib_addr + 12 + 16 * ((n - 2) / 4), ib_vmid, "MQD_ADDR_LO", stream->words[n], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 16 + 16 * ((n - 2) / 4), ib_vmid, "MQD_ADDR_HI", stream->words[n + 1], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 20 + 16 * ((n - 2) / 4), ib_vmid, "WPTR_ADDR_LO", stream->words[n + 2], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 24 + 16 * ((n - 2) / 4), ib_vmid, "WPTR_ADDR_HI", stream->words[n + 3], NULL, 16, 32);
						if (ui->add_data)
							ui->add_data(ui, asic,
										 ib_addr + 12 + 16 * ((n - 2) / 4), ib_vmid,
										 ((uint64_t)stream->words[n]) | (((uint64_t)stream->words[n + 1]) << 32), BITS(stream->words[0], 8, 12),
										 UMR_DATABLOCK_MQD_VI, BITS(stream->words[0], 26, 29));
					}
				}
			} else {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_SEL", BITS(stream->words[0], 4, 6), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "VMID", BITS(stream->words[0], 8, 12), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE", BITS(stream->words[0], 13, 21), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_TYPE", BITS(stream->words[0], 21, 24), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "STATIC_QUEUE_GROUP", BITS(stream->words[0], 24, 26), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", BITS(stream->words[0], 26, 29), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_QUEUES", BITS(stream->words[0], 29, 32), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "CHECK_DISABLE", BITS(stream->words[1], 1, 2), NULL, 16, 32);
				ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET", BITS(stream->words[1], 2, 28), NULL, 16, 32);
				{
					uint32_t n;
					for (n = 2; n + 4 <= stream->n_words; n += 4) {
						ui->add_field(ui, ib_addr + 12 + 16 * ((n - 2) / 4), ib_vmid, "MQD_ADDR_LO", stream->words[n], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 16 + 16 * ((n - 2) / 4), ib_vmid, "MQD_ADDR_HI", stream->words[n + 1], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 20 + 16 * ((n - 2) / 4), ib_vmid, "WPTR_ADDR_LO", stream->words[n + 2], NULL, 16, 32);
						ui->add_field(ui, ib_addr + 24 + 16 * ((n - 2) / 4), ib_vmid, "WPTR_ADDR_HI", stream->words[n + 3], NULL, 16, 32);
						if (ui->add_data)
							ui->add_data(ui, asic,
										 ib_addr + 12 + 16 * ((n - 2) / 4), ib_vmid,
										 ((uint64_t)stream->words[n]) | (((uint64_t)stream->words[n + 1]) << 32), BITS(stream->words[0], 8, 12),
										 UMR_DATABLOCK_MQD_NV, BITS(stream->words[0], 26, 29));
					}
				}
			}
			break;
		case 0xA3: // PKT3_UNMAP_QUEUES
			{
				uint32_t action, queue_sel, num_queues, engine_sel;

				if (asic->family <= FAMILY_VI) {
					queue_sel = BITS(stream->words[0], 4, 6);
					engine_sel = BITS(stream->words[0], 26, 29);
					num_queues = BITS(stream->words[0], 29, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ACTION", BITS(stream->words[0], 0, 2), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_SEL", queue_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", engine_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_QUEUES", num_queues, NULL, 10, 32);
					if (queue_sel == 1)
						ui->add_field(ui, ib_addr + 8, ib_vmid, "PASID", BITS(stream->words[1], 0, 16), NULL, 10, 32);
					else
						ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET0", BITS(stream->words[1], 2, 23), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 12, ib_vmid, "DOORBELL_OFFSET1", BITS(stream->words[2], 2, 23), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 16, ib_vmid, "DOORBELL_OFFSET2", BITS(stream->words[3], 2, 23), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 20, ib_vmid, "DOORBELL_OFFSET3", BITS(stream->words[4], 2, 23), NULL, 16, 32);
				} else if (asic->family <= FAMILY_AI) {
					queue_sel = BITS(stream->words[0], 4, 6);
					engine_sel = BITS(stream->words[0], 26, 29);
					num_queues = BITS(stream->words[0], 29, 32);
					action = BITS(stream->words[0], 0, 2);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ACTION", BITS(stream->words[0], 0, 2), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_SEL", queue_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", engine_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_QUEUES", num_queues, NULL, 10, 32);
					if (queue_sel == 1)
						ui->add_field(ui, ib_addr + 8, ib_vmid, "PASID", BITS(stream->words[1], 0, 16), NULL, 10, 32);
					else
						ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET0", BITS(stream->words[1], 2, 28), NULL, 16, 32);
					if (engine_sel == 4 && action == 3)
						ui->add_field(ui, ib_addr + 12, ib_vmid, "RB_WPTR", BITS(stream->words[2], 0, 20), NULL, 16, 32);
					else
						ui->add_field(ui, ib_addr + 12, ib_vmid, "DOORBELL_OFFSET1", BITS(stream->words[2], 2, 28), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 16, ib_vmid, "DOORBELL_OFFSET2", BITS(stream->words[3], 2, 28), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 20, ib_vmid, "DOORBELL_OFFSET3", BITS(stream->words[4], 2, 28), NULL, 16, 32);
				} else {
					queue_sel = BITS(stream->words[0], 4, 6);
					engine_sel = BITS(stream->words[0], 26, 29);
					num_queues = BITS(stream->words[0], 29, 32);
					action = BITS(stream->words[0], 0, 2);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ACTION", BITS(stream->words[0], 0, 2), NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "QUEUE_SEL", queue_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "ENGINE_SEL", engine_sel, NULL, 10, 32);
					ui->add_field(ui, ib_addr + 4, ib_vmid, "NUM_QUEUES", num_queues, NULL, 10, 32);
					if (queue_sel == 1)
						ui->add_field(ui, ib_addr + 8, ib_vmid, "PASID", BITS(stream->words[1], 0, 16), NULL, 10, 32);
					else
						ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET0", BITS(stream->words[1], 2, 28), NULL, 16, 32);
					if (action == 3)
						ui->add_field(ui, ib_addr + 12, ib_vmid, "TF_ADDR_LO32", BITS(stream->words[2], 2, 32), NULL, 16, 32);
					else
						ui->add_field(ui, ib_addr + 12, ib_vmid, "DOORBELL_OFFSET1", BITS(stream->words[2], 2, 28), NULL, 16, 32);
					if (action == 3)
						ui->add_field(ui, ib_addr + 16, ib_vmid, "TF_ADDR_HI32", BITS(stream->words[3], 0, 32), NULL, 16, 32);
					else
						ui->add_field(ui, ib_addr + 16, ib_vmid, "DOORBELL_OFFSET2", BITS(stream->words[3], 2, 28), NULL, 16, 32);
					if (action == 3)
						ui->add_field(ui, ib_addr + 20, ib_vmid, "TF_DATA", BITS(stream->words[4], 0, 32), NULL, 16, 32);
					else
						ui->add_field(ui, ib_addr + 20, ib_vmid, "DOORBELL_OFFSET3", BITS(stream->words[4], 2, 28), NULL, 16, 32);
				}
			}
			break;
		case 0xA4: // PKT3_QUERY_STATUS
			if (asic->family <= FAMILY_VI) {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "CONTEXT_ID", BITS(stream->words[0], 0, 28), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "INTERRUPT_SEL", BITS(stream->words[0], 28, 30), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "COMMAND", BITS(stream->words[0], 30, 32), NULL, 10, 32);
				if (BITS(stream->words[0], 28, 30) == 1) {
					ui->add_field(ui, ib_addr + 8, ib_vmid, "PASID", BITS(stream->words[1], 0, 16), NULL, 10, 32);
				} else {
					ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET", BITS(stream->words[1], 2, 23), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 8, ib_vmid, "ENGINE_SEL", BITS(stream->words[1], 26, 29), NULL, 10, 32);
				}
				ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDR_LO", stream->words[2], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "ADDR_HI", stream->words[3], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "DATA_LO", stream->words[4], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "DATA_HI", stream->words[5], NULL, 16, 32);
			} else {
				ui->add_field(ui, ib_addr + 4, ib_vmid, "CONTEXT_ID", BITS(stream->words[0], 0, 28), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "INTERRUPT_SEL", BITS(stream->words[0], 28, 30), NULL, 10, 32);
				ui->add_field(ui, ib_addr + 4, ib_vmid, "COMMAND", BITS(stream->words[0], 30, 32), NULL, 10, 32);
				if (BITS(stream->words[0], 28, 30) == 1) {
					ui->add_field(ui, ib_addr + 8, ib_vmid, "PASID", BITS(stream->words[1], 0, 16), NULL, 10, 32);
				} else {
					ui->add_field(ui, ib_addr + 8, ib_vmid, "DOORBELL_OFFSET", BITS(stream->words[1], 2, 28), NULL, 16, 32);
					ui->add_field(ui, ib_addr + 8, ib_vmid, "ENGINE_SEL", BITS(stream->words[1], 28, 31), NULL, 10, 32);
				}
				ui->add_field(ui, ib_addr + 12, ib_vmid, "ADDR_LO", stream->words[2], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 16, ib_vmid, "ADDR_HI", stream->words[3], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 20, ib_vmid, "DATA_LO", stream->words[4], NULL, 16, 32);
				ui->add_field(ui, ib_addr + 24, ib_vmid, "DATA_HI", stream->words[5], NULL, 16, 32);
			}
			break;
		case 0xA5:	// PKT3_MES_RUN_LIST
			ui->add_field(ui, ib_addr + 4, ib_vmid, "IB_BASE_LO", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "IB_BASE_HI", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_SIZE", BITS(stream->words[2], 0, 20), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "OFFLOAD_POLLING", BITS(stream->words[2], 21, 22), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "VALID", BITS(stream->words[2], 23, 24), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "PROCESS_CNT", BITS(stream->words[2], 24, 28), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "LEVEL_1_STATIC_QUEUE_CNT", BITS(stream->words[3], 0, 4), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "LEVEL_2_STATIC_QUEUE_CNT", BITS(stream->words[3], 4, 8), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "LEVEL_3_STATIC_QUEUE_CNT", BITS(stream->words[3], 8, 12), NULL, 10, 32);
			break;
		case 0xA9: 	// PKT3_DISPATCH_TASK_STATE_INIT
			ui->add_field(ui, ib_addr + 4, ib_vmid, "CONTROL_BUF_ADDR_LO", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "CONTROL_BUF_ADDR_HI", stream->words[1], NULL, 16, 32);
			break;
		case 0xAA:	// DISPATCH_TASKMESH_DIRECT_ACE
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DIM_X", stream->words[0], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DIM_Y", stream->words[1], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "DIM_Z", stream->words[2], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DISPATCH_INITIATOR", stream->words[3], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "RING_ENTRY_LOC", BITS(stream->words[4], 0, 16), umr_reg_name(asic, BITS(stream->words[4], 0, 16) + 0x2C00), 16, 32);
			break;
		case 0xAD: // DISPATCH_TASKMESH_INDIRECT_MULTI_ACE
			ui->add_field(ui, ib_addr + 4, ib_vmid, "DATA_ADDR_LO", BITS(stream->words[0], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 8, ib_vmid, "DATA_ADDR_HI", stream->words[1], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 12, ib_vmid, "RING_ENTRY_LOC", BITS(stream->words[2], 0, 16), umr_reg_name(asic, BITS(stream->words[2], 0, 16) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "THREAD_TRACE_MARKER_ENABLE", BITS(stream->words[3], 0, 1), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "COUNT_INDIRECT_ENABLE", BITS(stream->words[3], 1, 2), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DISPATCH_INDEX_ENABLE", BITS(stream->words[3], 2, 3), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "COMPUTE_XYZ_DIM_ENABLE", BITS(stream->words[3], 3, 4), NULL, 10, 32);
			ui->add_field(ui, ib_addr + 16, ib_vmid, "DISPATCH_INDEX_LOC", BITS(stream->words[3], 16, 32), umr_reg_name(asic, BITS(stream->words[3], 16, 32) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 20, ib_vmid, "COMPUTE_XYZ_DIM_LOC", BITS(stream->words[4], 0, 16), umr_reg_name(asic, BITS(stream->words[4], 0, 16) + 0x2C00), 16, 32);
			ui->add_field(ui, ib_addr + 24, ib_vmid, "COUNT", stream->words[5], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 28, ib_vmid, "COUNT_ADDR_LO", BITS(stream->words[6], 2, 32) << 2, NULL, 16, 32);
			ui->add_field(ui, ib_addr + 32, ib_vmid, "COUNT_ADDR_HI", stream->words[7], NULL, 16, 32);
			ui->add_field(ui, ib_addr + 36, ib_vmid, "STRIDE", stream->words[8], NULL, 10, 32);
			ui->add_field(ui, ib_addr + 40, ib_vmid, "DISPATCH_INITIATOR", stream->words[9], NULL, 16, 32);
			break;
		default:
			if (ui->unhandled)
				ui->unhandled(ui, asic, ib_addr, ib_vmid, stream, UMR_RING_PM4);
			break;
	}
}

/** umr_pm4_decode_stream_opcodes -- Decode sequence of PM4 opcodes from a stream
 *
 * 	asic: The asic this stream belongs to
 * 	ui: The user interface callbacks that will be fed with decoded data
 * 	stream:  The stream of PM4 packets to read
 * 	ib_addr: The address the stream begins at in the VM space
 * 	ib_vmid:  The VMID of the stream
 * 	from_addr: The address of the packet this stream was pointed to from (e.g., address of the IB opcode that points to this)
 * 	from_vmid: The VMID of the packet this stream was pointed to from
 * 	opcodes: The number of opcodes to decode (~0UL for max)
 * 	follow: Boolean controlling whether to follow into IBs pointed to by the stream or not.
 *
 * Returns the address of the stream object of any yet to be decoded opcodes or NULL
 * if the end of the stream has been reached.  In the case opcodes is not set
 * to max this value is a pointer to the next opcode to decode.
 */
struct umr_pm4_stream *umr_pm4_decode_stream_opcodes(struct umr_asic *asic, struct umr_stream_decode_ui *ui, struct umr_pm4_stream *stream, uint64_t ib_addr, uint32_t ib_vmid, uint64_t from_addr, uint64_t from_vmid, unsigned long opcodes, int follow)
{
	uint32_t nwords, ncodes;
	struct umr_pm4_stream *s;
	const char *opcode_name;

	s = stream;
	nwords = 0;
	ncodes = opcodes;
	while (s && ncodes--) {
		nwords += 1 + s->n_words;
		s = s->next;
	}

	ui->start_ib(ui, ib_addr, ib_vmid, from_addr, from_vmid, nwords, 4);
	ncodes = opcodes;
	while (stream && ncodes--) {
		if (stream->pkttype == 0) {
			opcode_name = "PKT0";
		} else if (stream->pkttype == 3) {
			switch (stream->opcode) {
				case 0x33: // INDIRECT_BUFFER_CONST and COND_INDIRECT_BUFFER_CONST
					opcode_name = (stream->n_words == 3) ? "PKT3_INDIRECT_BUFFER_CONST" : "PKT3_COND_INDIRECT_BUFFER_CONST";
					break;
				case 0x3F: // INDIRECT_BUFFER and COND_INDIRECT_BUFFER
					opcode_name = (stream->n_words == 3) ? "PKT3_INDIRECT_BUFFER" : "PKT3_COND_INDIRECT_BUFFER";
					break;
				default:
					opcode_name = pm4_pkt3_opcode_names[stream->opcode];
			}
		} else if (stream->pkttype == 0xff) {
			// invalid header dword
			if (ui->unhandled_dword)
				ui->unhandled_dword(ui, ib_addr, ib_vmid, stream->header);
		}

		if ((stream->pkttype == 0 || stream->pkttype == 3) && strcmp(opcode_name, "UNK"))
			ui->start_opcode(ui, ib_addr, ib_vmid, stream->pkttype, stream->opcode, 0, stream->n_words, opcode_name, stream->header, stream->words);

		if (stream->pkttype == 3)
			decode_pkt3(asic, ui, stream, ib_addr, ib_vmid);
		else if (stream->pkttype == 0)
			decode_pkt0(asic, ui, stream, ib_addr, ib_vmid);

		if (stream->shader)
			ui->add_shader(ui, asic, ib_addr, ib_vmid, stream->shader);

		if (follow && stream->ib)
			umr_pm4_decode_stream_opcodes(asic, ui, stream->ib, stream->ib_source.addr, stream->ib_source.vmid, ib_addr, ib_vmid, ~0UL, follow);

		ib_addr += 4 + stream->n_words * 4;
		stream = stream->next;
	}
	ui->done(ui);
	return stream;
}
