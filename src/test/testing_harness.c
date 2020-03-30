/*
 * Copyright 2020 Advanced Micro Devices, Inc.
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

#include <ctype.h>
#include <stdbool.h>

// chomp out rest of line
static void chomp(const char **ptr)
{
	// skip until we hit a newline
	while (**ptr && **ptr != '\n')
		++(*ptr);

	// skip newline
	if (**ptr)
		++(*ptr);
}

static void consume_whitespace(const char **ptr)
{
	int n;

	// eat white space and/or consume comments
	do {
		n = 0;
		while (**ptr && (**ptr == ' ' || **ptr == '\t' || **ptr == '\n')) {
			n = 1;
			++(*ptr);
		}
		if (**ptr == ';') {
			n = 1;
			chomp(ptr);
		}
	} while (n);
}

static void consume_hexdigits(const char **ptr)
{
	while (**ptr && (isxdigit(**ptr) || **ptr == 'x' || **ptr == 'X'))
		++(*ptr);
}

static uint64_t consume_xint64(const char **ptr, int *res)
{
	uint64_t v;
	consume_whitespace(ptr);
	if (sscanf(*ptr, "%"SCNx64, &v) == 1) {
		*res = 1;
		consume_hexdigits(ptr);
		return v;
	} else {
		*res = 0;
		return 0;
	}
}

static uint32_t consume_xint32(const char **ptr, int *res)
{
	uint32_t v;
	consume_whitespace(ptr);
	if (sscanf(*ptr, "%"SCNx32, &v) == 1) {
		*res = 1;
		consume_hexdigits(ptr);
		return v;
	} else {
		*res = 0;
		return 0;
	}
}

static uint8_t consume_xint8(const char **ptr, int *res)
{
	uint8_t v;
	char t[3];
	t[2] = 0;

	consume_whitespace(ptr);
	if (**ptr == '}') {
		*res = 0;
		return 0;
	}

	while (**ptr && !isxdigit(**ptr)) ++(*ptr);
	t[0] = **ptr;
	while (**ptr && !isxdigit(**ptr)) ++(*ptr);
	t[1] = **ptr;

	if (sscanf(t, "%"SCNx8, &v) == 1) {
		*res = 1;
		(*ptr) += 2;
		return v;
	} else {
		*res = 0;
		return 0;
	}
}

// expect '{...}'
static uint8_t *consume_bytes(const char **ptr, uint32_t *size)
{
	int s = 32, x, r;
	uint8_t *p, *po;

	consume_whitespace(ptr);
	if (**ptr == '{') {
		++(*ptr);
	} else {
		fprintf(stderr, "[ERROR]: Expecting '{' for array of bytes\n");
		*size = 0;
		return NULL;
	}

	p = calloc(1, s);
	if (!p) {
		fprintf(stderr, "[ERROR]: Out of memory\n");
		*size = 0;
		return NULL;
	}

	x = 0;
	for (;;) {
		p[x] = consume_xint8(ptr, &r);
		if (!r)
			break;
		if (++x == s) {
			po = realloc(p, s + 32);
			if (po) {
				p = po;
				s += 32;
			} else {
				free(p);
				fprintf(stderr, "[ERROR]: Out of memory\n");
				*size = 0;
				return NULL;
			}
		}
	}

	consume_whitespace(ptr);
	if (**ptr == '}') {
		++(*ptr);
	} else {
		fprintf(stderr, "[ERROR]: Expecting '}' for array of bytes\n");
		free(p);
		*size = 0;
		return NULL;
	}
	*size = x;
	return p;
}

// format: '{...[,...]}'
static uint32_t *consume_words(const char **ptr, uint32_t *size)
{
	int s = 8, x, r;
	uint32_t *p, *po;

	consume_whitespace(ptr);
	if (**ptr == '{') {
		++(*ptr);
	} else {
		fprintf(stderr, "[ERROR]: Expecting '{' for array of words\n");
		*size = 0;
		return NULL;
	}

	p = calloc(sizeof(p[0]), s);
	if (!p) {
		fprintf(stderr, "[ERROR]: Out of memory\n");
		*size = 0;
		return NULL;
	}

	x = 0;
	for (;;) {
		p[x] = consume_xint32(ptr, &r);
		if (!r)
			break;
		if (++x == s) {
			po = realloc(p, (s + 8) * sizeof(p[0]));
			if (po) {
				p = po;
				s += 8;
			} else {
				free(p);
				fprintf(stderr, "[ERROR]: Out of words\n");
				*size = 0;
				return NULL;
			}
		}

		// continue if there is a ','
		consume_whitespace(ptr);
		if (**ptr != ',')
			break;
		++(*ptr);
	}

	consume_whitespace(ptr);
	if (**ptr == '}') {
		++(*ptr);
	} else {
		fprintf(stderr, "[ERROR]: Expecting '}' for array of words\n");
		free(p);
		*size = 0;
		return NULL;
	}
	*size = x;
	return p;
}

static int consume_word(const char **ptr, char *token)
{
	consume_whitespace(ptr);
	if (!memcmp(*ptr, token, strlen(token))) {
		*ptr += strlen(token);
		return 1;
	}
	return 0;
}

static int expect_word(const char **ptr, char *token)
{
	int r;
	r = consume_word(ptr, token);
	if (!r)
		fprintf(stderr, "[ERROR]: Expecting token '%s'\n", token);
	return r;
}

void umr_free_test_harness(struct umr_test_harness *th)
{
	struct umr_ram_blocks *sram, *vram;
	struct umr_mmio_blocks *mmio;
	struct umr_sq_blocks *sq;
	void *t;

	if (!th)
		return;

	sram = th->sysram.next;
	vram = th->vram.next;
	mmio = th->mmio.next;
	sq   = th->sq.next;

	free(th->sysram.contents);
	free(th->vram.contents);
	free(th->mmio.values);
	free(th->sq.values);

	while (sram) {
		t = sram->next;
		free(sram->contents);
		free(sram);
		sram = t;
	}

	while (vram) {
		t = vram->next;
		free(vram->contents);
		free(vram);
		vram = t;
	}

	while (mmio) {
		t = mmio->next;
		free(mmio->values);
		free(mmio);
		mmio = t;
	}

	while (sq) {
		t = sq->next;
		free(sq->values);
		free(sq);
		sq = t;
	}
	free(th);
}

struct umr_test_harness *umr_create_test_harness(const char *script)
{
	struct umr_test_harness *th;
	struct umr_ram_blocks *sram, *vram;
	struct umr_mmio_blocks *mmio;
	struct umr_sq_blocks *sq;
	int r;

	th = calloc(1, sizeof *th);

	sram = &th->sysram;
	vram = &th->vram;
	mmio = &th->mmio;
	sq   = &th->sq;

	while (*script) {
		consume_whitespace(&script);
		if (consume_word(&script, "SYSRAM@")) {
			sram->base_address = consume_xint64(&script, &r);
			if (!r)
				goto error;
			if (!expect_word(&script, "="))
				goto error;
			sram->contents = consume_bytes(&script, &sram->size);
			if (!sram->size)
				goto error;
			sram->next = calloc(1, sizeof *sram);
			sram = sram->next;
		}
		if (consume_word(&script, "VRAM@")) {
			vram->base_address = consume_xint64(&script, &r);
			if (!r)
				goto error;
			if (!expect_word(&script, "="))
				goto error;
			vram->contents = consume_bytes(&script, &vram->size);
			if (!vram->size)
				goto error;
			vram->next = calloc(1, sizeof *vram);
			vram = vram->next;
		}
		if (consume_word(&script, "MMIO@")) {
			mmio->mmio_address = consume_xint32(&script, &r);
			if (!r)
				goto error;
			if (!expect_word(&script, "="))
				goto error;
			mmio->values = consume_words(&script, &mmio->no_values);
			if (!mmio->no_values)
				goto error;
			mmio->next = calloc(1, sizeof *mmio);
			mmio = mmio->next;
		}
		if (consume_word(&script, "SQ@")) {
			sq->sq_address = consume_xint32(&script, &r);
			if (!r)
				goto error;
			if (!expect_word(&script, "="))
				goto error;
			sq->values = consume_words(&script, &sq->no_values);
			if (!sq->no_values)
				goto error;
			sq->next = calloc(1, sizeof *sq);
			sq = sq->next;
		}
	}
	return th;
error:
	umr_free_test_harness(th);
	return NULL;
}

struct umr_test_harness *umr_create_test_harness_file(const char *fname)
{
	const char *script;
	int fd;
	off_t size;
	struct umr_test_harness *th;

	fd = open(fname, O_RDONLY);
	size = lseek(fd, 0, SEEK_END);
	lseek(fd, 0, SEEK_SET);
	script = calloc(1, size + 1);
	read(fd, (char*)script, size);
	close(fd);

	th = umr_create_test_harness(script);
	free((void*)script);
	return th;
}

static int access_sram(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en)
{
	struct umr_test_harness *th = asic->mem_funcs.data;
	struct umr_ram_blocks *rb = &th->sysram;

	// try to find first block that covers the range
	while (rb) {
		if (rb->base_address <= address &&
			(rb->base_address >= (address + size))) {
				if (!write_en)
					memcpy(dst, &rb->contents[address - rb->base_address], size);
				else
					memcpy(&rb->contents[address - rb->base_address], dst, size);
				return 0;
			}
		rb = rb->next;
	}
	fprintf(stderr, "[ERROR]: System address 0x%"PRIx64 " not found in test harness\n", address);
	return -1;
}

static int access_linear_vram(struct umr_asic *asic, uint64_t address, uint32_t size, void *data, int write_en)
{
	struct umr_test_harness *th = asic->mem_funcs.data;
	struct umr_ram_blocks *rb = &th->vram;

	// try to find first block that covers the range
	while (rb) {
		if (rb->base_address <= address &&
			((rb->base_address + rb->size) >= (address + size))) {
				if (!write_en)
					memcpy(data, &rb->contents[address - rb->base_address], size);
				else
					memcpy(&rb->contents[address - rb->base_address], data, size);
				return 0;
			}
		rb = rb->next;
	}
	fprintf(stderr, "[ERROR]: VRAM address 0x%"PRIx64 " not found in test harness\n", address);
	return -1;
}

static uint64_t gpu_bus_to_cpu_address(struct umr_asic *asic, uint64_t dma_addr)
{
	(void)asic;
	return dma_addr;
}

static uint32_t read_reg(struct umr_asic *asic, uint64_t addr, enum regclass type)
{
	struct umr_test_harness *th = asic->reg_funcs.data;
	struct umr_sq_blocks *sq;
	struct umr_mmio_blocks *mm;
	uint32_t v;
	uint64_t qaddr;

	// 'addr' is a byte address of the register but the database
	// is stored in DWORD addresses
	qaddr = addr >> 2;

	if (type != REG_MMIO)
		return 0xDEADBEEF;

	// are we reading from SQ_IND_DATA or MM_DATA?
	if (qaddr == umr_find_reg(asic, "mmSQ_IND_DATA")) {
		// find in SQ list
		sq = &th->sq;
		while (sq) {
			if (sq->sq_address == th->sq_ind_index) {
				v = sq->values[sq->cur_slot];
				if (sq->cur_slot < (sq->no_values - 1))
					++(sq->cur_slot);
				return v;
			}
			sq = sq->next;
		}
		return 0xDEADBEEF;
	} else if (qaddr == umr_find_reg(asic, "mmSQ_IND_INDEX")) {
		return th->sq_ind_index;
	} else if (qaddr == umr_find_reg(asic, "@mmMM_DATA") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_DATA")) {
		fprintf(stderr, "MM_DATA!\n");
		// read from VRAM
		if (th->vram_mm_index & (1ULL << 31)) {
			uint64_t addr;
			addr = (th->vram_mm_index & 0x7FFFFFFFULL) | ((th->vram_mm_index & 0xFFFFFFFF00000000ULL) >> 1);
			if (!access_linear_vram(asic, addr, 4, &v, 0)) {
				return v;
			} else {
				fprintf(stderr, "[ERROR]: Access to missing VRAM block via MMIO method\n");
				return 0;
			}
		} else {
			fprintf(stderr, "[ERROR]: MM_INDEX must have 32nd bit set\n");
			return 0;
		}
	} else if (qaddr == umr_find_reg(asic, "@mmMM_INDEX") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX")) {
		return th->vram_mm_index & 0xFFFFFFFFULL;
	} else if (qaddr == umr_find_reg(asic, "@mmMM_INDEX_HI") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX_HI")) {
		return th->vram_mm_index >> 32;
	} else {
		// read from MMIO list
		mm = &th->mmio;
		while (mm) {
			if (mm->mmio_address == addr) {
				v = mm->values[mm->cur_slot];
				if (mm->cur_slot < (mm->no_values - 1))
					++(mm->cur_slot);
				return v;
			}
			mm = mm->next;
		}
		return 0xDEADBEEF;
	}
}

static int write_reg(struct umr_asic *asic, uint64_t addr, uint32_t value, enum regclass type)
{
	struct umr_test_harness *th = asic->reg_funcs.data;
	struct umr_mmio_blocks *mm;
	uint64_t qaddr;

	// 'addr' is a byte address of the register but the database
	// is stored in DWORD addresses
	qaddr = addr >> 2;

	if (type != REG_MMIO)
		return -1;

	// are we reading from SQ_IND_DATA or MM_DATA?
	if (qaddr == umr_find_reg(asic, "mmSQ_IND_DATA")) {
		// don't allow writing to SQ_IND_DATA
		return -1;
	} else if (qaddr == umr_find_reg(asic, "mmSQ_IND_INDEX")) {
		th->sq_ind_index = value;
		return 0;
	} else if (qaddr == umr_find_reg(asic, "@mmMM_DATA") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_DATA")) {
		// write to VRAM
		if (th->vram_mm_index & (1ULL << 31)) {
			uint64_t addr;
			addr = (th->vram_mm_index & 0x7FFFFFFFULL) | ((th->vram_mm_index & 0xFFFFFFFF00000000ULL) >> 1);
			if (!access_linear_vram(asic, addr, 4, &value, 1)) {
				return 0;
			} else {
				fprintf(stderr, "[ERROR]: Access to missing VRAM block via MMIO method\n");
				return -1;
			}
		} else {
			fprintf(stderr, "[ERROR]: MM_INDEX must have 32nd bit set\n");
			return -1;
		}
	} else if (qaddr == umr_find_reg(asic, "@mmMM_INDEX") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX")) {
		th->vram_mm_index = (th->vram_mm_index & 0xFFFFFFFF00000000ULL) | value;
		return 0;
	} else if (qaddr == umr_find_reg(asic, "@mmMM_INDEX_HI") ||
			   qaddr == umr_find_reg(asic, "@mmBIF_BX_PF_MM_INDEX_HI")) {
		th->vram_mm_index = (th->vram_mm_index & 0xFFFFFFFFULL) | ((uint64_t)value << 32);
		return 0;
	} else {
		// write to MMIO
		mm = &th->mmio;
		while (mm) {
			if (mm->mmio_address == addr) {
				mm->values[mm->cur_slot] = value;
				return 0;
			}
			mm = mm->next;
		}
		return -1;
	}
}

void umr_attach_test_harness(struct umr_test_harness *th, struct umr_asic *asic)
{
	asic->mem_funcs.access_linear_vram = access_linear_vram;
	asic->mem_funcs.access_sram = access_sram;
	asic->mem_funcs.gpu_bus_to_cpu_address = gpu_bus_to_cpu_address;
	asic->mem_funcs.data = th;

	asic->reg_funcs.read_reg = read_reg;
	asic->reg_funcs.write_reg = write_reg;
	asic->reg_funcs.data = th;

	th->asic = asic;
}
