/*
 * Copyright (c) 2026 Advanced Micro Devices, Inc.
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
 */
#include "umr.h"
#include <stdbool.h>
#include <assert.h>
#include <ctype.h>

static char **parse_lines(char *content, size_t len, unsigned *line_count) {
	unsigned n_lines = 0, max_lines = 0;
	char **lines = NULL, *line, *nextline;

	*line_count = 0;

	if (content == NULL)
		return NULL;

	line = content;

	/* Same as strtok but keep empty lines. */
	while (line) {
		while (*line == ' ' || *line == '\t')
			line++;

		nextline = memchr(line, '\n', len - (line - content));
		if (nextline)
			*nextline = '\0';

		if (n_lines == max_lines) {
			max_lines = max_lines ? (max_lines * 2) : 16;
			lines = realloc(lines, max_lines * sizeof(*lines));
		}
		lines[n_lines++] = line;
		line = nextline ? nextline + 1 : NULL;
	}

	*line_count = n_lines;

	return lines;
}

static long umr_read_did_from_devcoredump(char **lines, size_t n_lines)
{
	const char *did_prefix = "SOC Device id: ";
	size_t len = strlen(did_prefix);
	for (size_t i = 0; i < n_lines; i++) {
		if (strncmp(lines[i], did_prefix, len)== 0) {
			return strtol(lines[i] + len, NULL, 10);
		}
	}
	return -1;
}

static int umr_parse_devcoredump_memory(struct umr_asic *asic, size_t n)
{
	char **lines = &asic->options.devcoredump.data[n];
	const char *titles[] = {
		"real vram size: ", "visible vram size: ", "gtt size: "
	};
	uint64_t *dst[] = {
		&asic->config.vram_size, &asic->config.vis_vram_size, &asic->config.gtt_size
	};

	if (n + ARRAY_SIZE(titles) > asic->options.devcoredump.n_lines)
		return -1;

	for (int i = 0; i < (int)ARRAY_SIZE(titles); i++) {
		size_t len = strlen(titles[i]);
		if (strncmp(lines[i], titles[i], len) == 0) {
			*(dst[i]) = strtoll(lines[i] + len, NULL, 10);
		} else {
			return -1;
		}
	}
	return n + ARRAY_SIZE(titles);
}

static int umr_parse_devcoredump_firmwares(struct umr_asic *asic, size_t n)
{
	char **lines = asic->options.devcoredump.data;
	int i, n_fw = 0;
	for (i = n; i < (int) asic->options.devcoredump.n_lines; i++) {
		char *line = lines[i];

		if (*line == '\0')
			break;

		char *feat = strstr(line, "feature version: ");
		if (feat == NULL)
			return -1;
		strncpy(asic->config.fw[n_fw].name, line, feat - line - 1);
		line = feat + strlen("feature version: ");
		if (sscanf(line, "0x%x, fw version: 0x%08x",
				   &asic->config.fw[n_fw].feature_version,
				   &asic->config.fw[n_fw].firmware_version) == 2 ||
			sscanf(line, "%u, fw version: 0x%08x",
				   &asic->config.fw[n_fw].feature_version,
				   &asic->config.fw[n_fw].firmware_version) == 2 ||
			sscanf(line, "%u, firmware version: 0x%08x",
				   &asic->config.fw[n_fw].feature_version,
				   &asic->config.fw[n_fw].firmware_version) == 2) {
			n_fw += 1;
		}
	}

	return i;
}

