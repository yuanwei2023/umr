/*
 * Copyright © 2022 Advanced Micro Devices, Inc.
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
#include "parson.h"
#include <fcntl.h>
#include <mutex>
#include <unistd.h>
#include <vector>
#include <stdio.h>
#include <pthread.h>
#include <regex.h>
#include <limits.h>

#if UMR_SERVER
#include <nanomsg/nn.h>
#include <nanomsg/reqrep.h>
#endif
#include "imgui.h"
#include "imgui_impl_opengl3.h"
#include "imgui_impl_sdl.h"
#include "glad/glad.h"

#include <SDL.h>
#include "gui/panels.h"
#define EGL_EGLEXT_PROTOTYPES
#include <EGL/egl.h>
#include <EGL/eglext.h>

#include "gui/qoi/qoi.h"

/* Random helpers */
extern void send_request(JSON_Value *req, struct umr_asic *asic);
extern void force_redraw();
extern void add_vertical_line(const ImVec2& avail);
extern bool kb_shortcut(int keycode);
extern GLuint texture_from_qoi_buffer(int width, int height, void *buffer, int buffer_size);
extern void goto_tab(int keycode);
extern "C" {
	JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsigned int *raw_data_size);
}


class SyntaxHighlighter {
public:
	SyntaxHighlighter();
	~SyntaxHighlighter();

	void add_definition(const char *regexp, std::vector<const char *> colors);

	char * transform(const char *input);

private:
	struct Def {
	   const char *expression;
	   regex_t preg;
	   const char * colors[6]; /* 6 = max capture groups in the expression */
	};
	std::vector<Def> definitions;
	regmatch_t *pmatch;
	char *output;
};

#include "gui/info_panel.cpp"
#include "gui/registers_panel.cpp"
#include "gui/power_panel.cpp"
#include "gui/rings_panel.cpp"
#include "gui/top_panel.cpp"
#include "gui/memory_usage_panel.cpp"
#include "gui/memory_debug_panel.cpp"
#include "gui/waves_panel.cpp"
#include "gui/kms_panel.cpp"
#include "gui/buffer_object_panel.cpp"

struct Link {
	int sock;
	int endpoint;
	bool use_sock;
};

JSON_Value *query(struct Link& lnk, JSON_Value *request, void **raw_data, unsigned *raw_data_size) {
	#if UMR_SERVER
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


		int strl = strlen(&buffer[sizeof(uint32_t)]) + 1;
		memcpy(raw_data_size, buffer, sizeof(uint32_t));
		assert(len == sizeof(uint32_t) + strl + *raw_data_size);
		JSON_Value *out = json_parse_string(&buffer[sizeof(uint32_t)]);
		if (json_object_get_boolean(json_object(out), "has_raw_data")) {
			assert(*raw_data_size);
			*raw_data = malloc(*raw_data_size);
			memcpy(*raw_data,
				   &buffer[sizeof(uint32_t) + strl],
				   *raw_data_size);
		}

		nn_freemsg(buffer);

		return out;
	} else
	#endif
		return umr_process_json_request(json_object(request), raw_data, raw_data_size);
}

void force_redraw() {
	SDL_Event evt;
	evt.type = SDL_USEREVENT;
	SDL_PushEvent(&evt);
}

static struct Link lnk;
static pthread_mutex_t mtx;
static pthread_cond_t cond;
static bool done;

struct AsicData {
	AsicData(JSON_Object *answer, char *ip_discovery_dump, long did, int instance) {
		int tryipdiscovery = 0;
		memset(&options, 0, sizeof options);
		options.instance = instance;
		options.database_path[0] = '\0';
		options.no_disasm = 0;
		options.no_follow_ib = 1;
		options.vm_partition = -1;
		options.no_follow_loadx = 1;

		if (ip_discovery_dump && strlen(ip_discovery_dump)) {
			struct umr_test_harness *th = umr_create_test_harness(ip_discovery_dump);

			options.test_log = 1;
			options.th = th;
			asic = umr_discover_asic_by_discovery_table(
				(char*)json_object_get_string(answer, "name"),
				&options,
				printf);

			if (asic) {
				umr_scan_config(asic, 0);
				asic->did = did;
			}
			umr_free_test_harness(th);
		} else {
			/* Don't rely on local IP discovery data zvzn if available, because
			 * it probably won't match the one on the server.
			 */
			options.force_asic_file = 1;
			asic = umr_discover_asic_by_did(&options, did, printf, &tryipdiscovery);
		}

		if (!asic) {
			fprintf(stderr, "Failed to create asic, aborting.\n");
			abort();
		}

		asic->instance = instance;

		panels.push_back(new InfoPanel(asic));
		panels.push_back(new RegistersPanel(asic));
		panels.push_back(new PowerPanel(asic));
		panels.push_back(new RingsPanel(asic));
		panels.push_back(new TopPanel(asic));
		panels.push_back(new MemoryUsagePanel(asic));
		panels.push_back(new MemoryDebugPanel(asic));
		panels.push_back(new WavesPanel(asic));
		panels.push_back(new KmsPanel(asic));
		panels.push_back(new BufferObjectPanel(asic));

		for (auto panel: panels) {
			panel->store_info(json_object_get_wrapping_value(answer));
		}
	}
	~AsicData() {
		for (auto p: panels)
			delete p;
		umr_close_asic(asic);
	}

