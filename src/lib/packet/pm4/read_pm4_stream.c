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
#include <stdbool.h>

#include "umr.h"

#define BITS(x, a, b) (unsigned long)((x >> (a)) & ((1ULL << ((b)-(a)))-1))

/**
 * fetch_word - Safely fetch a word from a packet stream with bounds checking
 *
 * @asic: The ASIC the stream is bound to
 * @stream: The stream packet you want to fetch a word from
 * @off: The offset (in words) of the word to read from the packet
 *
 */
static uint32_t fetch_word(struct umr_asic *asic, struct umr_pm4_stream *stream, uint32_t off)
{
	if (off >= stream->n_words) {
		if (!(stream->invalid))
			asic->err_msg("[ERROR]: PM4 decoding of opcode (%"PRIx32") went out of bounds.\n", stream->opcode);
		stream->invalid = 1;
		return 0;
	} else {
		return stream->words[off];
	}
}

static int reg_sort(const void *a, const void *b)
{
	const struct umr_shader_reg_pair *A = a, *B = b;
	return strcmp(A->regname, B->regname);
}

/**
 * umr_copy_regpairs - Create a distinct copy of a register pair linked list
 *
 * @head: The register pair linked list to clone
 *
 * Returns a pointer to a copy of the linked list in the form of a sorted array.
 * While this function does setup the 'next' pointer the returned pointer is itself
 * a heap pointer to an array so it should be freed instead of walking the list.
 */
struct umr_shader_reg_pair *umr_copy_regpairs(struct umr_shader_reg_pair *head)
{
	struct umr_shader_reg_pair *copy, *tmp;
	uint32_t x, count;

	// count the # of entries in the list
	tmp = head;
	count = 0;
	while (tmp) {
		++count;
		tmp = tmp->next;
	}

	if (count) {
		// allocate an array and copy the list into it
		copy = calloc(count, sizeof *head);
		tmp = head;
		count = 0;
		while (tmp) {
			copy[count] = *tmp;
			tmp = tmp->next;
			++count;
		}

		// sort the array by register name
		qsort(copy, count, sizeof(*copy), reg_sort);

		// re-attach the next pointers so other parts of the library can just walk the list
		for (x = 0; x < (count-1); x++) {
			copy[x].next = &copy[x+1];
		}
		copy[count-1].next = NULL;
		return copy;
	} else {
		return NULL;
	}
}

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
	struct umr_pm4_stream *ps,
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

	pgm->pm4_packet = ps;
	pgm->vmid = vmid;
	pgm->addr = shader_addr;
	if (!asic->options.no_follow_shader)
		pgm->size = umr_compute_shader_size(asic, vm_partition, pgm);
	else
		pgm->size = 1;
	pgm->type = type;
	pgm->regs = umr_copy_regpairs(reg_pairs);
}

/**
 * umr_shader_find_regpair - Find an exact match in the linked list
 *
 * @head: The register writes linked list to search
 * @regname: The name of the register to look for
 */
struct umr_shader_reg_pair *umr_shader_find_regpair(struct umr_shader_reg_pair *head, const char *regname)
{
	while (head) {
		if (!strcmp(head->regname, regname)) {
			return head;
		}
		head = head->next;
	}
	return NULL;
}

/**
 * umr_shader_find_partial_regpair - Find the first partial match in the linked list
 *
 * @head: The register writes linked list to search
 * @regname: The name of the register to look for
 */
struct umr_shader_reg_pair *umr_shader_find_partial_regpair(struct umr_shader_reg_pair *head, const char *regname)
{
	while (head) {
		if (strstr(head->regname, regname)) {
			return head;
		}
		head = head->next;
	}
	return NULL;
}

/**
 * umr_free_shader_reg_pairs - free the linked list of shader pairs
 *
 * @regs: The linked list to free
 *
 * Note: This is not to free the regs attached to a shader_pgm (just use free() on that)
 */
void umr_free_shader_reg_pairs(struct umr_shader_reg_pair *regs)
{
	while (regs) {
		struct umr_shader_reg_pair *next = regs->next;
		free(regs);
		regs = next;
	}
}

