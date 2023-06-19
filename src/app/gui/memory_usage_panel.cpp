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

/* Solarized palette (MIT License), https://github.com/altercation/solarized */
ImColor palette[] = {
	ImColor(181, 137,   0),
	ImColor(203,  75,  22),
	ImColor(220,  50,  47),
	ImColor(211,  54, 130),
	ImColor(108, 113, 196),
	ImColor( 38, 139, 210),
	ImColor( 42, 161, 152),
	ImColor(133, 153,   0),
	ImColor(131, 148, 150),
	ImColor(238, 232, 213),
	ImColor(253, 246, 227),
};

class MemoryUsagePanel : public Panel {
public:
	MemoryUsagePanel(struct umr_asic *asic) : Panel(asic), last_answer(NULL), last_vm_read(10), autorefresh(1) {
		got_first_drm_counters = false;
		show_gtt = true;
		show_vram = true;
		show_free_memory = true;
		drm_counters_offset = 0;
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
		if (can_send_request) {
			if (!last_answer || (autorefresh > 0 && last_vm_read > autorefresh)) {
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
		bool autorefresh_enabled = autorefresh >= 0;
		ImGui::PushID("autorefresh");
		if (ImGui::Checkbox("", &autorefresh_enabled)) {
			autorefresh = autorefresh_enabled ? 0.0 : -1;
		}
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
		if (last_answer && !memory_usage_app.empty()) {
			const char * titles[] = { "VRAM", "GTT", "Visible VRAM" };
			const char * names[] = { "vram", "gtt", "vis_vram" };

			char overlay[200];
			for (int i = 0; i < 3; i++) {
				JSON_Object *o = json_object(json_object_get_value(last_answer, names[i]));
				ImGui::Text("%*sUsed %s", (int)(strlen(titles[i]) - strlen(titles[2])), "", titles[i]);
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

			ImGui::Separator();
			ImGui::Text("Show: ");
			ImGui::SameLine();
			ImGui::Checkbox("GTT", &show_gtt);
			ImGui::SameLine();
			ImGui::Checkbox("VRAM", &show_vram);
			ImGui::SameLine();
			ImGui::Checkbox("Free memory", &show_free_memory);

			float max_s = 0;
			const float s = ImGui::GetFontSize();
			const float px = ImGui::GetStyle().FramePadding.x;
			for (size_t i = 0; i < memory_usage_app.size(); i++) {
				max_s = std::max(max_s,
					ImGui::CalcTextSize(memory_usage_app[i].name.c_str()).x +
					ImGui::CalcTextSize(format_bo_size(memory_usage_app[i].total)).x);
			}
			float legend_x = max_s + 4 * s + px;

			ImGui::BeginChild("amdgpu_vm_info", ImVec2(legend_x, 0));
			for (size_t i = 0; i < memory_usage_app.size(); i++) {
				ImVec2 base = ImGui::GetCursorScreenPos();
				ImVec2 end(base);
				end.x += legend_x;
				end.y += ImGui::GetTextLineHeightWithSpacing();
				memory_usage_app[i].highlight = ImGui::IsMouseHoveringRect(base, end);

				ImVec2 c(base.x + 2 * s, base.y + s);
				ImGui::GetWindowDrawList()->AddRectFilled(base, c,
														  palette[i % ARRAY_SIZE(palette)]);
				if (memory_usage_app[i].highlight)
					ImGui::GetWindowDrawList()->AddRect(base, c, IM_COL32_WHITE);

				base.x += 2 * s + px;
				ImGui::SetCursorScreenPos(base);
				if (memory_usage_app[i].name.size())
					ImGui::TextUnformatted(memory_usage_app[i].name.c_str());
				else
					ImGui::Text("pid-%d", memory_usage_app[i].pid);
				ImGui::SameLine();
				ImGui::TextUnformatted(format_bo_size(memory_usage_app[i].total));
			}
			ImGui::EndChild();
			ImGui::SameLine();
			ImGui::BeginChild("amdgpu_vm_info2", ImVec2(avail.x - legend_x - px * 2, 0));
			ImVec2 base = ImGui::GetCursorScreenPos();
			ImVec2 size = ImVec2(avail.x - legend_x - px * 2,
								 avail.y - base.y - ImGui::GetTextLineHeightWithSpacing());

			JSON_Object *o = json_object(json_object_get_value(last_answer, "gtt"));
			const uint64_t total_gtt = json_object_get_number(o, "total");
			o = json_object(json_object_get_value(last_answer, "vram"));
			const uint64_t total_vram = json_object_get_number(o, "total");
			o = json_object(json_object_get_value(last_answer, "vis_vram"));
			const uint64_t total_vis_vram = (used_vis_vram == 0) ? 0 : json_object_get_number(o, "total");

			float r;
			if (show_free_memory)
				r = (float)total_gtt / (total_gtt + total_vram);
			else
				r = (float)used_gtt / (used_gtt + used_vram);

			/* Split frame between GTT and VRAM */
			ImVec2 size_gtt, base_vram, size_vram;
			bool is_vertical = update_bbox(base, size, r, size_gtt, base_vram, size_vram, 5);

			if (show_gtt != show_vram) {
				if (show_gtt) {
					size_gtt = size;
				} else {
					base_vram = base;
					size_vram = size;
				}
			}

			int first_vram, first_vis_vram = -1;
			for (first_vram = 0; first_vram < memory_usage_data.size(); first_vram++)
				if (memory_usage_data[first_vram].memory_type == 1) {
					if (memory_usage_data[first_vram].visible) {
						if (first_vis_vram == -1)
							first_vis_vram = first_vram;
					} else {
						break;
					}
				}

			if (first_vis_vram < 0)
				first_vis_vram = first_vram;

			/* GTT */
			if (show_gtt) {
				ImGui::GetWindowDrawList()->AddRect(base, ImVec2(base.x + size_gtt.x, base.y + size_gtt.y),
													IM_COL32_WHITE);

				if (show_free_memory) {
					r = (float)used_gtt / total_gtt;
					ImVec2 size_rgtt, base_free, size_free;
					update_bbox(base, size_gtt, r, size_rgtt, base_free, size_free, 0);
					draw_treemap(0, first_vis_vram - 1, base, size_rgtt);
					draw_freespace(base_free, size_free, "GTT");
				} else {
					draw_treemap(0, first_vis_vram - 1, base, size_gtt);
				}
				ImGui::SetCursorPosX(size_gtt.x * 0.5);
				ImGui::SetCursorPosY(size.y);
				ImGui::TextUnformatted("GTT");
			}

			/* VRAM */
			if (show_vram) {
				ImGui::GetWindowDrawList()->AddRect(base_vram, ImVec2(base_vram.x + size_vram.x, base_vram.y + size_vram.y),
													IM_COL32_WHITE);

				/* Visible VRAM is part of VRAM */
				if (show_free_memory) {
					ImVec2 base_non_vis_vram, size_non_vis_vram;
					/* Split space between visible/non-visible VRAM */
					if (used_vis_vram > 0) {
						ImVec2 size_vis_vram;
						r = (float)total_vis_vram / total_vram;
						update_bbox(base_vram, size_vram, r, size_vis_vram, base_non_vis_vram, size_non_vis_vram, 3, is_vertical);
						/* Draw visible VRAM */
						ImVec2 size_vis_vram_used, base_vis_vram_free, size_vis_vram_free;
						r = (float)used_vis_vram / total_vis_vram;
						update_bbox(base_vram, size_vis_vram, r, size_vis_vram_used, base_vis_vram_free, size_vis_vram_free, 0);
						draw_treemap(first_vis_vram, first_vram - 1, base_vram, size_vis_vram_used);
						draw_freespace(base_vis_vram_free, size_vis_vram_free, "Vis VRAM");
					} else {
						base_non_vis_vram = base_vram;
						size_non_vis_vram = size_vram;
					}

					/* Draw invisible VRAM */
					ImVec2 size_vram_used, base_vram_free, size_vram_free;
					r = (float)used_vram / (total_vram - total_vis_vram);
					update_bbox(base_non_vis_vram, size_non_vis_vram, r, size_vram_used, base_vram_free, size_vram_free, 0);
					draw_treemap(first_vram, memory_usage_data.size() - 1, base_non_vis_vram, size_vram_used);
					draw_freespace(base_vram_free, size_vram_free, "VRAM");
				} else {
					/* Split space between visible/non-visible VRAM */
					if (used_vis_vram > 0) {
						ImVec2 size_vis_vram, base_non_vis_vram, size_non_vis_vram;
						r = (float)used_vis_vram / used_vram;
						update_bbox(base_vram, size_vram, r, size_vis_vram, base_non_vis_vram, size_non_vis_vram, 0, is_vertical);

						draw_treemap(first_vis_vram, first_vram - 1,
									 base_vram, size_vis_vram);
						draw_treemap(first_vram, memory_usage_data.size() - 1,
									 base_non_vis_vram, size_non_vis_vram);
					} else {
						draw_treemap(first_vram, memory_usage_data.size() - 1,
									 base_vram, size_vram);
					}
				}
				ImGui::SetCursorPosX(base_vram.x - base.x + size_vram.x * 0.5);
				ImGui::SetCursorPosY(size.y);
				ImGui::TextUnformatted("VRAM");
			}
			ImGui::EndChild();
		}
		ImGui::EndChild();
		#if 0
		ImGui::SameLine();
		ImGui::BeginChild("counters", ImVec2(avail.x, 0), false, ImGuiWindowFlags_NoTitleBar);
		const char *labels[] = {
			"GB moved", " evictions", "CPU page faults"
		};
		for (int i = 0; i < NUM_DRM_COUNTERS; i++) {
			float max = drm_counters[i * NUM_DRM_COUNTERS_VALUES + drm_counters_offset - 1];
			char l[128];
			if (i == 0)
				sprintf(l, "%.1f %s", max, labels[i]);
			else
				sprintf(l, "%d %s", (int)max, labels[i]);
			ImGui::PushID(labels[i]);
			ImGui::PlotLines("",
				 &drm_counters[i * NUM_DRM_COUNTERS_VALUES],
				 NUM_DRM_COUNTERS_VALUES,
				 drm_counters_offset,
				 l,
				 drm_counters_min[i], FLT_MAX,
				 ImVec2(0, avail.y / 4));
			ImGui::PopID();
		}
		ImGui::EndChild();
		#endif

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
		mem_data(uint32_t size = 0, uint8_t t = 0, bool v = false) :
				 bo_size(size), app_index(0), memory_type(t),
				 cpu_access(false), pinned(false), visible(v) {}
		uint32_t bo_size;
		uint32_t app_index;
		uint8_t memory_type;
		bool cpu_access;
		bool pinned;
		bool visible;
	};
	struct mem_app {
		uint32_t pid;
		std::string name;
		uint64_t total;
		bool highlight;
	};
	std::vector<mem_data> memory_usage_data;
	std::vector<mem_app> memory_usage_app;
	uint64_t used_gtt, used_vram, used_vis_vram;

	void prepare_memory_usage_data(JSON_Object *data) {
		std::vector<uint32_t> exported_ino;

		memory_usage_data.clear();
		memory_usage_app.clear();
		used_gtt = used_vram = used_vis_vram = 0;

		struct mem_app kernel;
		kernel.pid = -1;
		kernel.name = "kernel";
		kernel.total = 0;
		memory_usage_app.push_back(kernel);

		JSON_Array *pids = json_object_get_array(data, "pids");
		for (int i = 0; i < json_array_get_count(pids); i++) {
			uint64_t total = 0;
			JSON_Object *o = json_object(json_array_get_value(pids, i));
			uint32_t pid = json_object_get_number(o, "pid");

			/* Merge identical pid */
			size_t app_idx = memory_usage_app.size();
			for (size_t j = 0; j < memory_usage_app.size(); j++) {
				if (memory_usage_app[j].pid == pid) {
					app_idx = j;
					total = memory_usage_app[j].total;
					break;
				}
			}

			JSON_Array* bos = json_object_get_array(o, "bos");
			int bo_count = json_array_get_count(bos);

			if (bo_count == 0)
				continue;

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

				struct mem_data m;
				m.bo_size = json_object_get_number(bo, "size");
				m.app_index = app_idx;
				m.memory_type = json_object_get_number(bo, "gtt") ? 0 : 1;
				m.cpu_access = json_object_get_number(bo, "cpu");
				m.pinned = json_object_get_boolean(bo, "pinned");
				m.visible = json_object_get_number(bo, "visible");

				if (m.memory_type == 0)
					used_gtt += m.bo_size;
				else if (m.visible)
					used_vis_vram += m.bo_size;
				else
					used_vram += m.bo_size;

				total += m.bo_size;
				memory_usage_data.push_back(m);
			}
			if (app_idx == memory_usage_app.size()) {
				struct mem_app m;
				m.pid = pid;
				const char *name = json_object_get_string(o, "command");
				if (name)
					m.name = name;
				m.total = total;
				m.highlight = false;
				memory_usage_app.push_back(m);
			} else {
				memory_usage_app[app_idx].total = total;
			}
		}

		/* For each memory type add a fake buffer representing the mem allocations
		 * not exposed by the kernel through syfs (eg: firmwares, etc)
		 */
		JSON_Object *o = json_object(json_object_get_value(last_answer, "gtt"));
		const uint64_t total_gtt = json_object_get_number(o, "used");
		if (used_gtt < total_gtt) {
			memory_usage_data.push_back(mem_data(total_gtt - used_gtt));
			memory_usage_app[0].total += total_gtt - used_gtt;
			used_gtt = total_gtt;
		}
		o = json_object(json_object_get_value(last_answer, "vis_vram"));
		const uint64_t total_vis_vram = used_vis_vram > 0 ? json_object_get_number(o, "used") : 0;
		/* Only adjust vis_vram if the kernel reports VISIBLE. Otherwise don't display
		 * visible VRAM separately.
		 */
		if (used_vis_vram > 0 && used_vis_vram < total_vis_vram) {
			memory_usage_data.push_back(mem_data(total_vis_vram - used_vis_vram, 1, true));
			memory_usage_app[0].total += total_vis_vram - used_vis_vram;
			used_vis_vram = total_vis_vram;
		}
		o = json_object(json_object_get_value(last_answer, "vram"));
		const uint64_t total_vram = json_object_get_number(o, "used");
		if ((used_vis_vram + used_vram) < total_vram) {
			memory_usage_data.push_back(mem_data(total_vram - (used_vram + used_vis_vram), 1));
			memory_usage_app[0].total += total_vram - (used_vram + used_vis_vram);
			used_vram = total_vram - total_vis_vram;
		}

		std::sort(memory_usage_data.begin(), memory_usage_data.end(), [this](const struct mem_data& a, const struct mem_data& b) {
			/* Order like this: GTT, Visible VRAM, VRAM */
			if (a.memory_type != b.memory_type)
				return a.memory_type < b.memory_type;
			if (a.memory_type == 1 && a.visible != b.visible)
				return a.visible > b.visible;
			return a.bo_size > b.bo_size;
		});
	}

	const char* format_bo_size(uint64_t bo_size) {
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
					 bool force_vertical_split = false) {
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

	void draw_treemap(int begin, int end, ImVec2 base, ImVec2 size) {
		const ImVec2 padding(1.0, 1.0);
		if (begin == end) {
			ImVec2 corner1(base.x + padding.x, base.y + padding.y);
			ImVec2 corner2(corner1.x + size.x - 2 * padding.x,
						   corner1.y + size.y - 2 * padding.y);
			int idx = memory_usage_data[begin].app_index;

			ImGui::GetWindowDrawList()->AddRectFilled(corner1, corner2,
				ImColor(palette[idx % ARRAY_SIZE(palette)]));
			if (ImGui::IsMouseHoveringRect(corner1, corner2))
				ImGui::SetTooltip("App : %s\nSize: %s",
								  memory_usage_app[idx].name.c_str(),
								  format_bo_size(memory_usage_data[begin].bo_size));
			if (memory_usage_app[idx].highlight)
				ImGui::GetWindowDrawList()->AddRect(corner1, corner2, IM_COL32_WHITE);
			if (memory_usage_data[begin].cpu_access) {
				corner2.x = corner1.x + size.x * 0.3;
				ImGui::GetWindowDrawList()->AddRectFilled(
					corner1, corner2, ImColor(1.0f, 1.0f, 1.0f, 0.5f));
			}
			if (memory_usage_data[begin].pinned) {
				ImGui::GetWindowDrawList()->AddLine(
					corner1, corner2, ImColor(0.0f, 0.0f, 0.0f, 0.5f));
				std::swap(corner1.x, corner2.x);
				ImGui::GetWindowDrawList()->AddLine(
					corner1, corner2, ImColor(0.0f, 0.0f, 0.0f, 0.5f));
			}
		} else if (size.x * size.y < 50) {
			/* Area is too small. Draw a single rect. */
			ImVec2 corner1(base.x + padding.x, base.y + padding.y);
			ImVec2 corner2(corner1.x + size.x - 2 * padding.x,
						   corner1.y + size.y - 2 * padding.y);
			int idx = memory_usage_data[begin].app_index;

			ImGui::GetWindowDrawList()->AddRectFilled(corner1, corner2,
				ImColor(palette[idx % ARRAY_SIZE(palette)]));
		} else {
			uint64_t total = 0;
			for (int i = begin; i <= end; i++) {
				total += memory_usage_data[i].bo_size;
			}
			uint64_t target = total / 2;
			uint64_t partial = 0, closest = total;
			int cut = -1;
			for (int i = begin; i <= end; i++) {
				partial += memory_usage_data[i].bo_size;
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
				draw_treemap(begin, begin, base, size_left);
				draw_treemap(end, end, base_right, size_right);
			} else {
				assert(cut != end);
				draw_treemap(begin, cut, base, size_left);
				draw_treemap(cut + 1, end, base_right, size_right);
			}
		}
	}

private:
	JSON_Object *last_answer;
	float drm_counters[NUM_DRM_COUNTERS * NUM_DRM_COUNTERS_VALUES];
	float last_vm_read;
	float autorefresh;
	bool got_first_drm_counters;
	bool show_gtt, show_vram, show_free_memory;
	float drm_counters_min[NUM_DRM_COUNTERS];
	int drm_counters_offset;
};
