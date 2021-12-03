/*
 * Copyright © 2021 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sub license, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS, AUTHORS
 * AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
 * USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial portions
 * of the Software.
 */

extern "C" {
	#include "umr.h"
}
#include "imgui.h"
#include "imgui_impl_opengl3.h"
#include "imgui_impl_sdl.h"
#include "imgui_memory_editor.h"
#include "glad/glad.h"
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <SDL.h>
#include <fcntl.h>
#include <fstream>
#include <mutex>
#include <pthread.h>
#include <regex.h>
#include <sstream>
#include <stdio.h>
#include <unistd.h>
#include <vector>
#include <stdio.h>
#include <nanomsg/nn.h>
#include <nanomsg/reqrep.h>
#include <mutex>
#include <pthread.h>
#include <algorithm>

#include "parson.h"


struct PinnedRegister {
	PinnedRegister(struct umr_ip_block *_blk, struct umr_reg *_reg) : blk(_blk), reg(_reg) {
		value_is_valid = false;
		value_is_dirty = false;
	}
	struct umr_ip_block *blk;
	struct umr_reg *reg;
	bool value_is_valid;
	bool value_is_dirty;
};

/* per-asic data */
struct AsicData {
	AsicData(long did, int instance) {
		info_panel.last_answer = NULL;
		strcpy(memory_panel.vram_address, "00100000000");
		memory_panel.vram_content = NULL;
		memory_panel.vram_size = 1024;
		memory_panel.vmid = 1;
		memory_panel.valid_content_size = 0;
		memory_panel.num_page_table_entries = 0;
		waves_panel.last_answer = NULL;
		waves_panel.active_shader = NULL;
		waves_panel.details.view = NULL;
		waves_panel.details.vgpr = NULL;
		ring_panel.last_answer = NULL;
		power_panel.last_answer = NULL;
		power_panel.sensors_last_answer = NULL;
		power_panel.sensor_previous_values = NULL;
		memory_usage_panel.last_answer = NULL;

		options.no_kernel = true;
		options.instance = instance;
		options.database_path[0] = '\0';

		asic = umr_discover_asic_by_did(&options, did, printf);
		asic->instance = instance;

		blocks_panel.autorefresh = false;
		blocks_panel.autorefresh_hz = 5;
		blocks_panel.elapsed_since_last_refresh = 0;

		memset(&top_panel, 0, sizeof(top_panel));
	}
	~AsicData() {
		if (info_panel.last_answer)
			json_value_free(json_object_get_wrapping_value(info_panel.last_answer));
		if (waves_panel.last_answer) {
			json_value_free(json_object_get_wrapping_value(waves_panel.last_answer));
			json_value_free(json_array_get_wrapping_value(waves_panel.active_shader));
			free(waves_panel.details.vgpr);
			free(waves_panel.details.view);
		}
		if (ring_panel.last_answer)
			json_value_free(json_object_get_wrapping_value(ring_panel.last_answer));
		if (power_panel.last_answer)
			json_value_free(json_object_get_wrapping_value(power_panel.last_answer));
		if (power_panel.sensors_last_answer)
			json_value_free(json_object_get_wrapping_value(power_panel.sensors_last_answer));
		if (memory_usage_panel.last_answer)
			json_value_free(json_object_get_wrapping_value(memory_usage_panel.last_answer));
		if (top_panel.last_accumulate_answer)
			json_value_free(json_object_get_wrapping_value(top_panel.last_accumulate_answer));
		for (int i = 0; i < ring_panel.num_rings; i++)
			free(ring_panel.rings[i]);
		free(ring_panel.rings);
		free(power_panel.sensor_previous_values);
		free(memory_panel.vram_content);
		umr_close_asic(asic);
	}

	struct umr_options options;
	struct umr_asic *asic;

	struct {
		JSON_Object *last_answer;
	} info_panel;

	/* Register panel */
	struct {
		std::vector<PinnedRegister> pinned_registers;
		bool autorefresh;
		float elapsed_since_last_refresh;
		int autorefresh_hz;
	} blocks_panel;

	/* Memory panel */
	struct {
		uint64_t *vram_content;
		char vram_address[32];
		int vram_size;
		int vmid;
		int valid_content_size;
		struct {
			uint64_t va_mask;
			uint64_t pba;
			int type; /* 0: base, 1: pde, 2: pte */
			int valid;
			int system, tmz, mtype;
		} page_table[64];
		int num_page_table_entries;
		uint64_t decoded_addr;
		int decoded_vmid;
	} memory_panel;

	/* Waves panel */
	struct {
		JSON_Object *last_answer;
		JSON_Array *active_shader;
		uint64_t base_address;
		uint64_t pc;
		struct {
			bool *vgpr;
			int *view;
			int max_vgpr;
		} details;
	} waves_panel;

	/* Ring panel */
	struct {
		char **rings;
		int num_rings;
		JSON_Object *last_answer;
	} ring_panel;

	struct {
		JSON_Object *last_answer;

		JSON_Object *sensors_last_answer;
		bool consumed;
		float *sensor_previous_values;
		int sensor_values_offset;
	} power_panel;

	struct {
		JSON_Object *last_answer;
	} memory_usage_panel;

	struct {
		JSON_Object *last_accumulate_answer;
		const char *ipname;
		float *fences_deltas;
		int fence_deltas_offset;
		bool consumed;
	} top_panel;

	/* Interface */
	char register_filter[32] = {};
	char register_field_filter[32] = {};
};

struct Link {
	int sock;
	int endpoint;
	bool use_sock;
};


/* From fts_fuzzy_match */
static bool fuzzy_match_simple(char const * pattern, char const * str) {
  while (*pattern != '\0' && *str != '\0')  {
		if (tolower(*pattern) == tolower(*str))
			 ++pattern;
		++str;
  }

  return *pattern == '\0' ? true : false;
}

/* Helpers */
JSON_Value *query(struct Link& lnk, JSON_Value *request)
{
	if (lnk.use_sock) {
		char* s = json_serialize_to_string(request);
		int len = strlen(s) + 1;
		int r = nn_send(lnk.sock, s, len, 0);
		json_free_serialized_string(s);

		if (r < 0)
			exit(0);
		json_value_free(request);

		if (r < 0)
			return NULL;

		char *buffer;
		len = nn_recv(lnk.sock, &buffer, NN_MSG, 0);
		if (len < 0)
			exit(0);
		if (len == 0)
			return NULL;

		buffer[len - 1] = '\0';
		JSON_Value *out = json_parse_string(buffer);
		nn_freemsg(buffer);
		return out;
	} else {
		return umr_process_json_request(json_object(request));
	}
}

static void force_redraw() {
	SDL_Event evt;
	evt.type = SDL_USEREVENT;
	SDL_PushEvent(&evt);
}

struct Link lnk;
pthread_mutex_t mtx;
pthread_cond_t cond;
std::vector<JSON_Value*> pending_request;
bool done;

static void send_request(JSON_Value *req, struct umr_asic *asic) {
	if (asic) {
		JSON_Value *a = json_value_init_object();
		json_object_set_number(json_object(a), "did", asic->did);
		json_object_set_number(json_object(a), "instance", asic->instance);
		json_object_set_value(json_object(req), "asic", a);
	}
	pthread_mutex_lock(&mtx);
	pending_request.push_back(req);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_enumerate_command_answer(std::vector<AsicData*> *asics, JSON_Object *in) {
	JSON_Value *request = json_object_get_value(in, "request");
	JSON_Array *answer = json_array(json_object_get_value(in, "answer"));

	int s = json_array_get_count(answer);
	for (int i = 0; i < s; i++) {
		JSON_Object *a = json_object(json_array_get_value(answer, i));
		AsicData *d = new AsicData(json_object_get_number(a, "did"),
									json_object_get_number(a, "instance"));
		JSON_Array *rings = json_object_get_array(a, "rings");
		int n = json_array_get_count(rings);
		d->ring_panel.rings = (char**) malloc(sizeof(char*) * n);
		for (int i = 0; i < n; i++)
			d->ring_panel.rings[i] = strdup(json_array_get_string(rings, i));
		d->ring_panel.num_rings = n;
		d->info_panel.last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(a)));
		asics->push_back(d);
	}
}
void send_enumerate_command(struct Link& lnk) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "enumerate");
	send_request(req, NULL);
}

AsicData *answer_to_asic_data(std::vector<AsicData*> *asics, JSON_Object *response) {
	JSON_Object *asc = json_object(json_object_get_value(response, "asic"));
	int did = json_object_get_number(asc, "did");
	int instance = json_object_get_number(asc, "instance");

	for (int i = 0; i < (int) asics->size(); i++) {
		if ((*asics)[i]->asic->did == did && (*asics)[i]->asic->instance == instance)
			return (*asics)[i];
	}
	return NULL;
}

void process_read_reg_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	const char *blk = json_object_get_string(request, "block");
	const char *reg = json_object_get_string(request, "register");

	PinnedRegister *pinned = NULL;
	for (int i = 0; i < data->blocks_panel.pinned_registers.size() && !pinned; i++) {
		PinnedRegister &p = data->blocks_panel.pinned_registers[i];
		if (!strcmp(p.blk->ipname, blk) && !strcmp(p.reg->regname, reg))
			pinned = &p;
	}
	if (!pinned) {
		/* This can happen in replay mode: pin the register */
		struct umr_reg *r = umr_find_reg_data_by_ip(data->asic, blk, reg);
		struct umr_ip_block *b = NULL;
		umr_find_reg_by_addr(data->asic, r->addr, &b);
		data->blocks_panel.pinned_registers.push_back(PinnedRegister(b, r));
		pinned = &data->blocks_panel.pinned_registers.back();
	}

	pinned->reg->value = json_object_get_number(answer, "value");
	pinned->value_is_valid = true;
	pinned->value_is_dirty = false;
}

void send_read_reg_command(struct Link& lnk, AsicData &data, PinnedRegister *pinned)
{
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "read");
	json_object_set_string(json_object(req), "block", pinned->blk->ipname);
	json_object_set_string(json_object(req), "register", pinned->reg->regname);
	send_request(req, data.asic);
}

void process_accumulate_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	if (data->top_panel.last_accumulate_answer)
		json_value_free(json_object_get_wrapping_value(data->top_panel.last_accumulate_answer));
	data->top_panel.last_accumulate_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));
	data->top_panel.consumed = false;
}