/**
 * umr_shader_add_reg_pair - Add a register and value pair to the linked list
 *
 * @head: The head of the linked list.
 * @regname: The name of the register to add
 * @value: The 32-bit value of this register
 * @ib_vmid: The VMID of the IB containing this register write
 * @ib_addr: The address from the start of the IB of this register write
 */
void umr_shader_add_reg_pair(struct umr_shader_reg_pair **head, const char *regname, uint32_t value, uint32_t ib_vmid, uint64_t ib_addr)
{
	struct umr_shader_reg_pair *reg_pair;

	if (*head == NULL) {
		// add to the head of the list
		*head = calloc(1, sizeof(**head));
		if (!*head) {
			return;
		}
		reg_pair = *head;
	} else {
		// see if this register was written to earlier
		reg_pair = umr_shader_find_regpair(*head, regname);

		if (!reg_pair) {
			// if not seek to the end of the list
			reg_pair = *head;
			while (reg_pair->next) {
				reg_pair = reg_pair->next;
			}
			reg_pair->next = calloc(1, sizeof(*reg_pair));
			if (!reg_pair->next) {
				return;
			}
			reg_pair = reg_pair->next;
		}
	}
	snprintf(reg_pair->regname, sizeof(reg_pair->regname), "%s", regname);
	reg_pair->value = value;
	reg_pair->vmid = ib_vmid;
	reg_pair->addr = ib_addr;
	reg_pair->used = 0;
}

/**
 * process_shaders - Process register pairs looking for configured shaders
 *
 * @asic: The ASIC the shaders are bound to
 * @vm_partition: The GC core these are running on
 * @vmid: The VMID of the shader program
 * @ps: The packet the shaders should be attached to
 * @reg_pairs: The populated linked list of register writes
 * @compute_jobs: If 1 then only add compute shaders, otherwise add GFX shaders
 */
static void process_shaders(struct umr_asic *asic, int vm_partition, uint32_t vmid,
	struct umr_pm4_stream *ps, struct umr_shader_reg_pair *reg_pairs,
	int compute_jobs)
{
	struct {
		char *hi, *lo;
		int type;
		char *bitname;
		int gfx_max, gfx_min;  // highest and lowest gfx versions that have these bits
	} types[] = {
		{ "COMPUTE_PGM_HI", "COMPUTE_PGM_LO", UMR_SHADER_COMPUTE, NULL, 12, 0 },
		{ "SPI_SHADER_PGM_HI_VS", "SPI_SHADER_PGM_LO_VS", UMR_SHADER_VERTEX, "VS_EN", 11, 0 },
		{ "SPI_SHADER_PGM_HI_PS", "SPI_SHADER_PGM_LO_PS", UMR_SHADER_PIXEL, NULL, 12, 0 },
		{ "SPI_SHADER_PGM_HI_ES", "SPI_SHADER_PGM_LO_ES", UMR_SHADER_ES, "ES_EN", 11, 0 },
		{ "SPI_SHADER_PGM_HI_GS", "SPI_SHADER_PGM_LO_GS", UMR_SHADER_GS, "GS_EN", 12, 0 },
		{ "SPI_SHADER_PGM_HI_HS", "SPI_SHADER_PGM_LO_HS", UMR_SHADER_HS, "HS_EN", 12, 0 },
		{ "SPI_SHADER_PGM_HI_LS", "SPI_SHADER_PGM_LO_LS", UMR_SHADER_LS, "LS_EN", 11, 0 },
		{ NULL, NULL, -1, NULL, 0, 0 },
	};
	int x;
#if 0
	struct umr_shader_reg_pair *stages = umr_shader_find_partial_regpair(reg_pairs, "VGT_SHADER_STAGES_EN");
	struct umr_reg *stage_reg = NULL;
	int gfx_maj = 0, gfx_min = 0;

	if (stages) {
		// SHADER_STAGES was programmed so let's setup to process it
		stage_reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, strstr(stages->regname, ".") + 1);
		// we'll need to track which gfx version we are since bits come and go
		umr_gfx_get_ip_ver(asic, &gfx_maj, &gfx_min);
	}
