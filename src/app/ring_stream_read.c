/*
 * Copyright 2021 Advanced Micro Devices, Inc.
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
#include <inttypes.h>

/* NOTE: This stream based presentation will eventually replace the existing
 * umr_read_ring() --ring, -R code since having duplicate opcode decoding is
 * tedious and a waste of time.
 */

struct pm4_ui_data {
	struct {
		uint64_t ib_addr, f_addr, b_addr;
		const uint32_t *rawdata;
		uint32_t off;
		FILE *f;
	} stack[32];
	int sp, no;
	struct umr_asic *asic;
};

static void pm4_next_level(struct umr_pm4_stream_decode_ui *ui)
{
	struct pm4_ui_data *data = ui->data;
	char tmpname[64];
	sprintf(tmpname, "/tmp/umr_ring_out.%d", (data->no)++);
	++(data->sp);
	data->stack[data->sp].f = fopen(tmpname, "w");
}

static void pm4_start_ib(struct umr_pm4_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, uint64_t from_addr, uint32_t from_vmid, uint32_t size, int type)
{
	struct pm4_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;

	pm4_next_level(ui);
	data->stack[data->sp].ib_addr = ib_addr;
	fprintf(data->stack[data->sp].f, "Decoding IB at %s%lu%s@%s0x%"PRIx64"%s from %s%lu%s@%s0x%"PRIx64"%s of %s%lu%s words (type %s%d%s)", 
	BLUE, (unsigned long)ib_vmid, RST,
	YELLOW, ib_addr, RST,
	BLUE, (unsigned long)from_vmid, RST,
	YELLOW, from_addr, RST,
	BLUE, (unsigned long)size, RST,
	BLUE, type, RST);
}

static void pm4_start_opcode(struct umr_pm4_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, int pkttype, uint32_t opcode, uint32_t nwords, const char *opcode_name, uint32_t header, const uint32_t* raw_data)
{
	struct pm4_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;
	(void)raw_data;
	data->stack[data->sp].b_addr = ib_addr + 4;
	data->stack[data->sp].f_addr = ib_addr - 4;
	data->stack[data->sp].rawdata = raw_data;
	fprintf(data->stack[data->sp].f, "\n[%s%lu%s@%s0x%08"PRIx64"%s + %s0x%04"PRIx64"%s]\t[%s0x%08"PRIx32"%s]\t%sOpcode%s %s0x%lx%s [%s%s%s] (%s%lu%s words, type: %s%d%s, hdr: %s0x%"PRIx32"%s)",
		BLUE, (unsigned long)ib_vmid, RST,
		YELLOW, data->stack[data->sp].ib_addr, RST,
		YELLOW, ib_addr - data->stack[data->sp].ib_addr, RST,
		BMAGENTA, header, RST,
		BWHITE, RST, GREEN, (unsigned long)opcode, RST, GREEN, opcode_name, RST,
		BLUE, (unsigned long)nwords, RST,
		BLUE, pkttype, RST,
		BLUE, header, RST);
}

static void pm4_add_field(struct umr_pm4_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, const char *field_name, uint32_t value, char *str, int ideal_radix)
{
	struct pm4_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;
	if (data->stack[data->sp].f_addr != ib_addr) {
		data->stack[data->sp].f_addr = ib_addr;
		fprintf(data->stack[data->sp].f, "\n[%s%lu%s@%s0x%08"PRIx64"%s + %s0x%04"PRIx64"%s]\t[%s0x%08"PRIx32"%s]\t|---> ",
			BLUE, (unsigned long)ib_vmid, RST,
			YELLOW, data->stack[data->sp].ib_addr, RST,
			YELLOW, ib_addr - data->stack[data->sp].ib_addr, RST,
			BMAGENTA, data->stack[data->sp].rawdata[(ib_addr - data->stack[data->sp].b_addr)/4], RST);
	} else {
		fprintf(data->stack[data->sp].f, ", ");
	}

	if (!strcmp(field_name, "REG") && ideal_radix == 16) {
		// register name/value pairs
		fprintf(data->stack[data->sp].f, "%s%s%s=%s0x%"PRIx32"%s",
			RED, str, RST,
			YELLOW, value, RST);
	} else {
		// default
		fprintf(data->stack[data->sp].f, "%s%s%s=", CYAN, field_name, RST);
		if (str)
			fprintf(data->stack[data->sp].f, "[%s%s%s]", RED, str, RST);

		if (str && (ideal_radix == 10 || ideal_radix == 16))
			fprintf(data->stack[data->sp].f, "/");

		switch (ideal_radix) {
			case 10: fprintf(data->stack[data->sp].f, "%s%"PRIu32"%s", BBLUE, value, RST); break;
			case 16: fprintf(data->stack[data->sp].f, "%s0x%"PRIx32"%s", YELLOW, value, RST); break;
		}
	}
}