void send_accumulate_command(struct Link& lnk, AsicData &data, const char *ipname, int ms, const char **regname)
{
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "accumulate");
	json_object_set_string(json_object(req), "block", ipname);
	JSON_Value *regs = json_value_init_array();
	for (int i = 0; regname[i]; i++)
		json_array_append_string(json_array(regs), regname[i]);
	json_object_set_value(json_object(req), "registers", regs);
	json_object_set_number(json_object(req), "period", ms);
	json_object_set_number(json_object(req), "steps", 100);
	send_request(req, data.asic);
}

void send_write_reg_command(struct Link& lnk, AsicData &data, PinnedRegister *pinned, unsigned value)
{
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "write");
	json_object_set_string(json_object(req), "block", pinned->blk->ipname);
	json_object_set_string(json_object(req), "register", pinned->reg->regname);
	json_object_set_number(json_object(req), "value", value);
	send_request(req, data.asic);
}

void process_vm_read_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	JSON_Array *values = json_array(json_object_get_value(answer, "values"));
	if (values) {
		int s = json_array_get_count(values);
		data->memory_panel.vram_content = (uint64_t*) realloc(data->memory_panel.vram_content, s * sizeof(uint64_t));

		for (int k = 0; k < s; k++) {
			data->memory_panel.vram_content[k] = json_array_get_number(values, k);
		}
		data->memory_panel.valid_content_size = s * sizeof(uint64_t);
	}

	JSON_Array *pt = json_array(json_object_get_value(answer, "page_table"));
	if (pt) {
		int num_pt = json_array_get_count(pt);
		for (int k = 0; k < num_pt; k++) {
			JSON_Object *level = json_object(json_array_get_value(pt, k));
			data->memory_panel.page_table[k].pba = json_object_get_number(level, "pba");
			data->memory_panel.page_table[k].type = json_object_get_number(level, "type");
			if (data->memory_panel.page_table[k].type == 2)
				data->memory_panel.page_table[k].va_mask = json_object_get_number(level, "va_mask");
			data->memory_panel.page_table[k].system = json_object_get_number(level, "system");
			data->memory_panel.page_table[k].tmz = json_object_get_number(level, "tmz");
			data->memory_panel.page_table[k].mtype = json_object_get_number(level, "mtype");
		}
		data->memory_panel.num_page_table_entries = num_pt;
		data->memory_panel.decoded_addr = json_object_get_number(request, "address");
		data->memory_panel.decoded_vmid = json_object_get_number(request, "vmid");
	}
}
void send_vm_read_command(struct Link& lnk, AsicData &data, bool use_linear, bool decode_only = false) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", decode_only ? "vm-decode" : "vm-read");
	uint64_t addr;
	sscanf(data.memory_panel.vram_address, "%" SCNx64, &addr);
	json_object_set_number(json_object(req), "address", addr);
	json_object_set_number(json_object(req), "size", data.memory_panel.vram_size);
	if (!use_linear)
		json_object_set_number(json_object(req), "vmid", data.memory_panel.vmid);
	send_request(req, data.asic);
}

void process_ring_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	if (data->ring_panel.last_answer)
		json_value_free(json_object_get_wrapping_value(data->ring_panel.last_answer));
	data->ring_panel.last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));
}
void send_ring_command(struct Link& lnk, AsicData &data, const char *ring_name, bool halt_ring, bool rptr_wptr) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "ring");
	json_object_set_string(json_object(req), "ring", ring_name);
	json_object_set_boolean(json_object(req), "halt_waves", halt_ring);
	json_object_set_boolean(json_object(req), "rptr_wptr", rptr_wptr);
	send_request(req, data.asic);
}

void process_waves_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

  	data->waves_panel.active_shader = NULL;
	if (data->waves_panel.last_answer) {
		json_value_free(json_object_get_wrapping_value(data->waves_panel.last_answer));
  	}
	data->waves_panel.last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));

	data->waves_panel.details.max_vgpr = 0;

	JSON_Array *waves = json_array(json_object_get_value(data->waves_panel.last_answer, "waves"));
	int wave_count = json_array_get_count(waves);
	for (int i = 0; i < wave_count ; i++) {
		JSON_Object *wave = json_object(json_array_get_value(waves, i));
		JSON_Value *vgpr = json_object_get_value(wave, "vgpr");
		if (vgpr) {
			int s = json_array_get_count(json_array(vgpr));
			data->waves_panel.details.max_vgpr = std::max(s, data->waves_panel.details.max_vgpr);
		}
	}

	if (data->waves_panel.details.max_vgpr) {
		data->waves_panel.details.vgpr = (bool*)realloc(data->waves_panel.details.vgpr,
														wave_count * data->waves_panel.details.max_vgpr);
		data->waves_panel.details.view = (int*)realloc(data->waves_panel.details.view,
														wave_count * data->waves_panel.details.max_vgpr * sizeof(int));
		memset(data->waves_panel.details.vgpr, 0, wave_count * data->waves_panel.details.max_vgpr);
		memset(data->waves_panel.details.view, 0, wave_count * data->waves_panel.details.max_vgpr * sizeof(int));
	}
}
void send_waves_command(struct Link& lnk, AsicData &data, bool halt_waves, bool resume_waves, bool disable_gfxoff) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "waves");
	json_object_set_boolean(json_object(req), "halt_waves", halt_waves);
	json_object_set_boolean(json_object(req), "resume_waves", halt_waves && resume_waves);
	json_object_set_boolean(json_object(req), "disable_gfxoff", disable_gfxoff);
	json_object_set_string(json_object(req), "ring", data.asic->family >= FAMILY_NV ? "gfx_0.0.0" : "gfx");
	send_request(req, data.asic);
}

void process_power_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	if (data->power_panel.last_answer)
		json_value_free(json_object_get_wrapping_value(data->power_panel.last_answer));
	data->power_panel.last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));
}

void send_power_command(struct Link& lnk, AsicData &data, const char *new_value) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "power");
	if (new_value)
		json_object_set_string(json_object(req), "set", new_value);
	send_request(req, data.asic);
}

void process_sensors_command_answer(std::vector<AsicData*> *asics, JSON_Object *in)
{
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	if (data->power_panel.sensors_last_answer)
		json_value_free(json_object_get_wrapping_value(data->power_panel.sensors_last_answer));
	data->power_panel.sensors_last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));
	data->power_panel.consumed = false;
}

void send_sensors_command(struct Link& lnk, AsicData &data) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "sensors");
	send_request(req, data.asic);
}

void process_memory_usage_command_answer(std::vector<AsicData*> *asics, JSON_Object *in) {
	JSON_Object *request = json_object(json_object_get_value(in, "request"));
	JSON_Object *answer = json_object(json_object_get_value(in, "answer"));
	AsicData *data = answer_to_asic_data(asics, request);

	if (data->memory_usage_panel.last_answer)
		json_value_free(json_object_get_wrapping_value(data->memory_usage_panel.last_answer));
	data->memory_usage_panel.last_answer = json_object(json_value_deep_copy(json_object_get_wrapping_value(answer)));
}

void send_memory_usage_command(struct Link& lnk, AsicData &data) {
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "memory-usage");
	send_request(req, data.asic);
}

static void process_response(std::vector<AsicData*> *asics, JSON_Object *in) {
	JSON_Value *request = json_object_get_value(in, "request");
	const char *cmd = json_object_get_string(json_object(request), "command");
	JSON_Value *error = json_object_get_value(in, "error");


	if (!error && cmd) {
		if (!strcmp(cmd, "enumerate")) {
			process_enumerate_command_answer(asics, in);
		} else if (!strcmp(cmd, "read") || !strcmp(cmd, "write")) {
			process_read_reg_command_answer(asics, in);
		} else if (!strcmp(cmd, "ring")) {
			process_ring_command_answer(asics, in);
		} else if (!strcmp(cmd, "vm-decode") || !strcmp(cmd, "vm-read")) {
			process_vm_read_command_answer(asics, in);
		} else if (!strcmp(cmd, "power")) {
			process_power_command_answer(asics, in);
		} else if (!strcmp(cmd, "waves")) {
			process_waves_command_answer(asics, in);
		} else if (!strcmp(cmd, "sensors")) {
			process_sensors_command_answer(asics, in);
		} else if (!strcmp(cmd, "memory-usage")) {
			process_memory_usage_command_answer(asics, in);
		} else if (!strcmp(cmd, "accumulate")) {
			process_accumulate_command_answer(asics, in);
		}
	}

	force_redraw();
}

static void *communication_thread(void *_job) {
	int id = 0;
	char session_filename[512];
	while (id < 1024) {
		struct stat statbuf;
		sprintf(session_filename, "/tmp/umr_session.%d.json", id++);
		if (stat(session_filename, &statbuf) == -1 && errno == ENOENT)
			break;
	}
	JSON_Array *session = json_array(json_value_init_array());
	std::vector<AsicData*> *asics = (std::vector<AsicData*> *)_job;

	while (!done) {
		pthread_mutex_lock(&mtx);
		if (pending_request.empty())
			pthread_cond_wait(&cond, &mtx);
		for (int i = 0; i < pending_request.size(); i++) {
			JSON_Value* req = pending_request[i];
			pthread_mutex_unlock(&mtx);
			JSON_Value *in = query(lnk, req);
			pthread_mutex_lock(&mtx);

			/* Save to disk for replay */
			json_array_append_value(session, json_value_deep_copy(in));

			process_response(asics, json_object(in));

			json_value_free(in);
		}
		pending_request.clear();
		pthread_mutex_unlock(&mtx);

		json_serialize_to_file(json_array_get_wrapping_value(session), session_filename);
	}
	json_value_free(json_array_get_wrapping_value(session));
	return 0;
}