#endif

	// process jobs we're either just doing compute or we're doing draws
	for (x = compute_jobs ? 0 : 1; (compute_jobs && x < 1) || (!compute_jobs && types[x].hi != NULL); x++) {
		struct umr_shader_reg_pair *hi, *lo;

		// filter out shaders that are not wanted
		if (types[x].type == UMR_SHADER_COMPUTE && !asic->options.shader_enable.enable_comp_shader)
			continue;
		if (types[x].type == UMR_SHADER_VERTEX && !asic->options.shader_enable.enable_vs_shader)
			continue;
		if (types[x].type == UMR_SHADER_PIXEL && !asic->options.shader_enable.enable_ps_shader)
			continue;
		if (types[x].type == UMR_SHADER_ES && !asic->options.shader_enable.enable_es_shader)
			continue;
		if (types[x].type == UMR_SHADER_GS && !asic->options.shader_enable.enable_gs_shader)
			continue;
		if (types[x].type == UMR_SHADER_HS && !asic->options.shader_enable.enable_hs_shader)
			continue;
		if (types[x].type == UMR_SHADER_LS && !asic->options.shader_enable.enable_ls_shader)
			continue;

		// try to find programming the top and bottom halfs
		hi = umr_shader_find_partial_regpair(reg_pairs, types[x].hi);
		lo = umr_shader_find_partial_regpair(reg_pairs, types[x].lo);
		if (hi && lo) {
			if (hi->value || lo->value) {
#if 0
// TODO: sort out what to do with SHADER_STAGES register...
			if (stages && stage_reg) {
					if (types[x].bitname && (gfx_maj <= types[x].gfx_max) && (gfx_maj >= types[x].gfx_min)) {
						uint64_t b = umr_bitslice_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
							strstr(stages->regname, ".") + 1, types[x].bitname, stages->value);
						if (!b) {
							asic->err_msg("[ERROR]: Shader (%s) programmed but not enabled in VGT_SHADER_STAGES_EN\n", types[x].bitname);
						}
					}
				}
#endif
				hi->used = 1;
				lo->used = 1;
				// we found both addresses so let's add this shader
				uint64_t addr = (((uint64_t)hi->value) << 40) | (((uint64_t)lo->value) << 8);
				add_shader(asic, ps, vmid, addr, vm_partition, types[x].type, reg_pairs);				
			}
		}
	}
}

/**
 * parse_pm4 - Parse a PM4 packet looking for pointers to shaders or IBs
 *
 * @vm_partition: What VM partition does it come from (-1 is default)
 * @vmid:  The known VMID this packet belongs to (or 0 if from a ring)
 * @ib_addr: The address of the IB
 * @ps: The PM4 packet to parse
 * @reg_pairs: The linked list of register writes accumulated so far.
 *
 */
