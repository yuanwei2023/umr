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
#include <GL/glew.h>
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

#include <json.h>


struct Bitfield {
	std::string name;
	int start;
	int end;
};

struct Register {
	struct Block* block;
	std::string name;
	int type;
	uint64_t address;
	int value;
	bool value_is_valid;
	bool value_is_dirty;
	std::vector<Bitfield> bitfields;
	bool pinned;
	bool autorefresh;
	float elapsed_since_last_refresh;
	int autorefresh_hz;
};
struct Block {
	std::string name;
	std::vector<Register> registers;
	bool all_bitfields_are_known;
};

/* per-asic data */
struct AsicData {
	AsicData() {
		strcpy(memory_panel.vram_address, "0x00100000000");
		memory_panel.vram_content = NULL;
		memory_panel.vram_size = 256;
		memory_panel.vmid = 0;
		memory_panel.valid_content_size = 0;
		memory_panel.num_page_table_entries = 0;
		waves_panel.last_answer = NULL;
		waves_panel.active_shader = NULL;
		ring_panel.last_answer = NULL;
	}

	/* Info panel */
	struct {
		std::string name;
		unsigned index;
		unsigned instance;
		unsigned did;
		enum chipfamily family;
		uint64_t vram_size;
		uint64_t vis_vram_size;
		std::string vbios_version;
		struct json_object *firmwares;
		char **rings;
		int num_rings;
	} info_panel;

	/* Blocks panel */
	struct {
		std::vector<Block> blocks;
	} blocks_panel;

	/* Memory panel */
	struct {
		uint64_t *vram_content;
		char vram_address[32];
		int vram_size;
		int vmid;
		int valid_content_size;
		struct {
			uint64_t addr;
			uint64_t va;
			uint64_t pba;
			int type; /* 0: base, 1: pde, 2: pte */
			int valid;
			int system;
		} page_table[64];
		int num_page_table_entries;
	} memory_panel;

	/* Waves panel */
	struct {
		struct json_object *last_answer;
		struct json_object *active_shader;
		uint64_t base_address;
		uint64_t pc;
	} waves_panel;

	/* Ring panel */
	struct {
		struct json_object *last_answer;
	} ring_panel;

	/* Interface */
	char register_filter[32] = {};
	char register_field_filter[32] = {};
	std::vector<Register*> pinned_registers;
};

struct Link {
	union {
		int sock;
	};
	bool use_sock;
};

struct json_tokener *parser = json_tokener_new();

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
struct json_object *query(struct Link& lnk, struct json_object *request)
{
	if (lnk.use_sock) {
		const char* s = json_object_to_json_string(request);
		size_t len = strlen(s) + 1;
		int r = nn_send(lnk.sock, s, len, 0);
		// printf("Sent %d\n", r);
		if (r < 0)
			exit(0);
		json_object_put(request);

		if (r < 0)
			return NULL;

		char *buffer;
		len = nn_recv(lnk.sock, &buffer, NN_MSG, 0);
		if (len < 0)
			exit(0);

		struct json_object *out = json_tokener_parse_ex(parser, buffer, len);
		json_tokener_reset(parser);
		nn_freemsg(buffer);
		return out;
	} else {
		return umr_process_json_request(request);
	}
}

static void force_redraw() {
	SDL_Event evt;
	evt.type = SDL_USEREVENT;
	SDL_PushEvent(&evt);
}

static void parse_bitfields(struct json_object *bits, Register* reg) {
	int q = json_object_array_length(bits);
	reg->bitfields.clear();
	for (int j = 0; j < q; j++) {
		struct json_object *r = json_object_array_get_idx(bits, j);
		Bitfield bit;
		bit.name =json_object_get_string(json_object_object_get(r, "name"));
		bit.start = json_object_get_int(json_object_object_get(r, "start"));
		bit.end = json_object_get_int(json_object_object_get(r, "end"));
		reg->bitfields.push_back(bit);
	}
}


struct Link lnk;
pthread_mutex_t mtx;
pthread_cond_t cond;
typedef void (*process_answer_fn)(AsicData *data, struct json_object *answer, void *param);
typedef void (*process_answer_fn2)(std::vector<AsicData> *data, struct json_object *answer, void *param);

class Request {
	public:
		Request(struct json_object *j, void *arg) : json(j), param(arg) {
			struct timespec now;
			clock_gettime(CLOCK_MONOTONIC, &now);
			ts = now.tv_sec + now.tv_nsec * 0.000000001;
		}

		bool is(const char *command) {
			return strcmp(json_object_get_string(json_object_object_get(json, "command")), command) == 0;
		}

		float dt(float now) {
			return now - ts;
		}

		virtual void process_answer(struct json_object *answer) = 0;

	float ts;
	struct json_object *json;
	void *param;
};

class AsicVecRequest: public Request {
	public:
		AsicVecRequest(std::vector<AsicData> *d, struct json_object *j,
							process_answer_fn2 f, void *arg = NULL) : Request(j, arg), asics(d), func(f) {}

		void process_answer(struct json_object *answer) {
			func(asics, answer, param);
		}

	std::vector<AsicData> *asics;
	process_answer_fn2 func;
};