static bool kb_shortcut(int keycode) {
	return ImGui::GetIO().KeyCtrl && ImGui::IsKeyReleased(SDL_GetScancodeFromKey(keycode));
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

static void add_vertical_line(ImVec2& avail) {
	ImVec2 start = ImGui::GetCursorScreenPos();
	start.x -= ImGui::GetStyle().FramePadding.x;
	ImVec2 end = start;
	end.y += avail.y;
	ImGui::GetWindowDrawList()->AddLine(start, end, ImGui::GetColorU32(ImGuiCol_TabActive));
}

struct syntax_coloring {
   const char *expression;
   regex_t preg;
   size_t nmatch;
   const char * colors[6];
};

std::vector<syntax_coloring> regexps = {
   {
      /* PKT3_ */
      .expression = "(PKT3_[A-Z_0-9]*)",
      .colors = { "#3097a1" },
   },
   {
      /* number */
      .expression = "(0x[a-z0-9]*)",
      .colors = { "#dbde79" },
   },
   {
      /* keyword */
      .expression = "(PKT[0-3],|OPCODE)",
      .colors = { "#8f979c" },
   },
};

static uint32_t display_ib(struct umr_asic *asic, regmatch_t *pmatch, JSON_Array *raw, uint64_t base, int rptr = -1, int wptr = -1, int drv_wptr = -1)
{
	float addr_col_size = ImGui::CalcTextSize("Address").x;
	float raw_col_size = ImGui::CalcTextSize("Raw Value").x;
	uint32_t addr_lo_ib = 0;

	ImGuiListClipper clipper;
	clipper.Begin(json_array_get_count(raw));
	ImGui::Columns(4);
	ImGui::Text(rptr >= 0 ? "Index" : "Address");
	ImGui::NextColumn();
	ImGui::Text("Raw Value");
	ImGui::NextColumn();
	ImGui::Text("Pointers");
	ImGui::NextColumn();
	ImGui::Text("Disassembly");
	ImGui::NextColumn();
	ImGui::Separator();
	char tmp[1024];
	int nop_skipped = 0;

	struct umr_ring_decoder decoder;
	memset(&decoder, 0, sizeof decoder);
	decoder.pm = 4; /* TODO */
	decoder.pm4.cur_opcode = 0xFFFFFFFF;
	asic->options.no_follow_ib = 1;
	asic->options.use_colour = 0;
	asic->options.bitfields = 0;

	while (clipper.Step()) {
		for (int i = 0 ; i < clipper.DisplayEnd; i++) {
			uint32_t raw_value = json_array_get_number(raw, i);

			ring_decode_buffer_offset = 0;
			umr_print_decode(asic, &decoder, raw_value, ring_decode_fn);

			if (i < clipper.DisplayStart)
				continue;

			char *line = ring_decode_buffer;
			bool indent = false;

			char *ind = strstr(line, "---+");
			if (ind) {
				indent = true;
				line = &ind[5];
			}
			if (strncmp(line, "PKT3 ", strlen("PKT3 ")) == 0)
				line = &line[5];

			int idx = i;
			if (rptr >= 0)
				sprintf(tmp, "#0083d8%04d", idx);
			else
				sprintf(tmp, "#0083d8%" PRIx64, 4 * idx + base);
			addr_col_size = std::max(addr_col_size, ImGui::CalcTextSize(tmp).x);
			ImGui::TextUnformatted(tmp);
			ImGui::NextColumn();
			sprintf(tmp, "%08x", raw_value);
			raw_col_size = std::max(raw_col_size, ImGui::CalcTextSize(tmp).x);
			ImGui::TextUnformatted(tmp);
			ImGui::NextColumn();

			tmp[0] = '\0';
			if (idx == rptr)
				strcpy(tmp, "#d33682R ");
			if (idx == wptr)
				strcat(tmp, "#b58900W ");
			if (idx == drv_wptr)
				strcat(tmp, "#586e75DW");

			ImGui::TextUnformatted(tmp);
			ImGui::NextColumn();

			char copy[4096];
			int write_cursor;
			int size = ring_decode_buffer_offset;
			int ib_link_start = -1;
			for (size_t i = 0; i < regexps.size(); i++) {
				char *ptr = copy;
				write_cursor = 0;
				strcpy(copy, line);
				size = strlen(copy);
				int start = 0;
				int end = 0;
				bool one_match = false;

				while (true) {
					if ((regexec(&regexps[i].preg, ptr, regexps[i].nmatch + 1, pmatch, 0) == REG_NOMATCH) ||
						(pmatch[0].rm_so == -1))
						break;

					for (size_t group = 1; group <= regexps[i].nmatch; group++) {
						start = pmatch[group].rm_so;
						if (start < 0)
							continue;

						one_match = true;

						/* Copy everything until the match */
						memcpy(&line[write_cursor], &ptr[end], start - end);
						write_cursor += start - end;

						end = pmatch[group].rm_eo;
						/* Insert the color code, and copy the matching part */
						write_cursor += sprintf(&line[write_cursor], "%s%.*s%s", regexps[i].colors[group - 1],
							end - start,
							&ptr[start],
							"#ffffff");
					}
					ptr += end;
					end = 0;
				}

				if (one_match && size > 0) {
					/* Copy the reminder */
					memcpy(&line[write_cursor], ptr, size - (ptr - copy) + 1);
					write_cursor += size - (ptr - copy) + 1;
					line[write_cursor] = '\0';
				}
			}
			if (indent)
				ImGui::Indent();

			char *lnk = strstr(line, "IB_BASE_LO: ");
			if (lnk) {
				lnk += strlen("IB_BASE_LO: ");
				ImVec2 start = ImGui::CalcTextSize(line, lnk);
				ImVec2 end = ImGui::CalcTextSize(lnk, &lnk[17]);
				ImVec2 cursor = ImGui::GetCursorScreenPos();
				cursor.x += start.x;
				end.x += cursor.x;
				end.y += cursor.y;
				if (ImGui::IsMouseHoveringRect(cursor, end)) {
					sscanf(lnk + 7, "0x%08x", &addr_lo_ib);
					memcpy(lnk, "#ff8080", 7);
				}
			}

			ImGui::TextUnformatted(line);
			if (indent)
				ImGui::Unindent();
			ImGui::NextColumn();
		}
	}
	int p = 2 * ImGui::GetStyle().WindowPadding.x;
	ImGui::SetColumnWidth(0, addr_col_size + p);
	ImGui::SetColumnWidth(1, raw_col_size + p);
	ImGui::SetColumnWidth(2, ImGui::CalcTextSize("Pointers").x + p);
	ImGui::Columns(1);
	clipper.End();

	return addr_lo_ib;
}

static int run_gui(const char *url)
{
	pthread_mutexattr_t mat;
	pthread_mutexattr_init(&mat);
	pthread_mutexattr_settype(&mat, PTHREAD_MUTEX_RECURSIVE);
	pthread_mutex_init(&mtx, &mat);
	pthread_cond_init(&cond, NULL);

	bool replay = false;
	if (url) {
		struct stat statbuf;
		if (stat(url, &statbuf) == 0 && statbuf.st_mode & S_IFMT) {
			replay = true;
		} else {
			int rv;
			if ((lnk.sock = nn_socket(AF_SP, NN_REQ)) < 0) {
				exit(1);
			}
			if ((rv = nn_connect (lnk.sock, url)) < 0) {
				printf("Error: invalid url '%s'\n", url);
				exit(1);
			}
			int size = 100000000;
			if (nn_setsockopt(lnk.sock, NN_SOL_SOCKET, NN_RCVMAXSIZE, &size, sizeof(size)) < 0) {
				exit(0);
			}
			lnk.use_sock = true;
			lnk.endpoint = rv;
		}
	} else {
		lnk.use_sock = false;
	}

	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_GAMECONTROLLER) != 0) {
		printf("Error: %s\n", SDL_GetError());
		return -1;
	}

	std::vector<AsicData*> asics;

	pthread_t t_id;
	if (replay) {
		JSON_Array *session = json_array(json_parse_file(url));
		if (!session)
			return 1;
		for (int i = 0; i < json_array_get_count(session); i++) {
			process_response(&asics, json_object(json_array_get_value(session, i)));
		}
	} else {
		pthread_create(&t_id, NULL, communication_thread, &asics);
	}

	ImVec4 clear_color = ImColor(0, 43, 54, 255).Value;

	// GL 3.0 + GLSL 130
	const char *glsl_version = "#version 130";
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, 0);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);

	// Create window with graphics context
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
	SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
	SDL_WindowFlags window_flags =
		(SDL_WindowFlags)(SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI);

	char title[512];
	if (lnk.use_sock)
		sprintf(title, "umr (connected to %s)", url);
	else
		strcpy(title, "umr");
	SDL_Window *window = SDL_CreateWindow(title, SDL_WINDOWPOS_CENTERED,
													  SDL_WINDOWPOS_CENTERED, 1280, 720, window_flags);
	SDL_GLContext gl_context = SDL_GL_CreateContext(window);
	SDL_GL_MakeCurrent(window, gl_context);
	SDL_GL_SetSwapInterval(1); // Enable vsync

	// Initialize OpenGL loader
	if (gladLoadGL() == 0) {
		fprintf(stderr, "Failed to initialize OpenGL loader!\n");
		return 1;
	}

	// Setup Dear ImGui context
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO &io = ImGui::GetIO();
	(void)io;

	// Setup Dear ImGui style
	ImGui::StyleColorsDark();

	// Setup Platform/Renderer bindings
	ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
	ImGui_ImplOpenGL3_Init(glsl_version);

	MemoryEditor mem_edit;
	mem_edit.OptShowDataPreview = true;
	mem_edit.OptShowAscii = false;
	int need_auto_refresh = 0;

	struct timespec before;
	clock_gettime(CLOCK_MONOTONIC, &before);
	// Main loop
	done = false;

	regmatch_t *pmatch;
	{
		size_t max_nmatch = 0;
		for (size_t i = 0; i < regexps.size(); i++) {
			if (regcomp(&regexps[i].preg, regexps[i].expression, REG_EXTENDED) != 0) {
				printf("REGEXP '%s' failed\n", regexps[i].expression);
				continue;
			}

			regexps[i].nmatch = regexps[i].preg.re_nsub;
			assert (regexps[i].nmatch > 0);
			max_nmatch = std::max(max_nmatch, regexps[i].nmatch);
		}

		pmatch = (regmatch_t *)malloc(sizeof(regmatch_t) * (max_nmatch + 1));
	}

	send_enumerate_command(lnk);

	while (!done) {
		struct timespec now;
		clock_gettime(CLOCK_MONOTONIC, &now);
		float dt = now.tv_sec - before.tv_sec;
		if (now.tv_nsec < before.tv_nsec) {
			dt += ((1000000000 + now.tv_nsec) - before.tv_nsec) * 0.000000001 - 1;
		} else {
			dt += (now.tv_nsec - before.tv_nsec) * 0.000000001;
		}
		memcpy(&before, &now, sizeof(now));

		SDL_PumpEvents();

		SDL_Event event;
		/* Process all events, so the app get stuck SDL_WaitEvent() when there's nothing to do */
		if (need_auto_refresh && SDL_PeepEvents(&event, 1, SDL_PEEKEVENT, SDL_FIRSTEVENT, SDL_LASTEVENT) == 0) {
			need_auto_refresh--;
			/* Skip event processing */
			goto after_event_processing;
		}

		event_handling:
		if (SDL_WaitEventTimeout(&event, 500)) {
			need_auto_refresh = 3;
			ImGui_ImplSDL2_ProcessEvent(&event);
			if (event.type == SDL_QUIT)
				done = true;
			if (event.type == SDL_WINDOWEVENT && event.window.event == SDL_WINDOWEVENT_CLOSE &&
				 event.window.windowID == SDL_GetWindowID(window))
				done = true;
		}

		if (SDL_PeepEvents(&event, 1, SDL_PEEKEVENT, SDL_FIRSTEVENT, SDL_LASTEVENT) > 0)
			goto event_handling;

		after_event_processing:

		// Start the Dear ImGui frame
		ImGui_ImplOpenGL3_NewFrame();
		ImGui_ImplSDL2_NewFrame(window);
		ImGui::NewFrame();

		ImGui::SetNextWindowPos(ImVec2(0, 0));
		int w, h;
		SDL_GetWindowSize(window, &w, &h);
		ImGui::SetNextWindowSize(ImVec2(w, h));
		ImGui::Begin("umr", NULL, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize |
								  ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoScrollWithMouse);

		ImVec2 topleft = ImGui::GetCursorScreenPos();
		ImVec2 avail = ImGui::GetContentRegionAvail();
		avail.x -= 2 * ImGui::GetStyle().WindowPadding.x;

		float _8digitsize = ImGui::CalcTextSize("0x00000000").x + ImGui::GetStyle().FramePadding.x * 2;

		pthread_mutex_lock(&mtx);

		ImGui::BeginTabBar("asics", ImGuiTabBarFlags_None);

		if (asics.empty()) {
			if (url)
				ImGui::Text("No answer from %s yet...", url);
			else if (getuid() != 0 && geteuid() != 0) {
				ImGui::Text("No amdgpu devices found. Try running umr as root/sudo.");
			} else {
				ImGui::Text("No amdgpu devices found");
			}
		}

		for (int i = 0; i < asics.size(); i++) {
			AsicData &data = *asics[i];

			char asic[64];
			sprintf(asic, "%s (instance: %d)", data.asic->asicname, data.asic->instance);
			if (!ImGui::BeginTabItem(asic, NULL))
				continue;


			ImGui::BeginTabBar("tabs", ImGuiTabBarFlags_None);


			/*----------------------------------- Asic Info tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900I#ffffffnfo", NULL, kb_shortcut(SDLK_i) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static const char *families[] = {
						"SI", "CIK", "VI", "AI", "NV", "NPI"
				};
				ImGui::BeginChild("Info");
				JSON_Object *a = data.info_panel.last_answer;
				ImGui::BeginTable("Info", 2, ImGuiTableFlags_Borders, ImVec2(avail.x / 2, 0));
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("ASIC name");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%s", data.asic->asicname);
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("Instance");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%d", data.asic->instance);
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("DID");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%02x:#b58900%02x", (data.asic->did >> 8) & 0xff, data.asic->did & 0xff);
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("Family");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%s", families[data.asic->family]);
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("VRAM");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%6d MB", (int) (json_object_get_number(a, "vram_size") / (1024 * 1024)));
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("Visible VRAM");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%6d MB", (int) (json_object_get_number(a, "vis_vram_size") / (1024 * 1024)));
				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0); ImGui::Text("vBios version");
				ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%s", json_object_get_string(a, "vbios_version"));
				ImGui::EndTable();
				
				ImGui::BeginTable("Firmwares", 3, ImGuiTableFlags_Borders, ImVec2(avail.x / 2, 0));
				ImGui::TableSetupColumn("Firmware");
				ImGui::TableSetupColumn("Feature version");
				ImGui::TableSetupColumn("Firmware version");
				ImGui::TableHeadersRow();
				JSON_Array *fws = json_object_get_array(a, "firmwares");
				for (int j = 0; j < json_array_get_count(fws); j++) {
					JSON_Object *fw = json_object(json_array_get_value(fws, j));
					ImGui::TableNextRow();
					ImGui::TableSetColumnIndex(0);
					ImGui::TextUnformatted(json_object_get_string(fw, "name")); ImGui::NextColumn(); ImGui::NextColumn();
					ImGui::TableSetColumnIndex(1);
					ImGui::Text("#b589000x%x", (unsigned)json_object_get_number(fw, "feature_version")); ImGui::NextColumn();
					ImGui::TableSetColumnIndex(2);
					ImGui::Text("#b589000x%x", (unsigned)json_object_get_number(fw, "firmware_version")); ImGui::NextColumn();
				}
				ImGui::EndTable();
				ImGui::Separator();
				int j = 0;
				while (data.asic->config.fw[j].name[0] != '\0') {
					ImGui::TextUnformatted(data.asic->config.fw[j].name); ImGui::NextColumn(); ImGui::NextColumn();
					ImGui::Text("#b589000x%x", data.asic->config.fw[j].feature_version); ImGui::NextColumn();
					ImGui::Text("#b589000x%x", data.asic->config.fw[j].firmware_version); ImGui::NextColumn();
				}
				ImGui::EndChild();
				ImGui::EndTabItem();
			}

			/*----------------------------------- Blocks/Registers Info tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900R#ffffffegisters", NULL, kb_shortcut(SDLK_r) ? ImGuiTabItemFlags_SetSelected : 0)) {
				/* Split pane */
				ImGui::BeginChild("Registers list", ImVec2(avail.x / 3, 0), false,
									ImGuiWindowFlags_NoTitleBar);
				char details[128];
				for (int i = 0; i < (int) data.asic->no_blocks; i++) {
					unsigned matching = 0;
					struct umr_ip_block *b = data.asic->blocks[i];
					if (data.register_filter[0] != '\0' || data.register_field_filter[0] != '\0') {
						for (int j = 0; j < b->no_regs; j++) {
							if (data.register_filter[0] != '\0' && fuzzy_match_simple(data.register_filter, b->regs[j].regname)) {
								matching++;
							} else if (data.register_field_filter[0] != '\0') {
								for (int k = 0; k < b->regs[j].no_bits; k++) {
									if (b->regs[j].bits[k].regname &&
										  fuzzy_match_simple(data.register_field_filter, b->regs[j].bits[k].regname)) {
										matching++;
										break;
									}
								}
							}
						}
						if (matching == 0)
							continue;
						sprintf(details, "%d/%d registers", matching, b->no_regs);
					} else {
						sprintf(details, "%d registers", b->no_regs);
					}
					if (ImGui::TreeNodeEx(b->ipname, (matching && matching < 10) ? ImGuiTreeNodeFlags_Leaf : 0, "%12s (%s)", b->ipname, details)) {
						bool at_least_one = matching > 0;
						for (int j = 0; j < b->no_regs; j++) {
							bool pinned = false;
							for (int k = 0; k < (int) data.blocks_panel.pinned_registers.size() && !pinned; k++)
								pinned = data.blocks_panel.pinned_registers[k].reg == &b->regs[j];

							if (data.register_filter[0] != '\0' && !fuzzy_match_simple(data.register_filter, b->regs[j].regname))
								continue;

							if (data.register_field_filter[0] != '\0') {
								bool show = false;
								for (int k = 0; k < b->regs[j].no_bits; k++) {
									if (b->regs[j].bits[k].regname &&
										  fuzzy_match_simple(data.register_field_filter, b->regs[j].bits[k].regname)) {
										show = true;
										break;
									}
								}

								if (!show)
									continue;
							}
							at_least_one = true;
							if (pinned) {
								ImGui::TextUnformatted(b->regs[j].regname);
							} else if (ImGui::Button(b->regs[j].regname)) {
								data.blocks_panel.pinned_registers.push_back(PinnedRegister(b, &b->regs[j]));
								send_read_reg_command(lnk, data, &data.blocks_panel.pinned_registers.back());
							}
						}
						if (!at_least_one) {
							ImGui::Text("No matching registers");
						}
						ImGui::TreePop();
					}
				}
				ImGui::EndChild();
				ImGui::SameLine();

				ImGui::BeginChild("Filters:", ImVec2(2 * avail.x / 3, 0), false, ImGuiWindowFlags_NoTitleBar);
				ImGui::NewLine();
				ImGui::Text("Filters");
				if (kb_shortcut(SDLK_f))
					ImGui::SetKeyboardFocusHere();
				ImGui::InputText("Register name	  ", data.register_filter, sizeof(data.register_filter));
				ImGui::SameLine();
				if (ImGui::Button("Clear") || (kb_shortcut(SDLK_BACKSPACE)))
					data.register_filter[0] = '\0';
				ImGui::InputText("Register field name", data.register_field_filter, sizeof(data.register_field_filter));
				ImGui::SameLine();
				ImGui::PushID("Field");
				if (ImGui::Button("Clear") || (ImGui::GetIO().KeyCtrl && ImGui::IsKeyReleased(SDLK_BACKSPACE)))
					data.register_field_filter[0] = '\0';
				ImGui::PopID();
				ImGui::Separator();
				ImGui::Text("Register watchlist:");
				ImGui::NewLine();
				bool auto_read_reg = false;
				if (data.blocks_panel.pinned_registers.empty()) {
					ImGui::Indent();
					ImGui::Text("(Click on a register name to add it to the watchlist.)");
					ImGui::Unindent();
					ImGui::NewLine();
				} else {
					if (!replay && ImGui::Checkbox("Auto-refresh", &data.blocks_panel.autorefresh)) {
						data.blocks_panel.elapsed_since_last_refresh = 0;
					}
					if (data.blocks_panel.autorefresh) {
						ImGui::SameLine();
						need_auto_refresh = -1;
						data.blocks_panel.elapsed_since_last_refresh += dt;
						ImGui::SetNextItemWidth(_8digitsize);
						ImGui::InputInt("Frequency", &data.blocks_panel.autorefresh_hz);
						ImGui::SameLine();
						ImGui::ProgressBar(data.blocks_panel.elapsed_since_last_refresh / data.blocks_panel.autorefresh_hz, ImVec2(), "");
						if (data.blocks_panel.elapsed_since_last_refresh >= data.blocks_panel.autorefresh_hz) {
							data.blocks_panel.elapsed_since_last_refresh = 0;
							auto_read_reg = true;
						}
					}
				}

				ImGui::BeginTable("register", 7, ImGuiTableFlags_SizingStretchProp |
												 ImGuiTableFlags_Borders);
				ImGui::TableSetupColumn("Pin", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" R ").x);
				ImGui::TableSetupColumn("Name", ImGuiTableColumnFlags_WidthStretch);
				ImGui::TableSetupColumn("Address", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" 0x00000000 ").x);
				ImGui::TableSetupColumn("Value", ImGuiTableColumnFlags_WidthFixed, 120);
				ImGui::TableSetupColumn("Bitfield");
				ImGui::TableSetupColumn("R", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" R ").x);
				ImGui::TableSetupColumn("W", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" R ").x);
				ImGui::TableHeadersRow();
				for (int i = 0; i < (int) data.blocks_panel.pinned_registers.size(); ++i) {
					bool pin = true;
					PinnedRegister& pinned = data.blocks_panel.pinned_registers[i];
					ImGui::PushID(pinned.reg->regname);
	
					ImGui::TableNextRow();
					ImGui::TableSetColumnIndex(0);
					if (ImGui::Checkbox(" ", &pin)) {
						data.blocks_panel.pinned_registers.erase(data.blocks_panel.pinned_registers.begin() + i);
						i--;
					}
					ImGui::TableSetColumnIndex(1); ImGui::TextUnformatted(pinned.reg->regname);
					ImGui::TableSetColumnIndex(2); ImGui::Text("0x%08lx", pinned.reg->addr);
					ImGui::TableSetColumnIndex(3);
					{
						char tmp[512];
						bool was_dirty = pinned.value_is_dirty;
						if (was_dirty)
							ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0, 0, 1));
						sprintf(tmp, "0x%08lx", pinned.reg->value);
						if (ImGui::InputText("", tmp, 16, ImGuiInputTextFlags_CharsHexadecimal)) {
							unsigned value;
							if (sscanf(tmp, "0x%x", &value) == 1) {
								pinned.reg->value = value;
								pinned.value_is_dirty = true;
								force_redraw();
							}
						}
						if (was_dirty)
							ImGui::PopStyleColor();
					}
					ImGui::TableSetColumnIndex(4);
					ImGui::BeginTable("bitfield", 2);
					ImGui::TableSetupColumn("Field");
					ImGui::TableSetupColumn("Value", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" 0x00000000 ").x);
					for (int j = 0; j < pinned.reg->no_bits; j++) {
						ImGui::TableNextRow();
						struct umr_bitfield *bit = &pinned.reg->bits[j];
						ImGui::TableSetColumnIndex(0);
						ImGui::Text("#b58900%s [%d:%d]", bit->regname, bit->stop, bit->start);

						unsigned mask = 0;
						for (unsigned k = bit->start; k <= bit->stop; k++)
							mask |= 1u << k;
						unsigned v = (pinned.reg->value & mask) >> bit->start;
						ImGui::PushID(bit->regname);
						ImGui::SetNextItemWidth(_8digitsize);
						ImGui::TableSetColumnIndex(1);
						char tmp[16];
						sprintf(tmp, "0x%x", v);
						if (ImGui::InputText("", tmp, 10, ImGuiInputTextFlags_CharsHexadecimal)) {
							if (sscanf(tmp, "0x%x", &v) == 1) {
								v = v & mask;
								pinned.reg->value = (pinned.reg->value & ~mask) | (v << (unsigned)bit->start);
								pinned.value_is_dirty = true;
								force_redraw();
							}
						}
						ImGui::PopID();
					}
					ImGui::EndTable();

					ImGui::BeginDisabled(!pending_request.empty());
					bool read = false;
					ImGui::TableSetColumnIndex(5);
					ImGui::BeginDisabled(!pending_request.empty());
					if (ImGui::ArrowButton("read", ImGuiDir_Down) || auto_read_reg) {
						send_read_reg_command(lnk, data, &pinned);
					}
					if (pinned.value_is_dirty) {
						ImGui::TableSetColumnIndex(6);
						if (ImGui::ArrowButton("write", ImGuiDir_Up)) {
							send_write_reg_command(lnk, data, &pinned, pinned.reg->value);
						}
					}
					ImGui::EndDisabled();
					ImGui::EndDisabled();
					ImGui::PopID();
				}
				ImGui::EndTable();
				ImGui::EndChild();

				ImGui::EndTabItem();
			}

			/*----------------------------------- Waves tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900W#ffffffaves", NULL, kb_shortcut(SDLK_w) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static bool halt = true;
				static bool resume = true;
				static bool turn_off_gfxoff = true;

				ImGui::Checkbox("Disable gfxoff", &turn_off_gfxoff);
				ImGui::SameLine();
				ImGui::Checkbox("Halt waves", &halt);
				if (halt) {
					ImGui::SameLine();
					ImGui::Checkbox("Resume waves", &resume);
				}
				ImGui::SameLine();
				ImGui::BeginDisabled(!pending_request.empty());
				if (ImGui::Button("Query")) {
					send_waves_command(lnk, data, halt, resume, turn_off_gfxoff);
				}
				ImGui::EndDisabled();

				ImGui::Separator();
				if (data.waves_panel.last_answer) {
					ImGui::BeginChild("Waves", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
					JSON_Array *waves = json_object_get_array(data.waves_panel.last_answer, "waves");
					JSON_Object *shaders = json_object(json_object_get_value(data.waves_panel.last_answer, "shaders"));
					bool force_scroll = false;
					int w = json_array_get_count(waves);
					for (int i = 0; i < w; i++) {
						JSON_Object *wave = json_object(json_array_get_value(waves, i));
						JSON_Object *status = json_object(json_object_get_value(wave, "status"));

						ImGui::PushID(i);

						if (ImGui::TreeNode("wave", "Wave %d", i)) {
							ImGui::Columns(4);
							ImGui::Text("se: #b58900%d", json_object_get_number(wave, "se"));
							ImGui::NextColumn();
							ImGui::Text("sh: #b58900%d", json_object_get_number(wave, "sh"));
							ImGui::NextColumn();
							ImGui::Text("cu: #b58900%d", json_object_get_number(wave, "cu"));
							ImGui::NextColumn();
							ImGui::Text("simd_id: #b58900%d", json_object_get_number(wave, "simd_id"));
							ImGui::NextColumn();
							ImGui::Text("wave_id: #b58900%d", json_object_get_number(wave, "wave_id"));
							ImGui::NextColumn();
							const char *dis = json_object_get_string(wave, "shader_disassembly");
							if (dis) {
								char label[128];
								sprintf(label, "PC: 0x%lx", (uint64_t)json_object_get_number(wave, "PC"));
								if (ImGui::Button(label)) {
									data.waves_panel.active_shader = json_object_get_array(shaders, dis);
									sscanf(dis, "%" PRIx64, &data.waves_panel.base_address);
									data.waves_panel.pc = json_object_get_number(wave, "PC");

									force_scroll = true;
								}
							} else {
								ImGui::Text("PC: 0x%lx", json_object_get_number(wave, "PC"));
							}
							ImGui::Columns(2);
							ImGui::Text("wave_inst_dw0: #b589000x%08x", json_object_get_number(wave, "wave_inst_dw0"));
							ImGui::NextColumn();
							ImGui::Text("wave_inst_dw1: #b589000x%08x", json_object_get_number(wave, "wave_inst_dw1"));
							ImGui::NextColumn();
							ImGui::Columns(1);
							if (ImGui::TreeNodeEx("Status")) {
								ImGui::Columns(4);
								size_t n = json_object_get_count(status);
								for (size_t j = 0; j < n; j++) {
									ImGui::Text("%s: #b58900%d", json_object_get_name(status, j),
																 (unsigned)json_number(json_object_get_value_at(status, j)));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}
							if (ImGui::TreeNodeEx("Hardware Id")) {
								ImGui::Columns(4);
								JSON_Object *hw_id = json_object(json_object_get_value(wave, "hw_id"));
								size_t n = json_object_get_count(hw_id);
								for (size_t j = 0; j < n; j++) {
									ImGui::Text("%s: #b58900%d", json_object_get_name(hw_id, j),
																 (unsigned)json_number(json_object_get_value_at(hw_id, j)));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}
							if (ImGui::TreeNodeEx("GPR Alloc")) {
								ImGui::Columns(4);
								JSON_Object *gpr_alloc = json_object(json_object_get_value(wave, "gpr_alloc"));
								size_t n = json_object_get_count(gpr_alloc);
								for (size_t j = 0; j < n; j++) {
									ImGui::Text("%s: #b58900%d", json_object_get_name(gpr_alloc, j),
																 (unsigned)json_number(json_object_get_value_at(gpr_alloc, j)));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}

							{
								static const char *formats[] = { "s%*d: #d33682%d", "s%*d: #d33682%u", "s%*d: #d33682%08x" };
								JSON_Array *sgpr = json_object_get_array(wave, "sgpr");
								if (sgpr && ImGui::TreeNodeEx("#d33682SGPRs")) {
									static int mode = 2;
									ImGui::Text("Display as:");
									ImGui::SameLine();
									ImGui::RadioButton("int", &mode, 0);
									ImGui::SameLine();
									ImGui::RadioButton("uint", &mode, 1);
									ImGui::SameLine();
									ImGui::RadioButton("hex", &mode, 2);
									ImGui::SameLine();
									ImGui::RadioButton("float", &mode, 3);
									ImGui::Columns(4);
									ImGui::PushID("sgpr");
									int s = json_array_get_count(sgpr);
									int align = s > 99 ? 3 : 2;
									for (int i = 0; i < s; i++) {
										JSON_Value *v = json_array_get_value(sgpr, i);
										ImGui::PushID(v);
										int aaa = (int)json_number(v);
										if (mode == 3) {
											float f = reinterpret_cast<float&>(aaa);
											ImGui::Text("s%*d: #d33682%f", align, i, f);
										} else {
											ImGui::Text(formats[mode], align, i, aaa);
										}
										ImGui::PopID();
										ImGui::NextColumn();
									}
									ImGui::PopID();
									ImGui::Columns(1);
									ImGui::TreePop();
								}
							}

							{
								static const char *formats[] = { "#6c71c4%d", "#6c71c4%u", "#6c71c4%08x" };
								JSON_Array *vgpr = json_object_get_array(wave, "vgpr");
								if (vgpr && ImGui::TreeNodeEx("#6c71c4VGPRs")) {
									int s = json_array_get_count(vgpr);

									ImGui::BeginTable("vgprvalues", 5, ImGuiTableFlags_Borders);
									ImGui::TableSetupColumn("Base");
									ImGui::TableSetupColumn("+ 0");
									ImGui::TableSetupColumn("+ 1");
									ImGui::TableSetupColumn("+ 2");
									ImGui::TableSetupColumn("+ 3");
									ImGui::TableHeadersRow();
									char label[128];
									for (int i = 0; i < s; i++) {
										ImGui::PushID(i);
										ImGui::TableNextRow();
										ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TableRowBgAlt));
										ImGui::TableSetColumnIndex(0);
										sprintf(label, "show v%2d", i);
										ImGui::Checkbox(label, &data.waves_panel.details.vgpr[i * data.waves_panel.details.max_vgpr]);
										if (data.waves_panel.details.vgpr[i * data.waves_panel.details.max_vgpr]) {
											int *mode = &data.waves_panel.details.view[i * data.waves_panel.details.max_vgpr];
											ImGui::TableSetColumnIndex(1);
											ImGui::RadioButton("as int", mode, 0);
											ImGui::TableSetColumnIndex(2);
											ImGui::RadioButton("as uint", mode, 1);
											ImGui::TableSetColumnIndex(3);
											ImGui::RadioButton("as hex", mode, 2);
											ImGui::TableSetColumnIndex(4);
											ImGui::RadioButton("as float", mode, 3);

											JSON_Array *vg = json_array_get_array(vgpr, i);
											int num_thread = json_array_get_count(vg);

											for (int j = 0; j < num_thread; j++) {
												if (j % 4 == 0) {
													ImGui::TableNextRow();
													ImGui::TableSetColumnIndex(0);
													ImGui::Text("%d", j);
												}
												ImGui::TableSetColumnIndex(1 + j % 4);

												JSON_Value *v = json_array_get_value(vg, i);
												ImGui::PushID(v);
												int aaa = (int)json_number(v);
												if (*mode == 3) {
													float f = reinterpret_cast<float&>(aaa);
													ImGui::Text("#6c71c4%f", f);
												} else {
													ImGui::Text(formats[*mode], aaa);
												}
												ImGui::PopID();
											}
										}
										ImGui::PopID();
									}
									ImGui::EndTable();
									ImGui::TreePop();
								}
							}

							{
								JSON_Array *threads = json_object_get_array(wave, "threads");
								if (threads) {
									int s = json_array_get_count(threads);
									int active = 0;
									for (int i = 0; i < s; i++) {
										active += json_array_get_boolean(threads, i);
									}

									if (ImGui::TreeNode(threads, "Threads (%d active)", active)) {
										ImGui::Columns(4);
										for (int i = 0; i < s; i++) {
											ImGui::Text("t%d: %s", i,
												json_array_get_boolean(threads, i) ?
														"#859900on" : "#dc322foff");
											ImGui::NextColumn();
										}
										ImGui::Columns(1);
										ImGui::TreePop();
									}
								}
							}

							ImGui::TreePop();
						}
						ImGui::PopID();
					}
					ImGui::EndChild();
					ImGui::SameLine();
					ImGui::BeginChild("Shaders", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
					if (data.waves_panel.active_shader) {
						static regex_t syntax_coloring_regexp;
						static int regexp_init = 0;
						static size_t nmatch;
						static regmatch_t *pmatch = NULL;
						if (regexp_init == 0) {
							const char *regexp =
								"\\b(s[[:alnum:]]*|s\\[[[:alnum:]]*:[[:alnum:]]*\\])\\b|" // sgpr
								"\\b(v[[:alnum:]]*|v\\[[[:alnum:]]*:[[:alnum:]]*\\])\\b|" // vgpr
								"(0x[[:alnum:]]*)\\b|"									// constants
								"(;)"													 // comment
								;

							if (regcomp(&syntax_coloring_regexp, regexp, REG_EXTENDED) != 0) {
								printf("Regexp error\n");
								regexp_init = -1;
							} else {
								regexp_init = 1;
								nmatch = syntax_coloring_regexp.re_nsub;
								pmatch = (regmatch_t *)malloc(sizeof(regmatch_t) * (syntax_coloring_regexp.re_nsub + 1));
							}
						}

						int s = json_array_get_count(data.waves_panel.active_shader);
						int scroll = 0;
						float addr_col_size = 0;
						float raw_col_size = 0;

						ImGuiListClipper clipper;
						clipper.Begin(s);
						ImGui::Columns(3);
						ImGui::Text("Index");
						ImGui::NextColumn();
						ImGui::Text("Raw Value");
						ImGui::NextColumn();
						ImGui::Text("Disassembly");
						ImGui::NextColumn();
						ImGui::Separator();
						char tmp[1024];
						while (clipper.Step()) {
							for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++) {
								uint64_t addr = data.waves_panel.base_address + i * 4;
								const char *src = json_array_get_string(data.waves_panel.active_shader, i);
								bool is_pc = data.waves_panel.pc == addr;
								if (is_pc) {
									/* PC points to this instruction */
									scroll = ImGui::GetCursorPos().y;
									ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0.5, 0.5, 1));
								}
								const char *tknOpen = strchr(src, '[');
								const char *tkn = strchr(tknOpen, ']');
								sprintf(tmp, "%.*s", (int) (tkn - tknOpen + 1), tknOpen);
								addr_col_size = std::max(addr_col_size, ImGui::CalcTextSize(tmp).x);
								ImGui::TextUnformatted(tmp);
								ImGui::NextColumn();
								tkn += 4;
								sprintf(tmp, "%.10s", tkn);
								ImGui::TextUnformatted(tmp);
								raw_col_size = std::max(raw_col_size, ImGui::CalcTextSize(tmp).x);
								ImGui::NextColumn();
								tkn += 12;

								/* syntax coloring */
								char buf[2048];
								int wr = 0;
								const char *line = tkn;
								do {
									int r = pmatch ? regexec(&syntax_coloring_regexp, line, nmatch + 1, pmatch, 0) : -1;
									if (r == REG_NOMATCH || pmatch[0].rm_so == -1) {
										strcpy(&buf[wr], line);
										break;
									} else {
										for (size_t z = 0; z < nmatch; z++) {
											if (pmatch[1 + z].rm_so == pmatch[0].rm_so) {
												int st = pmatch[1 + z].rm_so;
												int end = pmatch[1 + z].rm_eo;
												const char *modifier = "";
													switch (z) {
													case 0: modifier = "#d33682"; break; // sgpr
													case 1: modifier = "#6c71c4"; break; // vgpr
													case 2: modifier = "#b58900"; break; // constants
													case 3: modifier = "#586e75"; break; // comments
													default:
														break;
												}
												memcpy(&buf[wr], line, st);
												wr += st;
												wr += sprintf(&buf[wr], "%s%.*s", modifier, end - st, &line[st]);
												line = &line[end];
												break;
											}
										}
									}
								} while (true);

								ImGui::TextUnformatted(buf);

								ImGui::NextColumn();
								if (is_pc)
									 ImGui::PopStyleColor();
							}
						}
						int p = 2 * ImGui::GetStyle().WindowPadding.x;
						ImGui::SetColumnWidth(0, addr_col_size + p);
						ImGui::SetColumnWidth(1, raw_col_size + p);
						ImGui::Columns(1);
						clipper.End();
						if (force_scroll) {
							force_scroll = false;
							ImGui::SetScrollY(scroll - avail.y / 2);
							force_redraw();
						}
					} else {
						ImGui::Text("Click on a wave's PC to show its shader disassembly");
					}
					ImGui::EndChild();
				} else {
					ImGui::Text("No waves.");
				}
				ImGui::EndTabItem();
			}

			/*----------------------------------- Rings tab -----------------------------------*/
			if (ImGui::BeginTabItem("Rin#b58900g#ffffffs", NULL, kb_shortcut(SDLK_g) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static int current_item = data.ring_panel.num_rings - 1;
				static bool halt = true;
				static bool rptr_wptr = true;

				ImGui::Checkbox("Halt waves", &halt);
				ImGui::SameLine();
				ImGui::TextUnformatted("Select ring:");
				ImGui::SameLine();
				ImGui::SetNextItemWidth(_8digitsize * 4);
				ImGui::PushID("selectring");
				ImGui::Combo("", &current_item, data.ring_panel.rings, data.ring_panel.num_rings);
				ImGui::PopID();
				ImGui::SameLine();
				ImGui::BeginDisabled(!pending_request.empty());
				ImGui::Checkbox("Limit to rptr/wptr", &rptr_wptr);
				ImGui::SameLine();
				if (!replay && ImGui::Button("Read")) {
					send_ring_command(lnk, data, &data.ring_panel.rings[current_item][strlen("amdgpu_ring_")], halt, rptr_wptr);
				}
				ImGui::EndDisabled();
				ImGui::Separator();
				if (data.ring_panel.last_answer) {
					JSON_Array *raw = json_object_get_array(data.ring_panel.last_answer, "raw");

					int rptr = json_object_get_number(data.ring_panel.last_answer, "read_ptr");
					int wptr = json_object_get_number(data.ring_panel.last_answer, "write_ptr");
					int drv_wptr = json_object_get_number(data.ring_panel.last_answer, "driver_write_ptr");

					ImGui::BeginTabBar("ringtabs", ImGuiTabBarFlags_None);
					
					uint32_t highlight_lo_ib = 0;
					if (ImGui::BeginTabItem("Ring Content")) {
						ImGui::BeginChild("ringtabs scroll");
						highlight_lo_ib = display_ib(data.asic, pmatch, raw, 0, rptr, wptr, drv_wptr);
						ImGui::EndChild();
						ImGui::EndTabItem();
					}
					JSON_Array *ibs = json_object_get_array(data.ring_panel.last_answer, "ibs");
					for (int i = 0; i < json_array_get_count(ibs); i++) {
						JSON_Object *ib = json_object(json_array_get_value(ibs, i));
						uint64_t base = (uint64_t) json_object_get_number(ib, "address");
						int high = (((uint32_t)base) == highlight_lo_ib);

						if (high)
							ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0.5, 0.5, 1));

						char tmp[128];
						sprintf(tmp, "IB @ %" PRIx64, base);
						if (ImGui::BeginTabItem(tmp)) {
							if (high)
								ImGui::PopStyleColor();
							ImGui::BeginChild(tmp);
							highlight_lo_ib = display_ib(data.asic, pmatch, json_object_get_array(ib, "opcodes"), base);
							ImGui::EndChild();
							ImGui::EndTabItem();		
						} else if (high) {
							ImGui::PopStyleColor();
						}
					}
					
					ImGui::EndTabBar();
				}
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900P#ffffffower", NULL, kb_shortcut(SDLK_p) ? ImGuiTabItemFlags_SetSelected : 0)) {
				ImGui::BeginChild("power profiles", ImVec2(avail.x / 3, 0), false, ImGuiWindowFlags_NoTitleBar);
				static float last_sensor_read = 0;
				static float sensor_read_interval = 0.5;
				if (!data.power_panel.last_answer) {
					send_power_command(lnk, data, NULL);
					last_sensor_read = 0;
				} else {
					ImGui::Text("Select DPM profile :");
					ImGui::Indent();
					ImGui::BeginDisabled(!pending_request.empty());
					JSON_Array *profiles = json_object_get_array(data.power_panel.last_answer, "profiles");
					const char *current = json_object_get_string(data.power_panel.last_answer, "current");
					for (int i = 0; i < json_array_get_count(profiles) ; i++) {
						const char *profile = json_array_get_string(profiles, i);
						if (ImGui::RadioButton(profile, !strcmp(current, profile))) {
							send_power_command(lnk, data, profile);
							last_sensor_read = 10;
						}
					}
					ImGui::EndDisabled();
					ImGui::Unindent();
				}
				ImGui::EndChild();
				ImGui::SameLine();
				ImGui::BeginChild("power sensors", ImVec2(avail.x * 2.0/ 3, 0), false, ImGuiWindowFlags_NoTitleBar);
				ImGui::Text("Sensors values:");
				if (last_sensor_read > sensor_read_interval) {
					if (pending_request.empty())
						send_sensors_command(lnk, data);
					last_sensor_read = 0;
				}
				last_sensor_read += dt;

				if (data.power_panel.sensors_last_answer) {
					ImGui::DragFloat("Refresh interval (drag to modify)", &sensor_read_interval, 0.1, 0.1, 5, "%.1f sec");

					const int old_value_count = 100;
					JSON_Array *values = json_object_get_array(data.power_panel.sensors_last_answer, "values");
					int sensors_count = json_array_get_count(values);

					if (!data.power_panel.sensor_previous_values) {
						data.power_panel.sensor_previous_values = (float *)calloc(sensors_count * old_value_count, sizeof(float));
						data.power_panel.sensor_values_offset = 0;
					}

					for (int i = 0; i < sensors_count; i++) {
						JSON_Object *v = json_object(json_array_get_value(values, i));
						data.power_panel.sensor_previous_values[i * old_value_count + data.power_panel.sensor_values_offset] =
							(int)json_object_get_number(v, "value");

						ImGui::PlotLines(json_object_get_string(v, "name"),
											 &data.power_panel.sensor_previous_values[i * old_value_count],
											 old_value_count,
											 data.power_panel.sensor_values_offset + 1,
											 NULL,
											 json_object_get_number(v, "min"),
											 json_object_get_number(v, "max"),
											 ImVec2(0, avail.y / (2 + sensors_count)));
						ImGui::SameLine();
						ImGui::Text(": %d %s",
							(int)data.power_panel.sensor_previous_values[i * old_value_count + data.power_panel.sensor_values_offset],
							json_object_get_string(v, "unit"));
					}
					if (!data.power_panel.consumed) {
						data.power_panel.sensor_values_offset = (data.power_panel.sensor_values_offset + 1) % old_value_count;
						data.power_panel.consumed = true;
					}
					need_auto_refresh = -1;
				}
				ImGui::EndChild();
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900M#ffffffemory Usage", NULL, kb_shortcut(SDLK_m) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static float last_vm_read = 10;
				static float autorefresh = 0;
				if (pending_request.empty()) {
					if (!data.memory_usage_panel.last_answer || (autorefresh && last_vm_read > autorefresh))
						send_memory_usage_command(lnk, data);
					last_vm_read = 0;
				}
				last_vm_read += dt;

				ImGui::DragFloat("Refresh interval (drag to modify)", &autorefresh, 0.1, 0, 10, "%.1f sec");

				if (data.memory_usage_panel.last_answer) {
					const char * titles[] = { "VRAM", "GTT", "Visible VRAM" };
					const char * names[] = { "vram", "gtt", "vis_vram" };

					char overlay[200];
					for (int i = 0; i < 3; i++) {
						JSON_Object *o = json_object(json_object_get_value(data.memory_usage_panel.last_answer, names[i]));
						ImGui::Text("%*sUsed %s", (int)(strlen(titles[i]) - strlen(titles[2])), "", titles[i]);
						ImGui::SameLine();
						uint64_t used = ((uint64_t) json_object_get_number(o, "used")) / (1024 * 1024);
						uint64_t total = ((uint64_t) json_object_get_number(o, "total")) / (1024 * 1024);
						float ratio = used / (float)total;
						sprintf(overlay, "%.1f%% (of %" PRId64 " MB)", 100 * ratio, total);
						ImGui::ProgressBar(ratio, ImVec2(-1, 0), overlay);
					}

					ImGui::Separator();

					ImGui::BeginChild("amdgpu_vm_info");
					JSON_Array *pids = json_object_get_array(data.memory_usage_panel.last_answer, "pids");
					const char *type[] = { "Idle", "Evicted", "Relocated", "Moved", "Invalidated", "Done" };

					std::vector<JSON_Object*> sorted;
					for (int i = 0; i < json_array_get_count(pids); i++) {
						sorted.push_back(json_object(json_array_get_value(pids, i)));
					}
					std::sort(sorted.begin(), sorted.end(), [](JSON_Object *a, JSON_Object *b) {
						return json_object_get_number(a, "total") >
							   json_object_get_number(b, "total");
					});

					uint64_t max = sorted.size() ? json_object_get_number(sorted[0], "total") / (1024 * 1024) : 0;
					for (auto *pid: sorted) {
						char label[256], overlay[256];
						sprintf(label, "pid: %8d ", (int)json_object_get_number(pid, "pid"));
						const char *name = json_object_get_string(pid, "name");
						if (strlen(name))
							strcat(label, name);
						uint64_t s = ((uint64_t)json_object_get_number(pid, "total")) / (1024 * 1024);
						ImGui::PushID(i);
						sprintf(overlay, "%ld MB", s);
						ImGui::ProgressBar(s / (float)max, ImVec2(avail.x / 5, 0), overlay);
						ImGui::SameLine();
						float x = ImGui::GetCursorPosX();
						ImGui::BeginGroup();
						if (ImGui::TreeNodeEx(label)) {
							for (int j = 0; j < 6; j++) {
								JSON_Array *cat = json_object_get_array(pid, type[j]);
								if (!cat)
									continue;
								int bo_count = json_array_get_count(cat);
								if (!bo_count)
									continue;
								char label[128];
								sprintf(label, "%s (%d bo)", type[j], bo_count);
								if (ImGui::TreeNodeEx(label)) {
									const char *categories[] = { "VRAM", "GTT" };
									for (int c = 0; c < 2; c++) {
										std::vector<JSON_Object *> bos;
										for (int k = 0; k < bo_count; k++) {
											JSON_Object *bo = json_object(json_array_get_value(cat, k));
											JSON_Array *attr = json_object_get_array(bo, "attributes");
											if (!attr)
												continue;
											const char *cc = json_array_get_string(attr, 0);
											if (!cc || strcmp(categories[c], cc))
												continue;

											bos.push_back(bo);
										}
										if (bos.empty())
											continue;
										ImGui::PushID(c);
										if (ImGui::TreeNodeEx(categories[c], 0, "%s (%d bos)", categories[c], bos.size())) {
											std::sort(bos.begin(), bos.end(), [](JSON_Object *a, JSON_Object *b) {
												return json_object_get_number(a, "size") > json_object_get_number(b, "size");
											});
											for (size_t k = 0; k < bos.size(); k++) {
												JSON_Object *bo = bos[k];
												JSON_Array *attr = json_object_get_array(bo, "attributes");
												ImGui::PushID(k);
												uint64_t s = (uint64_t)json_object_get_number(bo, "size");
												if (s < 1024)
													ImGui::Text("%4d #6bde79b", (int)s);
												else if (s < 1024 * 1024)
													ImGui::Text("%4d #9bde79kb", (int)(s / 1024));
												else if (s < 1024 * 1024 * 1024)
													ImGui::Text("%4d #ab8e79Mb", (int)(s / (1024 * 1024)));
												else
													ImGui::Text("%4d #db2e79Gb", (int)(s / (1024 * 1024 * 1024)));
												int cnt = json_array_get_count(attr);
												for (int l = 1; l < cnt; l++) {
													ImGui::SameLine();
													ImGui::Text("%s%s%s",
																l == 1 ? "(" : "",
																json_array_get_string(attr, l),
																(l == cnt - 1) ? ")" : ",");
												}

												int identical = 0;
												for (size_t l = k + 1; l < bos.size(); l++) {
													JSON_Object *bo2 = bos[l];
													if (json_value_equals(json_object_get_wrapping_value(bo),
														json_object_get_wrapping_value(bo2))) {
														identical++;
														k++;
													}
												}
												if (identical > 0) {
													ImGui::SameLine();
													ImGui::Text("#b58900x%d", identical + 1);
												}
												ImGui::PopID();
											}
											ImGui::TreePop();
										}
										ImGui::PopID();
									}
									ImGui::TreePop();
								}
							}
							ImGui::TreePop();
						}
						ImGui::EndGroup();
						ImGui::PopID();
					}
					ImGui::EndChild();
				}

				ImGui::EndTabItem();
				if (autorefresh)
					need_auto_refresh = -1;
			}

			if (ImGui::BeginTabItem("#b58900T#ffffffop", NULL, kb_shortcut(SDLK_t) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static ImColor colors[] = {
					ImColor(232, 45, 45),
					ImColor(12, 232, 56),
					ImColor(120, 115, 200),
					ImColor(80, 210, 156),
				};
				static float last_sensor_read = 0;
				static float top_read_interval = 0.5;

				if (!data.top_panel.ipname) {
					for (int i = 0; i < (int) data.asic->no_blocks && !data.top_panel.ipname; i++) {
						struct umr_ip_block *b = data.asic->blocks[i];
						for (int j = 0; j < b->no_regs; j++) {
							if (!strcmp(b->regs[j].regname, "mmGRBM_STATUS")) {
								data.top_panel.ipname = b->ipname;
								break;
							}
						}
					}
				}

				if (last_sensor_read > top_read_interval) {
					if (pending_request.empty()) {
						const char *regs[] = {"mmGRBM_STATUS", "mmGRBM_STATUS2", NULL};
						send_accumulate_command(lnk, data, data.top_panel.ipname, top_read_interval * 1000, regs);
						last_sensor_read = 0;
					}
				} else {
					last_sensor_read += dt;
				}

				ImGui::DragFloat("Interval (drag to modify)", &top_read_interval, 0.01, 0.1, 1, "%.2f sec");
				ImGui::Separator();
				if (data.top_panel.last_accumulate_answer) {
					ImGui::BeginChild("grbm bits", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
					JSON_Array *values = json_object_get_array(data.top_panel.last_accumulate_answer, "values");
					for (int i = 0; i < json_array_get_count(values); i++) {
						JSON_Array *val = json_array_get_array(values, i);
						for (int j = 0; j < json_array_get_count(val); j++) {
							JSON_Object *value = json_object(json_array_get_value(val, j));
							const char *name = json_object_get_string(value, "name");
							const size_t l = strlen(name);
							const char *pos = strstr(name, "_BUSY");
							if (pos && pos == (name + l - 5)) {
								int v = (int)json_object_get_number(value, "counter");
								ImGui::ProgressBar(v / 100.0, ImVec2(avail.x / 3, 0));
								ImGui::SameLine();
								const char *color = v < 20 ? "#34de51" : (v < 60 ? "#f3e26d" : "#8f2316");
								ImGui::Text("%s%s", color, name, pos);
							}
						}
					}
					ImGui::EndChild();
					if (!data.top_panel.fences_deltas) {
						data.top_panel.fences_deltas = (float *)calloc(data.ring_panel.num_rings * 100, sizeof(float));
						data.top_panel.fence_deltas_offset = 0;
					}
					ImGui::SameLine();
					ImGui::BeginChild("drm bits", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
					JSON_Array *fences = json_object_get_array(data.top_panel.last_accumulate_answer, "fences");

					ImVec2 sc = ImGui::GetCursorScreenPos();

					float max_value = 0;
					for (int i = 0; i < data.ring_panel.num_rings * 100; i++)
						max_value = std::max(max_value, data.top_panel.fences_deltas[i]);

					for (int i = 0; i < json_array_get_count(fences); i++) {
						JSON_Object *fence = json_object(json_array_get_value(fences, i));
						int delta = json_object_get_number(fence, "delta");
						data.top_panel.fences_deltas[i * 100 + data.top_panel.fence_deltas_offset] = delta / top_read_interval;

						ImGui::SetCursorScreenPos(sc);
						const char *ring_name = json_object_get_string(fence, "name");

						ImColor color;
						if (strstr(ring_name, "gfx")) {
							color = colors[0];
						} else if (strstr(ring_name, "comp")) {
							color = colors[1];
						} else if (strstr(ring_name, "sdma")) {
							color = colors[2];
						} else {
							color = colors[3];
						}
						ImGui::PushStyleColor(ImGuiCol_PlotLines, (ImU32)color);
						ImGui::PushStyleColor(ImGuiCol_Text, (ImU32)color);

						ImGui::PushID(ring_name);
						ImGui::PlotLines("",
							 &data.top_panel.fences_deltas[i * 100],
							 100,
							 data.top_panel.fence_deltas_offset + 1,
							 NULL,
							 0,
							 max_value + 10,
							 ImVec2(0, avail.y / 2),
							 sizeof(float),
							 i != 0);
						ImGui::SameLine();
						ImGui::SetCursorPosY(ImGui::GetCursorPosY() + i * ImGui::GetTextLineHeight());
						ImGui::Text("%12s: %5d fences/sec", ring_name, (int)data.top_panel.fences_deltas[i * 100 + data.top_panel.fence_deltas_offset]);

						ImGui::PopID();

						ImGui::PopStyleColor(2);
					}

					if (!data.top_panel.consumed) {
						data.top_panel.fence_deltas_offset = (data.top_panel.fence_deltas_offset + 1) % 100;
						data.top_panel.consumed = true;
					}
					ImGui::EndChild();
					need_auto_refresh = -1;
				}

				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("Memory #b58900I#ffffffnspector", NULL, kb_shortcut(SDLK_i) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static bool use_linear = true;
				bool fetch = false;

				if (ImGui::Checkbox("Linear (no vmid)", &use_linear)) {
					fetch = true;
				}

				ImGui::SameLine();
				ImGui::SetNextItemWidth(_8digitsize / 4);
				if (!use_linear)
					ImGui::InputInt("VMID", &data.memory_panel.vmid, 0, 0, ImGuiInputTextFlags_CharsDecimal);
				ImGui::SameLine();
				ImGui::Text("Address: 0x");
				ImGui::SameLine();
				ImGui::SetNextItemWidth(_8digitsize * 2);
				ImGui::PushID("Address");
				ImGui::InputText("", data.memory_panel.vram_address, 20, ImGuiInputTextFlags_CharsHexadecimal);
				ImGui::PopID();
				ImGui::SameLine();
				ImGui::SetNextItemWidth(_8digitsize);
				ImGui::InputInt("Size", &data.memory_panel.vram_size, 0, 0, ImGuiInputTextFlags_CharsDecimal);
				ImGui::SameLine();
				ImGui::BeginDisabled(!pending_request.empty());
				if (!replay && ImGui::Button("Read")) {
					send_vm_read_command(lnk, data, use_linear);
				}
				ImGui::SameLine();
				if (!use_linear && ImGui::Button("Decode 1 page")) {
					send_vm_read_command(lnk, data, use_linear, true);
				}
				ImGui::EndDisabled();
				ImGui::Separator();

				/* Split pane */
				ImGui::BeginChild("Memory Viewer", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
				if (data.memory_panel.valid_content_size) {
					mem_edit.DrawContents(data.memory_panel.vram_content,
										  data.memory_panel.valid_content_size,
										  (size_t)0);
				}
				ImGui::EndChild();
				ImGui::SameLine();
				add_vertical_line(avail);

				uint64_t addr;
				sscanf(data.memory_panel.vram_address, "%" SCNx64, &addr);

				if (data.memory_panel.num_page_table_entries) {
					ImGui::BeginChild("VM decode", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);   
					const char *names[] = { "BASE", "PDE", "PTE" };
					int i;

					if (!data.memory_panel.num_page_table_entries) {
						ImGui::Text("No PDE/PTE info to display");
					} else {
						ImGui::Text("PDE/PTE info for 0x%" PRIx64 " @ vmid %d", data.memory_panel.decoded_addr, data.memory_panel.decoded_vmid);
						uint64_t combined_va = 0;
						int pop = 0;
						for (i = 0; i < data.memory_panel.num_page_table_entries; i++) {
							if (ImGui::TreeNodeEx(names[data.memory_panel.page_table[i].type], ImGuiTreeNodeFlags_DefaultOpen)) {
								ImGui::Columns(2);
								ImGui::Text("Physical Base Address");
								ImGui::NextColumn();
								ImGui::Text("#cb4b160x%" PRIx64, data.memory_panel.page_table[i].pba);
								ImGui::NextColumn();
								if (i == data.memory_panel.num_page_table_entries - 1) {
									ImGui::Text("Location");
									ImGui::NextColumn();
									ImGui::Text(data.memory_panel.page_table[i].system ? "#b58900System #b58900RAM" : "#b58900VRAM");
									ImGui::NextColumn();
									ImGui::Text("mtype");
									ImGui::NextColumn();
									switch (data.memory_panel.page_table[i].mtype) {
										case 0: ImGui::Text("NC"); break;
										case 1: ImGui::Text("RW"); break;
										case 2: ImGui::Text("CC"); break;
										case 3: ImGui::Text("UC"); break;
									}
									ImGui::NextColumn();
									ImGui::Text("TMZ");
									ImGui::NextColumn();
									ImGui::Text("#b58900%x", data.memory_panel.page_table[i].tmz);
								}
								ImGui::Columns(1);
								pop++;
							}
						}
						while (pop-- > 0)
							ImGui::TreePop();
						ImGui::EndChild();
					}
				}
				ImGui::EndTabItem();
			}


			ImGui::EndTabBar(); // tabs
			ImGui::EndTabItem(); // asic
		}
		ImGui::EndTabBar();

		if (!pending_request.empty()) {
			avail.x += 2 * ImGui::GetStyle().WindowPadding.x;
			ImVec2 c(avail.x - 10, topleft.y);
			ImGui::SetCursorScreenPos(c);
			ImGui::Spinner("Waiting", 5, 2, ImGui::GetColorU32(ImGuiCol_ButtonHovered));
			need_auto_refresh = -1;
		}

		pthread_mutex_unlock(&mtx);

		ImGui::End();

		// Rendering
		ImGui::Render();
		glViewport(0, 0, (int)io.DisplaySize.x, (int)io.DisplaySize.y);
		glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
		SDL_GL_SwapWindow(window);
	}

	pthread_mutex_lock(&mtx);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);

	if (lnk.use_sock) {
		nn_shutdown(lnk.sock, lnk.endpoint);
		nn_close(lnk.sock);
	}

	if (!replay) {
		void *res;
		pthread_join(t_id, &res);
	}

	for (size_t i = 0; i < regexps.size(); i++) {
		regfree(&regexps[i].preg);
	}
	free(pmatch);
	for (int i = 0; i < asics.size(); i++)
		delete asics[i];

	// Cleanup
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplSDL2_Shutdown();
	ImGui::DestroyContext();

	SDL_GL_DeleteContext(gl_context);
	SDL_DestroyWindow(window);
	SDL_Quit();

	return 0;
}

extern "C" {
	void umr_run_gui(const char *url) {
		run_gui(url);
	}
}