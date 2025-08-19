/*
 * Copyright (c) 2025 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parson.h"
#include "umr_rumr.h"

extern JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsigned *raw_data_size);
extern void init_asics(void);
extern struct umr_asic *asics[16];

static struct rumr_comm_funcs *rumr_get_cf(char *arg, char **addr)
{
	struct rumr_comm_funcs *cf;
	*addr = arg;

	if (!memcmp(arg, "tcp://", 6)) {
		cf = (struct rumr_comm_funcs *) calloc(1, sizeof rumr_tcp_funcs);
		*cf = rumr_tcp_funcs;
		cf->log_msg = printf;
		*addr = &arg[6];
		return cf;
	}
	return NULL;
}

void run_server_loop(const char *url, struct umr_asic * asic)
{
	char *cfp;
	struct rumr_comm_funcs *cf = rumr_get_cf((char *)url, &cfp);

	if (cf == NULL)
		return;

	if (cf->bind(cf, cfp) < 0) {
		printf("Binding %s failed\n", cfp);
		return;
	}

	if (asic) {
		asics[0] = asic;
	} else {
		init_asics();
	}

	for (;;) {
		if (cf->accept(cf) < 0) {
			printf("TCP accept failed\n");
			return;
		}

		/* Everything is ready. Wait for commands */
		printf("Waiting for commands.\n");

		struct rumr_buffer *buffer;
		for (;;) {
			char* buf;

			if (cf->rx(cf, &buffer) < 0) {
				cf->closeconn(cf);
				break;
			}

			if (buffer->size == 0)
				continue;

			buf = (char *)buffer->data;
			buf[buffer->woffset - 1] = '\0';
			JSON_Value *request = json_parse_string(buf);

			if (request == NULL) {
				printf("ERROR parsing %d bytes\n", buffer->woffset);
				rumr_buffer_free(buffer);
				continue;
			}

			rumr_buffer_free(buffer);

			void *raw_data = NULL;
			unsigned raw_data_size = 0;
			JSON_Value *answer = umr_process_json_request(
				json_object(request), &raw_data, &raw_data_size);

			char* s = json_serialize_to_string(answer);
			size_t len = strlen(s) + 1;

			buffer = rumr_buffer_init();
			rumr_buffer_add_uint32(buffer, raw_data_size);
			rumr_buffer_add_data(buffer, s, len);
			if (raw_data_size)
				rumr_buffer_add_data(buffer, raw_data, raw_data_size);

			if (cf->tx(cf, buffer) < 0)
				printf("tx failed\n");

			json_free_serialized_string(s);
			json_value_free(answer);
			free(raw_data);
			rumr_buffer_free(buffer);
		}
	}
}
