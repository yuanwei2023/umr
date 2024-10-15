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

#include <ctype.h>
#include <SDL.h>

struct PinnedRegister {
	PinnedRegister(struct umr_ip_block *_blk, struct umr_reg *_reg) : blk(_blk), reg(_reg) { }
	struct umr_ip_block *blk;
	struct umr_reg *reg;
	uint32_t new_value;
	bool collapsed;
};

const char *skip_register_prefix(const char *reg_name) {
	if (strncmp(reg_name, "mm", 2) == 0)
		return reg_name + 2;
	else if (strncmp(reg_name, "reg", 3) == 0)
		return reg_name + 3;
	return reg_name;
}

static ImColor get_value_color(int index, uint32_t value, uint32_t original, bool highlight)
{
	if (value == original) {
		return palette[highlight ? 0 : (8 + 2 * (index % 2))];
	} else {
		return palette[highlight ? 2 : 3];
	}
}


class RegistersPanel : public Panel {
public:
	RegistersPanel(struct umr_asic *asic) : Panel(asic), hightlighted_field(NULL) {}

	~RegistersPanel() {}

	void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) {
		JSON_Value *error = json_object_get_value(response, "error");
		if (error)
			return;

		JSON_Object *request = json_object(json_object_get_value(response, "request"));
		JSON_Value *answer = json_object_get_value(response, "answer");
		const char *command = json_object_get_string(request, "command");

		if (strcmp(command, "read") && strcmp(command, "write"))
			return;

		const char *blk = json_object_get_string(request, "block");
		const char *reg = json_object_get_string(request, "register");

		PinnedRegister *pinned = NULL;
		for (int i = 0; i < pinned_registers.size() && !pinned; i++) {
			PinnedRegister &p = pinned_registers[i];
			if (!strcmp(p.blk->ipname, blk) && !strcmp(p.reg->regname, reg))
				pinned = &p;
		}
		if (!pinned) {
			/* This can happen in replay mode: pin the register */
			struct umr_reg *r = umr_find_reg_data_by_ip(asic, blk, reg);
			struct umr_ip_block *b = umr_find_ip_block(asic, blk, 0);
			if (r && b) {
				pinned_registers.push_back(PinnedRegister(b, r));
				pinned = &pinned_registers.back();
			}
		}

		pinned->reg->value = pinned->new_value = json_object_get_number(json_object(answer), "value");
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		const float _8digitsize = ImGui::CalcTextSize("00000000").x + ImGui::GetStyle().FramePadding.x * 2;

		/* Split pane */
		ImGui::BeginChild("Registers list", ImVec2(avail.x / 3, 0), false,
							ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_HorizontalScrollbar);
		char details[128];
		for (int i = 0; i < (int) asic->no_blocks; i++) {
			unsigned matching = 0;
			struct umr_ip_block *b = asic->blocks[i];
			if (filter[0] != '\0' || field_filter[0] != '\0') {
				for (int j = 0; j < b->no_regs; j++) {
					if (filter[0] != '\0' && fuzzy_match_simple(filter, skip_register_prefix(b->regs[j].regname))) {
						matching++;
					} else if (field_filter[0] != '\0') {
						for (int k = 0; k < b->regs[j].no_bits; k++) {
							if (b->regs[j].bits[k].regname &&
								  fuzzy_match_simple(field_filter, b->regs[j].bits[k].regname)) {
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
					for (int k = 0; k < (int) pinned_registers.size() && !pinned; k++)
						pinned = pinned_registers[k].reg == &b->regs[j];

					if (filter[0] != '\0' && !fuzzy_match_simple(filter, skip_register_prefix(b->regs[j].regname)))
						continue;

					if (field_filter[0] != '\0') {
						bool show = false;
						for (int k = 0; k < b->regs[j].no_bits; k++) {
							if (b->regs[j].bits[k].regname &&
								  fuzzy_match_simple(field_filter, b->regs[j].bits[k].regname)) {
								show = true;
								break;
							}
						}

						if (!show)
							continue;
					}
					at_least_one = true;
					if (pinned) {
						ImGui::TextUnformatted(skip_register_prefix(b->regs[j].regname));
					} else if (ImGui::Button(skip_register_prefix(b->regs[j].regname))) {
						pinned_registers.push_back(PinnedRegister(b, &b->regs[j]));
						send_read_reg_command(&pinned_registers.back());
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

		ImGui::BeginChild("filters", ImVec2(3 * avail.x / 4, 0), false,
			ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_HorizontalScrollbar);
		ImGui::NewLine();
		ImGui::PushStyleColor(ImGuiCol_Text, ImU32(palette[4]));
		ImGui::Text("Search register by:");
		ImGui::PopStyleColor();
		if (kb_shortcut(SDLK_f))
			ImGui::SetKeyboardFocusHere();
		ImGui::BulletText("Name:      ");
		ImGui::SameLine();
		ImGui::InputText("", filter, sizeof(filter));
		ImGui::SameLine();
		if (ImGui::Button("Clear") || (kb_shortcut(SDLK_BACKSPACE)))
			filter[0] = '\0';
		ImGui::BulletText("Field Name:");
		ImGui::SameLine();
		ImGui::PushID("field");
		ImGui::InputText("", field_filter, sizeof(field_filter));
		ImGui::PopID();
		ImGui::SameLine();
		ImGui::PushID("Field");
		if (ImGui::Button("Clear") || (ImGui::GetIO().KeyCtrl && ImGui::IsKeyReleased(SDLK_BACKSPACE)))
			field_filter[0] = '\0';
		ImGui::PopID();
		ImGui::Separator();
		bool auto_read_reg = false;
		if (pinned_registers.empty()) {
			ImGui::Indent();
			ImGui::Text("(Click on a register name to add it to the watchlist.)");
			ImGui::Unindent();
			ImGui::NewLine();
		}

		std::vector<ImVec2> folded_coords;
		const float line_height = ImGui::GetTextLineHeight();
		struct umr_bitfield *highlighted = NULL;
		for (int i = 0; i < (int) pinned_registers.size(); ++i) {
			PinnedRegister& pinned = pinned_registers[i];
			ImGui::PushID(pinned.reg->regname);

			ImGui::PushStyleColor(ImGuiCol_Text, ImU32(palette[6]));
			if (ImGui::TreeNodeEx(skip_register_prefix(pinned.reg->regname), ImGuiTreeNodeFlags_DefaultOpen)) {
				ImGui::PopStyleColor();
				pinned.collapsed = false;

				char tmp[9];
				bool dirty = pinned.new_value != pinned.reg->value;
				if (dirty) {
					ImColor col(get_value_color(0, pinned.new_value, pinned.reg->value, false));
					ImGui::PushStyleColor(ImGuiCol_Text, ImU32(col));
				}

				/* Mess up a bit with the cursor to:
				 * - remove horizontal spacing
				 * - aligned vertically with the InputText
				 */
				ImVec2 prev = ImGui::GetCursorScreenPos();
				ImGui::SetCursorScreenPos(ImVec2(prev.x, prev.y + ImGui::GetStyle().FramePadding.y));
				ImGui::Text("Value: 0x");
				ImGui::SameLine();
				prev.x = ImGui::GetCursorScreenPos().x - ImGui::GetStyle().ItemSpacing.x;
				ImGui::SetCursorScreenPos(prev);

				sprintf(tmp, "%08x", pinned.new_value);
				ImGui::SetNextItemWidth(_8digitsize);
				if (ImGui::InputText("", tmp, sizeof(tmp), ImGuiInputTextFlags_CharsHexadecimal)) {
					unsigned value;
					if (sscanf(tmp, "%x", &value) == 1) {
						pinned.new_value = value;
						force_redraw();
					}
				}

				if (dirty)
					ImGui::PopStyleColor();

				ImGui::BeginDisabled(!can_send_request);
				ImGui::SameLine();
				if (ImGui::Button("Read") || auto_read_reg) {
					send_read_reg_command(&pinned);
				}
				ImGui::EndDisabled();

				ImGui::BeginDisabled(!can_send_request || pinned.reg->value == pinned.new_value);
				ImGui::SameLine();
				if (ImGui::Button("Write")) {
					send_write_reg_command(&pinned, pinned.new_value);
				}
				ImGui::EndDisabled();

				ImVec2 p = ImGui::GetCursorScreenPos();
				float cx = ImGui::GetFontSize();

				ImVec2 bitfield_pos[32];

				/* Display bits value. */
				int previous_bit = 32;
				for (int j = pinned.reg->no_bits - 1; j >= 0; j--) {
					struct umr_bitfield *bit = &pinned.reg->bits[j];

					bitfield_pos[j].x = p.x;

					bool outside;
					for (int k = previous_bit - 1; k >= bit->start; k--) {
						if (k > bit->stop) {
							ImGui::GetWindowDrawList()->AddText(p, ImColor(1.f, 1.f, 1.f, 0.2f), "x");
							outside = true;
						} else {
							if (outside) {
								p.x += cx * 0.5;
								outside = false;
							}

							unsigned mask = 1u << k;
							unsigned v = (pinned.new_value & mask) >> k;
							unsigned v_original = (pinned.reg->value & mask) >> k;

							ImColor col(get_value_color(j, v, v_original, hightlighted_field == bit));
							if (ImGui::IsMouseHoveringRect(p, ImVec2(p.x + cx * 0.5, p.y + line_height))) {
								col = IM_COL32_WHITE;
								if (ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
									if (v)
										pinned.new_value &= ~mask;
									else
										pinned.new_value |= mask;
								}
							}

							ImGui::GetWindowDrawList()->AddText(p, col, v ? "1" : "0");
						}
						if (ImGui::IsMouseHoveringRect(p, ImVec2(p.x + cx * 0.5, p.y + line_height)))
							highlighted = bit;
						p.x += cx * 0.5;

					}
					bitfield_pos[j].x = p.x - cx * 0.25;
					p.x += cx * 0.5;
					previous_bit = bit->start;
				}

				ImGui::NewLine();
				/* Display bitfields name */
				ImVec2 c[4];
				float max_x_pos = 0;
				for (int j = 0; j < pinned.reg->no_bits; j++) {
					struct umr_bitfield *bit = &pinned.reg->bits[j];
					ImColor color(get_value_color(j, 0, 0, hightlighted_field == bit));

					ImGui::PushStyleColor(ImGuiCol_Text, ImU32(color));
					ImVec2 cursor(ImGui::GetCursorScreenPos());

					c[0] = ImVec2(bitfield_pos[j].x, p.y + ImGui::GetTextLineHeight());
					c[3] = ImVec2(bitfield_pos[j].x - cx * 0.5 * (bit->stop - bit->start),
								  p.y + ImGui::GetTextLineHeight());
					c[1] = ImVec2(bitfield_pos[j].x, cursor.y + ImGui::GetTextLineHeight() * .5);
					c[2] = ImVec2(bitfield_pos[j].x + cx * 0.5, c[1].y);
					color.Value.w = hightlighted_field == bit ? 0.4 : 0.2;
					ImGui::GetWindowDrawList()->AddPolyline(c, 3, color, 0, 1.0);
					ImGui::GetWindowDrawList()->AddLine(c[3], c[0], color);

					c[2].x += cx * 0.5;
					c[2].y = cursor.y;
					ImGui::SetCursorScreenPos(c[2]);
					ImGui::TextUnformatted(bit->regname);
					if (ImGui::IsItemHovered())
						highlighted = bit;
					ImGui::PopStyleColor();

					bitfield_pos[j].y = c[2].y;

					max_x_pos = std::max(max_x_pos, c[2].x + ImGui::CalcTextSize(bit->regname).x);
				}

				/* Display field value. */
				for (int j = 0; j < pinned.reg->no_bits; j++) {
					struct umr_bitfield *bit = &pinned.reg->bits[j];

					unsigned mask = (1llu << (1 + (bit->stop - bit->start))) - 1;
					unsigned v = (pinned.new_value >> bit->start) & mask;
					unsigned v_original = (pinned.reg->value >> bit->start) & mask;

					ImColor color(get_value_color(j, v, v_original, hightlighted_field == bit));

					ImGui::PushStyleColor(ImGuiCol_Text, ImU32(color));
					ImVec2 cursor(ImGui::GetCursorScreenPos());
					ImGui::SetCursorScreenPos(ImVec2(max_x_pos + cx, bitfield_pos[j].y));
					ImGui::Text("0x%x", v);

					if (ImGui::IsItemHovered())
						highlighted = bit;
					ImGui::PopStyleColor();
				}

				ImGui::TreePop();
			} else {
				ImGui::SameLine();
				folded_coords.push_back(ImGui::GetCursorScreenPos());
				ImGui::NewLine();
				pinned.collapsed = true;
				ImGui::PopStyleColor();
			}
			ImGui::PopID();
		}

		ImGui::PushStyleColor(ImGuiCol_Text, ImU32(palette[6]));
		float align_x = 0;
		for (auto v: folded_coords) {
			align_x = std::max(align_x, v.x);
		}
		for (int i = 0, j = 0; i < (int) pinned_registers.size(); ++i) {
			PinnedRegister& pinned = pinned_registers[i];
			if (!pinned.collapsed)
				continue;


			ImGui::SetCursorScreenPos(ImVec2(align_x, folded_coords[j++].y));
			ImGui::Text("... 0x%08x%c",
            			pinned.new_value,
                        pinned.new_value != pinned.reg->value ? '*' : ' ');

		}
		ImGui::PopStyleColor();

		ImGui::EndChild();

		if (hightlighted_field != highlighted) {
			hightlighted_field = highlighted;
			return true;
		}
		return false;
	}

private:
	void send_read_reg_command(PinnedRegister *pinned) {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "read");
		json_object_set_string(json_object(req), "block", pinned->blk->ipname);
		json_object_set_string(json_object(req), "register", pinned->reg->regname);
		send_request(req);
	}

	void send_write_reg_command(PinnedRegister *pinned, unsigned value) {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "write");
		json_object_set_string(json_object(req), "block", pinned->blk->ipname);
		json_object_set_string(json_object(req), "register", pinned->reg->regname);
		json_object_set_number(json_object(req), "value", value);
		send_request(req);
	}

	/* From fts_fuzzy_match */
	bool fuzzy_match_simple(char const * pattern, char const * str) {
		while (*pattern != '\0' && *str != '\0')  {
			if (tolower(*pattern) == tolower(*str))
				++pattern;
			++str;
		}
		return *pattern == '\0' ? true : false;
	}

private:
	std::vector<PinnedRegister> pinned_registers;

	struct umr_bitfield *hightlighted_field;

	char filter[32] = {};
	char field_filter[32] = {};
};
