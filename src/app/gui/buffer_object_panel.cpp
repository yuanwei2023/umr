/*
 * Copyright © 2023 Advanced Micro Devices, Inc.
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
#include "imgui/imgui.h"
#include "panels.h"

static struct umr_bitfield alloc_flag_bitfields[] = {
	{ .regname = (char*)"CPU_ACCESS_REQUIRED", .start = 0, .stop = 0 },
	{ .regname = (char*)"NO_CPU_ACCESS", .start = 1, .stop = 1 },
	{ .regname = (char*)"CPU_GTT_USWC", .start = 2, .stop = 2 },
	{ .regname = (char*)"VRAM_CLEARED", .start = 3, .stop = 3 },
	{ .regname = (char*)"VRAM_CONTIGUOUS", .start = 5, .stop = 5 },
	{ .regname = (char*)"VM_ALWAYS_VALID", .start = 6, .stop = 6 },
	{ .regname = (char*)"EXPLICIT_SYNC", .start = 7, .stop = 7 },
	{ .regname = (char*)"CP_MQD_GFX9", .start = 8, .stop = 8 },
	{ .regname = (char*)"VRAM_WIPE_ON_RELEASE", .start = 9, .stop = 9 },
	{ .regname = (char*)"ENCRYPTED", .start = 10, .stop = 10 },
	{ .regname = (char*)"PREEMPTIBLE", .start = 11, .stop = 11 },
	{ .regname = (char*)"DISCARDABLE", .start = 12, .stop = 12 },
	{ .regname = (char*)"COHERENT", .start = 13, .stop = 13 },
	{ .regname = (char*)"UNCACHED", .start = 14, .stop = 14 },
	{ .regname = (char*)"EXT_COHERENT", .start = 15, .stop = 15 },
	{ .regname = (char*)"GFX12_DCC", .start = 16, .stop = 16 },
};
/* Decoding based on Mesa ac_surface_compute_bo_metadata. */
static struct umr_bitfield tiling_gfx12_bitfields[] = {
	{ .regname = (char*)"GFX12_SWIZZLE_MODE", .start = 0, .stop = 2 },
	{ .regname = (char*)"GFX12_DCC_MAX_COMPRESSED_BLOCK", .start = 3, .stop = 4 },
	{ .regname = (char*)"GFX12_DCC_NUMBER_TYPE", .start = 5, .stop = 7 },
	{ .regname = (char*)"GFX12_DCC_DATA_FORMAT", .start = 8, .stop = 13 },
	{ .regname = (char*)"GFX12_DCC_WRITE_COMPRESS_DISABLE", .start = 14, .stop = 14 },
	{ .regname = (char*)"TILING_GFX12_SCANOUT", .start = 63, .stop = 63 },
};
static struct umr_bitfield tiling_gfx9_bitfields[] = {
	{ .regname = (char*)"SWIZZLE_MODE", .start = 0, .stop = 4 },
	{ .regname = (char*)"DCC_OFFSET_256B", .start = 5, .stop = 28 },
	{ .regname = (char*)"DCC_PITCH_MAX", .start = 29, .stop = 42 },
	{ .regname = (char*)"DCC_INDEPENDENT_64B", .start = 43, .stop = 43 },
	{ .regname = (char*)"DCC_INDEPENDENT_128B", .start = 44, .stop = 44 },
	{ .regname = (char*)"SCANOUT", .start = 63, .stop = 63 },
};
static struct umr_bitfield tiling_gfx6_bitfields[] = {
	{ .regname = (char*)"ARRAY_MODE", .start = 0, .stop = 3 },
	{ .regname = (char*)"PIPE_CONFIG", .start = 4, .stop = 8 },
	{ .regname = (char*)"TILE_SPLIT", .start = 9, .stop = 11 },
	{ .regname = (char*)"MICRO_TILE_MODE", .start = 12, .stop = 14 },
	{ .regname = (char*)"BANK_WIDTH", .start = 15, .stop = 16 },
	{ .regname = (char*)"BANK_HEIGHT", .start = 17, .stop = 18 },
	{ .regname = (char*)"MACRO_TILE_ASPECT", .start = 19, .stop = 20 },
	{ .regname = (char*)"NUM_BANKS", .start = 21, .stop = 22 },
};