	struct umr_options options;
	struct umr_asic *asic;
	std::vector<Panel*> panels;
};

std::vector<JSON_Value*> pending_request;

void send_request(JSON_Value *req, struct umr_asic *asic) {
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

void Panel::send_request(JSON_Value *req) {
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

AsicData *answer_to_asic_data(std::vector<AsicData*> *asics, JSON_Object *request) {
	JSON_Object *asc = json_object(json_object_get_value(request, "asic"));
	if (!asc)
		return NULL;

	int did = json_object_get_number(asc, "did");
	int instance = json_object_get_number(asc, "instance");

	for (int i = 0; i < (int) asics->size(); i++) {
		if ((*asics)[i]->asic->did == did && (*asics)[i]->asic->instance == instance)
			return (*asics)[i];
	}
	return NULL;
}

static int64_t time_ns(void)
{
   struct timespec ts;
   timespec_get(&ts, CLOCK_MONOTONIC);
   return ts.tv_nsec + ts.tv_sec * 1000000000;
}

static float ping_value = -1;

static void process_response(std::vector<AsicData*> *asics, JSON_Object *response, void *raw_data, unsigned raw_data_size) {
	JSON_Object *request = json_object(json_object_get_value(response, "request"));
	const char *cmd = json_object_get_string(request, "command");
	JSON_Value *error = json_object_get_value(response, "error");

	if (cmd) {
		if (!error && !strcmp(cmd, "enumerate")) {
			JSON_Array *as_array = json_array(json_object_get_value(response, "answer"));
			if (as_array) {
				int s = json_array_get_count(as_array);
				for (int i = 0; i < s; i++) {
					JSON_Object *v = json_object(json_array_get_value(as_array, i));

					char *ip_discovery_dump = NULL;

					int off = json_object_get_number(v, "ip_discovery_offset");
					int len = json_object_get_number(v, "ip_discovery_len");
					if (len > 0)
						ip_discovery_dump = strndup(&((char*)raw_data)[off], len);

					AsicData *d = new AsicData(v,
						ip_discovery_dump,
						json_object_get_number(v, "did"),
						json_object_get_number(v, "instance"));
					asics->push_back(d);

					free(ip_discovery_dump);
				}
				return;
			}
		}
		if (!error && !strcmp(cmd, "ping")) {
			int64_t pong = time_ns();
			int64_t ping = (int64_t)json_object_get_number(request, "ts");
			ping_value =(pong - ping) / 1000000.0f;
			return;
		}

		AsicData *data = answer_to_asic_data(asics, request);

		if (data) {
			JSON_Value *v = json_object_get_value(response, "answer");

			for (auto panel: data->panels) {
				if (panel->asic == data->asic)
					panel->process_server_message(response, raw_data, raw_data_size);
			}
		}
	}

	force_redraw();
}

static void *communication_thread(void *_job) {
	int id = 0;
	char session_filename[PATH_MAX - 4];
	char session_filename_raw[PATH_MAX];
	while (id < 1024) {
		struct stat statbuf;
		snprintf(session_filename, sizeof(session_filename), "/tmp/umr_session.%d.json", id++);
		if (stat(session_filename, &statbuf) == -1 && errno == ENOENT) {
			break;
		}
	}
	snprintf(session_filename_raw, sizeof(session_filename_raw), "%s.raw", session_filename);
	JSON_Array *session = json_array(json_value_init_array());
	std::vector<AsicData*> *asics = (std::vector<AsicData*> *)_job;
	int64_t last_ping = time_ns();

	while (!done) {
		pthread_mutex_lock(&mtx);
		if (pending_request.empty()) {
			int64_t now = time_ns();

			if (now - last_ping > 1000000000) {
				JSON_Value *req = json_value_init_object();
				json_object_set_string(json_object(req), "command", "ping");
				json_object_set_number(json_object(req), "ts", now);
				last_ping = now;
				pending_request.push_back(req);
			} else {
				struct timespec t;
				clock_gettime(CLOCK_REALTIME, &t);
				t.tv_sec += 1;
				pthread_cond_timedwait(&cond, &mtx, &t);
			}
		}
		for (int i = 0; i < pending_request.size(); i++) {
			void *raw_data = NULL;
			unsigned raw_data_size = 0;
			JSON_Value* req = pending_request[i];
			pthread_mutex_unlock(&mtx);
			JSON_Value *in = query(lnk, req, &raw_data, &raw_data_size);
			pthread_mutex_lock(&mtx);

			/* Save to disk for replay */
			json_array_append_value(session, json_value_deep_copy(in));
			json_serialize_to_file(json_array_get_wrapping_value(session), session_filename);

			if (raw_data_size) {
				uint32_t s = htole32(raw_data_size);
				int fd = open(session_filename_raw, O_WRONLY | O_CREAT | O_APPEND, 0644);
				write(fd, &s, sizeof(raw_data_size));
				write(fd, raw_data, raw_data_size);
				close(fd);
			}

			process_response(asics, json_object(in), raw_data, raw_data_size);

			json_value_free(in);
		}
		pending_request.clear();
		pthread_mutex_unlock(&mtx);

	}
	json_value_free(json_array_get_wrapping_value(session));
	return 0;
}

static int goto_tab_on_next_redraw = -1;
bool kb_shortcut(int keycode) {
	return (ImGui::GetIO().KeyCtrl && ImGui::IsKeyReleased(SDL_GetScancodeFromKey(keycode))) ||
			goto_tab_on_next_redraw == keycode;
}

void add_vertical_line(const ImVec2& avail) {
	ImVec2 start = ImGui::GetCursorScreenPos();
	start.x -= ImGui::GetStyle().FramePadding.x;
	ImVec2 end = start;
	end.y += avail.y;
	ImGui::GetWindowDrawList()->AddLine(start, end, ImGui::GetColorU32(ImGuiCol_TabActive));
}

GLuint texture_from_qoi_buffer(int width, int height, void *buffer, int buffer_size)
{
	GLuint texture_id;

	qoi_desc desc;
	desc.width = width;
	desc.height = height;
	desc.channels = 4;
	desc.colorspace = QOI_LINEAR;
	void *data = qoi_decode(buffer, buffer_size, &desc, 4);

	glGenTextures(1, &texture_id);
	glBindTexture(GL_TEXTURE_2D, texture_id);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0,
				 GL_RGBA, GL_UNSIGNED_BYTE, data);
	free(data);

	return texture_id;
}

void goto_tab(int key_code) {
	goto_tab_on_next_redraw = key_code;
	force_redraw();
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
			#if UMR_SERVER
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
			#else
			printf("Error: UMR remote GUI feature was not enabled at build time.\n");
			exit(1);
			#endif
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
		char raw_filename[PATH_MAX];
		sprintf(raw_filename, "%s.raw", url);
		JSON_Array *session = json_array(json_parse_file(url));
		if (!session)
			return 1;
		int fd = open(raw_filename, O_RDONLY);
		for (int i = 0; i < json_array_get_count(session); i++) {
			uint32_t raw_data_size = 0;
			void *raw_data = NULL;
			JSON_Object *e = json_object(json_array_get_value(session, i));
			if (json_object_get_boolean(e, "has_raw_data") && fd != -1) {
				uint32_t s;
				read(fd, &s, sizeof(raw_data_size));
				raw_data_size = le32toh(s);
				raw_data = malloc(raw_data_size);
				read(fd, raw_data, raw_data_size);
			}
			process_response(&asics, e, raw_data, raw_data_size);
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
		sprintf(title, "umr (%s)", url);
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
	char ini_path[8096];
	const char *config_filename = NULL;

	const char *bases[] = { "XDG_CONFIG_HOME", "HOME" };
	for (int i = 0; i < 2; i++) {
		if (getenv(bases[i])) {
			const char *base = getenv(bases[i]);
			if (i == 0) {
				strcpy(ini_path, base);
			} else {
				sprintf(ini_path, "%s/.config", base);
			}
			struct stat statbuf;
			if (stat(ini_path, &statbuf) == 0 && S_ISDIR(statbuf.st_mode)) {
				char *copy = strdup(ini_path);
				sprintf(ini_path, "%s/umr/", copy);
				if (stat(ini_path, &statbuf) == -1 && errno == ENOENT) {
					if (mkdir(ini_path, 0755) == 0) {
						sprintf(ini_path, "%s/umr/umr_gui.ini", copy);
						config_filename = strdup(ini_path);
					}
				} else {
					sprintf(ini_path, "%s/umr/umr_gui.ini", copy);
					config_filename = strdup(ini_path);
				}
				free(copy);
			}
		}
	}

	bool rebuild_scaled_font = false;
	ImFont *scaled_font = NULL;
	float old_scale = 1;
	float scale = 1;

	if (config_filename) {
		FILE *f = fopen(config_filename, "r");
		if (f) {
			if (fscanf(f, "ui_scale=%f", &scale) == 1) {
				scale = std::max(1.0f, std::min(2.0f, scale));
				old_scale = scale;
				if (scale != 1.0)
					rebuild_scaled_font = true;
			}
			fclose(f);
		}
	}

	// Setup Dear ImGui style (todo: support switch to light theme)
	ImGui::StyleColorsDark();

	// Setup Platform/Renderer bindings
	ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
	ImGui_ImplOpenGL3_Init(glsl_version);

	int need_auto_refresh = 0;

	struct timespec before;
	clock_gettime(CLOCK_MONOTONIC, &before);
	// Main loop
	done = false;

	io.FontGlobalScale = 1;
	/* Discover asics */
	JSON_Value *req = json_value_init_object();
	json_object_set_string(json_object(req), "command", "enumerate");
	send_request(req, NULL);

	bool clear_goto_tab_flag = false;
	float previous_ping = -1;

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

		if (lnk.use_sock && previous_ping != ping_value) {
			char title[512];
			sprintf(title, "umr (%s, %.1f ms)", url, ping_value);
			previous_ping = ping_value;
			SDL_SetWindowTitle(window, title);
		}

		if (rebuild_scaled_font) {
		    ImFontConfig cfg;
			cfg.SizePixels = 13 * scale;
			scaled_font = ImGui::GetIO().Fonts->AddFontDefault(&cfg);
			ImGui::GetIO().Fonts->Build();
			ImGui_ImplOpenGL3_CreateFontsTexture();
			old_scale = scale;
			ImGui::GetStyle().ScaleAllSizes(scale / old_scale);

			rebuild_scaled_font = false;
			force_redraw();
		}

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

		if (scaled_font)
			ImGui::PushFont(scaled_font);

		ImVec2 topleft = ImGui::GetCursorScreenPos();
		ImVec2 avail = ImGui::GetContentRegionAvail();
		avail.x -= 2 * ImGui::GetStyle().WindowPadding.x;

		pthread_mutex_lock(&mtx);

		ImGui::SetNextItemWidth(avail.x / 16);
		if (ImGui::SliderFloat("scale", &scale, 1, 2, "%.1f")) {
			if (scale < 1)
				scale = 1;
			if (scale > 2)
				scale = 2;

			rebuild_scaled_font = true;
		}
		ImGui::SameLine();
		ImGui::BeginTabBar("asics", ImGuiTabBarFlags_FittingPolicyScroll);

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

			bool can_send_request = pending_request.empty();

			ImGui::BeginTabBar("tabs", ImGuiTabBarFlags_None);

			if (ImGui::BeginTabItem("#b58900I#ffffffnfo", NULL, kb_shortcut(SDLK_i) ? ImGuiTabItemFlags_SetSelected : 0)) {
				data.panels[0]->display(dt, avail, can_send_request);
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900R#ffffffegisters", NULL, kb_shortcut(SDLK_r) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[1]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900W#ffffffaves", NULL, kb_shortcut(SDLK_w) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[7]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("Rin#b58900g#ffffffs", NULL, kb_shortcut(SDLK_g) ? ImGuiTabItemFlags_SetSelected : 0)) {
				data.panels[3]->display(dt, avail, can_send_request);
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900P#ffffffower", NULL, kb_shortcut(SDLK_p) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[2]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900M#ffffffemory Usage", NULL, kb_shortcut(SDLK_m) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[5]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900T#ffffffop", NULL, kb_shortcut(SDLK_t) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[4]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("#b58900K#ffffffMS", NULL, kb_shortcut(SDLK_k) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[8]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("Memory #b58900I#ffffffnspector", NULL, kb_shortcut(SDLK_i) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[6]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			if (ImGui::BeginTabItem("Buffer #b58900O#ffffffjects", NULL, kb_shortcut(SDLK_o) ? ImGuiTabItemFlags_SetSelected : 0)) {
				if (data.panels[9]->display(dt, avail, can_send_request))
					need_auto_refresh = -1;
				ImGui::EndTabItem();
			}

			ImGui::EndTabBar();
			ImGui::EndTabItem();
		}
		ImGui::EndTabBar();

		if (replay) {
			char txt[1024];
			snprintf(txt, sizeof(txt), "(replaying: #b58900%s)", url);
			float w = ImGui::CalcTextSize(txt).x;
			avail.x += 2 * ImGui::GetStyle().WindowPadding.x;
			ImVec2 c(avail.x - w, topleft.y);
			ImGui::SetCursorScreenPos(c);
			ImGui::TextUnformatted(txt);
		} else if (!pending_request.empty()) {
			avail.x += 2 * ImGui::GetStyle().WindowPadding.x;
			ImVec2 c(avail.x - 10, topleft.y);
			ImGui::SetCursorScreenPos(c);
			ImGui::Spinner("Waiting", 5, 2, ImGui::GetColorU32(ImGuiCol_ButtonHovered));
			need_auto_refresh = -1;
		}

		pthread_mutex_unlock(&mtx);

		if (scaled_font)
			ImGui::PopFont();

		ImGui::End();

		// Rendering
		ImGui::Render();
		glViewport(0, 0, (int)io.DisplaySize.x, (int)io.DisplaySize.y);
		glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
		SDL_GL_SwapWindow(window);

		if (clear_goto_tab_flag)
			goto_tab_on_next_redraw = -1;
		else if (goto_tab_on_next_redraw != -1)
			clear_goto_tab_flag = true;
	}

	pthread_mutex_lock(&mtx);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mtx);

