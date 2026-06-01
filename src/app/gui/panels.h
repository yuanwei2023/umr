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
#pragma once

extern "C" {
	#include "parson.h"
	#include "umr.h"
}
struct ImVec2;

class Panel {
public:
	Panel(struct umr_asic *_asic) : asic(_asic), info(NULL) {}
	virtual ~Panel() {
		if (info)
			json_value_free(json_object_get_wrapping_value(info));
	};
	virtual void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) = 0;

	virtual bool display(float dt, const ImVec2& avail, bool can_make_request) = 0;

	void send_request(JSON_Value *req);

	void store_info(JSON_Value *answer) {
		if (info)
			json_value_free(json_object_get_wrapping_value(info));
		info = json_object(json_value_deep_copy(answer));
	}

	struct umr_asic *asic;

	static const char* format_duration(double dt) {
		static char txt[32];
		if (dt > 1)
			sprintf(txt, "%.3f sec", dt);
		else if (dt > 0.001)
			sprintf(txt, "%.3f ms", dt * 1000);
		else
			sprintf(txt, "%.3f us", dt * 1000000);
		return txt;
	}

protected:
	JSON_Object *info;
};

static inline const char *color_to_hex_str(const ImColor& color) {
	static char tmp[64];
	sprintf(tmp, "%02x%02x%02x", (color >> IM_COL32_R_SHIFT) & 0xff,
								 (color >> IM_COL32_G_SHIFT) & 0xff,
								 (color >> IM_COL32_B_SHIFT) & 0xff);
	return tmp;
}

extern const ImColor palette[11];
extern const ImColor block_palette[36];
