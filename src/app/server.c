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
 */
#include "umrapp.h"
#include <signal.h>
#include <time.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdarg.h>
#include <nanomsg/nn.h>
#include <nanomsg/reqrep.h>
#include <json.h>

static char * read_file(const char *path) {
	static char *buffer = NULL;
	static unsigned buffer_size = 0;
	FILE *fd = fopen(path, "r");
	if (fd) {
		long total = 0;
		while (1) {
			if (total >= buffer_size) {
				buffer_size = total ? total * 2 : 1024;
				buffer = realloc(buffer, buffer_size);
			}

			int n = fread(&buffer[total], 1, buffer_size - total, fd);
			if (!n) {
				buffer[total] = '\0';
				break;
			}
			total += n;
		}
		fclose(fd);
		return buffer;
	}
	return "";
}

static uint64_t read_sysfs_uint64(const char *path) {
	char *content = read_file(path);
	uint64_t v;
	if (sscanf(content, "%lu", &v) == 1)
		return v;
	return 0;
}

static void parse_sysfs_clock_file(const char *path, int *min, int *max) {
	char *content = read_file(path);
	*min = 0;
	*max = 100;

	int i, value;
	char *in = content;
	char *ptr;
	while((ptr = strchr(in, '\n'))) {
		*ptr = '\0';
		if (sscanf(in, "%d: %dMHz", &i, &value) == 2) {
			if (i == 0)
				*min = value;
			*max = value;
		}
		in = ptr + 1;
	}
}

static const char *json_get_string(struct json_object *json, const char *name) {
	struct json_object *val = json_object_object_get(json, name);
	if (json_object_get_type(val) != json_type_string)
		return NULL;
	return json_object_get_string(val);
}


enum sensor_maps {
	SENSOR_IDENTITY = 0,
	SENSOR_D1000,
	SENSOR_D100,
	SENSOR_WAIT,
};

struct power_bitfield{
	char *regname;
	uint32_t value;
	enum amd_pp_sensors sensor_id;
	enum sensor_maps map;
};


static uint32_t parse_sensor_value(enum sensor_maps map, uint32_t value)
{
	uint32_t result = 0;

	switch(map) {
		case SENSOR_IDENTITY:
			result = value;
			break;
		case SENSOR_D1000:
			result = value / 1000;
			break;
		case SENSOR_D100:
			result = value / 100;
			break;
		case SENSOR_WAIT:
			result = ((value >> 8) * 1000);
			if ((value & 0xFF) < 100)
				result += (value & 0xFF) * 10;
			else
				result += value;
			result /= 1000;
			break;
		default:
			printf("invalid input value!\n");
			break;
	}
	return result;
}

struct {
	uint64_t addr;
	uint64_t va;
	uint64_t pba;

	int type; /* 0: base, 1: pde, 2: pte */

	int valid;
	int system;
	int cache;
	int pte;
} page_table[64];
int num_page_table_entries;

static int my_vm_message_fn(const char *fmt, ...) {
	int arg_offset = -1;

	if (strstr(fmt, "BASE=") == fmt) {
		page_table[num_page_table_entries].type = 0;
		arg_offset = 0;
	} else if (strstr(fmt, "PDE")) {
		page_table[num_page_table_entries].type = 1;
		arg_offset = 4;
	} else if (strstr(fmt, "%s %s@{") == fmt) {
		page_table[num_page_table_entries].type = 2;
		arg_offset = 4;
	}

	if (arg_offset >= 0) {
		va_list ap;
		va_start(ap, fmt);
		for(int i = 0; ; i++) {
			if (i < arg_offset)
				va_arg(ap, int);
			else if (i == arg_offset + 0)
				page_table[num_page_table_entries].addr = va_arg(ap, uint64_t);
			else if (i == arg_offset + 1)
				page_table[num_page_table_entries].va = va_arg(ap, uint64_t);
			else if (i == arg_offset + 2)
				page_table[num_page_table_entries].pba = va_arg(ap, uint64_t);
			else if (i == arg_offset + 3)
				page_table[num_page_table_entries].valid = va_arg(ap, int);
			else if (i == arg_offset + 4)
				page_table[num_page_table_entries].system = va_arg(ap, int);
			else if (i == arg_offset + 5)
				page_table[num_page_table_entries].cache = va_arg(ap, int);
			else if (i == arg_offset + 6)
				page_table[num_page_table_entries].pte = va_arg(ap, int);
			else
				break;
		}
		va_end(ap);
		num_page_table_entries++;
	}
	return 0;
}

