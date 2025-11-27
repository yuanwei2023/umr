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
#include "imgui.h"
#include "panels.h"
#include "parson.h"

#include <algorithm>
#include <cstdint>
#include <stdbool.h>
#include <vector>
#include <string>
#include <memory>

#define NUM_DRM_COUNTERS            3
#define NUM_DRM_COUNTERS_VALUES   100


const char *mem_type_title[] = {
	"UNKNOWN",
	"RAM",
	"GTT",
	"VRAM",
};

namespace Enum {
	enum Layout {
		LayoutHistory = 0,
		LayoutTreemap,
		LayoutCount,
	};
}

const uint16_t visible_icon[] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 1, 1, 1, 1, 0, 0,
	0, 1, 0, 0, 0, 0, 1, 0,
	1, 1, 0, 1, 1, 0, 1, 1,
	1, 0, 0, 1, 1, 0, 0, 1,
	0, 1, 0, 0, 0, 0, 1, 0,
	0, 0, 1, 1, 1, 1, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
};
const uint16_t pinned_icon[] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 1, 1, 1, 1, 1, 0,
	0, 1, 0, 0, 0, 0, 1, 0,
	0, 1, 1, 0, 0, 1, 1, 0,
	0, 0, 1, 1, 1, 1, 0, 0,
	0, 0, 0, 1, 1, 0, 0, 0,
	0, 0, 0, 1, 1, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
};
const uint16_t shared_icon[] = {
	0, 0, 0, 0, 0, 1, 1, 1,
	0, 0, 0, 0, 0, 1, 0, 1,
	0, 0, 0, 0, 1, 1, 1, 1,
	0, 0, 0, 1, 1, 0, 0, 0,
	1, 1, 1, 1, 0, 0, 0, 0,
	1, 0, 1, 0, 0, 0, 0, 0,
	1, 1, 1, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
};

const uint16_t *icons_bitmap[3] = { visible_icon, pinned_icon, shared_icon };
static void draw_rect_at_cursor(float x_off, int size, ImColor col, bool outline, ImColor col2) {
	ImVec2 base = ImGui::GetCursorScreenPos();
	base.x += x_off;
	ImVec2 c(base.x + 2 * size, base.y + size);

	ImColor co(col);
	if (col != col2)
		co.Value.w = 0.5;
	ImGui::GetWindowDrawList()->AddRectFilled(base, c, co, 3);

	if (outline)
		ImGui::GetWindowDrawList()->AddRect(base, c, IM_COL32_WHITE, 3);

	if (col != col2)
		ImGui::GetWindowDrawList()->AddLine(
			ImVec2(base.x + 3, base.y + size * 0.5), ImVec2(c.x - 3, base.y + size * 0.5), col2, 4);

	base.x += 2 * size + ImGui::GetStyle().FramePadding.x;
	ImGui::SetCursorScreenPos(base);
}

static void draw_rectangle(const ImVec2& bl, const ImVec2& tr, const ImColor& c1, const ImColor& c2, bool filled = true) {
	float rounding = (tr.y - bl.y > 6) ? 3 : 0;
	if (tr.x - bl.x <= 5 || c1 == c2) {
		if (filled)
			ImGui::GetWindowDrawList()->AddRectFilled(bl, tr, c1, rounding);
		else
			ImGui::GetWindowDrawList()->AddRect(bl, tr, c1, rounding);

		return;
	}

	ImColor c(c1);
	c.Value.w = 0.5;
	ImGui::GetWindowDrawList()->AddRectFilled(bl, tr, c, rounding);

	ImGui::GetWindowDrawList()->AddRect(
		ImVec2(bl.x + 3, bl.y + 3),
		ImVec2(tr.x - 3, tr.y - 3), c2, rounding, 0, 2);
}


class MemoryUsagePanel : public Panel {
public:
	MemoryUsagePanel(struct umr_asic *asic) : Panel(asic), last_answer(NULL), last_vm_read(10), autorefresh(1) {
		got_first_drm_counters = false;
		show_gtt = true;
		show_vram = true;
		show_free_memory = true;
		drm_counters_offset = 0;
		show_mem_type[0] = true;
		show_mem_type[1] = true;
		show_mem_type[2] = true;
		show_mem_type[3] = true;
		autorefresh_enabled = true;
		memset(icons, 0, sizeof(icons));
	}
	~MemoryUsagePanel() {
		if (last_answer)
			json_value_free(json_object_get_wrapping_value(last_answer));
	}

