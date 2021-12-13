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
#include "panels.h"

#include <algorithm>

class MemoryUsagePanel : public Panel {
public:
	MemoryUsagePanel(struct umr_asic *asic) : Panel(asic), last_answer(NULL), last_vm_read(10), autorefresh(-1) { }
	~MemoryUsagePanel() {
		if (last_answer)
			json_value_free(json_object_get_wrapping_value(last_answer));
	}

	void process_server_message(JSON_Object *request, JSON_Value *answer) {
		const char *command = json_object_get_string(request, "command");

		if (!strcmp(command, "memory-usage")) {
			if (last_answer)
				json_value_free(json_object_get_wrapping_value(last_answer));
			last_answer = json_object(json_value_deep_copy(answer));
		}
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		if (can_send_request) {
			if (!last_answer || (autorefresh > 0 && last_vm_read > autorefresh)) {
				send_memory_usage_command();
				last_vm_read = 0;
			}
		}
		last_vm_read += dt;

		if (ImGui::Button("Refresh")) {
			send_memory_usage_command();
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
		if (last_answer) {
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
				ImGui::ProgressBar(ratio, ImVec2(-1, 0), overlay);
			}

			ImGui::Separator();

			ImGui::BeginChild("amdgpu_vm_info");
			JSON_Array *pids = json_object_get_array(last_answer, "pids");
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
				ImGui::PushID(pid);
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
								if (ImGui::TreeNodeEx(categories[c], 0, "%s (%ld bos)", categories[c], bos.size())) {
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

		return autorefresh;
	}
private:
	void send_memory_usage_command() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "memory-usage");
		send_request(req);
	}
private:
	JSON_Object *last_answer;
	float last_vm_read;
	float autorefresh;
};