static void pm4_add_shader(struct umr_pm4_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, struct umr_shaders_pgm *shader)
{
	struct pm4_ui_data *data = ui->data;
	char **str;
	int x;

	pm4_next_level(ui);
	fprintf(data->stack[data->sp].f, "Shader from %lu@[0x%"PRIx64" + 0x%"PRIx64"] at %lu@0x%"PRIx64", type %d, size %lu\n", (unsigned long)ib_vmid, data->stack[data->sp-1].ib_addr, ib_addr - data->stack[data->sp-1].ib_addr, (unsigned long)shader->vmid, shader->addr, shader->type, (unsigned long)shader->size);
	umr_vm_disasm_to_str(asic, ib_vmid, ib_addr, 0, shader->size, 0, &str);
	x = 0;
	while (str[x]) {
		fprintf(data->stack[data->sp].f, "%s\n", str[x]);
		free(str[x++]);
	}
	free(str);
	fprintf(data->stack[data->sp].f, "Done disassembly of shader\n\n");
	fclose(data->stack[data->sp].f);
	--(data->sp);
}

static void pm4_unhandled(struct umr_pm4_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, struct umr_pm4_stream *stream)
{
	(void)ui;
	(void)asic;
	(void)ib_addr;
	(void)ib_vmid;
	(void)stream;
}

static void pm4_done(struct umr_pm4_stream_decode_ui *ui)
{
	struct pm4_ui_data *data = ui->data;
	fprintf(data->stack[data->sp].f, "\nDone decoding IB\n\n");
	fclose(data->stack[data->sp].f);
	--(data->sp);
}

static struct umr_pm4_stream_decode_ui pm4_ui = { pm4_start_ib, pm4_start_opcode, pm4_add_field, pm4_add_shader, pm4_unhandled, pm4_done, NULL };

// top level present pm4
static void present_pm4(struct umr_asic *asic, char *ringname, int start, int end)
{
	struct umr_pm4_stream *str;

	str = umr_pm4_decode_ring(asic, ringname, 0, start, end);
	if (str) {
		struct umr_pm4_stream_decode_ui ui;
		int x;
		char tmpname[64], buf[256];
		FILE *f;
		struct pm4_ui_data *data;

		// print decode str
		ui = pm4_ui;
		data = ui.data = calloc(1, sizeof(struct pm4_ui_data));
		data->sp = -1;
		data->asic = asic;
		umr_pm4_decode_stream_opcodes(asic, &ui, str, 0, 0, 0, 0, ~0UL, 1);

		for (x = 0; x < data->no; x++) {
			sprintf(tmpname, "/tmp/umr_ring_out.%d", x);
			f = fopen(tmpname, "r");
			while (fgets(buf, sizeof buf, f)) {
				printf("%s", buf);
			}
			fclose(f);
			remove(tmpname);
		}
		free(ui.data);
		umr_free_pm4_stream(str);
	}
}

// example opaque data to keep track of offsets
struct sdma_ui_data {
	struct {
		uint64_t ib_addr, f_addr, b_addr;
		const uint32_t *rawdata;
		uint32_t off;
		FILE *f;
	} stack[32];
	int sp, no;
	struct umr_asic *asic;
};

static void sdma_next_level(struct umr_sdma_stream_decode_ui *ui)
{
	struct sdma_ui_data *data = ui->data;
	char tmpname[64];
	sprintf(tmpname, "/tmp/umr_ring_out.%d", (data->no)++);
	++(data->sp);
	data->stack[data->sp].f = fopen(tmpname, "w");
}