	void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) {
		JSON_Value *error = json_object_get_value(response, "error");
		if (error)
			return;

		JSON_Object *request = json_object(json_object_get_value(response, "request"));
		JSON_Value *answer = json_object_get_value(response, "answer");
		const char *command = json_object_get_string(request, "command");

		if (!strcmp(command, "memory-usage")) {
			if (last_answer)
				json_value_free(json_object_get_wrapping_value(last_answer));
			last_answer = json_object(json_value_deep_copy(answer));

			prepare_memory_usage_data(last_answer);
		} else if (!strcmp(command, "drm-counters")) {
			double values[3];
			values[0] = json_object_get_number(json_object(answer), "bytes-moved") / (1024.0 * 1024.0 * 1024);
			values[1] = json_object_get_number(json_object(answer), "num-evictions");
			values[2] = json_object_get_number(json_object(answer), "cpu-page-faults");
			if (got_first_drm_counters) {
				for (int i = 0; i < NUM_DRM_COUNTERS; i++) {
					drm_counters[i * NUM_DRM_COUNTERS_VALUES + drm_counters_offset] = (float) values[i];
				}
				drm_counters_offset = (drm_counters_offset + 1) % NUM_DRM_COUNTERS_VALUES;
			} else {
				got_first_drm_counters = true;
				for (int i = 0; i < NUM_DRM_COUNTERS; i++) {
					for (int j = 0; j < NUM_DRM_COUNTERS_VALUES; j++) {
						drm_counters[i * NUM_DRM_COUNTERS_VALUES + j] = (float) values[i];
					}
					drm_counters_min[i] = (float)values[i];
				}
			}
		}
	}

	void draw_freespace(ImVec2 base, ImVec2 size, const char *label) {
		ImVec2 corner(base);
		corner.x += size.x;
		corner.y += size.y;
		ImGui::GetWindowDrawList()->AddRectFilled(base, corner, ImColor(1.0f, 1.0f, 1.0f, 0.1f));
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		if (icons[0] == 0)
			init_icons();

		if (can_send_request) {
			if (!last_answer || (autorefresh_enabled && last_vm_read > autorefresh)) {
				send_memory_usage_command();
				send_drm_counters_command();
				last_vm_read = 0;
			}
			last_vm_read += dt;
		}

		if (ImGui::Button("Refresh")) {
			send_memory_usage_command();
			send_drm_counters_command();
			last_vm_read = 0;
		}
		ImGui::SameLine();
		ImGui::Text("Auto-refresh");
		ImGui::SameLine();
		ImGui::PushID("autorefresh");
		ImGui::Checkbox("", &autorefresh_enabled);
		ImGui::PopID();
		if (autorefresh_enabled) {
			ImGui::SameLine();
			ImGui::Text("Interval:");
			ImGui::SameLine();
			ImGui::DragFloat(" (drag to modify)", &autorefresh, 0.1, 0, 10, "%.1f sec");
		}
		ImGui::Separator();
		const char *evict_labels[] = { "Evict VRAM", "Evict GTT" };
		ImGui::BeginChild("bars", ImVec2(avail.x, 0), false, ImGuiWindowFlags_NoTitleBar);
		if (last_answer && !memory_usage_snapshots.empty()) {
			const char * titles[] = { "VRAM", "GTT", "Visible VRAM" };
			const char * names[] = { "vram", "gtt", "vis_vram" };

			char overlay[200];
			for (int i = 0; i < 3; i++) {
				JSON_Object *o = json_object(json_object_get_value(last_answer, names[i]));
				ImGui::Text("%*s%s", (int)(strlen(titles[i]) - strlen(titles[2])), "", titles[i]);
				ImGui::SameLine();
				uint64_t used = ((uint64_t) json_object_get_number(o, "used")) / (1024 * 1024);
				uint64_t total = ((uint64_t) json_object_get_number(o, "total")) / (1024 * 1024);
				float ratio = used / (float)total;
				sprintf(overlay, "%.1f%% (of %" PRId64 " MB)", 100 * ratio, total);
				ImGui::ProgressBar(ratio, ImVec2(avail.x / 3, 0), overlay);

				if (i < 2) {
					ImGui::SameLine();
					if (ImGui::Button("Evict")) {
						send_evict_command(i);
					}
				}
			}

			if (memory_usage_snapshots.empty())
				return false;

			if (current_snapshot_index < 0 || current_snapshot_index >= memory_usage_snapshots.size())
				current_snapshot_index = memory_usage_snapshots.size() - 1;

			mem_app_snapshot *current_snapshot =
				memory_usage_snapshots.data() + current_snapshot_index;

			float legend_x = prepare_legend(current_snapshot);

			ImGui::BeginChild("legend", ImVec2(legend_x, 0));
			draw_legend(current_snapshot, legend_x);
			ImGui::EndChild();

			ImGui::SameLine();

			float remaining_w = avail.x - legend_x - ImGui::GetStyle().FramePadding.x * 2;
			ImGui::BeginChild("graph", ImVec2(remaining_w, 0));

			ImVec2 base = ImGui::GetCursorScreenPos();
			ImVec2 size = ImVec2(remaining_w,
								 avail.y - base.y - ImGui::GetTextLineHeightWithSpacing());

			if (layout == Enum::LayoutHistory)
				draw_memory_usage_history(base, size, memory_usage_snapshots, current_snapshot);
			else if (layout == Enum::LayoutTreemap)
				draw_memory_snapshot_as_treemap(base, size, memory_usage_snapshots, current_snapshot);

			ImGui::EndChild();
		}
		ImGui::EndChild();

		return autorefresh;
	}