static char ring_decode_buffer[8196];
static int ring_decode_buffer_offset = 0;
static int ring_decode_fn(const char *fmt, ...) {
	va_list ap;
	va_start(ap, fmt);
	ring_decode_buffer_offset += vsprintf(&ring_decode_buffer[ring_decode_buffer_offset], fmt, ap);
	va_end(ap);

	return 0;
}

static struct umr_asic *asics[16] = {0};

static void init_asics() {
	int i = 0;
	struct umr_options opt = {0};
	opt.need_scan = 1;
	opt.forcedid = -1;
	opt.scanblock = "";
	opt.instance = 0;
	while ((asics[i] = umr_discover_asic(&opt, NULL))) {
		// assign linux callbacks
		asics[i]->mem_funcs.vm_message = NULL;
		asics[i]->mem_funcs.gpu_bus_to_cpu_address = umr_vm_dma_to_phys;
		asics[i]->mem_funcs.access_sram = umr_access_sram;

		if (asics[i]->options.use_pci == 0)
			asics[i]->mem_funcs.access_linear_vram = umr_access_linear_vram;
		else
			asics[i]->mem_funcs.access_linear_vram = umr_access_vram_via_mmio;

		asics[i]->reg_funcs.read_reg = umr_read_reg;
		asics[i]->reg_funcs.write_reg = umr_write_reg;

		asics[i]->wave_funcs.get_wave_sq_info = umr_get_wave_sq_info;
		asics[i]->wave_funcs.get_wave_status = umr_get_wave_status;

		// default shader options
		if (asics[i]->family <= FAMILY_VI) { // on gfx9+ hs/gs are opaque
			asics[i]->options.shader_enable.enable_gs_shader = 1;
			asics[i]->options.shader_enable.enable_hs_shader = 1;
		}
		asics[i]->options.shader_enable.enable_vs_shader   = 1;
		asics[i]->options.shader_enable.enable_ps_shader   = 1;
		asics[i]->options.shader_enable.enable_es_shader   = 1;
		asics[i]->options.shader_enable.enable_ls_shader   = 1;
		asics[i]->options.shader_enable.enable_comp_shader = 1;

		if (asics[i]->family > FAMILY_VI)
			asics[i]->options.shader_enable.enable_es_ls_swap = 1;  // on >FAMILY_VI we swap LS/ES for HS/GS

		i++;

		memset(&opt, 0, sizeof(opt));
		opt.need_scan = 1;
		opt.forcedid = -1;
		opt.scanblock = "";
		opt.instance = i;
	}
}