static void parse_pm4(struct umr_asic *asic, int vm_partition, uint32_t vmid, uint64_t ib_addr, struct umr_pm4_stream *ps, struct umr_shader_reg_pair **reg_pairs, int32_t ip_version)
{
	uint32_t n, value;
	char *regname = NULL;

	switch (ps->opcode) {
		// these packets actually schedule shaders so this is where we process registers to see what
		// shaders were programmed
		case 0x15: // DISPATCH_DIRECT
		case 0x16: // DISPATCH_INDIRECT
		case 0xA7: // DISPATCH_DIRECT_INTERLEAVED
		case 0xAA: // DISPATCH_TASKMESH_DIRECT_ACE
		case 0xAD: // DISPATCH_TASKMESH_INDIRECT_MULTI_ACE
			process_shaders(asic, vm_partition, vmid, ps, *reg_pairs, 1); // <-- COMPUTE jobs
			break;
		case 0x4C: // DISPATCH_MESH_INDIRECT_MULTI
		case 0x4D: // DISPATCH_TASKMESH_GFX
		case 0x25: // DRAW_INDEX_INDIRECT
		case 0x27: // DRAW_INDEX_2
		case 0x2D: // DRAW_INDEX_AUTO
		case 0x38: // DRAW_INDEX_INDIRECT_MULTI
			process_shaders(asic, vm_partition, vmid, ps, *reg_pairs, 0); // <-- GFX jobs
			break;
		case 0x69: // SET_CONTEXT_REG
		{
			uint64_t addr = BITS(fetch_word(asic, ps, 0), 0, 16) + 0xA000;
			ib_addr += 4;
			for (n = 1; n < ps->n_words; n++) {
				regname = umr_reg_name(asic, addr);
				value = fetch_word(asic, ps, n);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				++addr;
				ib_addr += 4;
			}
			break;
		}
		case 0x79: // SET_UCONFIG_REG
		{
			uint64_t addr = BITS(fetch_word(asic, ps, 0), 0, 16) + 0xC000;
			ib_addr += 4;
			for (n = 1; n < ps->n_words; n++) {
				regname = umr_reg_name(asic, addr);
				value = fetch_word(asic, ps, n);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				++addr;
				ib_addr += 4;
			}
			break;
		}
		case 0xB8: // SET_CONTEXT_REG_PAIRS
		{
			for (n = 0; n < ps->n_words; n += 2) {
				// handle both register writes per doublet
				regname = umr_reg_name(asic, 0xA000 + BITS(fetch_word(asic, ps, n), 0, 16));
				value = fetch_word(asic, ps, n + 1);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				ib_addr += 8;
			}
			break;
		}
		case 0xBA: // SET_SH_REG_PAIRS
		{
			for (n = 0; n < ps->n_words; n += 2) {
				// handle both register writes per doublet
				regname = umr_reg_name(asic, 0x2C00 + BITS(fetch_word(asic, ps, n), 0, 16));
				value = fetch_word(asic, ps, n + 1);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				ib_addr += 8;
			}
			break;
		}
		case 0xBB:
		case 0xBC:
		case 0xBD: // SET_SH_REG_PAIRS_PACKED(_N)
		{
			// 0'th word is just the number of pairs, which we infer from the length of the packet
			ib_addr += 4;
			for (n = 1; n < ps->n_words; n += 3) {
				uint32_t m;
				// handle both register writes per triplet
				ib_addr += 4;
				for (m = 0; m < 2; m++) {
					regname = umr_reg_name(asic, 0x2C00 + BITS(fetch_word(asic, ps, n), (16 * m), (16 * (m + 1))));
					value = fetch_word(asic, ps, n + m + 1);
					umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
					ib_addr += 4;
				}
			}
			break;
		}
		case 0xBE: // SET_UCONFIG_REG_PAIRS
		{
			for (n = 0; n < ps->n_words; n += 2) {
				// handle both register writes per doublet
				regname = umr_reg_name(asic, 0xC000 + BITS(fetch_word(asic, ps, n), 0, 16));
				value = fetch_word(asic, ps, n + 1);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				ib_addr += 8;
			}
			break;
		}
		case 0x76: // SET_SH_REG (looking for writes to shader registers);
		case 0x9B: // SET_SH_REG_INDEX
		{
			uint32_t reg_addr = BITS(fetch_word(asic, ps, 0), 0, 16) + 0x2C00;
			ib_addr += 4;
			for (n = 1; n < ps->n_words; n++) {
				regname = umr_reg_name(asic, reg_addr + n - 1);
				value = fetch_word(asic, ps, n);
				umr_shader_add_reg_pair(reg_pairs, regname, value, vmid, ib_addr);
				ib_addr += 4;
			}
			break;
		}
		case 0x3f: // INDIRECT_BUFFER_CIK
		case 0x33: // INDIRECT_BUFFER_CONST
		{
			// Check chain bit to dump chained IBs for INDIRECT_BUFFER and INDIRECT_BUFFER_CONST
			bool follow_chained_ib = !asic->options.no_follow_chained_ib && ps->n_words == 3 ?
									BITS(fetch_word(asic, ps, 2), 20, 21) : false;
			if (!asic->options.no_follow_ib || follow_chained_ib) {
				uint64_t ib_addr;
				uint32_t tvmid, size;
				void *buf;
				ib_addr = (fetch_word(asic, ps, 0) & ~3ULL) | ((uint64_t)(fetch_word(asic, ps, 1) & 0xFFFF) << 32);

				// abort if the IB is >8 MB in size which is very likely just garbage data
				size = (fetch_word(asic, ps, 2) & ((1UL << 20) - 1)) * 4;
				if (size > (1024UL * 1024UL * 8UL))
					break;

				tvmid = (fetch_word(asic, ps, 2) >> 24) & 0xF;
				if (!tvmid)
					tvmid = vmid;
				buf = calloc(1, size);
				if (umr_read_vram(asic, vm_partition, tvmid, ib_addr, size, buf) < 0) {
					asic->err_msg("[ERROR]: Could not read IB at 0x%"PRIx32":0x%" PRIx64 "\n", tvmid, ib_addr);
				} else {
					ps->ib = umr_pm4_decode_stream(asic, vm_partition, tvmid, ib_addr, buf, size / 4, reg_pairs, ip_version);
					ps->ib->parent = ps;
					ps->ib_source.addr = ib_addr;
					ps->ib_source.vmid = tvmid;
				}
				free(buf);
			}
			break;
		}
	}
}