static void sdma_start_ib(struct umr_sdma_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, uint64_t from_addr, uint32_t from_vmid, uint32_t size)
{
	struct sdma_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;
	sdma_next_level(ui);
	data->stack[data->sp].ib_addr = ib_addr;

	fprintf(data->stack[data->sp].f, "Decoding IB at %s%lu%s@%s0x%"PRIx64"%s from %s%lu%s@%s0x%"PRIx64"%s of %s%lu%s words",
	BLUE, (unsigned long)ib_vmid, RST,
	YELLOW, ib_addr, RST,
	BLUE, (unsigned long)from_vmid, RST,
	YELLOW, from_addr, RST,
	BLUE, (unsigned long)size, RST);
}

static void sdma_start_opcode(struct umr_sdma_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, uint32_t opcode, uint32_t sub_opcode, uint32_t nwords, char *opcode_name, uint32_t header, uint32_t *raw_data)
{
	struct sdma_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;
	data->stack[data->sp].b_addr = ib_addr + 4;
	data->stack[data->sp].f_addr = ib_addr - 4;
	data->stack[data->sp].rawdata = raw_data;
	fprintf(data->stack[data->sp].f, "\n[%s%lu%s@%s0x%08"PRIx64"%s + %s0x%04"PRIx64"%s] [%s0x%08"PRIx32"%s]\t%sOpcode%s %s0x%"PRIx32"%s [%s%s%s] Sub-Opcode %s%"PRIx32"%s (%s%lu%s words, hdr: %s0x%"PRIx32"%s)",
		BLUE, (unsigned long)ib_vmid, RST,
		YELLOW, data->stack[data->sp].ib_addr, RST,
		YELLOW, ib_addr - data->stack[data->sp].ib_addr, RST,
		BMAGENTA, header, RST,
		BWHITE, RST, GREEN, opcode, RST, GREEN, opcode_name, RST, GREEN, sub_opcode, RST,
		BLUE, (unsigned long)nwords, RST,
		BLUE, header, RST);
}

static void sdma_add_field(struct umr_sdma_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, const char *field_name, uint32_t value, char *str, int ideal_radix)
{
	struct sdma_ui_data *data = ui->data;
	struct umr_asic *asic = data->asic;
	if (data->stack[data->sp].f_addr != ib_addr) {
		data->stack[data->sp].f_addr = ib_addr;
		fprintf(data->stack[data->sp].f, "\n[%s%lu%s@%s0x%08"PRIx64"%s + %s0x%04"PRIx64"%s] [%s0x%08"PRIx32"%s]\t|---> ",
			BLUE, (unsigned long)ib_vmid, RST,
			YELLOW, data->stack[data->sp].ib_addr, RST,
			YELLOW, ib_addr - data->stack[data->sp].ib_addr, RST,
			BMAGENTA, data->stack[data->sp].rawdata[(ib_addr - data->stack[data->sp].b_addr)/4], RST);
	} else {
		fprintf(data->stack[data->sp].f, ", ");
	}

	if (!strcmp(field_name, "REG") && ideal_radix == 16) {
		// register name/value pairs
		fprintf(data->stack[data->sp].f, "%s%s%s=%s0x%"PRIx32"%s",
			RED, str, RST,
			YELLOW, value, RST);
	} else {
		// default
		fprintf(data->stack[data->sp].f, "%s%s%s=", CYAN, field_name, RST);
		if (str)
			fprintf(data->stack[data->sp].f, "[%s%s%s]", RED, str, RST);

		if (str && (ideal_radix == 10 || ideal_radix == 16))
			fprintf(data->stack[data->sp].f, "/");

		switch (ideal_radix) {
			case 10: fprintf(data->stack[data->sp].f, "%s%"PRIu32"%s", BBLUE, value, RST); break;
			case 16: fprintf(data->stack[data->sp].f, "%s0x%"PRIx32"%s", YELLOW, value, RST); break;
		}
	}
}

static void sdma_unhandled(struct umr_sdma_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, struct umr_sdma_stream *stream)
{
	(void)ui;
	(void)asic;
	(void)ib_addr;
	(void)ib_vmid;
	(void)stream;
}

