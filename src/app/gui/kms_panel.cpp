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

class KmsPanel : public Panel {
public:
	KmsPanel(struct umr_asic *asic) : Panel(asic), last_answer(NULL) {}

	~KmsPanel() {
		if (last_answer)
			json_value_free(json_object_get_wrapping_value(last_answer));
	}

	void process_server_message(JSON_Object *request, JSON_Value *answer) {
		const char *command = json_object_get_string(request, "command");

		if (!strcmp(command, "kms")) {
			if (last_answer)
				json_value_free(json_object_get_wrapping_value(last_answer));
			last_answer = json_object(json_value_deep_copy(answer));
		}
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		if (!last_answer && can_send_request) {
			send_kms_command();
		}

		ImGui::BeginChild("framebuffers", ImVec2(avail.x / 4, 0), false, ImGuiWindowFlags_NoTitleBar);
		ImGui::EndChild();

		ImGui::SameLine();
		ImGui::BeginChild("planes", ImVec2(avail.x / 4, 0), false, ImGuiWindowFlags_NoTitleBar);
		ImGui::EndChild();

		ImGui::SameLine();
		ImGui::BeginChild("crtcs", ImVec2(avail.x / 4, 0), false, ImGuiWindowFlags_NoTitleBar);
		ImGui::EndChild();

		ImGui::SameLine();
		ImGui::BeginChild("connectors", ImVec2(avail.x / 4, 0), false, ImGuiWindowFlags_NoTitleBar);
		ImGui::EndChild();

		return false;
	}

private:
	void send_kms_command() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "kms");
		send_request(req);
	}

private:
	JSON_Object *last_answer;
};