static int umr_parse_devcoredump_ip_dump(struct umr_asic *asic, size_t n)
{
	char **lines = asic->options.devcoredump.data;
	int max_registers, no_registers;
	int me, pipe, queue, instance, num_inst, lookup_instance, i;
	struct devcoredump_reg *registers = NULL;
	char *version, *ip_blk, *line;
	char *regname, *regvalue, *inst;
	struct umr_reg *reg;

	const char *ip_prefix = "IP: ";

	max_registers = no_registers = 0;

	for (i = n; i < (int) asic->options.devcoredump.n_lines; i++) {
		line = lines[i];

		if (*line == '\0')
			break;

		if (strncmp(line, ip_prefix, strlen(ip_prefix)))
			goto error;

		line += strlen(ip_prefix);
		ip_blk = line;
		version = strstr(line, "_v");
		if (version == NULL)
			goto error;

		me = pipe = queue = instance = 0;

		for (i = i + 1; i < (int) asic->options.devcoredump.n_lines; i++) {
			line = lines[i];

			/* This is a register value. */
			if (memcmp(line, "reg", 3) == 0 || memcmp(line, "mm", 2) == 0) {
				regname = strtok(line, " ");
				regvalue = strtok(NULL, " ");
				regvalue = strtok(NULL, " ");
				if (!regname || !regvalue)
					goto error;

				if (instance == 0) {
					lookup_instance = -2;
				} else if ((inst = strstr(regname, "0_"))) {
					*inst += instance;
					lookup_instance = -2;
				} else {
					lookup_instance = instance;
				}

				/* Filter out invalid registers. */
				if (!strcmp(regname, "regGRBM_STATUS2") && !strncmp(ip_blk, "sdma_", 5))
					continue;

				reg = umr_find_reg_data_by_ip_by_instance(asic, NULL, lookup_instance, regname);

				if (reg) {
					if (no_registers == max_registers) {
						max_registers = max_registers ? (max_registers * 2) : 64;
						registers = realloc(registers, max_registers * sizeof(*registers));
						if (!registers)
							goto error;
					}

					/* Remember this value. */
					registers[no_registers].addr = reg->addr;
					registers[no_registers].instance = lookup_instance;
					registers[no_registers].me = me;
					registers[no_registers].pipe = pipe;
					registers[no_registers].queue = queue;
					registers[no_registers].value = strtol(regvalue, NULL, 16);

					no_registers++;
				}
			} else if (sscanf(line, "Instance:%d", &instance) == 1 ||
					   sscanf(line, "num_instances:%d", &num_inst) == 1) {
				/* good. */
			} else if (sscanf(line, "Active Instance:VCN%d", &instance) == 1 ||
					   sscanf(line, "Active Instance:JPEG%d", &instance) == 1) {
				/* good */
			} else if (sscanf(line, "me %d, pipe %d, queue %d", &me, &pipe, &queue) == 3) {
				/* good. */
			} else if (sscanf(line, "mec %d, pipe %d, queue %d", &me, &pipe, &queue) == 3) {
				/* good. */
			} else if (memcmp(line, ip_prefix, strlen(ip_prefix)) == 0) {
				i--;
				break;
			} else if (strcmp(line, "Ring buffer information") == 0) {
				i--;
				goto out;
			} else {
				/* ignore other lines. */
			}
		}
	}

out:
	asic->options.devcoredump.registers = registers;
	asic->options.devcoredump.no_registers = no_registers;

	return i;
error:
	free(registers);
	return -1;
}

static int umr_parse_devcoredump_rings(struct umr_asic *asic, size_t n)
{
	char **lines = asic->options.devcoredump.data;
	char *line;
	struct umr_devcoredump_ring_data *ring;
	uint32_t off, value, j;
	int i, parser_state;

	const char *ring_prefix = "ring name: ";

	parser_state = -1;

	for (i = n; i < (int) asic->options.devcoredump.n_lines; i++) {
		line = lines[i];

		if (parser_state == -1) {
			if (strncmp(line, ring_prefix, strlen(ring_prefix)))
				break;

			line += strlen(ring_prefix);
			asic->options.devcoredump.no_ring_dumps += 1;
			asic->options.devcoredump.ring_dumps =
				realloc(asic->options.devcoredump.ring_dumps,
						sizeof(struct umr_devcoredump_ring_data) * asic->options.devcoredump.no_ring_dumps);
			if (!asic->options.devcoredump.ring_dumps)
				goto error;
			ring = &asic->options.devcoredump.ring_dumps[asic->options.devcoredump.no_ring_dumps - 1];
			memset(ring, 0, sizeof(*ring));
			strncpy(ring->ring_name, line, sizeof(ring->ring_name) - 1);
			parser_state = 0;
		} else if (parser_state == 0) {
			if (sscanf(line, "Rptr: 0x%x Wptr: 0x%x", &ring->rptr, &ring->wptr) == 2)
				parser_state = 1;
			else
				goto error;
		} else if (parser_state == 1) {
			if (sscanf(line, "Ring size in dwords: %u", &ring->size) == 1) {
				parser_state = 2;
				ring->data = malloc(ring->size * sizeof(uint32_t));
				if (!ring->data)
					goto error;
			} else {
				goto error;
			}
		} else if (parser_state == 2) {
			if (strcmp(line, "Ring contents") == 0)
				parser_state = 2;
			else if (strstr(line, "Offset") && strstr(line, "Value"))
				parser_state = 3;
			else
				goto error;
		} else if (parser_state == 3) {
			if (i + ring->size > asic->options.devcoredump.n_lines)
				goto error;
			for (j = 0; j < ring->size; j++) {
				if (sscanf(lines[i + j], "0x%x 0x%x", &off, &value) == 2) {
					if (off == j * 4)
						ring->data[j] = value;
				} else {
					goto error;
				}
			}
			i = i + ring->size - 1;
			parser_state = -1;
		}
	}

	return asic->options.devcoredump.no_ring_dumps ? i : -1;

error:
	asic->options.devcoredump.no_ring_dumps = 0;
	return -1;
}