class BufferObjectPanel : public Panel {
public:
	BufferObjectPanel(struct umr_asic *asic) : Panel(asic), last_answer_gem_info(NULL),
											   last_answer_peak_bo(NULL), texture_id(0),
											   raw_data(NULL), zoom_to_fit(false),
											   last_error_peak_bo(NULL), zoom(1) { }
	~BufferObjectPanel() {
		if (last_answer_gem_info)
			json_value_free(json_object_get_wrapping_value(last_answer_gem_info));
	}

	void process_server_message(JSON_Object *response, void *_raw_data, unsigned _raw_data_size) {
		JSON_Value *error = json_object_get_value(response, "error");
		JSON_Object *request = json_object(json_object_get_value(response, "request"));
		JSON_Value *answer = json_object_get_value(response, "answer");
		const char *command = json_object_get_string(request, "command");

		if (!strcmp(command, "gem-info") && !error) {
			if (last_answer_gem_info)
				json_value_free(json_object_get_wrapping_value(last_answer_gem_info));
			last_answer_gem_info = json_object(json_value_deep_copy(answer));
		}
		if (!strcmp(command, "peak-bo")) {
			if (last_answer_peak_bo) {
				json_value_free(json_object_get_wrapping_value(last_answer_peak_bo));
				last_answer_peak_bo = NULL;
			}

			if (error) {
				if (last_error_peak_bo)
					free(last_error_peak_bo);
				last_error_peak_bo = strdup(json_string(error));
				displayed.is = -1;
			} else {
				last_answer_peak_bo = json_object(json_value_deep_copy(answer));
				if (this->raw_data)
					free(this->raw_data);
				if (!json_object_has_value(request, "metadata")) {
					displayed.bo.pid = json_object_get_number(request, "pid");
					displayed.bo.handle = json_object_get_number(request, "handle");
					displayed.bo.gpu_fd = json_object_get_number(request, "gpu-fd");
					displayed.bo.bo = NULL;
					displayed.is = 1;
				} else {
					displayed.is = 2;
				}
				this->raw_data = malloc(_raw_data_size);
				memcpy(this->raw_data, _raw_data, _raw_data_size);
				this->raw_data_size = _raw_data_size;
			}
		}
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		JSON_Object *displayed_bo = NULL;

		if (raw_data) {
			/* The texture has to be created in the display thread because
			 * it requires the GL context.
			 */
			int width = json_object_get_number(last_answer_peak_bo, "width");
			int height = json_object_get_number(last_answer_peak_bo, "height");
			if (texture_id)
				glDeleteTextures(1, &texture_id);
			texture_id = texture_from_qoi_buffer(width, height,
												 this->raw_data, this->raw_data_size);
			free(raw_data);
			this->raw_data_size = 0;
			this->raw_data = NULL;
		}

		if (can_send_request) {
			if (!last_answer_gem_info)
				send_gem_info_command();
		}

		if (ImGui::Button("Refresh List")) {
			displayed.is = -1;
			send_gem_info_command();
		}
		if (texture_id) {
			ImGui::SameLine();
			ImGui::Checkbox("Zoom to fit", &zoom_to_fit);
			if (!zoom_to_fit) {
				ImGui::SameLine();
				ImGui::SliderFloat("Zoom", &zoom, 0.1, 10, "%.1f");
			}
		}

		ImGui::Separator();

		if (!last_answer_gem_info)
			return 0;

		float left_pane_width = ImGui::CalcTextSize(" Buffer Object from KMS framebuffers ").x;
		ImGui::BeginChild("list",
			ImVec2(left_pane_width, 0),
			false, ImGuiWindowFlags_NoTitleBar);

		ImGui::PushStyleColor(ImGuiCol_Text, (ImU32)ImColor(229, 169, 41));
		ImGui::TextUnformatted("Buffer Object from pid");
		ImGui::PopStyleColor();
		bool display_help = true;
		JSON_Array *apps = json_object_get_array(last_answer_gem_info, "apps");
		for (int i = 0; i < json_array_get_count(apps); i++) {
			JSON_Object *app = json_array_get_object(apps, i);
			JSON_Array *clients = json_object_get_array(app, "clients");
			const uint32_t pid = json_object_get_number(app, "pid");

			char label[256];
			ImGui::PushID(i);
			sprintf(label, "%s (%d)", json_object_get_string(app, "command"),
									  (int)json_object_get_number(app, "pid"));

			display_help = false;

			if (ImGui::TreeNodeEx(label)) {
				for (int j = 0; j < json_array_get_count(clients); j++) {
					JSON_Value *client = json_array_get_value(clients, j);
					const uint32_t gpu_fd = json_object_get_number(json_object(client), "gpu-fd");

					ImGui::Text("drm-client: %d",
						(int)json_object_get_number(json_object(client), "drm-client-id"));
					if (json_object_has_value(json_object(client), "drm-client-name")) {
						ImGui::SameLine();
						ImGui::TextUnformatted(json_object_get_string(json_object(client), "drm-client-name"));
					}

					if (json_value_get_type(client) == JSONNull)
						continue;

					JSON_Array *bos = json_object_get_array(json_object(client), "bos");

					int bo_count = 0;
					for (int k = 0; k < json_array_get_count(bos); k++) {
						JSON_Value *_bo = json_array_get_value(bos, k);
						if (json_value_get_type(_bo) == JSONNull)
							continue;
						JSON_Object *bo = json_object(_bo);
						bo_count++;
					}
					if (bo_count == 0)
						continue;

					ImGui::Unindent();
					ImGui::PushID(j);
					ImGui::BeginTable("BOs", 4, ImGuiTableFlags_SizingFixedFit | ImGuiTableFlags_NoHostExtendX);
					ImGui::TableSetupColumn("Handle");
					ImGui::TableSetupColumn(" Resolution ");
					ImGui::TableSetupColumn("     ");
					ImGui::TableSetupColumn("  ");
					ImGui::TableHeadersRow();

					for (int k = 0; k < json_array_get_count(bos); k++) {
						JSON_Value *_bo = json_array_get_value(bos, k);
						if (json_value_get_type(_bo) == JSONNull)
							continue;

						JSON_Object *bo = json_object(_bo);
						const uint32_t handle = json_object_get_number(bo, "handle");

						ImGui::PushID(k);
						ImGui::TableNextRow();

						if (displayed.is == 1 &&
								displayed.bo.pid == pid && displayed.bo.gpu_fd == gpu_fd && displayed.bo.handle == handle) {
							ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TabActive));
							displayed_bo = bo;
						} else {
							ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TableRowBg));
						}

						ImGui::TableSetColumnIndex(0);
						ImGui::Text("#dbde79%d", handle);

						ImGui::TableSetColumnIndex(1);
						ImGui::Text("%dx%d",
							(int) json_object_get_number(bo, "width"),
							(int) json_object_get_number(bo, "height"));
						ImGui::TableSetColumnIndex(2);
						if (ImGui::Button("View")) {
							if (texture_id) {
								glDeleteTextures(1, &texture_id);
								texture_id = 0;
							}
							send_peak_bo_command(pid, handle, gpu_fd);
							displayed.bo.bo = bo;
							displayed.is = -1;
						}
						ImGui::TableSetColumnIndex(3);
						ImGui::Button("?");
						if (ImGui::IsItemHovered()) {
							ImGui::BeginTooltip();
							display_bo_details(bo);
							ImGui::EndTooltip();
						}
						ImGui::PopID();
					}