static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shaders, struct json_object *out) {
	struct umr_pm4_stream *stream = umr_pm4_decode_ring(asic, asic->options.ring_name, 1, -1, -1);

	struct umr_wave_data *wd = umr_scan_wave_data(asic);

	struct json_object *shaders = json_object_new_object();

	struct json_object *waves = json_object_new_array();
	while (wd) {
		uint64_t pgm_addr = (((uint64_t)wd->ws.pc_hi << 32) | wd->ws.pc_lo);
		unsigned vmid;

		struct json_object *wave = json_object_new_object();
		json_object_object_add(wave, "se", json_object_new_int(wd->se));
		json_object_object_add(wave, "sh", json_object_new_int(wd->se));
		json_object_object_add(wave, "cu", json_object_new_int(wd->cu));
		json_object_object_add(wave, "simd_id", json_object_new_int(wd->ws.hw_id1.simd_id));
		json_object_object_add(wave, "wave_id", json_object_new_int(wd->ws.hw_id1.wave_id));
		json_object_object_add(wave, "PC", json_object_new_uint64(pgm_addr));
		json_object_object_add(wave, "wave_inst_dw0", json_object_new_int(wd->ws.wave_inst_dw0));
		json_object_object_add(wave, "wave_inst_dw1", json_object_new_int(wd->ws.wave_inst_dw1));

		struct json_object *status = json_object_new_object();
		json_object_object_add(status, "value", json_object_new_int(wd->ws.wave_status.value));
		json_object_object_add(status, "scc", json_object_new_int(wd->ws.wave_status.scc));
		json_object_object_add(status, "execz", json_object_new_int(wd->ws.wave_status.execz));
		json_object_object_add(status, "vccz", json_object_new_int(wd->ws.wave_status.vccz));
		json_object_object_add(status, "in_tg", json_object_new_int(wd->ws.wave_status.in_tg));
		json_object_object_add(status, "halt", json_object_new_int(wd->ws.wave_status.halt));
		json_object_object_add(status, "valid", json_object_new_int(wd->ws.wave_status.valid));
		json_object_object_add(status, "spi_prio", json_object_new_int(wd->ws.wave_status.spi_prio));
		json_object_object_add(status, "wave_prio", json_object_new_int(wd->ws.wave_status.wave_prio));
		json_object_object_add(status, "priv", json_object_new_int(wd->ws.wave_status.priv));
		json_object_object_add(status, "trap_en", json_object_new_int(wd->ws.wave_status.trap_en));
		json_object_object_add(status, "trap", json_object_new_int(wd->ws.wave_status.trap));
		json_object_object_add(status, "ttrace_en", json_object_new_int(wd->ws.wave_status.ttrace_en));
		json_object_object_add(status, "export_rdy", json_object_new_int(wd->ws.wave_status.export_rdy));
		json_object_object_add(status, "in_barrier", json_object_new_int(wd->ws.wave_status.in_barrier));
		json_object_object_add(status, "ecc_err", json_object_new_int(wd->ws.wave_status.ecc_err));
		json_object_object_add(status, "skip_export", json_object_new_int(wd->ws.wave_status.skip_export));
		json_object_object_add(status, "perf_en", json_object_new_int(wd->ws.wave_status.perf_en));
		json_object_object_add(status, "cond_dbg_user", json_object_new_int(wd->ws.wave_status.cond_dbg_user));
		json_object_object_add(status, "cond_dbg_sys", json_object_new_int(wd->ws.wave_status.cond_dbg_sys));
		json_object_object_add(status, "allow_replay", json_object_new_int(wd->ws.wave_status.allow_replay));
		json_object_object_add(status, "fatal_halt", json_object_new_int(asic->family >= FAMILY_AI && wd->ws.wave_status.fatal_halt));
		json_object_object_add(status, "must_export", json_object_new_int(wd->ws.wave_status.must_export));

		json_object_object_add(wave, "status", status);

		struct json_object *hw_id = json_object_new_object();
		if (asic->family < FAMILY_NV) {
			json_object_object_add(hw_id, "value", json_object_new_int(wd->ws.hw_id.value));
			json_object_object_add(hw_id, "wave_id", json_object_new_int(wd->ws.hw_id.wave_id));
			json_object_object_add(hw_id, "simd_id", json_object_new_int(wd->ws.hw_id.simd_id));
			json_object_object_add(hw_id, "pipe_id", json_object_new_int(wd->ws.hw_id.pipe_id));
			json_object_object_add(hw_id, "cu_id", json_object_new_int(wd->ws.hw_id.cu_id));
			json_object_object_add(hw_id, "sh_id", json_object_new_int(wd->ws.hw_id.sh_id));
			json_object_object_add(hw_id, "tg_id", json_object_new_int(wd->ws.hw_id.tg_id));
			json_object_object_add(hw_id, "state_id", json_object_new_int(wd->ws.hw_id.state_id));
			json_object_object_add(hw_id, "vm_id", json_object_new_int(wd->ws.hw_id.vm_id));
			vmid = wd->ws.hw_id.vm_id;
		} else {
			json_object_object_add(hw_id, "value", json_object_new_int(wd->ws.hw_id1.value));
			json_object_object_add(hw_id, "wave_id", json_object_new_int(wd->ws.hw_id1.wave_id));
			json_object_object_add(hw_id, "simd_id", json_object_new_int(wd->ws.hw_id1.simd_id));
			json_object_object_add(hw_id, "wgp_id", json_object_new_int(wd->ws.hw_id1.wgp_id));
			json_object_object_add(hw_id, "se_id", json_object_new_int(wd->ws.hw_id1.se_id));
			json_object_object_add(hw_id, "sa_id", json_object_new_int(wd->ws.hw_id1.sa_id));
			json_object_object_add(hw_id, "queue_id", json_object_new_int(wd->ws.hw_id2.queue_id));
			json_object_object_add(hw_id, "pipe_id", json_object_new_int(wd->ws.hw_id2.pipe_id));
			json_object_object_add(hw_id, "me_id", json_object_new_int(wd->ws.hw_id2.me_id));
			json_object_object_add(hw_id, "state_id", json_object_new_int(wd->ws.hw_id2.state_id));
			json_object_object_add(hw_id, "wg_id", json_object_new_int(wd->ws.hw_id2.wg_id));
			json_object_object_add(hw_id, "compat_level", json_object_new_int(wd->ws.hw_id2.compat_level));
			json_object_object_add(hw_id, "vm_id", json_object_new_int(wd->ws.hw_id2.vm_id));
			vmid = wd->ws.hw_id2.vm_id;
		}
		json_object_object_add(wave, "hw_id", hw_id);

		struct json_object *gpr_alloc = json_object_new_object();
		json_object_object_add(gpr_alloc, "vgpr_base", json_object_new_int(wd->ws.gpr_alloc.vgpr_base));
		json_object_object_add(gpr_alloc, "vgpr_size", json_object_new_int(wd->ws.gpr_alloc.vgpr_size));
		json_object_object_add(gpr_alloc, "sgpr_base", json_object_new_int(wd->ws.gpr_alloc.sgpr_base));
		json_object_object_add(gpr_alloc, "sgpr_size", json_object_new_int(wd->ws.gpr_alloc.sgpr_size));
		json_object_object_add(wave, "gpr_alloc", gpr_alloc);

		if (is_halted) {
			int spgr_count = (wd->ws.gpr_alloc.sgpr_size + 1) * ((asic->family <= FAMILY_CIK) ? 3 : 4);
			struct json_object *sgpr = json_object_new_array();
			for (int x = 0; x < spgr_count; x++) {
				json_object_array_add(sgpr, json_object_new_int(wd->sgprs[x]));
			}
			json_object_object_add(wave, "sgpr", sgpr);

			struct json_object *threads = json_object_new_array();
			int num_threads = asic->family < FAMILY_NV ? 64 : wd->num_threads;
			for (int thread = 0; thread < num_threads; thread++) {
				unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
				json_object_array_add(threads, json_object_new_int(live ? 1 : 0));
			}
			json_object_object_add(wave, "threads", threads);


			if (wd->have_vgprs) {
				unsigned granularity = asic->parameters.vgpr_granularity;
				unsigned vpgr_count = (wd->ws.gpr_alloc.vgpr_size + 1) << granularity;
				struct json_object *vgpr = json_object_new_array();
				for (int x = 0; x < (int) vpgr_count; x++) {
					struct json_object *v = json_object_new_array();
					for (int thread = 0; thread < num_threads; thread++) {
						json_object_array_add(v, json_object_new_int(wd->vgprs[thread * 256 + x]));
					}
					json_object_array_add(vgpr, v);
				}
				json_object_object_add(wave, "vgpr", vgpr);
			}

			/* */
			if (include_shaders && (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt)) {
				struct umr_shaders_pgm *shader = umr_find_shader_in_stream(stream, vmid, pgm_addr);
				uint32_t shader_size;
				uint64_t shader_addr;
				if (shader) {
					shader_size = shader->size;
					shader_addr = shader->addr;
				} else {
					#define NUM_OPCODE_WORDS 16
					pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
					shader_addr = pgm_addr;
					shader_size = NUM_OPCODE_WORDS * 4;
					#undef NUM_OPCODE_WORDS
				}
				char **disassembly;
				int r = umr_vm_disasm_to_str(asic, vmid,
											 shader_addr, pgm_addr, shader_size,
											 0,
											 &disassembly);

				if (r == 0) {
					/* Remember which shader address we used for this wave */
					char tmp[128];
					sprintf(tmp, "%lx", shader_addr);
					json_object_object_add(wave, "shader_disassembly", json_object_new_string(tmp));

					/* And add it to the top level object if it's not there already */
					int lines = shader_size / 4;
					struct json_object *dis = json_object_object_get(shaders, tmp) == NULL ? json_object_new_array() : NULL;

					for (int f = 0 ; f < lines; f++) {
						if (dis)
							json_object_array_add(dis, json_object_new_string(disassembly[f]));
						free(disassembly[f]);
					}
					free(disassembly);
					if (dis)
						json_object_object_add(shaders, tmp, dis);
				} else {
					printf("disassembly failed.\n");
				}
			}
		}

		json_object_array_add(waves, wave);

		struct umr_wave_data *old = wd;
		wd = wd->next;
		free(old);
	}

	json_object_object_add(out, "waves", waves);
	if (include_shaders)
		json_object_object_add(out, "shaders", shaders);
	else
		json_object_put(shaders);

	if (stream)
		umr_free_pm4_stream(stream);
}