static int umr_parse_devcoredump(struct umr_asic *asic, umr_err_output errout)
{
	int i;

	for (i = 0; i < (int) asic->options.devcoredump.n_lines; i++) {
		const char *line = asic->options.devcoredump.data[i];

		if (strcmp(line, "SOC Information") == 0) {
			// TODO
		} else if (strcmp(line, "SOC Memory Information") == 0) {
			i = umr_parse_devcoredump_memory(asic, i + 1);
		} else if (strcmp(line, "GDS Config") == 0) {
			// TODO
		} else if (strcmp(line, "IP Firmwares") == 0) {
			i = umr_parse_devcoredump_firmwares(asic, i + 1);
		} else if (strcmp(line, "VBIOS Information") == 0) {
			// TODO
		} else if (strcmp(line, "Ring timeout details") == 0) {
			// TODO
		} else if (strstr(line, "page fault observed")) {
			// TODO
		} else if (strcmp(line, "IP Dump") == 0) {
			i = umr_parse_devcoredump_ip_dump(asic, i + 1);
		} else if (strcmp(line, "Ring buffer information") == 0) {
			i = umr_parse_devcoredump_rings(asic, i + 1);
		}

		if (i < 0) {
			errout("[ERROR] Can't parse devcoredump (%s)\n", line);
			goto error;
		}
	}

	asic->options.is_devcoredump = 1;
	asic->options.no_follow_ib = 1;
	asic->instance = 0;

	return 0;

error:
	errout("[ERROR] umr_parse_devcoredump failed\n");
	for (int i = 0; i < asic->no_blocks; i++)
		free(asic->blocks[i]);
	free(asic->blocks);
	free(asic);

	return -1;
}

static void *umr_devcoredump_read_ring_data(struct umr_asic *asic, char *ringname, uint32_t *ringsize)
{
	void *ring_data;
	for (int i = 0; i < asic->options.devcoredump.no_ring_dumps; i++) {
		if (strcmp(ringname, asic->options.devcoredump.ring_dumps[i].ring_name))
			continue;
		int ndw = asic->options.devcoredump.ring_dumps[i].size;
		*ringsize = ndw * sizeof(uint32_t);
		if (!(ring_data = calloc((ndw + 3), sizeof(uint32_t))))
			return NULL;
		((uint32_t*)ring_data)[0] = asic->options.devcoredump.ring_dumps[i].rptr;
		((uint32_t*)ring_data)[1] = asic->options.devcoredump.ring_dumps[i].wptr;
		((uint32_t*)ring_data)[2] = asic->options.devcoredump.ring_dumps[i].wptr;
		memcpy(&((uint32_t*)ring_data)[3], asic->options.devcoredump.ring_dumps[i].data,
				 ndw * sizeof(uint32_t));
		return ring_data;
	}
	return NULL;
}