					ImGui::EndTable();
					ImGui::Indent();
					ImGui::PopID();
				}
				ImGui::TreePop();
			}
			ImGui::PopID();
		}
		if (display_help) {
			ImGui::Text("Buffer objects can only be shown for\n"
			            "applications using the Mesa driver and\n"
			            "launched using:");
			ImGui::Bullet();
			ImGui::SameLine();
			ImGui::PushStyleColor(ImGuiCol_Text, (ImU32)ImColor(48, 151, 161));
			ImGui::Text("AMD_DEBUG=extra_md");
			ImGui::PopStyleColor();
			ImGui::SameLine();
			ImGui::Text("(OpenGL / radeonsi)");
			ImGui::Bullet();
			ImGui::SameLine();
			ImGui::PushStyleColor(ImGuiCol_Text, (ImU32)ImColor(48, 151, 161));
			ImGui::Text("RADV_DEBUG=extra_md");
			ImGui::PopStyleColor();
			ImGui::SameLine();
			ImGui::Text("(Vulkan / radv)");
		}
		ImGui::NewLine();
		ImGui::NewLine();

		ImGui::PushStyleColor(ImGuiCol_Text, (ImU32)ImColor(229, 169, 41));
		ImGui::TextUnformatted("Buffer Object from KMS framebuffers");
		ImGui::PopStyleColor();

		ImGui::BeginTable("fbs", 5, ImGuiTableFlags_SizingFixedFit | ImGuiTableFlags_NoHostExtendX);
		ImGui::TableSetupColumn("ID");
		ImGui::TableSetupColumn("Created by");
		ImGui::TableSetupColumn("Resolution");
		ImGui::TableSetupColumn("     ");
		ImGui::TableSetupColumn("  ");
		ImGui::TableHeadersRow();

		JSON_Array *fbs = json_object_get_array(last_answer_gem_info, "framebuffers");
		for (int i = 0; i < json_array_get_count(fbs); i++) {
			JSON_Object *fb = json_object(json_array_get_value(fbs, i));
			if (json_object_has_value(fb, "metadata") == 0)
				continue;

			ImGui::TableNextRow();
			if (displayed.fb == fb) {
				ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TabActive));
			} else {
				ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TableRowBg));
			}
			JSON_Object *md = json_object(json_object_get_value(fb, "metadata"));

			ImGui::PushID(i);
			const char *cmd = json_object_get_string(fb, "allocated by");
			int l = strlen(cmd);
			if (l > 15) l = 15;
			ImGui::TableSetColumnIndex(0);
			ImGui::Text(" %d", (int)json_object_get_number(fb, "id"));
			ImGui::TableSetColumnIndex(1);
			ImGui::PushStyleColor(ImGuiCol_Text, ImU32(0xffdbde79));
			ImGui::Text("%.*s", l, cmd);
			ImGui::PopStyleColor(1);
			ImGui::TableSetColumnIndex(2);
			ImGui::Text("%dx%d", (int) json_object_get_number(md, "width"),
								 (int) json_object_get_number(md, "height"));

			ImGui::TableSetColumnIndex(3);
			if (ImGui::Button("View")) {
				if (texture_id) {
					glDeleteTextures(1, &texture_id);
					texture_id = 0;
				}
				send_peak_bo_command2(json_object_get_wrapping_value(md));
				displayed.fb = fb;
			}
			ImGui::TableSetColumnIndex(4);
			ImGui::Button("?");
			if (ImGui::IsItemHovered()) {
				ImGui::BeginTooltip();
				ImGui::Text("#dbde79%s", json_object_get_string(fb, "allocated by"));
				ImGui::Text("pid: %d", (int) json_object_get_number(md, "pid"));
				ImGui::Text("fourcc: 0x%08x", (int) json_object_get_number(md, "fourcc"));
				ImGui::EndTooltip();
			}
			ImGui::PopID();
		}
		ImGui::EndTable();
		ImGui::EndChild();

		ImGui::SameLine();
		ImGui::BeginChild("image", ImVec2(0, 0), false, ImGuiWindowFlags_NoTitleBar |
														ImGuiWindowFlags_HorizontalScrollbar);
		if (last_answer_peak_bo && texture_id) {
			float w, h;
			int width = json_object_get_number(last_answer_peak_bo, "width");
			int height = json_object_get_number(last_answer_peak_bo, "height");
			if (zoom_to_fit) {
				float ratio = height / (float) width;
				w = ImGui::GetContentRegionAvail().x - ImGui::GetStyle().FramePadding.x;
				h = ImGui::GetContentRegionAvail().y - ImGui::GetStyle().FramePadding.y;

				if (w * ratio < h)
					h = w * ratio;
				else
					w = h / ratio;
			} else {
				w = width * zoom;
				h = height * zoom;
			}

			ImGui::Image((ImTextureID) (intptr_t) texture_id, ImVec2(w, h),
										ImVec2(0, 0), ImVec2(1, 1),
										ImVec4(1,1,1,1), ImVec4(1,1,1,1));

			ImGui::Separator();

			if (displayed.is == 1 && !displayed_bo) {
				for (int i = 0; i < json_array_get_count(apps) && !displayed_bo; i++) {
					JSON_Object *app = json_array_get_object(apps, i);
					JSON_Array *clients = json_object_get_array(app, "clients");
					const uint32_t pid = json_object_get_number(app, "pid");
					for (int j = 0; j < json_array_get_count(clients) && !displayed_bo; j++) {
						JSON_Value *client = json_array_get_value(clients, j);
						const uint32_t gpu_fd = json_object_get_number(json_object(client), "gpu-fd");

						if (json_value_get_type(client) == JSONNull)
							continue;

						JSON_Array *bos = json_object_get_array(json_object(client), "bos");

						for (int k = 0; k < json_array_get_count(bos); k++) {
							JSON_Value *_bo = json_array_get_value(bos, k);
							if (json_value_get_type(_bo) == JSONNull)
								continue;
							JSON_Object *bo = json_object(_bo);
							const uint32_t handle = json_object_get_number(bo, "handle");

							if (displayed.bo.pid == pid && displayed.bo.gpu_fd == gpu_fd && displayed.bo.handle == handle) {
								displayed_bo  = bo;
								break;
							}
						}
					}
				}
			}
			if (displayed_bo) {
				display_bo_details(displayed_bo);
			}
		} else if (last_error_peak_bo) {
			ImVec2 space = ImGui::GetContentRegionAvail();
			float w = ImGui::CalcTextSize(last_error_peak_bo).x * 2;
			ImGui::SetCursorPosX(ImGui::GetCursorPosX() + space.x / 2 - w / 2);
			ImGui::SetCursorPosY(ImGui::GetCursorPosY() + space.y / 2);
			ImGui::Text("Error: %s", last_error_peak_bo);
		}
		ImGui::EndChild();

		return 0;
	}