class AsicDataRequest: public Request {
	public:
		AsicDataRequest(AsicData *d, struct json_object *j, process_answer_fn f, void *arg = NULL) : Request(j, arg), data(d), func(f) {
			json_object_object_add(json, "asic_index", json_object_new_int(data->info_panel.index));
		}

		void process_answer(struct json_object *answer) {
			if (func)
				func(data, answer, param);
		}

	AsicData *data;
	process_answer_fn func;
};

std::vector<Request*> pending_request;
bool done;

static void *communication_thread(void *_job) {
	while (!done) {
		pthread_mutex_lock(&mtx);
		pthread_cond_wait(&cond, &mtx);
		for (int i = 0; i < pending_request.size(); i++) {
			Request* r = pending_request[i];
			pthread_mutex_unlock(&mtx);
			struct json_object *answer = query(lnk, r->json);
			pthread_mutex_lock(&mtx);
			r->process_answer(answer);
			delete r;
			force_redraw();
		}
		pending_request.clear();
		pthread_mutex_unlock(&mtx);
	}
	return 0;
}

void process_enumerate_command_answer(std::vector<AsicData> *asics, struct json_object *answer, void *param) {
	int s = json_object_array_length(answer);
	for (int i = 0; i < s; i++) {
		struct json_object *a = json_object_array_get_idx(answer, i);
		AsicData d;
		d.info_panel.name = json_object_get_string(json_object_object_get(a, "name"));
		d.info_panel.index = json_object_get_int(json_object_object_get(a, "index"));
		d.info_panel.instance = json_object_get_int(json_object_object_get(a, "instance"));
		d.info_panel.did = json_object_get_int(json_object_object_get(a, "did"));
		d.info_panel.family = static_cast<enum chipfamily>(json_object_get_int(json_object_object_get(a, "family")));
		d.info_panel.vram_size = json_object_get_uint64(json_object_object_get(a, "vram_size"));
		d.info_panel.vis_vram_size = json_object_get_uint64(json_object_object_get(a, "vis_vram_size"));
		d.info_panel.vbios_version = json_object_get_string(json_object_object_get(a, "vbios_version"));
		d.info_panel.firmwares = json_object_get(json_object_object_get(a, "firmwares"));
		struct json_object *rings = json_object_object_get(a, "rings");
		int n = json_object_array_length(rings);
		d.info_panel.rings = (char**) malloc(sizeof(char*) * n);
		for (int i = 0; i < n; i++)
			d.info_panel.rings[i] = strdup(json_object_get_string(json_object_array_get_idx(rings, i)));
		d.info_panel.num_rings = n;

		asics->push_back(d);
	}
	json_object_put(answer);
}
void send_enumerate_command(struct Link& lnk, std::vector<AsicData> &asics) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("enumerate"));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicVecRequest(&asics, req, process_enumerate_command_answer));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}