static void sdma_unhandled_subop(struct umr_sdma_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, struct umr_sdma_stream *stream)
{
	(void)ui;
	(void)asic;
	(void)ib_addr;
	(void)ib_vmid;
	(void)stream;
}

static void sdma_done(struct umr_sdma_stream_decode_ui *ui)
{
	struct sdma_ui_data *data = ui->data;
	fprintf(data->stack[data->sp].f, "\nDone decoding IB\n");
	fclose(data->stack[data->sp].f);
	--(data->sp);
}

static struct  umr_sdma_stream_decode_ui sdma_ui = { sdma_start_ib, sdma_start_opcode, sdma_add_field, sdma_unhandled, sdma_unhandled_subop, sdma_done, NULL };

static void present_sdma(struct umr_asic *asic, char *ringname, int start, int end)
{
	struct umr_sdma_stream *stream;

	stream = umr_sdma_decode_ring(asic, ringname, start, end);
	if (stream) {
		struct umr_sdma_stream_decode_ui myui;
		struct sdma_ui_data *data;
		int x;
		char tmpname[64], buf[256];
		FILE *f;

		myui = sdma_ui;

		// assign our opaque structure
		data = myui.data = calloc(1, sizeof(struct sdma_ui_data));
		data->sp = -1;
		data->asic = asic;

		umr_sdma_decode_stream_opcodes(asic, &myui, stream, 0, 0, 0, 0, ~0UL, 1);

		for (x = 0; x < data->no; x++) {
			sprintf(tmpname, "/tmp/umr_ring_out.%d", x);
			f = fopen(tmpname, "r");
			while (fgets(buf, sizeof buf, f)) {
				printf("%s", buf);
			}
			fclose(f);
			remove(tmpname);
		}
		umr_free_sdma_stream(stream);
		free(myui.data);
	}
}

void umr_read_ring_stream(struct umr_asic *asic, char *ringpath)
{
	char ringname[32], from[32], to[32];
	int  enable_decoder, start, end;

	memset(ringname, 0, sizeof ringname);
	memset(from, 0, sizeof from);
	memset(to, 0, sizeof to);
	if (sscanf(ringpath, "%[a-z0-9._][%[.0-9]:%[.0-9]]", ringname, from, to) < 1) {
		printf("Invalid ringpath\n");
		return;
	}

	// only decode PM4 packets on certain rings
	if (!memcmp(ringname, "gfx", 3) ||
	    !memcmp(ringname, "uvd", 3) ||
	    !memcmp(ringname, "vcn_dec", 7) ||
	    !memcmp(ringname, "vcn_enc", 7) ||
	    !memcmp(ringname, "kiq", 3) ||
	    !memcmp(ringname, "comp", 4)) {
		enable_decoder = 4;
	} else if (!memcmp(ringname, "sdma", 4) ||
		   !memcmp(ringname, "page", 4)) {
		enable_decoder = 3;
	} else {
		enable_decoder = 0;
	}

	/* default to reading entire ring */
	if (!from[0]) {
		start = 0;
		end   = 10000;
	} else {
		if (from[0] == '.') {
			if (to[0] == 0 || to[0] == '.') {
				/* Notation: [.] or [.:.], meaning
				 * [rptr, wptr].
				 */
				start = -1;
				end = -1;
			} else {
				/* Notation: [.:k], k >=0, meaning
				 * [rptr, rtpr+k] double-words.
				 */
				start = -1;
				sscanf(to, "%d", &end);
			}
		} else {
			sscanf(from, "%d", &start);
			start *= 4;

			if (to[0] != 0 && to[0] != '.') {
				/* [k:r] ==> absolute [k, r].
				 */
				sscanf(to, "%d", &end);
			} else {
				/* to[0] is 0 or '.',
				 * [k] or [k:.] ==> [wptr - k, wptr]
				 */
				end = -1;
			}
		}
	}

	/* pm4 streams */
	if (enable_decoder == 4) {
		present_pm4(asic, ringname, start, end);
	} else if (enable_decoder == 3) {
		present_sdma(asic, ringname, start, end);
	} else {
		fprintf(stderr, "[BUG]: Unknown ring type for [%s]\n", ringname);
	}
}