static uint32_t umr_devcoredump_read_reg(struct umr_asic *asic, uint64_t addr, enum regclass type) {
	(void)type;
	int no_registers = asic->options.devcoredump.no_registers;
	const struct devcoredump_reg *registers = asic->options.devcoredump.registers;

	for (int i = 0; i < no_registers; i++) {
		if (registers[i].addr != addr >> 2)
			continue;

		if (asic->options.use_bank == 2) {
			if (registers[i].me != (int)asic->options.bank.srbm.me)
				continue;
			if (registers[i].pipe != (int)asic->options.bank.srbm.pipe)
				continue;
			if (registers[i].queue != (int)asic->options.bank.srbm.queue)
				continue;
		}

		return registers[i].value;
	}

	asic->err_msg("[ERROR]: couldn't find register at addr==0x%08x [%d registers loaded]\n", addr >> 2, no_registers);
	return 0xffffffff;
}


static void set_ip_logical_inst(struct umr_discovery_table_entry *first,
                                uint32_t inst_mask)
{
	struct umr_discovery_table_entry *ent = first;
	uint32_t mask;
	int logical_inst;

	while (ent) {
		logical_inst = -1;
		if (!ent->harvest) {
			/* Count the set bits in inst_mask before ent->instance */
			mask = ((1U << ent->instance) - 1) & inst_mask;
			logical_inst = 0;
			while (mask) {
				if (mask & 1)
					++logical_inst;
				mask >>= 1;
			}
		}
		ent->logical_inst = logical_inst;
		ent = ent->next;
	}
}

struct umr_discovery_table_entry *umr_devcoredump_parse_ip_discovery(struct umr_options *options, int *nblocks)
{
	char **lines = options->devcoredump.data;
	char *line;
	char linebuf[512], ipname[512];
	struct umr_discovery_table_entry *pdet = NULL, *det = NULL, *hw_ip_start;
	int base_addr, num_base_addresses, hw_id, x, blk_inst;
	uint32_t inst_mask, segment_base;
	bool in_hw_ip, in_instance;
	int parser_state = -1, i;

	snprintf(linebuf, sizeof(linebuf), "die %d", options->instance);

	for (i = 0; i < (int) options->devcoredump.n_lines; i++) {
		line = lines[i];
		if (parser_state == -1) {
			if (strcmp(line, "HW IP Discovery") == 0)
				parser_state = 0;
		} else if (parser_state == 0) {
			if (*line == '\0')
				goto error;

			if (strcmp(line, linebuf) == 0) {
				parser_state = 1;
				i++;
				break;
			}
		}
	}
	if (parser_state != 1)
		return NULL;

	pdet = det = calloc(1, sizeof *det);
	if (!det)
		return NULL;

	hw_ip_start = det;
	inst_mask = 0;
	in_hw_ip = in_instance = false;

	for (; i < (int) options->devcoredump.n_lines; i++) {
		line = lines[i];

		if (*line == '\0')
			break;

retry:
		if (in_instance) {
			if (sscanf(line, "major %d", &det->maj) == 1 ||
			    sscanf(line, "minor %d", &det->min) == 1 ||
				sscanf(line, "revision %d", &det->rev) == 1 ||
				sscanf(line, "num_base_addresses %d", &num_base_addresses) == 1) {
				// ok
			} else if (sscanf(line, "harvest 0x%" SCNx8, &det->harvest) == 1) {
				if (det->harvest == 0)
					inst_mask |= (1 << det->instance);
			} else if (base_addr < num_base_addresses &&
					   sscanf(line, "base_addr[%d] 0x%" SCNx32, &base_addr, &segment_base) == 2) {
				det->segments[base_addr] = segment_base;
			} else if (sscanf(line, "instance %d", &blk_inst) == 1) {
				if (blk_inst > 0) {
					det->next = calloc(1, sizeof *det);
					if (!det->next)
						goto error;
					strcpy(det->next->ipname, strdup(det->ipname));
					det = det->next;
				}
				det->instance = blk_inst;
				num_base_addresses = base_addr = 0;
				++(*nblocks);
			} else if (strncmp(line, "hw_id", 5) == 0) {
				in_instance = in_hw_ip = false;
				goto retry;
			} else {
				goto error;
			}
		} else if (in_hw_ip) {
			if (sscanf(line, "instance %d", &det->instance) == 1)
				in_instance = true;
		} else {
			in_hw_ip = sscanf(line, "hw_id %d %s", &hw_id, ipname) == 2;
			num_base_addresses = base_addr = 0;
			if (det != pdet) {
				det->next = calloc(1, sizeof *det);
				if (!det->next)
					goto error;

				set_ip_logical_inst(hw_ip_start, inst_mask);
				det = det->next;
			}
			hw_ip_start = det;
			inst_mask = 0;
			++(*nblocks);
			for (x = 0; ipname[x]; x++)
				det->ipname[x] = tolower(ipname[x]);
		}

		if (!in_hw_ip) {
			set_ip_logical_inst(hw_ip_start, inst_mask);
			break;
		}
	}