void process_list_blocks_command_answer(AsicData *data, struct json_object *answer, void *param) {
	int s = json_object_array_length(answer);
	for (int i = 0; i < s; i++) {
		struct json_object *j = json_object_array_get_idx(answer, i);
		Block b;
		b.name = json_object_get_string(j);
		b.all_bitfields_are_known = false;
		data->blocks_panel.blocks.push_back(b);
	}
	json_object_put(answer);
}
void send_list_blocks_command(struct Link& lnk, AsicData &data) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("list-blocks"));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_list_blocks_command_answer));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_list_regs_command_answer(AsicData *data, struct json_object *answer, void *param) {
	Block *b = (Block*)param;
	bool existing = !b->registers.empty();
	int s = json_object_array_length(answer);
	for (int i = 0; i < s; i++) {
		struct json_object *r = json_object_array_get_idx(answer, i);
		Register reg;
		reg.name = json_object_get_string(json_object_object_get(r, "name"));
		reg.address = json_object_get_uint64(json_object_object_get(r, "address"));
		reg.value_is_valid = false;
		reg.value_is_dirty = false;
		reg.pinned = false;
		reg.autorefresh = false;
		reg.block = b;
		reg.autorefresh_hz = 5;

		struct json_object *bits = json_object_object_get(r, "bitfields");
		if (bits) {
			parse_bitfields(bits, existing ? &b->registers[i] : &reg);
			b->all_bitfields_are_known = true;
		}
		if (!existing)
			b->registers.push_back(reg);
	}
	json_object_put(answer);
}
void send_list_regs_command(struct Link& lnk, AsicData &data, Block &b, bool details = false) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("list-regs"));
	json_object_object_add(req, "block", json_object_new_string(b.name.c_str()));
	json_object_object_add(req, "details", json_object_new_boolean(details));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_list_regs_command_answer, &b));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_read_reg_command_answer(AsicData *data, struct json_object *answer, void *param)
{
	Register *reg = (Register*) param;
	reg->value = json_object_get_int(json_object_object_get(answer, "value"));
	reg->value_is_valid = true;
	reg->value_is_dirty = false;

	struct json_object *bits = json_object_object_get(answer, "bitfields");
	if (bits) {
		parse_bitfields(bits, reg);
	}
	json_object_put(answer);
}
void send_read_reg_command(struct Link& lnk, AsicData &data, Register& reg)
{
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("read"));
	json_object_object_add(req, "block", json_object_new_string(reg.block->name.c_str()));
	json_object_object_add(req, "register", json_object_new_string(reg.name.c_str()));
	json_object_object_add(req, "details", json_object_new_boolean(reg.bitfields.size() == 0));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_read_reg_command_answer, &reg));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void send_write_reg_command(struct Link& lnk, AsicData &data, Register& reg, unsigned value)
{
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("write"));
	json_object_object_add(req, "block", json_object_new_string(reg.block->name.c_str()));
	json_object_object_add(req, "register", json_object_new_string(reg.name.c_str()));
	json_object_object_add(req, "details", json_object_new_boolean(0));
	json_object_object_add(req, "value", json_object_new_int(value));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_read_reg_command_answer, &reg));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_vm_read_command_answer(AsicData *data, struct json_object *answer, void *param)
{
	struct json_object *values = json_object_object_get(answer, "values");
	if (values) {
		int s = json_object_array_length(values);
		data->memory_panel.vram_content = (uint64_t*) realloc(data->memory_panel.vram_content, s * sizeof(uint64_t));

		for (int k = 0; k < s; k++) {
			data->memory_panel.vram_content[k] = json_object_get_uint64(json_object_array_get_idx(values, k));
		}
		data->memory_panel.valid_content_size = s * sizeof(uint64_t);
	}

	struct json_object *pt = json_object_object_get(answer, "page_table");
	if (pt) {
		int num_pt = json_object_array_length(pt);
		for (int k = 0; k < num_pt; k++) {
			struct json_object *level = json_object_array_get_idx(pt, k);
			data->memory_panel.page_table[k].addr = json_object_get_uint64(json_object_object_get(level, "address"));
			data->memory_panel.page_table[k].va = json_object_get_uint64(json_object_object_get(level, "va"));
			data->memory_panel.page_table[k].pba = json_object_get_uint64(json_object_object_get(level, "pba"));
			data->memory_panel.page_table[k].type = json_object_get_uint64(json_object_object_get(level, "type"));
			data->memory_panel.page_table[k].valid = json_object_get_uint64(json_object_object_get(level, "valid"));
			data->memory_panel.page_table[k].system = json_object_get_uint64(json_object_object_get(level, "system"));
		}
		data->memory_panel.num_page_table_entries = num_pt;
	}
	json_object_put(answer);
}
void send_vm_read_command(struct Link& lnk, AsicData &data, bool use_linear, bool decode_only = false) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string(decode_only ? "vm-decode" : "vm-read"));
	uint64_t addr;
	sscanf(data.memory_panel.vram_address, "%" SCNx64, &addr);
	json_object_object_add(req, "address", json_object_new_uint64(addr));
	json_object_object_add(req, "size", json_object_new_int(data.memory_panel.vram_size));
	if (!use_linear)
		json_object_object_add(req, "vmid", json_object_new_int(data.memory_panel.vmid));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_vm_read_command_answer));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_ring_command_answer(AsicData *data, struct json_object *answer, void *param)
{
  if (data->ring_panel.last_answer)
		json_object_put(data->ring_panel.last_answer);
	data->ring_panel.last_answer = answer;
}
void send_ring_command(struct Link& lnk, AsicData &data, const char *ring_name, bool halt_ring) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("ring"));
	json_object_object_add(req, "ring", json_object_new_string(ring_name));
	json_object_object_add(req, "halt_waves", json_object_new_boolean(halt_ring));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_ring_command_answer));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void process_waves_command_answer(AsicData *data, struct json_object *answer, void *param)
{
  	data->waves_panel.active_shader = NULL;
	if (data->waves_panel.last_answer) {
		json_object_put(data->waves_panel.last_answer);
  	}
	data->waves_panel.last_answer = answer;
}
void send_waves_command(struct Link& lnk, AsicData &data, bool halt_waves, bool resume_waves, bool disable_gfxoff) {
	#if 0
	// replay
	struct json_object *answer = json_object_from_file("/home/pierre-eric/amd/code/umr/waves_answer2.json");
	process_waves_command_answer(&data, answer, NULL);
	return;
	#endif
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("waves"));
	json_object_object_add(req, "halt_waves", json_object_new_boolean(halt_waves));
	json_object_object_add(req, "resume_waves", json_object_new_boolean(halt_waves && resume_waves));
	json_object_object_add(req, "disable_gfxoff", json_object_new_boolean(disable_gfxoff));
	json_object_object_add(req, "ring", json_object_new_string(data.info_panel.family >= FAMILY_NV ? "gfx_0.0.0" : "gfx"));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, process_waves_command_answer));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

void send_resume_command(struct Link& lnk, AsicData &data) {
	struct json_object *req = json_object_new_object();
	json_object_object_add(req, "command", json_object_new_string("resume-waves"));
	json_object_object_add(req, "ring", json_object_new_string(data.info_panel.family >= FAMILY_NV ? "gfx_0.0.0" : "gfx"));
	pthread_mutex_lock(&mtx);
	pending_request.push_back(new AsicDataRequest(&data, req, NULL));
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);
}

static bool kb_shortcut(int keycode) {
	return ImGui::GetIO().KeyCtrl && ImGui::IsKeyReleased(SDL_GetScancodeFromKey(keycode));
}