#if UMR_SERVER
	if (lnk.use_sock) {
		nn_shutdown(lnk.sock, lnk.endpoint);
		nn_close(lnk.sock);
	}
#endif

	if (!replay) {
		void *res;
		pthread_join(t_id, &res);
	}

	for (int i = 0; i < asics.size(); i++)
		delete asics[i];

	if (config_filename) {
		FILE *f = fopen(config_filename, "w");
		if (f) {
			fprintf(f, "ui_scale=%.1f\n", scale);
			fclose(f);
		}
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

SyntaxHighlighter::SyntaxHighlighter() : pmatch(NULL), output(NULL) { }
SyntaxHighlighter::~SyntaxHighlighter() {
	free (pmatch);
	free (output);
	for (Def& def: definitions) {
		regfree(&def.preg);
	}
}

void SyntaxHighlighter::add_definition(const char *expression, std::vector<const char *> colors) {
	regex_t preg;
	if (regcomp(&preg, expression, REG_EXTENDED) != 0) {
		printf("REGEXP '%s' failed\n", expression);
		assert(false);
		return;
	}
	Def d;
	d.preg = preg;
	for (int i = 0; i < preg.re_nsub; i++) {
		d.colors[i] = strdup(colors[i]);
	}
	definitions.push_back(d);

	size_t max_nmatch = 0;
	for (const Def& d: definitions) {
		max_nmatch = std::max(max_nmatch, d.preg.re_nsub);
	}
	pmatch = (regmatch_t *)realloc(pmatch, sizeof(regmatch_t) * (max_nmatch + 1));
}

char * SyntaxHighlighter::transform(const char *in) {
	static char out[4096];
	char input[4096];

	if (*in == '\0') {
		out[0] = '\0';
		return out;
	}

	strcpy(input, in);

	for (const Def& def: definitions) {
		int read_cursor = 0;
		int write_cursor = 0;
		int size = strlen(input);
		int end = 0;
		bool one_match = false;
		while (true) {
			if ((regexec(&def.preg, &input[read_cursor], def.preg.re_nsub + 1, pmatch, 0) == REG_NOMATCH) ||
				(pmatch[0].rm_so == -1))
				break;

			for (size_t group = 1; group <= def.preg.re_nsub; group++) {
				int start = pmatch[group].rm_so;
				if (start < 0)
					continue;

				/* Copy everything until the match */
				if (start > end) {
					memcpy(&out[write_cursor], &input[read_cursor + end], start - end);
					write_cursor += start - end;
				}

				end = pmatch[group].rm_eo;
				/* Insert the color code, and copy the matching part */
				write_cursor += sprintf(&out[write_cursor], "%s%.*s%s", def.colors[group - 1],
					end - start,
					&input[read_cursor + start],
					"#ffffff");
			}
			read_cursor += end;
			end = 0;
		}

		/* Copy the reminder */
		memcpy(&out[write_cursor], &input[read_cursor], size - read_cursor + 1);
		write_cursor += size - read_cursor + 1;
		out[write_cursor] = '\0';

		/* Use the output as the input for the next regexp */
		strcpy(input, out);
	}

	return out;
}

extern "C" {
	void umr_run_gui(const char *url) {
		run_gui(url);
	}
}