	return pdet;
error:
	while (pdet) {
		det = pdet->next;
		free(pdet);
		pdet = det;
	}
	return NULL;
}

static int umr_attach_devcoredump(struct umr_asic *asic)
{
	if (umr_parse_devcoredump(asic, asic->err_msg) < 0)
		return -1;

	asic->ring_func.read_ring_data = umr_devcoredump_read_ring_data;
	asic->reg_funcs.read_reg = umr_devcoredump_read_reg;

	asic->options.shader_enable.enable_vs_shader   = 1;
	asic->options.shader_enable.enable_ps_shader   = 1;
	asic->options.shader_enable.enable_es_shader   = 1;
	asic->options.shader_enable.enable_ls_shader   = 1;
	asic->options.shader_enable.enable_comp_shader = 1;
	asic->options.shader_enable.enable_es_ls_swap = 1;

	free(asic->options.devcoredump.data[0]);
	free(asic->options.devcoredump.data);

	return 0;
}

struct umr_asic *umr_discover_asic_by_devcoredump(struct umr_options *options, umr_err_output errout)
{
	struct umr_asic *asic;
	char buf[32];
	long did;

	did = umr_read_did_from_devcoredump(options->devcoredump.data, options->devcoredump.n_lines);
	if (did <= 0)
		return NULL;

	snprintf(buf, sizeof(buf), "amd%04" PRIx64, (uint64_t)did);

	asic = umr_discover_asic_by_discovery_table(buf, options, errout);
	if (!asic || umr_attach_devcoredump(asic)) {
		errout("[ERROR] Failed to init asic from devcoredump (%p)\n", asic);
		return NULL;
	}

	asic->did = did;
	asic->err_msg = errout;
	asic->std_msg = errout;
	return asic;
}

int umr_prepare_devcoredump(struct umr_options *options, const char *file, umr_err_output errout)
{
	struct stat stats;
	char *content;
	int fd;

	memset(&options->devcoredump, 0, sizeof(options->devcoredump));

	fd = open(file, O_RDONLY);
	if (fd < 0) {
		errout("[ERROR]: Could not read devcoredump from file %s\n", file);
		return EXIT_FAILURE;
	}
	if (fstat(fd, &stats)) {
		errout("[ERROR]: Could not fstat devcoredump from file %s\n", file);
		close(fd);
		return EXIT_FAILURE;
	}

	content = calloc(1, stats.st_size + 1);
	if (!content)
		goto error;

	if (read(fd, content, stats.st_size) != stats.st_size) {
		fprintf(stderr, "[ERROR]: Could not read devcoredump from file %s\n", file);
		close(fd);
		return EXIT_FAILURE;
	}
	close(fd);

	options->devcoredump.data = parse_lines(content, stats.st_size, &options->devcoredump.n_lines);

	if (!options->devcoredump.data || !options->devcoredump.n_lines) {
		free(content);
		goto error;
	}
	return 0;

error:
	close(fd);
	return -1;
}

void umr_free_devcoredump(struct umr_asic *asic)
{
	int i;
	for (i = 0; i < asic->options.devcoredump.no_ring_dumps; i++)
		free(asic->options.devcoredump.ring_dumps[i].data);
	free(asic->options.devcoredump.registers);
}