static int run_gui(const char *url)
{
	pthread_mutexattr_t mat;
	pthread_mutexattr_init(&mat);
	pthread_mutexattr_settype(&mat, PTHREAD_MUTEX_RECURSIVE);
	pthread_mutex_init(&mtx, &mat);
	pthread_cond_init(&cond, NULL);
	if (url) {
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
	} else {
		lnk.use_sock = false;
	}

	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_GAMECONTROLLER) != 0) {
		printf("Error: %s\n", SDL_GetError());
		return -1;
	}

	pthread_t t_id;
	pthread_create(&t_id, NULL, communication_thread, NULL);

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
	if (glewInit() != GLEW_OK) {
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

	std::vector<AsicData> asics;

	MemoryEditor mem_edit;
	mem_edit.OptShowDataPreview = true;
	mem_edit.OptShowAscii = false;
	int need_auto_refresh = 0;

	struct timespec before;
	clock_gettime(CLOCK_MONOTONIC, &before);
	// Main loop
	done = false;

	send_enumerate_command(lnk, asics);

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
		if (SDL_WaitEvent(&event)) {
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
		ImGui::Begin("umr", NULL, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize);

		ImVec2 avail = ImGui::GetContentRegionAvail();
		avail.x -= 2 * ImGui::GetStyle().WindowPadding.x;

		float _8digitsize = ImGui::CalcTextSize("0x00000000").x + ImGui::GetStyle().FramePadding.x * 2;

		pthread_mutex_lock(&mtx);

		ImGui::BeginTabBar("asics", ImGuiTabBarFlags_None);

		if (asics.empty() && url) {
			ImGui::Text("No answer from %s yet...", url);
		}

		for (int i = 0; i < asics.size(); i++) {
			AsicData &data = asics[i];

			char asic[64];
			sprintf(asic, "%s (instance: %d)", data.info_panel.name.c_str(), data.info_panel.instance);
			if (!ImGui::BeginTabItem(asic, NULL))
				continue;


			ImGui::BeginTabBar("tabs", ImGuiTabBarFlags_None);


			/*----------------------------------- Asic Info tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900I#ffffffnfo", NULL, kb_shortcut(SDLK_i) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static const char *families[] = {
						"SI", "CIK", "VI", "AI", "NV", "NPI"
				};
				ImGui::Columns(2);
				ImGui::Text("ASIC name"); ImGui::NextColumn();
				ImGui::Text("#b58900%s", data.info_panel.name.c_str()); ImGui::NextColumn();
				ImGui::Text("Instance"); ImGui::NextColumn();
				ImGui::Text("#b58900%d", data.info_panel.instance); ImGui::NextColumn();
				ImGui::Text("DID"); ImGui::NextColumn();
				ImGui::Text("#b58900%02x:#b58900%02x", (data.info_panel.did >> 8) & 0xff, data.info_panel.did & 0xff); ImGui::NextColumn();
				ImGui::Text("Family"); ImGui::NextColumn();
				ImGui::Text("#b58900%s", families[data.info_panel.family]); ImGui::NextColumn();
				ImGui::Text("VRAM"); ImGui::NextColumn();
				ImGui::Text("#b58900%d MB", (int) (data.info_panel.vram_size / (1024 * 1024))); ImGui::NextColumn();
				ImGui::Text("Visible VRAM"); ImGui::NextColumn();
				ImGui::Text("#b58900%d MB", (int) (data.info_panel.vis_vram_size / (1024 * 1024))); ImGui::NextColumn();
				ImGui::Text("vBios version"); ImGui::NextColumn();
				ImGui::Text("#b58900%s", data.info_panel.vbios_version.c_str()); ImGui::NextColumn();
				ImGui::Separator();
				ImGui::Columns(4);
				ImGui::Text("Firmware"); ImGui::NextColumn(); ImGui::NextColumn();
				ImGui::Text("Feature version"); ImGui::NextColumn();
				ImGui::Text("Firmware version"); ImGui::NextColumn();
				ImGui::Separator();
				for (int j = 0; j < json_object_array_length(data.info_panel.firmwares); j++) {
					struct json_object *fw = json_object_array_get_idx(data.info_panel.firmwares, j);
					ImGui::Text(json_object_get_string(json_object_object_get(fw, "name"))); ImGui::NextColumn(); ImGui::NextColumn();
					ImGui::Text("#b589000x%x", json_object_get_int(json_object_object_get(fw, "feature_version"))); ImGui::NextColumn();
					ImGui::Text("#b589000x%x", json_object_get_int(json_object_object_get(fw, "firmware_version"))); ImGui::NextColumn();
				}
				ImGui::Separator();
				ImGui::Columns(1);
				ImGui::Text("Rings:");
				ImGui::Columns(4);
				ImGui::Indent();
				for (int j = 0; j < data.info_panel.num_rings; j++) {
					ImGui::Text("#b58900%s", data.info_panel.rings[j]);
					ImGui::NextColumn();
				}
				ImGui::Unindent();

				ImGui::Columns(1);
				ImGui::EndTabItem();
			}

			/*----------------------------------- Blocks/Registers Info tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900R#ffffffegisters", NULL, kb_shortcut(SDLK_r) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (pending_request.empty() && data.blocks_panel.blocks.empty()) {
					send_list_blocks_command(lnk, data);
				}

				/* Split pane */
				ImGui::BeginChild("Registers list", ImVec2(avail.x / 2, 0), false,
									ImGuiWindowFlags_NoTitleBar);
				for (int i = 0; i < (int) data.blocks_panel.blocks.size(); i++) {
					Block &b = data.blocks_panel.blocks[i];
					if (ImGui::TreeNodeEx(b.name.c_str())) {
						if (b.registers.empty() && pending_request.empty()) {
							send_list_regs_command(lnk, data, b);
						}
						if (!b.all_bitfields_are_known && data.register_field_filter[0] != '\0' && pending_request.empty()) {
							send_list_regs_command(lnk, data, b, true);
						}

						bool at_least_one = false;
						for (auto& reg: b.registers) {
							if (data.register_filter[0] != '\0' && !fuzzy_match_simple(data.register_filter, reg.name.c_str()))
								continue;

							if (data.register_field_filter[0] != '\0') {
								bool show = false;
								for (auto &bit: reg.bitfields) {
									if (fuzzy_match_simple(data.register_field_filter, bit.name.c_str())) {
										show = true;
										break;
									}
								}

								if (!show)
									continue;
							}
							at_least_one = true;
							if (reg.pinned) {
								ImGui::Text(reg.name.c_str());
							} else if (ImGui::Button(reg.name.c_str())) {
								reg.pinned = true;
								data.pinned_registers.push_back(&reg);
								send_read_reg_command(lnk, data, reg);
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
				ImGui::BeginChild("Filters:", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
				ImGui::NewLine();
				ImGui::Text("Filters");
				if (kb_shortcut(SDLK_f))
					ImGui::SetKeyboardFocusHere();
				ImGui::InputText("Register name      ", data.register_filter, sizeof(data.register_filter));
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
				if (data.pinned_registers.empty()) {
					ImGui::NewLine();
					ImGui::Indent();
					ImGui::Text("(Click on a register name to add it to the watchlist.)");
				}
				for (int i = 0; i < (int) data.pinned_registers.size(); ++i) {
					Register &reg = *(data.pinned_registers[i]);
					if (ImGui::Button(reg.name.c_str())) {
						reg.pinned = false;
						data.pinned_registers.erase(data.pinned_registers.begin() + i);
						i--;
						continue;
					}
					ImGui::PushID(reg.name.c_str());
					ImGui::Indent();
					char tmp[512];
					ImGui::Text("Address: 0x08%lx", reg.address);
					if (reg.value_is_valid) {
						ImGui::Columns(2);
						ImGui::PushID(reg.name.c_str());
						sprintf(tmp, "0x%08x", reg.value);
						ImGui::Text("Value");
						ImGui::NextColumn();
						ImGui::SetNextItemWidth(_8digitsize);
						if (ImGui::InputText("", tmp, 11, ImGuiInputTextFlags_CharsHexadecimal)) {
							unsigned value;
							if (sscanf(tmp, "0x%x", &value) == 1) {
								reg.value = value;
								reg.value_is_dirty = true;
							}
						}
						if (reg.value_is_dirty) {
							ImGui::SameLine();
							ImGui::Text("(dirty)");
						}
						ImGui::PopID();
					}
					ImGui::Columns(1);

					if (ImGui::Checkbox("Auto-refresh", &reg.autorefresh)) {
						reg.elapsed_since_last_refresh = 0;
					}
					ImGui::SameLine();
					if (!reg.autorefresh) {
						if (ImGui::Button("Read")) {
							send_read_reg_command(lnk, data, reg);
						}
					} else {
						need_auto_refresh = -1;
						reg.elapsed_since_last_refresh += dt;
						ImGui::SetNextItemWidth(_8digitsize);
						ImGui::InputInt("Frequency", &reg.autorefresh_hz);
						ImGui::SameLine();
						ImGui::ProgressBar(reg.elapsed_since_last_refresh / reg.autorefresh_hz, ImVec2(), "");
						if (reg.elapsed_since_last_refresh >= reg.autorefresh_hz) {
							reg.elapsed_since_last_refresh = 0;
							send_read_reg_command(lnk, data, reg);
						}
					}

					if (reg.value_is_dirty) {
						ImGui::SameLine();
						if (ImGui::Button("Write")) {
							send_write_reg_command(lnk, data, reg, reg.value);
						}
					}

					if (reg.value_is_valid && !reg.bitfields.empty()) {
						ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0, 0));
						int p = 2 * ImGui::GetStyle().WindowPadding.x;
						if (ImGui::CollapsingHeader("Bitfields") && reg.bitfields.size()) {
							float foo = ImGui::GetContentRegionAvailWidth();
							ImGui::PushID(reg.name.c_str());
							ImGui::Columns(4);
							for (auto& bit: reg.bitfields) {
								ImGui::Text("%s[%d:%d]", bit.name.c_str(), bit.end, bit.start);
								ImGui::NextColumn();
								unsigned mask = 0;
								for (unsigned k = bit.start; k <= bit.end; k++)
									mask |= 1u << k;
								unsigned v = (reg.value & mask) >> bit.start;
								sprintf(tmp, "0x%x", v);
								ImGui::PushID(bit.name.c_str());
								ImGui::SetNextItemWidth(_8digitsize);
								if (ImGui::InputText("", tmp, 11, ImGuiInputTextFlags_CharsHexadecimal)) {
									unsigned va;
									if (sscanf(tmp, "%x", &va) == 1) {
										va = va & mask;
										reg.value = (reg.value & ~mask) | (va << (unsigned)bit.start);
										reg.value_is_dirty = true;
									}
								}
								ImGui::NextColumn();
								ImGui::PopID();
							}
							ImGui::SetColumnWidth(0, (foo - 2 * _8digitsize - p) / 2);
							ImGui::SetColumnWidth(1, _8digitsize);
							ImGui::SetColumnWidth(2, (foo - 2 * _8digitsize - p) / 2);
							ImGui::SetColumnWidth(3, _8digitsize);
							ImGui::Columns(1);
							ImGui::PopID();
						}
						ImGui::PopStyleVar();
					}
					ImGui::PopID();
					ImGui::Unindent();
					ImGui::Separator();
				}
				ImGui::EndChild();

				ImGui::EndTabItem();
			}

			/*----------------------------------- Memory tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900M#ffffffemory", NULL, kb_shortcut(SDLK_m) ? ImGuiTabItemFlags_SetSelected : 0)) {
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
				ImGui::SetNextItemWidth(_8digitsize * 2);
				ImGui::InputText("Address", data.memory_panel.vram_address, 20, ImGuiInputTextFlags_CharsHexadecimal);
				ImGui::SameLine();
				ImGui::SetNextItemWidth(_8digitsize);
				ImGui::InputInt("Size", &data.memory_panel.vram_size, 0, 0, ImGuiInputTextFlags_CharsDecimal);
				ImGui::SameLine();
				if (ImGui::Button("Read")) {
					send_vm_read_command(lnk, data, use_linear);
				}
				ImGui::SameLine();
				if (!use_linear && ImGui::Button("Decode 1 page")) {
					send_vm_read_command(lnk, data, use_linear, true);
				}
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

				if (data.memory_panel.num_page_table_entries) {
					ImGui::BeginChild("VM decode", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);   
					const char *names[] = { "BASE", "PDE", "PTE" };
					int i;
					uint64_t combined_va = 0;
					for (i = 0; i < data.memory_panel.num_page_table_entries; i++) {
						if (ImGui::TreeNodeEx(names[data.memory_panel.page_table[i].type], ImGuiTreeNodeFlags_DefaultOpen)) {
							ImGui::Columns(2);
							combined_va += data.memory_panel.page_table[i].va;
							ImGui::PushID(i);
							ImGui::Text("Address:");
							ImGui::NextColumn();
							ImGui::Text("#b589000x%" PRIx64, data.memory_panel.page_table[i].addr);
							ImGui::NextColumn();
							ImGui::Text("VA:");
							ImGui::NextColumn();
							ImGui::Text("#cb4b160x%" PRIx64, data.memory_panel.page_table[i].va);
							if (combined_va != data.memory_panel.page_table[i].va) {
								ImGui::NextColumn();
								ImGui::Text("Cumulated VA:");
								ImGui::NextColumn();
								ImGui::Text("#b589000x%" PRIx64, combined_va);
							}
							ImGui::NextColumn();
							ImGui::Text(data.memory_panel.page_table[i].type < 2 ? "PBA:" : "Physical Address");
							ImGui::NextColumn();
							ImGui::Text("#cb4b160x%" PRIx64, data.memory_panel.page_table[i].pba);
							ImGui::NextColumn();
							ImGui::Text("Location");
							ImGui::NextColumn();
							ImGui::Text(data.memory_panel.page_table[i].system ? "#b58900System #b58900RAM" : "#b58900VRAM");
							ImGui::Columns(1);
						} else
							break;
						if (data.memory_panel.page_table[i].type == 2) {
							i++;
							break;
						}
					}
					for (int j = 0; j < i; j++) {
						ImGui::TreePop();
						ImGui::PopID();
					}
					ImGui::EndChild();
				}
				ImGui::EndTabItem();
			}

			/*----------------------------------- Waves tab -----------------------------------*/
			if (ImGui::BeginTabItem("#b58900W#ffffffaves", NULL, kb_shortcut(SDLK_w) ? ImGuiTabItemFlags_SetSelected : 0)) {
				static bool halt = false;
				static bool resume = true;
				static bool turn_off_gfxoff = turn_off_gfxoff;


				ImGui::Checkbox("Disable gfxoff", &turn_off_gfxoff);
				ImGui::SameLine();
				ImGui::Checkbox("Halt waves", &halt);
				if (halt) {
					ImGui::SameLine();
					ImGui::Checkbox("Resume waves", &resume);
				}
				ImGui::SameLine();
				if (ImGui::Button("Query")) {
					send_waves_command(lnk, data, halt, resume, turn_off_gfxoff);
				}

				ImGui::SameLine();
				if (ImGui::Button("Resume")) {
					send_resume_command(lnk, data);
				}

				ImGui::Separator();
				if (data.waves_panel.last_answer) {
					ImGui::BeginChild("Waves", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
					struct json_object *waves = json_object_object_get(data.waves_panel.last_answer, "waves");
					struct json_object *shaders = json_object_object_get(data.waves_panel.last_answer, "shaders");
					bool force_scroll = false;
					int w = json_object_array_length(waves);
					for (int i = 0; i < w; i++) {
						struct json_object *wave = json_object_array_get_idx(waves, i);
						struct json_object *status = json_object_object_get(wave, "status"); 

						ImGui::PushID(i);

						if (ImGui::TreeNode("wave", "Wave %d", i)) {
							ImGui::Columns(4);
							ImGui::Text("se: #b58900%d", json_object_get_int(json_object_object_get(wave, "se")));
							ImGui::NextColumn();
							ImGui::Text("sh: #b58900%d", json_object_get_int(json_object_object_get(wave, "sh")));
							ImGui::NextColumn();
							ImGui::Text("cu: #b58900%d", json_object_get_int(json_object_object_get(wave, "cu")));
							ImGui::NextColumn();
							ImGui::Text("simd_id: #b58900%d", json_object_get_int(json_object_object_get(wave, "simd_id")));
							ImGui::NextColumn();
							ImGui::Text("wave_id: #b58900%d", json_object_get_int(json_object_object_get(wave, "wave_id")));
							ImGui::NextColumn();
							struct json_object *dis = json_object_object_get(wave, "shader_disassembly");
							if (dis) {
								char label[128];
								sprintf(label, "PC: 0x%lx", json_object_get_uint64(json_object_object_get(wave, "PC")));
								if (ImGui::Button(label)) {
									const char *sh = json_object_get_string(dis);
									data.waves_panel.active_shader = json_object_object_get(shaders, sh);
									sscanf(sh, "%" PRIx64, &data.waves_panel.base_address);
									data.waves_panel.pc = json_object_get_uint64(json_object_object_get(wave, "PC"));

									force_scroll = true;
								}
							} else {
								ImGui::Text("PC: 0x%lx", json_object_get_uint64(json_object_object_get(wave, "PC")));
							}
							ImGui::Columns(2);
							ImGui::Text("wave_inst_dw0: #b589000x%08x", json_object_get_int(json_object_object_get(wave, "wave_inst_dw0")));
							ImGui::NextColumn();
							ImGui::Text("wave_inst_dw1: #b589000x%08x", json_object_get_int(json_object_object_get(wave, "wave_inst_dw1")));
							ImGui::NextColumn();
							ImGui::Columns(1);
							if (ImGui::TreeNodeEx("Status")) {
								ImGui::Columns(4);
								json_object_object_foreach(status, key, val) {
									ImGui::Text("%s: #b58900%d", key, json_object_get_int(val));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}
							if (ImGui::TreeNodeEx("Hardware Id")) {
								ImGui::Columns(4);
								json_object_object_foreach(json_object_object_get(wave, "hw_id"), key, val) {
									ImGui::Text("%s: #b58900%d", key, json_object_get_int(val));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}
							if (ImGui::TreeNodeEx("GPR Alloc")) {
								ImGui::Columns(4);
								json_object_object_foreach(json_object_object_get(wave, "gpr_alloc"), key, val) {
									ImGui::Text("%s: #b58900%d", key, json_object_get_int(val));
									ImGui::NextColumn();
								}
								ImGui::Columns(1);
								ImGui::TreePop();
							}

							{
								struct json_object *sgpr = json_object_object_get(wave, "sgpr");
								if (sgpr && ImGui::TreeNodeEx("#d33682SGPRs")) {
									static int mode = 2;
									static const char *formats[] = { "s%*d: #d33682%d", "s%*d: #d33682%u", "s%*d: #d33682%08x" };
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
									int s = json_object_array_length(sgpr);
									int align = s > 99 ? 3 : 2;
									for (int i = 0; i < s; i++) {
										struct json_object *v = json_object_array_get_idx(sgpr, i);
										ImGui::PushID(v);
										int aaa = json_object_get_int(v);
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
								struct json_object *vgpr = json_object_object_get(wave, "vgpr");
								if (vgpr && ImGui::TreeNodeEx("#6c71c4VGPRs")) {
									static int mode = 2;
									static const char *formats[] = { "#6c71c4%d", "#6c71c4%u", "#6c71c4%08x" };
									ImGui::Text("Display as:");
									ImGui::SameLine();
									ImGui::RadioButton("int", &mode, 0);
									ImGui::SameLine();
									ImGui::RadioButton("uint", &mode, 1);
									ImGui::SameLine();
									ImGui::RadioButton("hex", &mode, 2);
									ImGui::SameLine();
									ImGui::RadioButton("float", &mode, 3);
									int s = json_object_array_length(vgpr);
									for (int i = 0; i < s; i++) {
										ImGui::PushID(i);
										if (ImGui::TreeNode("vgpr", "v%d", i)) {
											ImGui::Columns(4);
											struct json_object *vg = json_object_array_get_idx(vgpr, i);
											int num_thread = json_object_array_length(vg);
											for (int j = 0; j < num_thread; j++) {
												struct json_object *v = json_object_array_get_idx(vg, i);
												ImGui::PushID(v);
												int aaa = json_object_get_int(v);
												if (mode == 3) {
													float f = reinterpret_cast<float&>(aaa);
													ImGui::Text("t%02d: #6c71c4%f", i, f);
												} else {
													ImGui::Text(formats[mode], aaa);
												}
												ImGui::PopID();
												ImGui::NextColumn();
											}
											ImGui::Columns(1);
											ImGui::TreePop();
										}
										ImGui::PopID();

										ImGui::NextColumn();
									}
									ImGui::Columns(1);
									ImGui::TreePop();
								}
							}

							{
								struct json_object *threads = json_object_object_get(wave, "threads");
								if (threads) {
									int s = json_object_array_length(threads);
									int active = 0;
									for (int i = 0; i < s; i++) {
										active += json_object_get_int(json_object_array_get_idx(threads, i));
									}

									if (ImGui::TreeNode(threads, "Threads (%d active)", active)) {
										ImGui::Columns(4);
										for (int i = 0; i < s; i++) {
											ImGui::Text("t%d: %s", i,
												json_object_get_int(
													json_object_array_get_idx(threads, i)) ?
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
								"(0x[[:alnum:]]*)\\b|"                                    // constants
								"(;)"                                                     // comment
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

						int s = json_object_array_length(data.waves_panel.active_shader);
						int scroll = 0;
						float addr_col_size = 0;
						float raw_col_size = 0;

						ImGuiListClipper clipper;
						clipper.Begin(s);
						ImGui::Columns(3);
						ImGui::Text("Address");
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
								const char *src = json_object_get_string(json_object_array_get_idx(data.waves_panel.active_shader, i));
								bool is_pc = data.waves_panel.pc == addr;
								if (is_pc) {
									/* PC points to this instruction */
									scroll = ImGui::GetCursorPos().y;
									ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0.5, 0.5, 1));
								}
								const char *tknOpen = strchr(src, '[');
								const char *tkn = strchr(tknOpen, ']');
								sprintf(tmp, "%.*s", tkn - tknOpen + 1, tknOpen);
								addr_col_size = std::max(addr_col_size, ImGui::CalcTextSize(tmp).x);
								ImGui::Text(tmp);
								ImGui::NextColumn();
								tkn += 4;
								sprintf(tmp, "%.10s", tkn);
								ImGui::Text(tmp);
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

								ImGui::Text(buf);

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
				static int current_item = data.info_panel.num_rings - 1;
				static bool halt = true;

				ImGui::Checkbox("Halt waves", &halt);
				ImGui::SameLine();
				ImGui::Combo("Ring selection:", &current_item, data.info_panel.rings, data.info_panel.num_rings);

				ImGui::SameLine();
				if (ImGui::Button("Read")) {
					send_ring_command(lnk, data, &data.info_panel.rings[current_item][strlen("amdgpu_ring_")], halt);
				}
				ImGui::Separator();
				if (data.ring_panel.last_answer) {
					static regex_t syntax_coloring_regexp;
					static int regexp_init = 0;
					static size_t nmatch;
					static regmatch_t *pmatch = NULL;
					if (regexp_init == 0) {
						const char *regexp =
							//"(\\[PKT3_[A-Z0-9_]+\\])|" // PKT
							"(\\[.+\\])"
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

					float addr_col_size = ImGui::CalcTextSize("Address").x;
					float raw_col_size = ImGui::CalcTextSize("Raw Value").x;

					struct json_object *decoded = json_object_object_get(data.ring_panel.last_answer, "decoded");
					struct json_object *raw = json_object_object_get(data.ring_panel.last_answer, "raw");
					struct json_object *offsets = json_object_object_get(data.ring_panel.last_answer, "offsets");

					int rptr = json_object_get_int(json_object_object_get(data.ring_panel.last_answer, "read_ptr"));
					int wptr = json_object_get_int(json_object_object_get(data.ring_panel.last_answer, "write_ptr"));
					int drv_wptr = json_object_get_int(json_object_object_get(data.ring_panel.last_answer, "driver_write_ptr"));

					ImGuiListClipper clipper;
					clipper.Begin(json_object_array_length(decoded));
					ImGui::Columns(4);
					ImGui::Text("Address");
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
					while (clipper.Step()) {
						for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++) {
							const char *line = json_object_get_string(json_object_array_get_idx(decoded, i));

							int idx = json_object_get_int(json_object_array_get_idx(offsets, i));
							sprintf(tmp, "%4d", idx);
							addr_col_size = std::max(addr_col_size, ImGui::CalcTextSize(tmp).x);
							ImGui::Text(tmp);
							ImGui::NextColumn();
							sprintf(tmp, "%08x", json_object_get_int(json_object_array_get_idx(raw, i)));
							raw_col_size = std::max(raw_col_size, ImGui::CalcTextSize(tmp).x);
							ImGui::Text(tmp);
							ImGui::NextColumn();

							tmp[0] = '\0';
							if (idx == rptr)
								strcpy(tmp, "#d33682R ");
							if (idx == wptr)
								strcat(tmp, "#b58900W ");
							if (idx == drv_wptr)
								strcat(tmp, "#586e75DW");

							ImGui::Text(tmp);
							ImGui::NextColumn();

							/* syntax coloring */
							char buf[2048];
							int wr = 0;

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
												case 0: modifier = "#d33682"; break; // PKTn
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

							ImGui::Text(buf);
							ImGui::NextColumn();
						}
					}
					int p = 2 * ImGui::GetStyle().WindowPadding.x;
					ImGui::SetColumnWidth(0, addr_col_size + p);
					ImGui::SetColumnWidth(1, raw_col_size + p);
					ImGui::SetColumnWidth(2, ImGui::CalcTextSize("Pointers").x + p);
					ImGui::Columns(1);
					clipper.End();
				}
				ImGui::EndTabItem();
			}

			ImGui::EndTabBar(); // tabs
			ImGui::EndTabItem(); // asic
		}
		ImGui::EndTabBar();
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