struct json_object *umr_process_json_request(struct json_object *request)
{
	struct json_object *answer = NULL;
	const char *last_error;
	const char *command = json_get_string(request, "command");
	int j, k, l;

	if (!command) {
		last_error = "missing command";
		goto error;
	}

	if (asics[0] == NULL)
		init_asics();

	struct umr_asic *asic = asics[json_object_get_int(json_object_object_get(request, "asic_index"))];

	if (strcmp(command, "enumerate") == 0) {
		int i = 0, j;
		answer = json_object_new_array();
		while (asics[i]) {
			struct json_object *as = json_object_new_object();
			json_object_object_add(as, "name", json_object_new_string(asics[i]->asicname));
			json_object_object_add(as, "index", json_object_new_int(i));
			json_object_object_add(as, "instance", json_object_new_int(asics[i]->instance));
			json_object_object_add(as, "did", json_object_new_int(asics[i]->did));
			json_object_object_add(as, "family", json_object_new_int(asics[i]->family));
			json_object_object_add(as, "vram_size", json_object_new_uint64(asics[i]->config.vram_size));
			json_object_object_add(as, "vis_vram_size", json_object_new_uint64(asics[i]->config.vis_vram_size));
			json_object_object_add(as, "vbios_version", json_object_new_string(asics[i]->config.vbios_version));
			struct json_object *fws = json_object_new_array();
			j = 0;
			while (asics[i]->config.fw[j].name[0] != '\0') {
				struct json_object *fw = json_object_new_object();
				json_object_object_add(fw, "name", json_object_new_string(asics[i]->config.fw[j].name));
				json_object_object_add(fw, "feature_version", json_object_new_int(asics[i]->config.fw[j].feature_version));
				json_object_object_add(fw, "firmware_version", json_object_new_int(asics[i]->config.fw[j].firmware_version));
				json_object_array_add(fws, fw);
				j++;
			}
			json_object_object_add(as, "firmwares", fws);

			/* Discover the rings */
			{
				struct json_object *rings = json_object_new_array();
				char fname[256];
				struct dirent *dir;
				sprintf(fname, "/sys/kernel/debug/dri/%d/", asic->instance);
				DIR *d = opendir(fname);
				if (d) {
					while ((dir = readdir(d))) {
						if (strncmp(dir->d_name, "amdgpu_ring_", strlen("amdgpu_ring_")) == 0) {
							json_object_array_add(rings, json_object_new_string(dir->d_name));
						}
					}
					closedir(d);
				}
				json_object_object_add(as, "rings", rings);
			}

			json_object_array_add(answer, as);
			i++;
		}
	} else if (strcmp(command, "list-blocks") == 0) {
		answer = json_object_new_array();

		for (j = 0; j < asic->no_blocks; j++) {
			json_object_array_add(answer, json_object_new_string(asic->blocks[j]->ipname));
		}
	} else if (strcmp(command, "list-regs") == 0) {
		const char *blockname = json_get_string(request, "block");
		int details = json_object_get_boolean(json_object_object_get(request, "details"));
		for (j = 0; j < asic->no_blocks; j++) {
			if (!strcmp(asic->blocks[j]->ipname, blockname)) {
				/* Found the block */
				answer = json_object_new_array();
				for (k = 0; k < asic->blocks[j]->no_regs; k++) {
					struct json_object *reg = json_object_new_object();
					json_object_object_add(reg, "name", json_object_new_string(asic->blocks[j]->regs[k].regname));
					json_object_object_add(reg, "address", json_object_new_uint64(asic->blocks[j]->regs[k].addr));

					if (details) {
						struct json_object *bits = json_object_new_array();
						for (l = 0; l < asic->blocks[j]->regs[k].no_bits; l++) {
							struct json_object *bit = json_object_new_object();
							json_object_object_add(bit, "name", json_object_new_string(asic->blocks[j]->regs[k].bits[l].regname));
							json_object_object_add(bit, "start", json_object_new_int(asic->blocks[j]->regs[k].bits[l].start));
							json_object_object_add(bit, "end", json_object_new_int(asic->blocks[j]->regs[k].bits[l].stop));
							json_object_array_add(bits, bit);
						}
						json_object_object_add(reg, "bitfields", bits);
					}

					json_object_array_add(answer, reg);
				}
			}
		}
	} else if (strcmp(command, "read") == 0) {
		struct umr_reg *r = umr_find_reg_data_by_ip(
			asic, json_get_string(request, "block"), json_get_string(request, "register"));

		answer = json_object_new_object();

		unsigned value = umr_read_reg_by_name_by_ip(asic, (char*) json_get_string(request, "block"), r->regname);
		json_object_object_add(answer, "value", json_object_new_int(value));

		struct json_object *details = json_object_object_get(request, "details");
		if (details && json_object_get_boolean(details)) {
			struct json_object *bits = json_object_new_array();
			for (l = 0; l < r->no_bits; l++) {
				struct json_object *bit = json_object_new_object();
				json_object_object_add(bit, "name", json_object_new_string(r->bits[l].regname));
				json_object_object_add(bit, "start", json_object_new_int(r->bits[l].start));
				json_object_object_add(bit, "end", json_object_new_int(r->bits[l].stop));
				json_object_array_add(bits, bit);
			}
			json_object_object_add(answer, "bitfields", bits);
		}
	} else if (strcmp(command, "write") == 0) {
		struct umr_reg *r = umr_find_reg_data_by_ip(
			asic, json_get_string(request, "block"), json_get_string(request, "register"));

		answer = json_object_new_object();

		char *block = (char*) json_get_string(request, "block");
		unsigned value = json_object_get_int(json_object_object_get(request, "value"));
		if (umr_write_reg_by_name_by_ip(asic, block, r->regname, value)) {
			value = umr_read_reg_by_name_by_ip(asic, block, r->regname);
		}
		json_object_object_add(answer, "value", json_object_new_int(value));
	} else if (strcmp(command, "vm-read") == 0 || strcmp(command, "vm-decode") == 0) {
		uint64_t address = json_object_get_uint64(json_object_object_get(request, "address"));
		struct json_object *vmidv = json_object_object_get(request, "vmid");
		uint32_t vmid = UMR_LINEAR_HUB;
		if (vmidv)
			vmid = json_object_get_int(vmidv);

		uint64_t *buf = NULL;
		unsigned size = json_object_get_int(json_object_object_get(request, "size"));
		if (size % 8) {
			size += 8 - size % 8;
		}

		asic->options.verbose = 1;
		asic->mem_funcs.vm_message = my_vm_message_fn;
		memset(page_table, 0, sizeof(page_table));
		num_page_table_entries = 0;

		if (strcmp(command, "vm-read") == 0) {
			buf = malloc((sizeof(uint64_t) * size) / 8);
		} else {
			size = 4;
		}

		int r = umr_read_vram(asic, vmid, address, size, buf);
		if (r && buf) {
			memset(buf, 0, size);
			num_page_table_entries = 0;
		}

		asic->mem_funcs.vm_message = NULL;
		asic->options.verbose = 0;

		answer = json_object_new_object();

		if (buf) {
			struct json_object *value = json_object_new_array();
			for (int i = 0; i < (int) size / 8; i++) {
				json_object_array_add(value, json_object_new_uint64(buf[i]));
			}
			json_object_object_add(answer, "values", value);
			free(buf);
		}
		struct json_object *pt = json_object_new_array	();
		for (int i = 0; i < num_page_table_entries; i++) {
			struct json_object *level = json_object_new_object();
			json_object_object_add(level, "address", json_object_new_uint64(page_table[i].addr));
			json_object_object_add(level, "va", json_object_new_uint64(page_table[i].va));
			json_object_object_add(level, "pba", json_object_new_uint64(page_table[i].pba));
			json_object_object_add(level, "type", json_object_new_int(page_table[i].type));
			json_object_object_add(level, "valid", json_object_new_int(page_table[i].valid));
			json_object_object_add(level, "system", json_object_new_int(page_table[i].system));
			json_object_array_add(pt, level);
		}
		json_object_object_add(answer, "page_table", pt);
	} else if (strcmp(command, "waves") == 0) {
		/* Assumes Navi chip for now (= code adapted from umr_print_waves_nv,
		 * should be updated to cover umr_print_waves_si_ai as well). */
		struct json_object *halt = json_object_object_get(request, "halt_waves");
		int halt_waves = halt && json_object_get_int(halt);
		int resume_waves = halt_waves;
		struct json_object *resume = json_object_object_get(request, "resume_waves");
		if (resume)
			resume_waves = json_object_get_int(resume);
		if (json_object_object_get(request, "ring")) {
			strcpy(asic->options.ring_name, json_get_string(request, "ring"));
		}

		struct json_object *gfxoff = json_object_object_get(request, "disable_gfxoff");
		int disable_gfxoff = gfxoff && json_object_get_int(gfxoff);
		if (disable_gfxoff) {
			uint32_t value = 0;
			write(asic->fd.gfxoff, &value, sizeof(value));
		}

		if (halt_waves) {
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT);
		}