private:
	void send_gem_info_command() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "gem-info");
		send_request(req);
	}

	void send_peak_bo_command(unsigned pid, unsigned handle, int gpu_fd) {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "peak-bo");
		json_object_set_number(json_object(req), "pid", pid);
		json_object_set_number(json_object(req), "handle", handle);
		json_object_set_number(json_object(req), "gpu-fd", gpu_fd);
		send_request(req);
		displayed.is = -1;
	}

	void send_peak_bo_command2(JSON_Value *md) {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "peak-bo");
		json_object_set_value(json_object(req), "metadata", json_value_deep_copy(md));
		send_request(req);
		displayed.is = -1;
	}

	void display_bo_details(JSON_Object *bo) {
		struct umr_ip_block* gfx = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
		unsigned gfx_level = gfx ? gfx->discoverable.maj : 0;

		ImGui::Text("Format : %d", (int) json_object_get_number(bo, "format"));
		ImGui::Text("Swizzle: %d", (int) json_object_get_number(bo, "swizzle"));
		ImGui::Text("Size: %ld bytes", (int64_t) json_object_get_number(bo, "size"));
		ImGui::BeginTable("attr", 2, ImGuiTableFlags_Borders);
		ImGui::TableSetupColumn("Attributes");
		ImGui::TableSetupColumn("Value");
		ImGui::TableHeadersRow();
		JSON_Object *att = json_object_get_object(bo, "attributes");
		for (size_t m = 0; m < json_object_get_count(att); m++) {
			ImGui::TableNextRow();
			ImGui::TableSetColumnIndex(0);
			ImGui::TextUnformatted(json_object_get_name(att, m));
			ImGui::TableSetColumnIndex(1);
			char *val = json_serialize_to_string(json_object_get_value_at(att, m));
			ImGui::Text("%s", val);
			json_free_serialized_string(val);
		}
		ImGui::EndTable();
		uint64_t alloc_flags = (uint64_t)json_object_get_number(bo, "alloc_flags");
		ImGui::Text("Alloc flags: 0x%" PRIx64, alloc_flags);
		draw_value_as_bitfield(alloc_flag_bitfields, ARRAY_SIZE(alloc_flag_bitfields), alloc_flags, 17 /* skip irrelevant bits */, NULL, NULL);

		uint64_t tiling = (uint64_t)json_object_get_number(bo, "tiling");
		ImGui::Text("Tiling: 0x%" PRIx64, tiling);

		/* Decoding based on Mesa ac_surface_compute_bo_metadata. */
		if (gfx_level >= 12) {
			draw_value_as_bitfield(tiling_gfx12_bitfields, ARRAY_SIZE(tiling_gfx12_bitfields), tiling, 64, NULL, NULL);
		} else if (gfx_level >= 9) {
			draw_value_as_bitfield(tiling_gfx9_bitfields, ARRAY_SIZE(tiling_gfx9_bitfields), tiling, 64, NULL, NULL);
		} else if (gfx_level) {
			draw_value_as_bitfield(tiling_gfx6_bitfields, ARRAY_SIZE(tiling_gfx6_bitfields), tiling, 23, NULL, NULL);
		}
	}

private:
	JSON_Object *last_answer_gem_info;
	JSON_Object *last_answer_peak_bo;
	struct {
		union {
			struct {
				uint32_t pid, handle, gpu_fd;
				JSON_Object *bo;
			} bo;
			JSON_Object *fb;
		};
		int is; /* <= 0: invalid, 1: bo, 2: fb. */
	} displayed;

	GLuint texture_id;
	void *raw_data;
	unsigned raw_data_size;
	bool zoom_to_fit;
	float zoom;
	char *last_error_peak_bo;
};