/**
 * umr_find_shader_in_pm4_stream - Find a shader in a PM4 stream
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
struct umr_shaders_pgm *umr_find_shader_in_pm4_stream(struct umr_asic *asic, struct umr_pm4_stream *stream, unsigned vmid, uint64_t addr)
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

		// recurse into IBs if any
		if (stream->ib) {
			p = umr_find_shader_in_pm4_stream(asic, stream->ib, vmid, addr);
			if (p)
				return p;
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

/**
 * umr_free_pm4_stream - Free a PM4 stream object
 */
void umr_free_pm4_stream(struct umr_pm4_stream *stream)
{
	while (stream) {
		struct umr_pm4_stream *n;
		n = stream->next;
		if (stream->ib)
			umr_free_pm4_stream(stream->ib);
		if (stream->shader) {
			struct umr_shaders_pgm *pgmnext, *pgm = stream->shader;
			while (pgm) {
				pgmnext = pgm->next;
				free(pgm->regs);
				free(pgm);
				pgm = pgmnext;
			}
		}
		free(stream->words);
		free(stream);
		stream = n;
	}
}

/**
 * umr_pm4_decode_stream - Decode an array of PM4 packets into a PM4 stream
 *
 * @vm_partition: What VM partition does it come from (-1 is default)
 * @vmid:  The VMID (or zero) that this array comes from (if say an IB)
 * @from_addr: The address in the VMID where the stream came from.
 * @stream: An array of DWORDS which contain the PM4 packets
 * @nwords:  The number of words in the stream
 *
 * Returns a PM4 stream if successfully decoded.
 */
struct umr_pm4_stream *umr_pm4_decode_stream(struct umr_asic *asic, int vm_partition, uint32_t vmid, uint64_t from_addr, uint32_t *stream, uint32_t nwords, struct umr_shader_reg_pair **reg_head, int32_t ip_version)
{
	struct umr_pm4_stream *ops, *ps, *prev_ps = NULL;
	uint64_t ib_addr = from_addr;
	struct {
		int n;
		uint32_t
			size,
			vmid;
		uint64_t
			addr;
	} uvd_ib;
	struct umr_shader_reg_pair *local_pairs = NULL;
	(void)ip_version;
	// if the caller passed in NULL then just initialize a local set of register pairs
	if (reg_head == NULL) {
		reg_head = &local_pairs;
	}

	ps = ops = calloc(1, sizeof *ops);
	if (!ps) {
		asic->err_msg("[ERROR]: Out of memory\n");
		return NULL;
	}

	memset(&uvd_ib, 0, sizeof uvd_ib);