		asic->options.skip_gprs = 0;
		asic->options.halt_waves = halt_waves;
		asic->options.verbose = 0;

		int is_halted = umr_pm4_decode_ring_is_halted(asic, asic->options.ring_name);

		answer = json_object_new_object();

		wave_to_json(asic, is_halted, 1, answer);

		if (disable_gfxoff) {
			uint32_t value = 1;
			write(asic->fd.gfxoff, &value, sizeof(value));
		}
		if (resume_waves)
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
	} else if (strcmp(command, "resume-waves") == 0) {
		if (json_object_object_get(request, "ring")) {
			strcpy(asic->options.ring_name, json_get_string(request, "ring"));
		}
		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
		answer = json_object_new_object();
	} else if (strcmp(command, "ring") == 0) {
		char *ring_name = (char*) json_get_string(request, "ring");
		uint32_t wptr, rptr, drv_wptr, ringsize, start, end, value, *ring_data;
		struct umr_ring_decoder decoder;

		struct json_object *halt = json_object_object_get(request, "halt_waves");
		int halt_waves = halt && json_object_get_int(halt);

		if (halt_waves) {
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT);
		}
		ring_data = umr_read_ring_data(asic, ring_name, &ringsize);

		if (!ring_data) {
			last_error = "couldn't read ring";
			goto error;
		}

		/* read pointers */
		rptr = ring_data[0]<<2;
		wptr = ring_data[1]<<2;
		drv_wptr = ring_data[2]<<2;

		answer = json_object_new_object();
		json_object_object_add(answer, "read_ptr", json_object_new_int(rptr / 4));
		json_object_object_add(answer, "write_ptr", json_object_new_int(wptr / 4));
		json_object_object_add(answer, "driver_write_ptr", json_object_new_int(drv_wptr / 4));

		struct json_object *ring_decode_answer_array = json_object_new_array();
		struct json_object *ring_decode_raw = json_object_new_array();
		struct json_object *ring_decode_offset = json_object_new_array();

		memset(&decoder, 0, sizeof decoder);
		if (!memcmp(ring_name, "gfx", 3) ||
			!memcmp(ring_name, "uvd", 3) ||
			!memcmp(ring_name, "vcn_dec", 7) ||
			!memcmp(ring_name, "vcn_enc", 7) ||
			!memcmp(ring_name, "kiq", 3) ||
			!memcmp(ring_name, "comp", 4)) {
			decoder.pm = 4;
		} else if (!memcmp(ring_name, "sdma", 4) ||
			   !memcmp(ring_name, "page", 4)) {
			decoder.pm = 3;
		}
		decoder.pm4.cur_opcode = 0xFFFFFFFF;
		decoder.sdma.cur_opcode = 0xFFFFFFFF;
		start = 0;
		end = ringsize - 4;

		int is_nop;
		int previous_was_nop = 0;
		do {
			ring_decode_buffer_offset = 0;

			value = ring_data[(start+12)>>2];
			decoder.next_ib_info.addr = start / 4;
			umr_print_decode(asic, &decoder, value, ring_decode_fn);

			start += 4;
			start %= ringsize;

			char *nop = strstr(ring_decode_buffer, "NOP]");
			is_nop = nop && nop < &ring_decode_buffer[ring_decode_buffer_offset];
			if (is_nop) {
				if (previous_was_nop > 1)
					continue;
				else if (previous_was_nop == 1) {
					strcpy(ring_decode_buffer, "(more NOPs)");
					ring_decode_buffer_offset = strlen(ring_decode_buffer);
					previous_was_nop++;
				} else {
					previous_was_nop = 1;
				}
			} else if (previous_was_nop) {
				previous_was_nop = 0;
			}

			json_object_array_add(ring_decode_answer_array,
								  json_object_new_string_len(ring_decode_buffer,
															 ring_decode_buffer_offset));
			json_object_array_add(ring_decode_raw, json_object_new_int(value));
			json_object_array_add(ring_decode_offset, json_object_new_int(start / 4 - 1));


		} while (start != ((end + 4) % ringsize));

		json_object_object_add(answer, "decoded", ring_decode_answer_array);
		json_object_object_add(answer, "raw", ring_decode_raw);
		json_object_object_add(answer, "offsets", ring_decode_offset);
		ring_decode_answer_array = NULL;

		if (halt_waves) {
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
		}
	} else {
		last_error = "unknown command";
		goto error;
	}

	return answer;