private:
	void send_memory_usage_command() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "memory-usage");
		send_request(req);
	}
	void send_drm_counters_command() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "drm-counters");
		send_request(req);
	}
	void send_evict_command(int type) {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "evict");
		json_object_set_number(json_object(req), "type", type);
		send_request(req);
	}

	struct mem_data {
		mem_data(JSON_Object *bo) {
			bo_size = json_object_get_number(bo, "size");
			handle = json_object_get_number(bo, "handle");
			can_be_viewed = json_object_get_number(bo, "has_metadata");

			JSON_Object *att = json_object_get_object(bo, "attributes");
			memory_type = 0;
			for (int i = 0; i < ARRAY_SIZE(mem_type_title); i++) {
				if (json_object_get_number(att, mem_type_title[i])) {
					memory_type = i;
					break;
				}
			}
			shared = json_object_has_value(att, "exported as ino");
			pinned = json_object_has_value(att, "pin count");
			this->attr = json_object(json_value_deep_copy(json_object_get_wrapping_value(att)));
		}
		mem_data& operator=(const mem_data& d) {
			_copy(d);
			return *this;
		}
		mem_data(const mem_data& d) {
			_copy(d);
		}
		void _copy(const mem_data& d) {
			this->bo_size = d.bo_size;
			this->can_be_viewed = d.can_be_viewed;
			this->pinned = d.pinned;
			this->shared = d.shared;
			this->app_index = d.app_index;
			this->fd_index = d.fd_index;
			this->handle = d.handle;
			this->memory_type = d.memory_type;
			this->attr = json_object(json_value_deep_copy(json_object_get_wrapping_value(d.attr)));
		}
		~mem_data() {
			json_value_free(json_object_get_wrapping_value(attr));
		}

		uint64_t bo_size;
		uint32_t app_index;
		uint32_t fd_index;
		uint32_t handle;
		uint16_t memory_type;
		bool can_be_viewed, pinned, shared;
		JSON_Object *attr;
	};
	struct mem_file {
		mem_file() : total(0) {}
		std::string drm_client_name;
		uint64_t total;
		uint32_t drm_client_id;
		uint32_t gpu_fd;
	};
	struct mem_app {
		mem_app() : total(0), num_bos(0) {}

		uint32_t pid;
		std::string name;
		uint64_t total;
		uint32_t num_bos;
		bool highlight;
		std::vector<mem_file> per_fd;
	};
	struct mem_app_snapshot {
		mem_app_snapshot() {
			memset(used_mem_type, 0, sizeof(used_mem_type));
		}
		std::vector<mem_app> apps;
		std::vector<mem_data> bos;
		uint64_t used_mem_type[8];
	};
	std::vector<mem_app_snapshot> memory_usage_snapshots;
	int current_snapshot_index = -1;
	bool show_mem_type[ARRAY_SIZE(mem_type_title)];
	float zoom = 1.0;

	void prepare_memory_usage_data(JSON_Object *data) {
		std::vector<uint32_t> exported_ino;

		mem_app_snapshot snapshot;
		auto &memory_usage_data = snapshot.bos;

		JSON_Array *apps = json_object_get_array(data, "apps");
		for (int i = 0; i < json_array_get_count(apps); i++) {
			uint64_t total = 0;
			JSON_Object *app = json_object(json_array_get_value(apps, i));
			uint32_t pid = json_object_get_number(app, "pid");

			struct mem_app app_stat;
			app_stat.pid = pid;
			const char *name = json_object_get_string(app, "command");
			if (name)
				app_stat.name = name;

			JSON_Array* clients = json_object_get_array(app, "clients");
			for (size_t j = 0; j < json_array_get_count(clients); j++) {
				JSON_Object *client = json_object(json_array_get_value(clients, j));
				JSON_Array* bos = json_object_get_array(client, "bos");

				struct mem_file file;
				const char *drm_client_name = json_object_get_string(client, "drm-client-name");
				if (drm_client_name)
					file.drm_client_name = drm_client_name;
				file.drm_client_id = json_object_get_number(client, "drm-client-id");
				file.gpu_fd = json_object_get_number(client, "gpu-fd");

				const int bo_count = json_array_get_count(bos);
				for (int k = 0; k < bo_count; k++) {
					JSON_Object *bo = json_object(json_array_get_value(bos, k));

					/* The same bo may endup being exported multiple times. Only
					 * consider the first one.
					 */
					if (json_object_has_value(bo, "ino")) {
						uint32_t ino = json_object_get_number(bo, "ino");
						if (std::find(exported_ino.begin(), exported_ino.end(), ino) != exported_ino.end()) {
							continue;
						}
						exported_ino.push_back(ino);
					}

					struct mem_data m(bo);
					m.app_index = i;
					m.fd_index = j;
					memory_usage_data.push_back(m);

					snapshot.used_mem_type[m.memory_type] += m.bo_size;
					file.total += m.bo_size;
					app_stat.total += m.bo_size;
					app_stat.num_bos += 1;
				}
				app_stat.per_fd.push_back(file);
			}

			snapshot.apps.push_back(app_stat);
		}

		std::sort(memory_usage_data.begin(), memory_usage_data.end(), [this](const struct mem_data& a, const struct mem_data& b) {
			if (a.memory_type != b.memory_type)
				return a.memory_type < b.memory_type;
			return a.bo_size > b.bo_size;
		});

		memory_usage_snapshots.push_back(snapshot);
	}


	float prepare_legend(mem_app_snapshot *snapshot) const {
		float max_s = 0;
		const float s = ImGui::GetFontSize();
		const float px = ImGui::GetStyle().FramePadding.x;
		char label[128];

		for (size_t i = 0; i < snapshot->apps.size(); i++) {
			const auto& app = snapshot->apps[i];
			sprintf(label, "%s (%d)", app.name.c_str(), app.pid);
			max_s = std::max(max_s,
				ImGui::CalcTextSize(label).x +
				ImGui::CalcTextSize(format_bo_size(app.total)).x);

			for (size_t j = 0; j < app.per_fd.size(); j++) {
				const auto& fd = app.per_fd[j];
				max_s = std::max(max_s,
					px + px + ImGui::CalcTextSize(fd.drm_client_name.c_str()).x +
					ImGui::CalcTextSize(format_bo_size(fd.total)).x);
			}
		}

		return max_s + 4 * s + px;
	}

	void draw_legend(mem_app_snapshot *snapshot, float legend_width) {
		const float s = ImGui::GetFontSize();

		const char *titles[] = { "History", "Treemap" };
		if (ImGui::BeginCombo("", titles[layout])) {
			for (int i = 0; i < Enum::LayoutCount; i++) {
				if (ImGui::Selectable(titles[i], layout == i)) {
					layout = static_cast<Enum::Layout>(i);
				}
			}
			ImGui::EndCombo();
		}

		ImGui::Text("Snapshot #%d", current_snapshot_index);

		for (size_t i = 0; i < snapshot->apps.size(); i++) {
			auto& app = snapshot->apps[i];
			const ImColor col = palette[app.pid % ARRAY_SIZE(palette)];
			ImVec2 base = ImGui::GetCursorScreenPos();
			ImVec2 end(base);
			end.x += legend_width;
			end.y += ImGui::GetTextLineHeightWithSpacing();
			app.highlight = ImGui::IsMouseHoveringRect(base, end);

			bool no_per_fd = snapshot->apps[i].pid == 0 ||
							 app.per_fd.size() == 1;

			if (no_per_fd) {
				draw_rect_at_cursor(0, s, col, app.highlight, col);
			} else {
				ImColor c(col);
				c.Value.w = 0.5;
				draw_rect_at_cursor(0, s, c, app.highlight, c);
			}

			if (!app.name.empty())
				ImGui::Text("%s (%d)", snapshot->apps[i].name.c_str(),
				snapshot->apps[i].pid);
			ImGui::SameLine();

			/* Right Align. */
			const char *sz = format_bo_size(app.total);
			ImGui::GetWindowDrawList()->AddText(
				ImVec2(end.x - ImGui::CalcTextSize(sz).x, base.y), IM_COL32_WHITE, sz);
			ImGui::NewLine();

			if (no_per_fd)
				continue;

			for (size_t j = 0; j < app.per_fd.size(); j++) {
				const auto& fd = app.per_fd[j];
				draw_rect_at_cursor(s, s, col, app.highlight,
									palette[(app.pid + 1 + j) % ARRAY_SIZE(palette)]);
				if (!fd.drm_client_name.empty()) {
					char cmp[256];
					const char *fd_name = fd.drm_client_name.c_str();
					snprintf(cmp, sizeof(cmp), "%s/", snapshot->apps[i].name.c_str());
					size_t l = strlen(snapshot->apps[i].name.c_str());
					/* If the fd_name starts with "app_name/" skip it. */
					if (strncmp(fd_name, cmp, l + 1) == 0)
						fd_name += l + 1;
					ImGui::TextUnformatted(fd_name);
				} else {
					ImGui::Text("drm-client-id: %d", fd.drm_client_id);
				}
				ImGui::SameLine();

				const char *sz = format_bo_size(fd.total);
				ImGui::GetWindowDrawList()->AddText(
					ImVec2(end.x - ImGui::CalcTextSize(sz).x, base.y +
						   (j + 1) * ImGui::GetTextLineHeightWithSpacing()), IM_COL32_WHITE, sz);
				ImGui::NewLine();
			}
		}
	}

	float get_box_width_history(float graph_with, size_t n_snapshots) const {
		return std::min(ImGui::GetFontSize() * 2, (zoom * graph_with) / n_snapshots);
	}

	void draw_memory_usage_history(ImVec2 base, ImVec2 size,
								   std::vector<mem_app_snapshot>& snapshots,
								   const mem_app_snapshot *current) {
		uint64_t total_vram = (uint64_t)json_object_dotget_number(last_answer, "vram.total");
		uint64_t total_mem =
			(uint64_t)json_object_dotget_number(last_answer, "gtt.total") + total_vram;

		uint64_t max_used_mem = 0;
		for (size_t i = 0; i < snapshots.size(); i++) {
			uint64_t t = 0;
			for (const auto& app: snapshots[i].apps) {
				t += app.total;
			}
			max_used_mem = std::max(max_used_mem, t);
		}

		uint64_t displayed_mem = (max_used_mem * 1.1);

		/* Reserve some space at the bottom for the options. */
		const ImVec2 below_graph(base.x, base.y + size.y);
		const float original_size_x = size.x;
		size.y -= ImGui::GetTextLineHeightWithSpacing();

		const float w = ImGui::GetIO().MouseWheel;
		if (w) {
			zoom += w * 0.1 * zoom;
			if (zoom < 1)
				zoom = 1;
		}

		const float box_width = get_box_width_history(size.x, snapshots.size());
		const float hbox_spacing = box_width * 0.1;
		const float px = ImGui::GetStyle().FramePadding.x;
		const float base_x = base.x;
		base.x += size.x - box_width;
		base.y += size.y;
		float base_y = base.y;
		for (int i = (int)snapshots.size() - 1; i >= 0; i--) {
			mem_app_snapshot& snapshot = snapshots[i];

			ImVec2 r1(base.x + hbox_spacing, base.y - size.y);
			ImVec2 r2(base.x + box_width - hbox_spacing, base.y);

			if (r2.x < base_x)
				break;

			if (ImGui::IsMouseHoveringRect(r1, r2)) {
				current_snapshot_index = i;
				if (ImGui::IsMouseClicked(ImGuiMouseButton_Left))
					layout = Enum::LayoutTreemap;
			}

			/* Draw frame */
			if (&snapshot == current) {
				ImGui::GetWindowDrawList()->AddRectFilled(r1, r2, ImColor(1.0f, 1.0f, 1.0f, 0.2f), 3);

				char title[32];
				sprintf(title, "%.1f %% GTT+VRAM", 100 * max_used_mem / (float)total_mem);

				float ty = base_y - size.y;
				float tl = ImGui::CalcTextSize(title).x;
				ImGui::GetWindowDrawList()->AddText(
					ImVec2(base.x - tl * 0.5, ty), IM_COL32_WHITE, title);

				ty += ImGui::GetTextLineHeight() * 0.5;

				ImGui::GetWindowDrawList()->AddLine(
					ImVec2(base_x, ty),
					ImVec2(base.x - tl * 0.5 - px, ty), IM_COL32_WHITE, 3);
				ImGui::GetWindowDrawList()->AddLine(
					ImVec2(base.x + tl * 0.5 + px, ty),
					ImVec2(base.x + size.x, ty), IM_COL32_WHITE, 3);
			}

			for (size_t j = 0; j < snapshot.apps.size(); j++) {
				auto& app = snapshot.apps[j];

				bool use_subcolor = app.pid && app.per_fd.size() > 1;

				uint64_t app_total = app.total;

				const float sy = (app_total * size.y) / displayed_mem;
				ImColor col(palette[app.pid % ARRAY_SIZE(palette)]);
				if (use_subcolor)
					col.Value.w = 0.5;
				draw_rectangle(ImVec2(r1.x, base.y),
							   ImVec2(r2.x, base.y - sy),
							   col, col);

				if (use_subcolor) {
					float by = base.y;
					for (size_t k = 0; k < app.per_fd.size(); k++) {
						float s_fd_y = (app.per_fd[k].total * size.y) / displayed_mem;
						ImGui::GetWindowDrawList()->AddRectFilled(
									ImVec2(r1.x + 2, by),
								    ImVec2(r2.x - 2, by - std::min(sy, s_fd_y - 1)),
									palette[(app.pid + 1 + k) % ARRAY_SIZE(palette)]);
						app_total -= app.per_fd[k].total;
						by -= s_fd_y;
					}
				}

				base.y -= sy + 1;
			}
			base.x -= box_width;
			base.y = base_y;
		}

		ImGui::SetCursorScreenPos(below_graph);
		if (ImGui::Button("Clear Data"))
			memory_usage_snapshots.clear();
	}

	void draw_memory_snapshot_as_treemap(ImVec2 base, ImVec2 size, std::vector<mem_app_snapshot>& snapshots,
										 mem_app_snapshot *snapshot) {
		uint64_t total_per_cat[4] = {
			snapshot->used_mem_type[0], /* Unknown */
			snapshot->used_mem_type[1], /* RAM */
			show_free_memory ? (uint64_t)json_object_dotget_number(last_answer, "gtt.total") :
							   snapshot->used_mem_type[2], /* GTT */
			show_free_memory ? (uint64_t)json_object_dotget_number(last_answer, "vram.total") :
							   snapshot->used_mem_type[3], /* VRAM */
		};

		/* Reserve some space at the bottom for the options. */
		const ImVec2 below_graph(base.x, base.y + size.y);
		const float original_size_x = size.x;
		size.y -= 2 * ImGui::GetTextLineHeightWithSpacing();
		const auto &memory_usage_data = snapshot->bos;

		int start_bo_index = 0;
		for (int i = 0; i < ARRAY_SIZE(mem_type_title); i++) {
			if (!show_mem_type[i] || total_per_cat[i] == 0)
				continue;

			/* Determine how much space this category can use. */
			uint64_t total_considered_memory = 0;
			for (int j = i; j < ARRAY_SIZE(mem_type_title); j++)
				total_considered_memory += show_mem_type[j] ? total_per_cat[j] : 0;
			float r = total_per_cat[i] / (float) total_considered_memory;

			ImVec2 cat_size, remain_base, remain_size;
			bool is_vertical = update_bbox(base, size, r, cat_size, remain_base, remain_size, 5);

			int end_bo_index = -1;
			bool start_valid = false;
			for (int j = start_bo_index; j < memory_usage_data.size(); j++) {
				if (memory_usage_data[j].memory_type == i) {
					if (!start_valid) {
						start_bo_index = j;
						start_valid = true;
					}
					end_bo_index = j;
				} else if (start_valid) {
					break;
				}
			}

			if (end_bo_index >= 0) {
				float ts = ImGui::CalcTextSize(mem_type_title[i]).x;
				if (cat_size.x > ts) {
					ImGui::GetWindowDrawList()->AddText(
						ImVec2(base.x + cat_size.x * 0.5 - ts * 0.5,
							   base.y + size.y),
						IM_COL32_WHITE,
						mem_type_title[i]);
				}
			}

			ImVec2 free_cat_base, free_cat_size;
			if (show_free_memory && (i == 2 || i ==3)) {
				ImVec2 used_cat_size;

				float used_ratio = snapshot->used_mem_type[i] / (float)total_per_cat[i];
				update_bbox(base, cat_size, used_ratio, used_cat_size, free_cat_base, free_cat_size, 0);
				cat_size = used_cat_size;
			}
			if (end_bo_index >= 0)
				draw_treemap(*snapshot, start_bo_index, end_bo_index, base, cat_size);

			if (show_free_memory && (i == 2 || i ==3)) {
				draw_freespace(free_cat_base, free_cat_size, "GTT");
			}

			start_bo_index = end_bo_index + 1;

			base = remain_base;
			size = remain_size;
		}

		/* Draw snapshot selection. */
		base = below_graph;
		size.y = ImGui::GetTextLineHeight();
		float box_width = get_box_width_history(original_size_x, snapshots.size());
		const float hbox_spacing = box_width * 0.1;
		base.x += original_size_x - box_width;

		for (int i = (int)snapshots.size() - 1; i >= 0 && base.x >= below_graph.x; i--) {
			mem_app_snapshot& snapshot = snapshots[i];

			ImVec2 r1(base.x + hbox_spacing, base.y - size.y);
			ImVec2 r2(base.x + box_width - hbox_spacing, base.y);

			if (ImGui::IsMouseHoveringRect(r1, r2)) {
				if (ImGui::IsMouseClicked(ImGuiMouseButton_Left))
					current_snapshot_index = i;
				if (ImGui::IsMouseClicked(ImGuiMouseButton_Right))
					layout = Enum::LayoutHistory;
			}

			ImGui::GetWindowDrawList()->AddRectFilled(r1, r2,
				ImColor(1.0f, 1.0f, 1.0f, current_snapshot_index == i ? 0.2f : 1.0f));

			base.x -= box_width;
		}

		ImGui::SetCursorScreenPos(below_graph);
		ImGui::Text("Show: ");
		for (int i = 0; i < ARRAY_SIZE(show_mem_type) && i <= 3; i++) {
			ImGui::SameLine();
			ImGui::Checkbox(mem_type_title[i], &show_mem_type[i]);
		}
		ImGui::SameLine();
		ImGui::Checkbox("Free memory", &show_free_memory);
	}


	const char* format_bo_size(uint64_t bo_size) const {
		static char txt[256];
		if (bo_size < 1024)
			sprintf(txt, "%lu bytes", bo_size);
		if (bo_size < 1024 * 1024)
			sprintf(txt, "%lu kB", bo_size / 1024);
		else if (bo_size < 1024 * 1024 * 1024)
			sprintf(txt, "%lu MB", bo_size / (1024 * 1024));
		else
			sprintf(txt, "%lu GB", bo_size / (1024 * 1024 * 1024));
		return txt;
	}

	bool update_bbox(const ImVec2& base, const ImVec2& size, float ratio,
					 ImVec2& size1, ImVec2& base2, ImVec2& size2,
					 float padding = 0,
					 bool force_vertical_split = false) const {
		size1 = size2 = size;
		base2 = base;

		if (size.x > size.y || force_vertical_split) {
			size1.x = size.x * ratio - padding * 0.5;
			base2.x += size1.x + padding;
			size2.x = size.x * (1 - ratio) - padding * 0.5;
			return true;
		} else {
			size1.y = size.y * ratio - padding * 0.5;
			base2.y += size1.y + padding;
			size2.y = size.y * (1 - ratio) - padding * 0.5;
			return false;
		}
	}

	void draw_treemap(const mem_app_snapshot& snapshot, int begin, int end, ImVec2 base, ImVec2 size) {
		const ImVec2 padding(1.0, 1.0);
		
		if (begin == end) {
			const float icon_size = ImGui::GetFontSize();
			ImVec2 corner1(base.x + padding.x, base.y + padding.y);
			ImVec2 corner2(corner1.x + size.x - 2 * padding.x,
						   corner1.y + size.y - 2 * padding.y);
			int app_idx = snapshot.bos[begin].app_index;
			assert(app_idx < snapshot.apps.size());
			const auto& app = snapshot.apps[app_idx];
			bool use_subcolor = app.pid && app.per_fd.size() > 1;
			int fd_idx = snapshot.bos[begin].fd_index;

			draw_rectangle(corner1, corner2,
						   palette[app.pid % ARRAY_SIZE(palette)],
						   palette[(app.pid + (use_subcolor ? (1 + fd_idx): 0)) % ARRAY_SIZE(palette)]);

			const ImVec2 icon_padding = ImGui::GetStyle().FramePadding;
			if (size.x > (icon_size + icon_padding.x) && size.y > (icon_size + icon_padding.y)) {
				ImGui::PushClipRect(corner1, corner2, true);
				float icon_base_x = corner1.x + icon_padding.x;
				float icon_base_y = corner1.y + icon_padding.y;
				if (snapshot.bos[begin].can_be_viewed) {
					ImGui::GetWindowDrawList()->AddImage(
						(ImTextureID) (intptr_t) icons[0],
						ImVec2(icon_base_x, icon_base_y), ImVec2(icon_base_x + icon_size, icon_base_y + icon_size));
					icon_base_x += icon_size + icon_padding.x;
				}
				if (snapshot.bos[begin].pinned) {
					ImGui::GetWindowDrawList()->AddImage(
						(ImTextureID) (intptr_t) icons[1],
						ImVec2(icon_base_x, icon_base_y), ImVec2(icon_base_x + icon_size, icon_base_y + icon_size));
					icon_base_x += icon_size + icon_padding.x;
				}
				if (snapshot.bos[begin].shared) {
					ImGui::GetWindowDrawList()->AddImage(
						(ImTextureID) (intptr_t) icons[2],
						ImVec2(icon_base_x, icon_base_y), ImVec2(icon_base_x + icon_size, icon_base_y + icon_size));
					icon_base_x += icon_size + icon_padding.x;
				}
				ImGui::PopClipRect();
			}

			if (ImGui::IsMouseHoveringRect(corner1, corner2)) {
				ImGui::BeginTooltip();
				ImGui::Text("App: %s, PID: %d", app.name.empty() ? "" : app.name.c_str(), app.pid);
				ImGui::Text("drm-client-id: %d", app.per_fd[fd_idx].drm_client_id);
				if (!app.per_fd[fd_idx].drm_client_name.empty())
					ImGui::Text("drm-client-name: %s", app.per_fd[fd_idx].drm_client_name.c_str());
				ImGui::Text("Size: %s", format_bo_size(snapshot.bos[begin].bo_size));
				ImGui::SetMouseCursor(snapshot.bos[begin].can_be_viewed ? ImGuiMouseCursor_Hand : ImGuiMouseCursor_Arrow);
				if (snapshot.bos[begin].handle) {
					ImGui::Text("Handle: %d", snapshot.bos[begin].handle);
					if (snapshot.bos[begin].can_be_viewed && ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
						JSON_Value *req = json_value_init_object();
						json_object_set_string(json_object(req), "command", "peak-bo");
						json_object_set_number(json_object(req), "pid", app.pid);
						json_object_set_number(json_object(req), "handle", snapshot.bos[begin].handle);
						json_object_set_number(json_object(req), "gpu-fd", app.per_fd[fd_idx].gpu_fd);
						send_request(req);
						goto_tab(SDLK_o);
					}
				}
				JSON_Object *attr = snapshot.bos[begin].attr;
				for (size_t i = 0; i < json_object_get_count(attr); i++)
					ImGui::Text("%s: %d", json_object_get_name(attr, i), (int)json_number(json_object_get_value_at(attr, i)));

				ImGui::EndTooltip();
			}
			if (snapshot.apps[app_idx].highlight)
				ImGui::GetWindowDrawList()->AddRect(corner1, corner2, IM_COL32_WHITE);
		} else if (size.x * size.y < 50) {
			/* Area is too small. Draw a single rect. */
			ImVec2 corner1(base.x + padding.x, base.y + padding.y);
			ImVec2 corner2(corner1.x + size.x - 2 * padding.x,
						   corner1.y + size.y - 2 * padding.y);
			int app_idx = snapshot.bos[begin].app_index;
			const auto& app = snapshot.apps[app_idx];
			int fd_idx =
				(app.pid && app.per_fd.size() > 1) ?
					snapshot.bos[begin].fd_index : -1;

			draw_rectangle(corner1, corner2,
						   palette[app.pid % ARRAY_SIZE(palette)],
						   palette[(app.pid + 1 + fd_idx) % ARRAY_SIZE(palette)]);
		} else {
			uint64_t total = 0;
			for (int i = begin; i <= end; i++) {
				total += snapshot.bos[i].bo_size;
			}
			uint64_t target = total / 2;
			uint64_t partial = 0, closest = total;
			int cut = -1;
			for (int i = begin; i <= end; i++) {
				partial += snapshot.bos[i].bo_size;
				if (partial < target) {
					closest = partial;
					cut = i;
				} else if (partial >= target) {
					if (partial - target < target - closest) {
						closest = partial;
						cut = i;
					}
					break;
				}
			}

			float ratio = closest / (float)total;

			assert(cut >= begin && cut <= end);
			ImVec2 size_left, base_right, size_right;
			update_bbox(base, size, ratio, size_left, base_right, size_right);

			if (end == begin + 1) {
				draw_treemap(snapshot, begin, begin, base, size_left);
				draw_treemap(snapshot, end, end, base_right, size_right);
			} else {
				assert(cut != end);
				draw_treemap(snapshot, begin, cut, base, size_left);
				draw_treemap(snapshot, cut + 1, end, base_right, size_right);
			}
		}
	}

	void init_icons() {
		glGenTextures(ARRAY_SIZE(icons), icons);
		for (int i = 0; i < ARRAY_SIZE(icons); i++) {
			glBindTexture(GL_TEXTURE_2D, icons[i]);
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 8, 8, 0,
						 GL_RGBA, GL_UNSIGNED_SHORT_5_5_5_1, icons_bitmap[i]);
			}
	}

private:
	JSON_Object *last_answer;
	float drm_counters[NUM_DRM_COUNTERS * NUM_DRM_COUNTERS_VALUES];
	float last_vm_read;
	float autorefresh;
	bool autorefresh_enabled;
	bool got_first_drm_counters;
	bool show_gtt, show_vram, show_free_memory;
	float drm_counters_min[NUM_DRM_COUNTERS];
	int drm_counters_offset;

	GLuint icons[ARRAY_SIZE(icons_bitmap)];

	Enum::Layout layout = Enum::LayoutHistory;
};