	while (nwords) {
		// fetch basics out of header
		ps->header = *stream;
		ps->pkttype = *stream >> 30;
		ps->n_words = ((*stream >> 16) + 1) & 0x3FFF;
		ps->ib_offset = ib_addr;
		ps->prev = prev_ps;

		// grab type specific header data
		if (ps->pkttype == 0)
			ps->pkt0off = *stream & 0xFFFF;
		else if (ps->pkttype == 2)
			--(ps->n_words);
		else if (ps->pkttype == 3)
			ps->opcode = (*stream >> 8) & 0xFF;

		if (nwords < 1 + ps->n_words) {
			// if not enough words to fill packet, stop and set current packet to null
			free(ps);
			if (prev_ps) {
				prev_ps->next = NULL;
			} else {
				ops = NULL;
			}
			return ops;
		} 

		// grab rest of words
		if (ps->n_words) {
			ps->words = calloc(ps->n_words, sizeof(ps->words[0]));
			memcpy(ps->words, &stream[1], ps->n_words * sizeof(stream[0]));
		}

		// decode specific packets
		if (ps->pkttype == 3) {
			parse_pm4(asic, vm_partition, vmid, ib_addr + 4, ps, reg_head, ip_version); // +4 is to skip the PM4 header
		} else if (ps->pkttype == 0) {
			char *name;
			name = umr_reg_name(asic, ps->pkt0off);

			// look for UVD IBs which are marked by 3-4 distinct
			// register writes.  They can occur in any order
			// except for the SIZE so we use a bitfield to keep
			// track of them
			if (strstr(name, "mmUVD_LMI_RBC_IB_VMID")) {
				uvd_ib.vmid = fetch_word(asic, ps, 0) | ((asic->family <= FAMILY_VI) ? 0 : UMR_MM_HUB);
				uvd_ib.n |= 1;
			} else if (strstr(name, "mmUVD_LMI_RBC_IB_64BIT_BAR_LOW")) {
				uvd_ib.addr |= fetch_word(asic, ps, 0);
				uvd_ib.n |= 2;
			} else if (strstr(name, "mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH")) {
				uvd_ib.addr |= (uint64_t)fetch_word(asic, ps, 0) << 32;
				uvd_ib.n |= 4;
			} else if (strstr(name, "mmUVD_RBC_IB_SIZE")) {
				uvd_ib.size = fetch_word(asic, ps, 0) * 4;
				uvd_ib.n |= 8;
			}

			// if we have everything but the VMID assume vmid 0
			if (uvd_ib.n == (2|4|8)) {
				uvd_ib.vmid = 0;
				uvd_ib.n = 15;
			}

			// we have everything we need to point to an IB
			if (!asic->options.no_follow_ib && uvd_ib.n == 15) {
				void *buf;
				buf = calloc(1, uvd_ib.size);
				if (umr_read_vram(asic, vm_partition, uvd_ib.vmid, uvd_ib.addr, uvd_ib.size, buf) < 0) {
					asic->err_msg("[ERROR]: Could not read IB at 0x%"PRIx32":0x%" PRIx64 "\n", uvd_ib.vmid, uvd_ib.addr);
				} else {
					ps->ib = umr_pm4_decode_stream(asic, vm_partition, uvd_ib.vmid, uvd_ib.addr, buf, uvd_ib.size / 4, reg_head, ip_version);
					ps->ib->parent = ps;
					ps->ib_source.addr = uvd_ib.addr;
					ps->ib_source.vmid = uvd_ib.vmid;
				}
				free(buf);
				memset(&uvd_ib, 0, sizeof uvd_ib);
			}
		}

		// advance stream
		nwords -= 1 + ps->n_words;
		stream += 1 + ps->n_words;
		ib_addr += 4 * (1 + ps->n_words);
		if (nwords) {
			ps->next = calloc(1, sizeof(*ps));
			prev_ps = ps;
			ps = ps->next;
		}
	}

	// if we created the list locally free the linked list of register writes
	while (local_pairs) {
		struct umr_shader_reg_pair *next = local_pairs->next;
		free(local_pairs);
		local_pairs = next;
	}

	return ops;
}