error:
	answer = json_object_new_object();
	json_object_object_add(answer, "error", json_object_new_string(last_error));
	return answer;
}

void run_server_loop(const char *url, struct umr_asic * asic)
{
	int sock = nn_socket(AF_SP, NN_REP);
	if (sock < 0) {
		exit(1);
	}

	int rv = nn_bind(sock, url);
	if (rv < 0) {
		exit(1);
	}

	int size = 100000000;
	if (nn_setsockopt(sock, NN_SOL_SOCKET, NN_RCVMAXSIZE, &size, sizeof(size)) < 0) {
		exit(0);
	}

	if (asic) {
		asics[0] = asic;
	} else {
		init_asics();
	}

	/* Everything is ready. Wait for commands */

	printf("Waiting for commands.\n");
	struct json_tokener *parser = json_tokener_new();

	for (;;) {
		char* buf;
		int len = nn_recv(sock, &buf, NN_MSG, 0);
		// printf("Received %d\n", len);
		if (len < 0)
			exit(0);
		struct json_object *request = json_tokener_parse_ex(parser, buf, len);

		enum json_tokener_error jerr = json_tokener_get_error(parser);
		if (jerr != json_tokener_success) {
			printf("ERROR\n");
		} else {
			struct json_object *answer = umr_process_json_request(request);
			#if 0
			static int count = 0;
			char tmp[512];
			sprintf(tmp, "/tmp/answer%d.json", count);
			count++;
			json_object_to_file(tmp, answer);
			#endif
			const char* s = json_object_to_json_string(answer);
			size_t len = strlen(s) + 1;
			if (nn_send(sock, s, len, 0) < 0)
				exit(0);
			json_object_put(answer);
			json_object_put(request);
			json_tokener_reset(parser);
		}
		nn_freemsg(buf);
	}
	json_tokener_free(parser);
}
