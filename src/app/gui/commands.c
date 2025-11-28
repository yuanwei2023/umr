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
#include <linux/limits.h>
#define _GNU_SOURCE
#include <stdlib.h>
#include <string.h>
#include "parson.h"
#include "umrapp.h"
#include <signal.h>
#include <time.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdarg.h>
#include <stdbool.h>
#include <errno.h>
#include <ctype.h>
#include <assert.h>

#include "parson.h"

#define SYSFS_PATH_DRM       "/sys/class/drm/"
#define SYSFS_PATH_DEBUG_DRI "/sys/kernel/debug/dri/"
#define SYSFS_PATH_TRACING   "/sys/kernel/tracing/"
#define SYSFS_PATH_TRACING_AMDGPU SYSFS_PATH_TRACING "events/amdgpu/"

static int64_t time_ns(void)
{
   struct timespec ts;
   timespec_get(&ts, CLOCK_MONOTONIC);
   return ts.tv_nsec + ts.tv_sec * 1000000000;
}

static char * _read_file(const char *path, char **buffer, unsigned *buffer_size) {
	FILE *fd = fopen(path, "r");
	if (fd) {
		long total = 0;

		fcntl(fileno(fd), F_SETFL, O_NONBLOCK);
		while (1) {
			if (total >= *buffer_size) {
				*buffer_size = total ? total * 2 : 1024;
				(*buffer) = realloc((*buffer), *buffer_size);
			}

			int n = fread(&(*buffer)[total], 1, *buffer_size - total, fd);

			if (n == 0) {
				(*buffer)[total] = '\0';
				break;
			} else if (n < 0) {
				printf("Error %s\n", strerror(errno));
				continue;

			}
			total += n;
		}
		fclose(fd);
		return (*buffer);
	}
	if (*buffer_size < 2) {
		*buffer = malloc(2);
		*buffer_size = 2;
	}
	**buffer = '\0';
	return *buffer;
}

static const char *uint64_to_str(uint64_t m)
{
	static char tmp[128];
	sprintf(tmp, "%0lx", m);
	return tmp;
}

static uint64_t str_to_uint64(const char *s)
{
	uint64_t u;
	if (sscanf(s, "%lx", &u) == 1)
		return u;
	else
		return (uint64_t)-1;
}

static char *read_file(const char *format, ...) {
	static char *buffer = NULL;
	static unsigned buffer_size = 0;
	char path[PATH_MAX];
	va_list args;
	va_start (args, format);
	if (vsprintf(path, format, args) < 0)
		return NULL;
	va_end (args);
	return _read_file(path, &buffer, &buffer_size);
}

static char *read_file_n(const char *format, unsigned *buffer_size, ...) {
	static char *buffer = NULL;
	char path[PATH_MAX];
	va_list args;
	va_start (args, buffer_size);
	if (vsprintf(path, format, args) < 0)
		return NULL;
	va_end (args);
	return _read_file(path, &buffer, buffer_size);
}

static char * read_file_a(const char *format, ...) {
	char *buffer = NULL;
	unsigned buffer_size = 0;
	char path[PATH_MAX];
	va_list args;
	va_start (args, format);
	if (vsprintf(path, format, args) < 0)
		return NULL;
	va_end (args);
	return _read_file(path, &buffer, &buffer_size);
}

static char **parse_lines(char *content, unsigned *line_count) {
	unsigned n_lines = 0, max_lines = 8;
	char **lines = NULL;

	*line_count = 0;

	if (content == NULL)
		return NULL;

	char *line = strtok(content, "\n");
	if (line == NULL)
		return NULL;

	lines = realloc(lines, max_lines * sizeof(*lines));
	lines[n_lines++] = line;

	while ((line = strtok(NULL, "\n"))) {
		if (*line == '\0')
			continue;
		while (isspace(*line))
			line++;

		lines[n_lines++] = line;
		if (n_lines == max_lines) {
			max_lines *= 2;
			lines = realloc(lines, max_lines * sizeof(*lines));
		}
	}
	lines[n_lines] = NULL;
	*line_count = n_lines;

	return lines;
}

static uint32_t get_tgid_for_tid(uint32_t tid);
static int get_pid_name(int pid, char process_name[32]);
static void parse_drm_clients(struct umr_asic *asic, JSON_Array * clients);
static bool parse_fdinfo_entry(const char *content, const char *dev_id, bool limit_to_drm_engines, JSON_Object *out);

static int find_amdgpu_fd(unsigned pid, const char *pci_name, int *result, int max_fd, int *drm_client_ids) {
	char folder[PATH_MAX], node[512];
	struct stat statbuf;
	__ino_t render_ino, card_ino;
	int i;
	sprintf(folder, "/proc/%d/fd", pid);

	int num_fds = 0;

	int dirfd = open(folder, O_DIRECTORY);
	if (dirfd < 0)
		return 0;

	/* Find the ino of the render/card nodes. */
	sprintf(node, "/dev/dri/by-path/pci-%s-render", pci_name);
	if (stat(node, &statbuf) < 0)
		return 0;
	render_ino = statbuf.st_ino;
	sprintf(node, "/dev/dri/by-path/pci-%s-card", pci_name);
	if (stat(node, &statbuf) < 0)
		return 0;
	card_ino = statbuf.st_ino;

	DIR *d = opendir(folder);
	if (d) {
		struct dirent *entry;
		drm_client_ids = drm_client_ids ? drm_client_ids : malloc(max_fd * sizeof(int));
		while ((entry = readdir(d))) {
			int r = fstatat(dirfd, entry->d_name, &statbuf, 0);

			if (r)
				continue;

			/* Find if this fd points to the GPU nodes. */
			if (statbuf.st_ino == card_ino || statbuf.st_ino == render_ino) {
				JSON_Object *fdinfo = json_object(json_value_init_object());
				/* Filter out fd pointing out to the same drm-client-id. */
				char *fdinfoc = read_file_a("/proc/%d/fdinfo/%s", pid, entry->d_name);

				if (!parse_fdinfo_entry(fdinfoc, pci_name, true, fdinfo)) {
					free(fdinfoc);
					json_value_free(json_object_get_wrapping_value(fdinfo));
					continue;
				}

				int drm_client_id = json_object_get_number(fdinfo, "drm-client-id");
				free(fdinfoc);
				json_value_free(json_object_get_wrapping_value(fdinfo));

				for (i = 0; i < num_fds; i++) {
					if (drm_client_ids[i] == drm_client_id) {
						break;
					}
				}

				if (i == num_fds) {
					drm_client_ids[num_fds] = drm_client_id;
					result[num_fds++] = atoi(entry->d_name);
				}

				if (num_fds == max_fd)
					break;
			}
		}
		closedir(d);
	}
	close(dirfd);
	return num_fds;
}

#if CAN_IMPORT_BO
#include "commands_bo.c"
#endif

static uint64_t read_sysfs_uint64(const char *path, ...) {
	char _path[PATH_MAX];
	va_list args;
	va_start (args, path);
	if (vsprintf(_path, path, args) < 0)
		return 0;
	va_end (args);

	char *content = read_file(_path);
	uint64_t v;
	if (sscanf(content, "%lu", &v) == 1)
		return v;
	return 0;
}

void parse_sysfs_clock_file(char *content, int *min, int *max) {
	*min = 100000;
	*max = 0;

	int value, ign;
	unsigned nlines;
	char **lines = parse_lines(content, &nlines);
	for (unsigned i = 0; i < nlines; i++) {
		if (sscanf(lines[i], "%d: %dMHz", &ign, &value) == 2) {
			if (value < *min) *min = value;
			if (value > *max) *max = value;
		}
	}
	free(lines);
}

static const char * lookup_field(const char **in, const char *field, char separator) {
	static char value[2048];
	const char *input = *in;
	input = strstr(input, field);
	if (!input)
		return NULL;
	input += strlen(field);
	while (*input != separator)
		input++;
	input++;
	while (*input == ' ' || *input == '\t')
		input++;
	const char *end = input + 1;
	while (*end != '\n')
		end++;
	memcpy(value, input, end - input);
	value[end - input] = '\0';
	*in = end;

	return value;
}

enum kms_field_type {
	KMS_STRING = 0,
	KMS_INT_10,
	KMS_INT_16,
	KMS_SIZE,
	KMS_SIZE_POS
};
static int parse_kms_field(const char **content, const char *field, const char *js_field, enum kms_field_type type, JSON_Object *out) {
	const char *ptr = lookup_field(content, field, '=');
	if (!ptr)
		return 0;

	switch (type) {
		case KMS_STRING:
			json_object_set_string(out, js_field, ptr);
			break;
		case KMS_INT_10: {
			int v;
			if (sscanf(ptr, "%d", &v) == 1)
				json_object_set_number(out, js_field, v);
			break;
		}
		case KMS_INT_16: {
			uint64_t v;
			if (sscanf(ptr, "0x%" PRIx64, &v) == 1)
				json_object_set_string(out, js_field, uint64_to_str(v));
			break;
		}
		case KMS_SIZE: {
			int w, h;
			if (sscanf(ptr, "%dx%d", &w, &h) == 2) {
				JSON_Value *size = json_value_init_object();
				json_object_set_number(json_object(size), "w", w);
				json_object_set_number(json_object(size), "h", h);
				json_object_set_value(out, js_field, size);
			}
			break;
		}
		case KMS_SIZE_POS: {
			int x, y, w, h;
			if (sscanf(ptr, "%dx%d+%d+%d", &w, &h, &x, &y) == 4) {
				JSON_Value *size = json_value_init_object();
				json_object_set_number(json_object(size), "w", w);
				json_object_set_number(json_object(size), "h", h);
				json_object_set_number(json_object(size), "x", x);
				json_object_set_number(json_object(size), "y", y);
				json_object_set_value(out, js_field, size);
			}
			break;
		}
		default:
			break;
	}
	return 1;
}

JSON_Array *parse_kms_framebuffer_sysfs_file(struct umr_asic *asic, const char *content) {
	JSON_Array* drm_card_clients = NULL;
	JSON_Array *out = json_array(json_value_init_array());
	const char *next_framebuffer = strstr(content, "framebuffer[");

	if (asic) {
		drm_card_clients = json_array(json_value_init_array());
		parse_drm_clients(asic, drm_card_clients);
		/* Remove the render-only clients. */
		for (size_t n = 0; n < json_array_get_count(drm_card_clients);) {
			JSON_Object *client = json_array_get_object(drm_card_clients, n);
			if (json_object_get_number(client, "dev") >= 128 || json_object_get_number(client, "tgid") == getpid()) {
				json_array_remove(drm_card_clients, n);
			} else {
				n++;
			}
		}
	}

	while (next_framebuffer) {
		if (!next_framebuffer)
			break;

		JSON_Object *fb = json_object(json_value_init_object());
		content = next_framebuffer + strlen("framebuffer");
		int id;
		if (sscanf(content, "[%d]", &id) == 1)
			json_object_set_number(fb, "id", id);

		parse_kms_field(&content, "allocated by", "allocated by", KMS_STRING, fb);
		#if CAN_IMPORT_BO
		/* The kernel only gives us a thread-name but we really need a pid. Instead
		 * of parsing all of /proc/xxx/task/yyy to figure out the tgid, we'll check
		 * amongst the primary clients, which one has the framebuffer.
		 */
		if (asic) {
			for (size_t n = 0; n < json_array_get_count(drm_card_clients); n++) {
				JSON_Object *client = json_array_get_object(drm_card_clients, n);
				uint32_t pid = json_object_get_number(client, "tgid");

				int gpu_fd;
				unsigned width, height, fourcc, nplanes;
				unsigned offsets[3], pitches[3];
				uint64_t modifier;
				if (get_bo_md_using_fb_id(asic, pid, id, &gpu_fd, &width, &height,
										  &fourcc, &modifier, &nplanes, offsets, pitches) == NULL) {
					JSON_Object *md = json_object(json_value_init_object());
					json_object_set_number(md, "fb_id", id);
					json_object_set_number(md, "pid", pid);
					json_object_set_number(md, "gpu-fd", gpu_fd);
					json_object_set_number(md, "width", width);
					json_object_set_number(md, "height", height);
					json_object_set_number(md, "fourcc", fourcc);
					json_object_set_string(md, "modifier", uint64_to_str(modifier));
					json_object_set_number(md, "nplanes", nplanes);
					JSON_Value *off = json_value_init_array();
					for (unsigned i = 0; i < nplanes; i++)
						json_array_append_number(json_array(off), offsets[i]);
					JSON_Value *str = json_value_init_array();
					for (unsigned i = 0; i < nplanes; i++)
						json_array_append_number(json_array(str), pitches[i]);
					json_object_set_value(md, "offsets", off);
					json_object_set_value(md, "pitches", str);
					json_object_set_value(fb, "metadata", json_object_get_wrapping_value(md));
				}
				break;
			}
		}
		#endif

		parse_kms_field(&content, "format", "format", KMS_STRING, fb);
		parse_kms_field(&content, "modifier", "modifier", KMS_INT_16, fb);
		parse_kms_field(&content, "size", "size", KMS_SIZE, fb);

		#if CAN_IMPORT_BO
		uint64_t modifier_i = str_to_uint64(json_object_get_string(fb, "modifier"));
		char *mod_str = drmGetFormatModifierName(modifier_i);
		if (mod_str) {
			json_object_set_string(fb, "modifier_str", mod_str);
			free(mod_str);
		}
		#endif

		JSON_Value *layers = json_value_init_array();
		content = strstr(content, "layers:");
		next_framebuffer = strstr(content, "framebuffer[");
		int layer_id = 0;
		while (content) {
			JSON_Value *layer = json_value_init_object();

			char tmp[256];
			sprintf(tmp, "size[%d]", layer_id);
			if (parse_kms_field(&content, tmp, "size", KMS_SIZE, json_object(layer))) {
				if (content > next_framebuffer && next_framebuffer) {
					json_value_free(layer);
					break;
				}

				sprintf(tmp, "pitch[%d]", layer_id);
				parse_kms_field(&content, tmp, "pitch", KMS_INT_10, json_object(layer));
				json_array_append_value(json_array(layers), layer);
				layer_id++;
			} else {
				json_value_free(layer);
				break;
			}
		}
		json_object_set_value(fb, "layers", layers);

		json_array_append_value(out, json_object_get_wrapping_value(fb));
	}

	json_value_free(json_array_get_wrapping_value(drm_card_clients));
	return out;
}

JSON_Object *parse_kms_state_sysfs_file(const char *content) {
	char tmp[256];
	JSON_Object *out = json_object(json_value_init_object());

	/* planes */
	JSON_Value *planes = json_value_init_array();
	int plane_id = 0;
	while (1) {
		const char *last_input = content;
		sprintf(tmp, "plane-%d", plane_id);
		const char *plane = strstr(content, tmp);
		if (plane) {
			JSON_Object *p = json_object(json_value_init_object());
			json_object_set_number(p, "id", plane_id);
			const char *ptr = lookup_field(&plane, "crtc", '=');
			if (ptr) {
				int crtc_id;
				if (sscanf(ptr, "crtc-%d", &crtc_id) == 1) {
					parse_kms_field(&plane, "fb", "fb", KMS_INT_10, p);
					JSON_Object *cr = json_object(json_value_init_object());
					json_object_set_number(cr, "id", crtc_id);
					parse_kms_field(&plane, "crtc-pos", "pos", KMS_SIZE_POS, cr);
					json_object_set_value(p, "crtc", json_object_get_wrapping_value(cr));
				} else {
					parse_kms_field(&plane, "fb", "fb", KMS_INT_10, p);
				}
			}
			content = plane;
			json_array_append_value(json_array(planes), json_object_get_wrapping_value(p));
			plane_id++;
		} else {
			content = last_input;
			break;
		}
	}

	/* crtcs */
	JSON_Value *crtcs = json_value_init_array();
	int crtc_id = 0;
	while (1) {
		const char *last_input = content;
		sprintf(tmp, "crtc-%d", crtc_id);
		const char *crtc = strstr(content, tmp);
		if (crtc) {
			JSON_Object *c = json_object(json_value_init_object());
			json_object_set_number(c, "id", crtc_id);
			parse_kms_field(&content, "enable", "enable", KMS_INT_10, c);
			parse_kms_field(&content, "active", "active", KMS_INT_10, c);
			json_array_append_value(json_array(crtcs), json_object_get_wrapping_value(c));
			crtc_id++;
		} else {
			content = last_input;
			break;
		}
	}

	/* connectors */
	JSON_Value *connectors = json_value_init_array();
	while (1) {
		const char *last_input = content;
		const char *ptr = strstr(content, "connector[");
		if (ptr) {
			JSON_Object *c = json_object(json_value_init_object());
			while(*ptr != ' ')
				ptr++;
			ptr++;
			const char *end = ptr + 1;
			while (*end != '\n')
				end++;
			json_object_set_string_with_len(c, "name", ptr, end - ptr);
			const char *cr = lookup_field(&ptr, "crtc", '=');
			if (cr) {
				int cid;
				if (sscanf(cr, "crtc-%d", &cid) == 1) {
					json_object_set_number(c, "crtc", cid);
				}
			}
			json_array_append_value(json_array(connectors), json_object_get_wrapping_value(c));
			content = end;
		} else {
			content = last_input;
			break;
		}
	}

	json_object_set_value(out, "planes", planes);
	json_object_set_value(out, "crtcs", crtcs);
	json_object_set_value(out, "connectors", connectors);

	return out;
}

JSON_Array *get_rings_last_signaled_fences(const char *fence_info, const char *ring_filter) {
	JSON_Array *fences = json_array(json_value_init_array());
	int cursor = 0;
	while (1) {
		char *next_ring = strstr(&fence_info[cursor], "--- ring");
		if (!next_ring)
			break;
		char *next_ring_start = strchr(next_ring, '(');
		if (!next_ring_start)
			break;
		next_ring_start++;
		char *next_ring_end = strchr(next_ring_start, ')');
		int len = next_ring_end - next_ring_start;
		char ring_name[128];
		strncpy(ring_name, next_ring_start, len);
		ring_name[len] = '\0';

		char *next_line = strstr(next_ring_end + 1, "0x");
		if (!next_line)
			break;

		int c = next_line - fence_info;
		unsigned long last_signaled;
		if (sscanf(&fence_info[c], "0x%08lx", &last_signaled) == 1) {
			if (!ring_filter || strcmp(ring_filter, ring_name) == 0) {
				JSON_Value *fence = json_value_init_object();
				json_object_set_string(json_object(fence), "name", ring_name);
				json_object_set_number(json_object(fence), "value", last_signaled);
				json_array_append_value(fences, fence);
			}
		}
		cursor = c + strlen("0x00000000") + 1;
	}
	return fences;
}

JSON_Value *compare_fence_infos(const char *fence_info_before, const char *fence_info_after) {
	JSON_Value *fences = json_value_init_array();
	JSON_Array *before = get_rings_last_signaled_fences(fence_info_before, NULL);
	JSON_Array *after = get_rings_last_signaled_fences(fence_info_after, NULL);
	for (size_t i = 0; i < json_array_get_count(before); i++) {
		JSON_Value *fence = json_value_init_object();
		JSON_Object *b = json_object(json_array_get_value(before, i));
		JSON_Object *a = json_object(json_array_get_value(after, i));

		const char *ring_name = json_object_get_string(b, "name");
		uint32_t v1 = (uint32_t)json_object_get_number(b, "value");
		uint32_t v2 = (uint32_t)json_object_get_number(a, "value");
		json_object_set_string(json_object(fence), "name", ring_name);
		json_object_set_number(json_object(fence), "delta", v2 - v1);
		json_array_append_value(json_array(fences), fence);
	}
	json_value_free(json_array_get_wrapping_value(before));
	json_value_free(json_array_get_wrapping_value(after));

	return fences;
}


static bool parse_fdinfo_entry(const char *content, const char *dev_id, bool limit_to_drm_engines, JSON_Object *out)
{
	const char *c = content;
	const char *start = content;

	/* Filter based on device name (if available). */
	bool discard = true;
	const char *dev_id_v = lookup_field(&c, "drm-pdev", ':');
	if (dev_id_v) {
		discard = strcmp(dev_id_v, dev_id) != 0;
	} else {
		/* Older kernel didn't have this field so filter by "ino" instead. */
		const char *ino = NULL;
		if ((ino = lookup_field(&content, "ino", ':'))) {
			struct stat buf;
			unsigned ino_n = strtol(ino, NULL, 10);
			char render_path[PATH_MAX];
			const char *nodes[] = { "render", "card" };
			for (size_t i = 0; i < ARRAY_SIZE(nodes) && discard; i++) {
				sprintf(render_path, "/dev/dri/by-path/pci-%s-%s", dev_id, nodes[i]);

				if (stat(render_path, &buf) == 0 && buf.st_ino == ino_n)
					discard = false;
			}
		}
	}
	if (discard)
		return false;

	const char *ptr = start;

	/* Lookup all drm-* entries */
	while (ptr && (ptr = strstr(ptr, "drm-"))) {
		char *cm = strchr(ptr, ':');
		if (!cm)
			continue;
		char *key_name = strndup(ptr, cm - ptr);
		cm++;

		while (cm && isspace(*cm))
			cm++;
		if (!cm) {
			free(key_name);
			continue;
		}

		char *end = strchr(cm, '\n');

		if (limit_to_drm_engines && strstr(key_name, "drm-engine") == NULL && strstr(key_name, "drm-client") == NULL)
			goto end;

		if (isdigit(*cm)) {
			uint64_t value = strtol(cm, NULL, 10);
			if (value)
				json_object_set_number(out, key_name, value);
		} else {
			if (end)
				json_object_set_string_with_len(out, key_name, cm, end - cm);
			else
				json_object_set_string(out, key_name, cm);
		}
		end:
		ptr = end;
		free(key_name);
	}

	return true;
}

static void read_fdinfo(JSON_Value *container, JSON_Object *pid, const char *dev_id) {
	/* Read fdinfo for each client. */
	char fd_info_path[1024], fd_info[4096], lbl[64];
	DIR *dir;
	struct dirent *entry;
	int app_pid = (int)json_object_get_number(pid, "pid");

	/* Parse the /proc/$fd tree, and find amdgpu's fd. */
	sprintf(fd_info_path, "/proc/%d/fdinfo", app_pid);

	dir = opendir(fd_info_path);
	if (!dir)
		return;

	/* Process all fds. */
	while ((entry = readdir(dir))) {
		sprintf(fd_info, "%s/%s", fd_info_path, entry->d_name);

		JSON_Value *fdinfo = json_value_init_object();
		int64_t n = time_ns();

		unsigned long gpu_fd = strtol(entry->d_name, NULL, 10);
		if (!parse_fdinfo_entry(read_file(fd_info), dev_id, true, json_object(fdinfo))) {
			json_value_free(fdinfo);
			continue;
		}

		sprintf(lbl, "%ld", (long)json_object_get_number(json_object(fdinfo), "drm-client-id"));
		json_object_set_number(json_object(fdinfo), "ts", n);
		json_object_set_string(json_object(fdinfo), "command", json_object_get_string(pid, "app"));
		json_object_set_number(json_object(fdinfo), "pid", app_pid);
		json_object_set_number(json_object(fdinfo), "tgid", get_tgid_for_tid(app_pid));
		json_object_set_number(json_object(fdinfo), "gpu-fd", gpu_fd);
		json_object_set_value(json_object(container), lbl, fdinfo);
	}
	
	closedir(dir);
}

static void parse_drm_clients(struct umr_asic *asic, JSON_Array * clients)
{
	/* Tokens we care about are non-empty. */
	const char *tokens[] = {
		"command", "tgid", "dev", "master", "a", "uid", "magic", "name", "id"
	};
	const enum json_value_type tokens_type[] = {
		JSONString, JSONNumber, JSONNumber, JSONNull,
		JSONNull, JSONNull, JSONNull, JSONString, JSONNumber
	};
	char *ptr = read_file_a(SYSFS_PATH_DEBUG_DRI "%d/clients", asic->instance);
	if (!ptr)
		return;

	unsigned i, j, n_lines, line_check;
	uint64_t number;
	char **lines = parse_lines(ptr, &n_lines);

	for (i = 1; i < n_lines; i++) {
		JSON_Object *app = json_object(json_value_init_object());

		line_check = 0;
		for (j = 0; j < ARRAY_SIZE(tokens); j++) {
			char *token = strtok(j == 0 ? lines[i] : NULL, " ");
			if (token == NULL) {
				/* Malformed line. */
				break;
			}
			line_check++;

			switch (tokens_type[j]) {
				case JSONString:
					json_object_set_string(app, tokens[j], token);
					break;
				case JSONNumber: {
					if (sscanf(token, "%" PRIu64, &number) == 1)
						json_object_set_number(app, tokens[j], number);
					break;
				}
				default:
					break;
			}
		}
		if (line_check == ARRAY_SIZE(tokens_type)) {
			json_array_append_value(clients, json_object_get_wrapping_value(app));
		} else {
			json_value_free(json_object_get_wrapping_value(app));
		}
	}
	free(ptr);
	free(lines);
}

JSON_Array *get_active_amdgpu_clients(struct umr_asic *asic)
{
	JSON_Array *pids = json_array(json_value_init_array());
	/* Find out about the active clients. */
	const char *ptr = read_file("/sys/kernel/debug/dri/%d/amdgpu_vm_info", asic->instance);
	while (ptr) {
		unsigned pid;
		char *next_pid = strstr(ptr, "pid:");
		if (!next_pid)
			break;
		char *next_space = strchr(next_pid, '\t');
		ptr = next_space + 1;

		if (sscanf(next_pid, "pid:%u", &pid) == 1) {
			if (pid == 0)
				continue;

			JSON_Value *p = NULL;
			for (size_t i = 0; i < json_array_get_count(pids) && p == NULL; i++) {
				JSON_Object *o = json_object(json_array_get_value(pids, i));
				if (json_object_get_number(o, "pid") == pid)
					p = json_object_get_wrapping_value(o);
			}

			if (p)
				continue;

			p = json_value_init_object();
			json_array_append_value(pids, p);
			json_object_set_number(json_object(p), "pid", pid);

			char *command = read_file_a("/proc/%d/comm", pid);
			if (command) {
				size_t len = strlen(command);
				if (len > 1)
					json_object_set_string_with_len(json_object(p), "app", command, len - 1);
				free(command);
			}

			ptr = next_space + 1 + strlen("Process:");

		} else {
			break;
		}
	}
	return pids;
}

JSON_Array *parse_buffer_object_info(char *content, bool is_vm_info)
{
	JSON_Array *apps = json_array(json_value_init_array());

	unsigned nlines = 0;
	char **lines = parse_lines(content, &nlines);

	for (unsigned i = 0; i < nlines;) {
		if (strncmp(lines[i], "pid", 3) != 0) {
			printf("Incorrect line start %d '%s'. Aborting\n", i, lines[i]);
			return NULL;
		}
		const char *cursor = lines[i] + 3;

		if (is_vm_info) {
			if (*cursor != ':')
				return NULL;
			cursor++;
		}
		while (isspace(*cursor)) cursor++;

		unsigned pid;
		sscanf(cursor, "%u", &pid);

		/* vm_info uses the tid, not the pid. */
		if (is_vm_info)
			pid = get_tgid_for_tid(pid);

		/* Do we already know about this pid? */
		JSON_Object *p = NULL;
		for (size_t j = 0; j < json_array_get_count(apps); j++) {
			JSON_Object *q = json_object(json_array_get_value(apps, i));
			if (json_object_get_number(q, "pid") == pid) {
				p = q;
				break;
			}
		}

		if (p == NULL) {
			p = json_object(json_value_init_object());
			json_object_set_number(p, "pid", pid);

			/* Set the main process command based on the real comm, and fallback
			 * on the value we parsed if it fails.
			 */
			char *cmd = read_file("/proc/%d/comm", pid);
			if (cmd && strlen(cmd)) {
				json_object_set_string_with_len(p, "command", cmd, strlen(cmd) - 1);
			} else {
				const char *cmd_prefix = is_vm_info ? "Process:" : "command ";
				const char *cmd_end = is_vm_info ? " ----------" : ":";
				cursor = strstr(cursor, cmd_prefix);
				if (cursor == NULL)
					return NULL;
				cursor += strlen(cmd_prefix);
				char *end = strstr(cursor, cmd_end);
				json_object_set_string_with_len(p, "command", cursor, end - cursor);
			}
			json_object_set_value(p, "clients", json_value_init_array());
		}

		JSON_Object *client = json_object(json_value_init_object());
		JSON_Array *bos = json_array(json_value_init_array());
		json_object_set_value(client, "bos", json_array_get_wrapping_value(bos));

		/* Now parse lines belonging to this pid */
		for (i = i + 1; i < nlines; i++) {
			/* Break if we're starting a new one. */
			if (strncmp(lines[i], "pid", 3) == 0)
				break;

			cursor = lines[i];

			unsigned kms_handle;
			long unsigned size;
			if (sscanf(cursor, "0x%x", &kms_handle) != 1)
				continue;

			cursor += strlen("0x00000000:");
			while (isspace(*cursor)) cursor++;

			sscanf(cursor, "%" PRIu64, &size);

			JSON_Object *bo = json_object(json_value_init_object());
			json_object_set_number(bo, "handle", kms_handle);
			json_object_set_number(bo, "size", size);
			json_array_append_value(bos, json_object_get_wrapping_value(bo));

			/* Parse attributes. */
			const char *attributes[] = {
				" pin count %lu", " GTT", " CPU_ACCESS_REQUIRED", " VRAM_CLEARED",
				" VRAM", " CPU_GTT_USWC", " exported as ino:%lu", " VRAM VISIBLE",
				" NONE", " DOORBELL", " CPU", " UNKNOWN", " imported from ino:%lu",
				" EXPLICIT_SYNC", " VM_ALWAYS_VALID", " VRAM_CONTIGUOUS",
				" NO_CPU_ACCESS"
			};
			const size_t len = strlen(lines[i]);
			JSON_Object *attr = json_object(json_value_init_object());
			for (size_t j = 0; j < ARRAY_SIZE(attributes); j++) {
				const int attr_len = strlen(attributes[j]);
				char *pct = strchr(attributes[j], '%');

				char *found = memmem(lines[i], len, attributes[j],
									 pct ? (pct - attributes[j]) : attr_len);

				if (found) {
					if (pct) {
						unsigned long v;
						if (sscanf(found, attributes[j], &v) == 1) {
							char attr_name[64] = {0};
							strncpy(attr_name, attributes[j] + 1, pct - attributes[j] - 2);
							json_object_set_number(attr, attr_name, v);
						}
					} else {
						/* Make sure we match the whole word. */
						char *end = found + attr_len;
						if (*end == '\0' || *end == ' ')
							json_object_set_number(attr, attributes[j] + 1, 1);
					}
				}
			}
			json_object_set_value(bo, "attributes", json_object_get_wrapping_value(attr));
			if (json_object_has_value(attr, "exported as ino"))
				json_object_set_number(bo, "ino", json_object_get_number(attr, "exported as ino"));
		}

		if (json_array_get_count(bos)) {
			json_array_append_value(apps, json_object_get_wrapping_value(p));
			json_array_append_value(json_array(json_object_get_value(p, "clients")),
									json_object_get_wrapping_value(client));
		}
	}

	free(lines);

	return apps;
}

/* A single pid can have multiple drm_client_id. This functions identifies the gpu's fd of
 * each client.
 */
static bool assign_gpu_fd_to_clients(struct umr_asic *asic, int pid, JSON_Array *clients)
{
	int gpu_fds[1024], client_ids[1024];
	size_t gpu_fds_count;

	int pid_fd = syscall(SYS_pidfd_open, pid, 0);
	if (pid_fd < 0)
		return false;

	/* Get all the open fd (drm client) for this pid. */
	gpu_fds_count = find_amdgpu_fd(pid, asic->options.pci.name,
								   gpu_fds, ARRAY_SIZE(gpu_fds), client_ids);
	if (gpu_fds_count == 0) {
		close(pid_fd);
		return false;
	}

#if CAN_IMPORT_BO
	unsigned n = 0;
	char *buf = read_file_n("/proc/%d/environ", &n, pid);
	bool has_extra_md = memmem(buf, n, "extra_md", strlen("extra_md"));

	if (gpu_fds_count == 1 && json_array_get_count(clients) == 1 && !has_extra_md) {
#else
	if (1) {
#endif
		JSON_Object *client = json_array_get_object(clients, 0);
		json_object_set_number(client, "gpu-fd", gpu_fds[0]);
		json_object_set_number(client, "drm-client-id", client_ids[0]);
		close(pid_fd);
		return true;
	}

#if CAN_IMPORT_BO
	return use_dmabuf_to_identify_owner_fd(clients, pid_fd, gpu_fds, gpu_fds_count, client_ids, has_extra_md);
#endif
}

static void postprocess_gem_info(struct umr_asic *asic, JSON_Array *apps, JSON_Array *apps_from_vm)
{
	size_t i, j, k;

	size_t max_drm_client_id_to_vm_apps = 8;
	int64_t *drm_client_id_to_vm_apps =
		malloc(sizeof(int64_t) * 2 * max_drm_client_id_to_vm_apps);
	size_t n_drm_client_id_to_vm_apps = 0;
	for (i = 0; i < json_array_get_count(apps_from_vm); i++) {
		JSON_Object *vm_app = json_array_get_object(apps_from_vm, i);

		int gpu_fds[1024], drm_clients_id[1024];
		uint32_t pid = json_object_get_number(vm_app, "pid");
		int gpu_fds_count = find_amdgpu_fd(pid, asic->options.pci.name,
										   gpu_fds, ARRAY_SIZE(gpu_fds),
										   drm_clients_id);
		for (int j = 0; j < gpu_fds_count; j++) {
			bool found = false;
			for (k = 0; k < n_drm_client_id_to_vm_apps && !found; k++) {
				if (drm_client_id_to_vm_apps[2 * k] == drm_clients_id[j])
					found = true;
			}
			if (!found) {
				drm_client_id_to_vm_apps[2 * n_drm_client_id_to_vm_apps] = drm_clients_id[j];
				drm_client_id_to_vm_apps[2 * n_drm_client_id_to_vm_apps + 1] = i;
				n_drm_client_id_to_vm_apps++;

				if (n_drm_client_id_to_vm_apps == max_drm_client_id_to_vm_apps) {
					max_drm_client_id_to_vm_apps *= 2;
					drm_client_id_to_vm_apps = realloc(drm_client_id_to_vm_apps,
													   sizeof(int64_t) * 2 * max_drm_client_id_to_vm_apps);
				}
			}
		}
	}

	/* The goal here is to find the real app pid and the gpu fd owning the buffers.
	 * amdgpu_gem_info and amdgpu_vm_info both have deficiencies:
	 *   - amdgpu_gem_info:
	 *       * pro: reports the BO handle
	 *       * con: the pid/app name might be incorrect
	 *   - amdgpu_vm_info:
	 *       * pro: report the precise tid
	 *       * con: the handle is just an index
	 *
	 * So the idea here is to use the exported buffers as the source of truth:
	 * we want to find the pid/fd that have all of them (and not more).
	*/
	for (i = 0; i < json_array_get_count(apps); i++) {
		JSON_Object *app = json_array_get_object(apps, i);
		JSON_Array *clients = json_object_get_array(app, "clients");

		int pid = json_object_get_number(app, "pid");

		if (!assign_gpu_fd_to_clients(asic, pid, clients))
			continue;

		for (k = 0; k < json_array_get_count(clients); k++) {
			JSON_Object *client = json_array_get_object(clients, k);

			/* So far so good. Now check if vm_info gave us a better hint of who's the actual user
			 * of the drm-client-id for this fd.
			 */
			int64_t drm_client_id = json_object_get_number(client, "drm-client-id");
			for (j = 0; drm_client_id && j < n_drm_client_id_to_vm_apps; j++) {
				if (drm_client_id_to_vm_apps[2 * j] == drm_client_id) {
					JSON_Object *vm_app = json_array_get_object(apps_from_vm, drm_client_id_to_vm_apps[2 * j + 1]);
					int p = json_object_get_number(vm_app, "pid");
					if (p != pid) {
						json_object_set_number(app, "pid", json_object_get_number(vm_app, "pid"));
						json_object_set_string(app, "command", json_object_get_string(vm_app, "command"));
						assign_gpu_fd_to_clients(asic, p, clients);
					}
					break;
				}
			}
		}
	}

	free(drm_client_id_to_vm_apps);
}

JSON_Array *get_bo_infos(struct umr_asic *asic) {
	/* We're going to parse both gem_info and vm_info. */
	char *data_gem_info = read_file_a(SYSFS_PATH_DEBUG_DRI "%d/amdgpu_gem_info", asic->instance);
	if (!data_gem_info)
		return NULL;

	char *data_vm_info = read_file_a(SYSFS_PATH_DEBUG_DRI "%d/amdgpu_vm_info", asic->instance);
	if (!data_vm_info) {
		free(data_gem_info);
		return NULL;
	}

	JSON_Array *apps_gem_info = parse_buffer_object_info(data_gem_info, false);
	JSON_Array *apps_vm_info = parse_buffer_object_info(data_vm_info, true);

	postprocess_gem_info(asic, apps_gem_info, apps_vm_info);

	json_value_free(json_array_get_wrapping_value(apps_vm_info));
	free(data_gem_info);
	free(data_vm_info);

	return apps_gem_info;
}

enum sensor_maps {
	SENSOR_IDENTITY = 0,
	SENSOR_D1000,
	SENSOR_D100,
	SENSOR_WAIT,
};

struct power_bitfield{
	char *regname;
	uint32_t value;
	enum amd_pp_sensors sensor_id;
	enum sensor_maps map;
};


static uint32_t parse_sensor_value(enum sensor_maps map, uint32_t value)
{
	uint32_t result = 0;

	switch(map) {
		case SENSOR_IDENTITY:
			result = value;
			break;
		case SENSOR_D1000:
			result = value / 1000;
			break;
		case SENSOR_D100:
			result = value / 100;
			break;
		case SENSOR_WAIT:
			result = ((value >> 8) * 1000);
			if ((value & 0xFF) < 100)
				result += (value & 0xFF) * 10;
			else
				result += value;
			result /= 1000;
			break;
		default:
			printf("invalid input value!\n");
			break;
	}
	return result;
}

int parse_pp_feature_vega_line(const char *line, const char **name_start, const char **name_end, int *bit, int *enabled)
{
	/* NAME      0x0000000000000000    Y */
	*name_start = line;
	*name_end = strchr(line, ' ');

	if (*name_end == NULL)
		return -1;

	const char *ptr = *name_end;
	while (*ptr == ' ')
		ptr++;

	uint64_t bitmask;
	*bit = -1;
	if (sscanf(ptr, "0x%" PRIx64, &bitmask) == 1) {
		for (int b = 0; b < 64; b++)
			if (bitmask & (1lu << b)) {
				*bit = b;
				break;
			}
	}


	if (*bit >= 0) {
		/* Skip the 16 bytes hex value */
		ptr += 18;
		while (*ptr == ' ') ptr++;
		*enabled = *ptr == 'Y';
		return 0;
	}

	return -1;
}

int parse_pp_feature_line(const char *line, int i, const char **name_start, const char **name_end, int *bit, int *enabled)
{
	const char *ptr = line;
	char label[64];
	sprintf(label, "%02d.", i);
	const char *feature = lookup_field(&ptr, label, ' ');
	if (!feature)
		return -1;
	const char *sp = strchr(feature, ' ');
	if (!sp)
		return -1;
	*name_start = feature;
	*name_end = sp;
	*enabled = strstr(feature, "enabled") != NULL;

	/* Skip spaces */
	while (*sp == ' ')
		sp++;
	/* Parse bit */
	if (sscanf(sp, "(%d)", bit) == 1)
		return 0;

	return -1;
}

JSON_Object *parse_pp_features_sysfs_file(const char *content)
{
	const char *ptr = content;
	uint64_t raw_value = 0;
	JSON_Object *out = json_object(json_value_init_object());
	JSON_Array *features = json_array(json_value_init_array());
	json_object_set_value(out, "features", json_array_get_wrapping_value(features));

	int vega_format = 0;

	/* 2 possible formats: Vega dGPU or newer ones */
	vega_format = strncmp(ptr, "Current ppfeatures", strlen("Current ppfeatures")) == 0;

	/* Strip the first 2 lines */
	ptr = strchr(ptr, '\n') + 1;
	ptr = strchr(ptr, '\n') + 1;

	for (int i = 0; i < 64; i++) {
		const char *name_start, *name_end;
		int bit, enabled;
		int r;
		if (vega_format) {
			r = parse_pp_feature_vega_line(ptr, &name_start, &name_end, &bit, &enabled);
		} else {
			r = parse_pp_feature_line(ptr, i, &name_start, &name_end, &bit, &enabled);
		}

		if (r < 0)
			break;

		JSON_Object *feat = json_object(json_value_init_object());
		json_object_set_string_with_len(feat, "name", name_start, name_end - name_start);
		json_object_set_boolean(feat, "on", enabled);

		int implicit_bit = json_array_get_count(features);
		/* If there's a gap insert dummy values, so array index can be used
		 * as bit index. */
		if (implicit_bit < bit) {
			int delta = bit - implicit_bit;
			for (int j = 0; j < delta; j++)
				json_array_append_value(features, json_value_init_object());
		}

		json_array_append_value(features, json_object_get_wrapping_value(feat));
		if (enabled)
			raw_value |= 1lu << bit;

		ptr = strchr(ptr, '\n') + 1;
	}
	json_object_set_number(out, "raw_value", raw_value);

	return out;
}

struct {
	uint64_t pba;
	uint64_t va_mask;

	int type; /* 0: base, 1: pde, 2: pte */

	int system, tmz, mtype;
	int pte;
} page_table[64];
int num_page_table_entries;

static void my_va_decode(pde_fields_t *pdes, int num_pde, pte_fields_t pte) {
	for (int i = 0; i < num_pde; i++) {
		page_table[num_page_table_entries].pba = pdes[i].pte_base_addr;
		page_table[num_page_table_entries].type = i == 0 ? 0 : 1;
		page_table[num_page_table_entries].system = pdes[i].pte;
		num_page_table_entries++;
	}
	if (pte.valid || 1) {
		page_table[num_page_table_entries].type = 2;
		page_table[num_page_table_entries].pba = pte.page_base_addr;
		page_table[num_page_table_entries].system = pte.system;
		page_table[num_page_table_entries].va_mask = pte.pte_mask;
		page_table[num_page_table_entries].tmz = pte.tmz;
		page_table[num_page_table_entries].mtype = pte.mtype;
		num_page_table_entries++;
	}
}

static int dummy_printf(const char *fmt, ...) {
	(void)fmt;
	return 0;
}

static JSON_Value *shader_pgm_to_json(struct umr_asic *asic, uint32_t vmid, uint64_t addr, uint32_t size) {
	JSON_Object *res = NULL;
	uint32_t *opcodes = calloc(size / 4, sizeof(uint32_t));
	res = json_object(json_value_init_object());
	json_object_set_number(res, "address", addr);
	json_object_set_number(res, "vmid", vmid);
	if (umr_read_vram(asic, asic->options.vm_partition, vmid, addr, size, (void*)opcodes) == 0) {
		JSON_Array *op = json_array(json_value_init_array());
		for (unsigned i = 0; i < size / 4; i++)
			json_array_append_number(op, opcodes[i]);
		json_object_set_value(res, "opcodes", json_array_get_wrapping_value(op));
	} else {
		printf("Reading vram failed (%d@%" PRIx64" size: %d)\n", vmid, addr, size);
	}
	free(opcodes);
	return json_object_get_wrapping_value(res);
}

static JSON_Value *vcn_pgm_to_json(struct umr_asic *asic, uint32_t type, uint32_t vmid, uint64_t addr, uint32_t size) {
	JSON_Object *res = NULL;
	uint32_t *opcodes = calloc(size / 4, sizeof(uint32_t));
	res = json_object(json_value_init_object());
	json_object_set_number(res, "address", addr);
	json_object_set_number(res, "vmid", vmid);
	json_object_set_number(res, "type", type);
	if (umr_read_vram(asic, asic->options.vm_partition, vmid, addr, size, (void*)opcodes) == 0) {
		JSON_Array *op = json_array(json_value_init_array());
		for (unsigned i = 0; i < size / 4; i++)
			json_array_append_number(op, opcodes[i]);
		json_object_set_value(res, "opcodes", json_array_get_wrapping_value(op));
	} else {
		printf("Reading vram failed (%d@%" PRIx64" size: %d)\n", vmid, addr, size);
	}
	free(opcodes);
	return json_object_get_wrapping_value(res);
}

/* Ring stream decoding */
struct ib_raw_opcodes {
	uint32_t *v;
	uint32_t count;
	uint32_t max;
};

struct ring_decoding_data {
	JSON_Array *shaders;
	JSON_Array *vcns;
	JSON_Array *ibs;
	JSON_Value *ring;
	JSON_Array *open_ibs;
	struct ib_raw_opcodes *raw_opcodes;
	int total_ibs;

	struct {
		uint32_t *opcodes;
		uint32_t count;
	} concatenated;
};

static void _ring_start_ib(struct ring_decoding_data *data, uint64_t ib_addr, uint32_t ib_vmid) {
	JSON_Object *current_ib = json_object(json_value_init_object());
	json_object_set_number(current_ib, "address", ib_addr);
	json_object_set_number(current_ib, "vmid", ib_vmid);
	json_array_append_value(data->open_ibs, json_object_get_wrapping_value(current_ib));
	data->raw_opcodes = (struct ib_raw_opcodes*)realloc(data->raw_opcodes, json_array_get_count(data->open_ibs) * sizeof(struct ib_raw_opcodes));
	int idx = json_array_get_count(data->open_ibs) - 1;
	data->raw_opcodes[idx].v = realloc(NULL, 128 * sizeof(uint32_t));
	data->raw_opcodes[idx].max = 128;
	data->raw_opcodes[idx].count = 0;
}
static void _ring_start_opcode(struct ring_decoding_data *data, uint32_t nwords, uint32_t header, const uint32_t* raw_data, bool is_sdma) {
	const int idx = json_array_get_count(data->open_ibs) - 1;

	/* sdma stream already counts the header dw in nwords */
	if (is_sdma)
		nwords--;

	struct ib_raw_opcodes *raw_opcodes = &data->raw_opcodes[idx];

	int need_alloc = 0;
	while ((raw_opcodes->count + nwords + 1) >= raw_opcodes->max) {
		raw_opcodes->max = 2 * raw_opcodes->max;
		need_alloc = 1;
	}
	if (need_alloc)
		raw_opcodes->v = realloc(raw_opcodes->v, raw_opcodes->max * sizeof(uint32_t));

	raw_opcodes->v[raw_opcodes->count++] = header;
	memcpy(&raw_opcodes->v[raw_opcodes->count], raw_data, nwords * sizeof(uint32_t));
	raw_opcodes->count += nwords;
}

static void _ring_done(struct ring_decoding_data *data) {
	const int idx = json_array_get_count(data->open_ibs) - 1;
	const struct ib_raw_opcodes *raw_opcodes = &data->raw_opcodes[idx];

	JSON_Value *v = json_value_deep_copy(json_array_get_value(data->open_ibs, idx));
	json_object_set_number(json_object(v), "opcode_start", data->concatenated.count);
	json_object_set_number(json_object(v), "opcode_count", raw_opcodes->count);

	data->concatenated.opcodes = realloc(data->concatenated.opcodes, sizeof(uint32_t) *
		(raw_opcodes->count + data->concatenated.count));
	memcpy(&data->concatenated.opcodes[data->concatenated.count],
		raw_opcodes->v,
		raw_opcodes->count * sizeof(uint32_t));
	data->concatenated.count += raw_opcodes->count;
	free(raw_opcodes->v);

	if (json_object_get_number(json_object(v), "address") == 0)
		data->ring = v;
	else
		json_array_append_value(data->ibs, v);

	json_array_remove(data->open_ibs, idx);
	data->total_ibs += 1;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"


static void ring_start_ib(struct umr_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, uint64_t from_addr, uint32_t from_vmid, uint32_t size, int type) {
	_ring_start_ib((struct ring_decoding_data*) ui->data, ib_addr, ib_vmid);
}

static void ring_start_opcode(struct umr_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, int pkttype, uint32_t opcode, uint32_t subop, uint32_t nwords, const char *opcode_name, uint32_t header, const uint32_t* raw_data) {
	_ring_start_opcode((struct ring_decoding_data*) ui->data, nwords, header, raw_data, ui->rt == UMR_RING_SDMA);
}

static void ring_add_field(struct umr_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, const char *field_name, uint64_t value, char *str, int ideal_radix, int field_size) {
	/* Ignore */
}

static void ring_add_shader(struct umr_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, struct umr_shaders_pgm *shader) {
	struct ring_decoding_data *data = (struct ring_decoding_data*) ui->data;

	for (size_t i = 0; i < json_array_get_count(data->shaders); i++) {
		JSON_Object *sh = json_object(json_array_get_value(data->shaders, i));
		uint64_t addr = json_object_get_number(sh, "address");
		uint64_t vmid = json_object_get_number(sh, "vmid");
		if (addr == shader->addr && vmid == shader->vmid) {
			/* Duplicate => skip */
			return;
		}
	}

	JSON_Value *sh = shader_pgm_to_json(asic, shader->vmid, shader->addr, shader->size);
	if (sh)
		json_array_append_value(data->shaders, sh);
}

static void ring_add_vcn(struct umr_stream_decode_ui *ui, struct umr_asic *asic, struct umr_vcn_cmd_message *vcn) {
	struct ring_decoding_data *data = (struct ring_decoding_data*) ui->data;

	JSON_Value *sh = vcn_pgm_to_json(asic, vcn->type, vcn->vmid, vcn->addr, vcn->size);
	if (sh)
		json_array_append_value(data->vcns, sh);

	if (vcn->next)
		ring_add_vcn(ui, asic, vcn->next);
}

static void ring_add_data(struct umr_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, uint64_t buf_addr, uint32_t buf_vmid, enum UMR_DATABLOCK_ENUM type, uint64_t etype) {
	/* Ignore */
}

static void ring_unhandled(struct umr_stream_decode_ui *ui, struct umr_asic *asic, uint64_t ib_addr, uint32_t ib_vmid, void *str, enum umr_ring_type rt) {
	/* Ignore */
}

static void ring_done(struct umr_stream_decode_ui *ui) {
	_ring_done((struct ring_decoding_data*) ui->data);
}

#pragma GCC diagnostic pop

struct umr_asic *asics[16] = {0};
char *ip_discovery_dumps[16] = {0};
int *ring_kernel_pid[16] = {0};

void init_asics(void) {
	struct umr_options opt;
	char database_path[256] = { 0 };
	int asic_count = 0;

	struct umr_asic **enum_asics;

	memset(&opt, 0, sizeof(opt));
	opt.forcedid = -1;
	opt.scanblock = "";
	opt.vm_partition = -1;
	/* Allocate a buffer to pass ip discovery info to the client. */
	char *ip_discovery_dump = calloc(1, 100000);
	opt.test_log_fd = fmemopen(ip_discovery_dump, 100000, "w");
	if (!opt.test_log_fd)
		opt.force_asic_file = 1;
	else
		opt.test_log = 1;

	if (umr_enumerate_device_list(printf, database_path, &opt, &enum_asics, &asic_count, 1) < 0) {
		exit(0);
	}

	fflush(opt.test_log_fd);
	char *asic_discovery_data = ip_discovery_dump;

	for (int i = 0; i < asic_count; i++) {
		asics[i] = enum_asics[i];

		/* Assign linux callbacks */
		asics[i]->ring_func.read_ring_data = umr_read_ring_data;

		asics[i]->mem_funcs.vm_message = dummy_printf;
		asics[i]->mem_funcs.gpu_bus_to_cpu_address = umr_vm_dma_to_phys;
		asics[i]->mem_funcs.access_sram = umr_access_sram;

		asics[i]->shader_disasm_funcs.disasm = umr_shader_disasm;

		if (asics[i]->options.use_pci == 0)
			asics[i]->mem_funcs.access_linear_vram = umr_access_linear_vram;
		else
			asics[i]->mem_funcs.access_linear_vram = umr_access_vram_via_mmio;

		asics[i]->reg_funcs.read_reg = umr_read_reg;
		asics[i]->reg_funcs.write_reg = umr_write_reg;

		asics[i]->wave_funcs.get_wave_sq_info = umr_get_wave_sq_info;
		asics[i]->wave_funcs.get_wave_status = umr_get_wave_status;

		/* Default shader options */
		if (asics[i]->family <= FAMILY_VI) {
			asics[i]->options.shader_enable.enable_gs_shader = 1;
			asics[i]->options.shader_enable.enable_hs_shader = 1;
		}
		asics[i]->options.shader_enable.enable_vs_shader   = 1;
		asics[i]->options.shader_enable.enable_ps_shader   = 1;
		asics[i]->options.shader_enable.enable_es_shader   = 1;
		asics[i]->options.shader_enable.enable_ls_shader   = 1;
		asics[i]->options.shader_enable.enable_comp_shader = 1;

		asics[i]->gpr_read_funcs.read_sgprs = umr_read_sgprs;
		asics[i]->gpr_read_funcs.read_vgprs = umr_read_vgprs;

		asics[i]->err_msg = printf;

		if (asics[i]->family > FAMILY_VI)
			asics[i]->options.shader_enable.enable_es_ls_swap = 1;

		umr_scan_config(asics[i], 1);
		if (asics[i]->fd.drm < 0) {
			char devname[PATH_MAX];
			sprintf(devname, "/dev/dri/card%d", asics[i]->instance);
			asics[i]->fd.drm = open(devname, O_RDWR);
		}

		if (opt.test_log_fd) {
			const char *separator = "-----\n";
			if (asic_discovery_data == NULL) {
				printf("Unexpected discovery buffer:\n'%s'\n", ip_discovery_dump);
				exit(0);
			}
			char *next_asic = strstr(asic_discovery_data, separator);
			assert(next_asic);

			if (asics[i]->was_ip_discovered)
				ip_discovery_dumps[i] =
					strndup(asic_discovery_data, next_asic - asic_discovery_data);

			asic_discovery_data = next_asic + strlen(separator);
		}
		asics[i]->options.test_log = false;
		asics[i]->options.test_log_fd = 0;
	}
	free(enum_asics);

	fclose(opt.test_log_fd);
	free(ip_discovery_dump);
}

static bool is_thread_alive(struct umr_asic *asic, struct umr_wave_data *wd, int tid) {
	uint32_t exec_mask = umr_wave_data_get_value(asic, wd,
		tid < 32 ? "ixSQ_WAVE_EXEC_LO" : "ixSQ_WAVE_EXEC_HI");
	return exec_mask & (1u << (tid % 32));
}

static JSON_Value *wave_to_json(struct umr_asic *asic, struct umr_wave_data *wd, int gfx_maj_version,
				struct umr_packet_stream *stream, JSON_Value *shaders) {
	uint64_t pc;
	uint32_t vmid;

	JSON_Value *wave = json_value_init_object();
	json_object_set_number(json_object(wave), "se", wd->se);
	json_object_set_number(json_object(wave), gfx_maj_version <= 9 ? "sh" : "sa", wd->sh);
	json_object_set_number(json_object(wave), gfx_maj_version <= 9 ? "cu" : "wgp", wd->cu);
	json_object_set_number(json_object(wave), "simd_id", umr_wave_data_get_flag_simd_id(asic, wd));
	json_object_set_number(json_object(wave), "wave_id", umr_wave_data_get_flag_wave_id(asic, wd));
	umr_wave_data_get_shader_pc_vmid(asic, wd, &vmid, &pc);
	json_object_set_number(json_object(wave), "PC", pc);

	JSON_Object *registers = json_object(json_value_init_object());
	json_object_set_value(json_object(wave), "registers",
		json_object_get_wrapping_value(registers));
	for (int x = 0; wd->reg_names[x]; x++) {
		int no_bits;
		struct umr_bitfield *bits;
		JSON_Object *r;

		r = json_object(json_value_init_object());
		json_object_set_number(r, "raw", wd->ws.reg_values[x]);

		umr_wave_data_get_bit_info(asic, wd, wd->reg_names[x], &no_bits, &bits);
		for (int y = 0; y < no_bits; y++) {
			json_object_set_number(r, bits[y].regname,
								   umr_wave_data_get_bits(asic, wd, wd->reg_names[x], bits[y].regname));
		}

		json_object_set_value(registers, wd->reg_names[x], json_object_get_wrapping_value(r));
	}

	JSON_Value *threads = json_value_init_array();
	int num_threads = wd->num_threads;
	for (int thread = 0; thread < num_threads; thread++) {
		bool live = is_thread_alive(asic, wd, thread);
		json_array_append_boolean(json_array(threads), live ? 1 : 0);
	}
	json_object_set_value(json_object(wave), "threads", threads);

	if (!asic->options.skip_gprs && (umr_wave_data_get_flag_halt(asic, wd) || umr_wave_data_get_flag_fatal_halt(asic, wd))) {
		int sgpr_count = umr_wave_data_num_of_sgprs(asic, wd);
		JSON_Value *sgpr = json_value_init_array();
		for (int x = 0; x < sgpr_count; x++)
			json_array_append_number(json_array(sgpr), wd->sgprs[x]);
		json_object_set_value(json_object(wave), "sgpr", sgpr);

		if (umr_wave_data_get_flag_trap_en(asic, wd) || umr_wave_data_get_flag_priv(asic, wd)) {
			JSON_Value *extra_sgpr = json_value_init_array();
			for (int x = 0; x < 16; x++)
				json_array_append_number(json_array(extra_sgpr), wd->sgprs[0x6C + x]);
			json_object_set_value(json_object(wave), "extra_sgpr", extra_sgpr);
		}


		if (wd->have_vgprs) {
			unsigned granularity = asic->parameters.vgpr_granularity;
			int vpgr_count =
				(umr_wave_data_get_bits(asic, wd, "ixSQ_WAVE_GPR_ALLOC", "VGPR_SIZE") + 1) << granularity;
			JSON_Value *vgpr = json_value_init_array();
			for (int x = 0; x < vpgr_count; x++) {
				JSON_Value *v = json_value_init_array();
				for (int thread = 0; thread < num_threads; thread++) {
					json_array_append_number(json_array(v), wd->vgprs[thread * 256 + x]);
				}
				json_array_append_value(json_array(vgpr), v);
			}
			json_object_set_value(json_object(wave), "vgpr", vgpr);
		}

		/* */
		if (stream) {
			struct umr_shaders_pgm *shader = NULL;
			uint32_t shader_size;
			uint64_t shader_addr;
			uint64_t pgm_addr = pc;

			shader = umr_packet_find_shader(asic, stream, vmid, pgm_addr);

			if (shader) {
				shader_size = shader->size;
				shader_addr = shader->addr;
			} else {
				#define NUM_OPCODE_WORDS 16
				pgm_addr -= (NUM_OPCODE_WORDS*4)/2;
				shader_addr = pgm_addr;
				shader_size = NUM_OPCODE_WORDS * 4;
				#undef NUM_OPCODE_WORDS
			}

			char tmp[128];
			sprintf(tmp, "%lx", shader_addr);
			/* This given shader isn't there, so read it. */
			if (json_object_get_value(json_object(shaders), tmp) == NULL) {
				JSON_Value *shader = shader_pgm_to_json(asic, vmid, shader_addr, shader_size);
				if (shader)
					json_object_set_value(json_object(shaders), tmp, shader);
			}
			json_object_set_string(json_object(wave), "shader", tmp);
		}
	}

	return wave;
}

static void read_clock_min_max(struct umr_asic *asic, const char *clk_name, int *min, int *max)
{
	parse_sysfs_clock_file(
		read_file(SYSFS_PATH_DRM "card%d/device/pp_dpm_%s", asic->instance, clk_name),
		min, max);
}

static bool
write_str_to_file(const char *path, const char *str) {
	FILE *f = fopen(path, "w");
	if (f == NULL) {
		fprintf(stderr, "Failed to open '%s'\n", path);
		return false;
	}
	int b = strlen(str);
	while (b) {
		int written = fwrite(str, 1, b, f);
		if (written < 0) {
			fprintf(stderr, "Failed to write '%s' to '%s'\n", str, path);
			fclose(f);
			return false;
		}
		b -= written;
	}
	fclose(f);
	return true;
}

struct pid_tgid_mapping {
	int pid;
	int tgid;
	char process_name[32];
};

struct string_array {
	struct {
		char *ptr;
		int used, capacity;
	} strings;
	struct {
		struct {
			int len;
			int offset;
		} *ptr;
		int used, capacity;
	} len_off;
};
static void string_array_deinit(struct string_array *arr)
{
	free(arr->len_off.ptr);
	free(arr->strings.ptr);
}
static int string_array_push(struct string_array *arr, char *str, int len)
{
	if (arr->len_off.used == arr->len_off.capacity) {
		arr->len_off.capacity *= 2;
		arr->len_off.ptr = realloc(arr->len_off.ptr, arr->len_off.capacity * sizeof(*arr->len_off.ptr));
	}
	if ((arr->strings.used + len) >= arr->strings.capacity) {
		while ((arr->strings.used + len) >= arr->strings.capacity)
			arr->strings.capacity *= 2;
		arr->strings.ptr = realloc(arr->strings.ptr, arr->strings.capacity * sizeof(*arr->strings.ptr));
	}

	int i = arr->len_off.used;
	arr->len_off.ptr[i].offset = arr->strings.used;
	arr->len_off.ptr[i].len = len;

	arr->len_off.used += 1;
	arr->strings.used += len;
	memcpy(&arr->strings.ptr[arr->len_off.ptr[i].offset], str, len);
	return i;
}

static void string_array_init(struct string_array *arr)
{
	arr->strings.used = 0;
	arr->strings.capacity = 128;
	arr->strings.ptr = realloc(NULL, arr->strings.capacity * sizeof(*arr->strings.ptr));

	arr->len_off.used = 0;
	arr->len_off.capacity = 8;
	arr->len_off.ptr = realloc(NULL, arr->len_off.capacity * 2 * sizeof(*arr->len_off.ptr));
}

static int string_array_lookup_or_push(struct string_array *arr, char *str, int len)
{
	for (int i = 0; i < arr->len_off.used; i++) {
		if (arr->len_off.ptr[i].len != len)
			continue;
		if (strncmp(&arr->strings.ptr[arr->len_off.ptr[i].offset], str, len) == 0)
			return i;
	}
	return string_array_push(arr, str, len);
}

struct activity_capture_data {
	pthread_t event_thread;
	bool event_thread_is_valid;

	struct string_array tasks;

	/* Sensor + memory store. */
	pthread_mutex_t mtx;

	/* Trace buffer fd. */
	FILE *tracing_pipe_fd;

	/* pid -> tgid mapping. */
	struct pid_tgid_mapping* mapping;
	int mapping_count, mapping_capacity;

	int lost_events;
	int8_t *event_buffer;
	int event_buffer_size;

	bool run;
	bool verbose;
	bool client_names;
};

struct activity_capture_data *__sensor_data = NULL;

static void* read_trace_buffer_thread(void *in);
static bool events_tracing_helper(int mode, bool verbose, struct umr_asic *asic,
											 JSON_Object *request) {
	write_str_to_file(SYSFS_PATH_TRACING "trace_clock", "mono");

	write_str_to_file(SYSFS_PATH_TRACING "buffer_size_kb", "10 * 1024 * 1024");

	/* Disable all events */
	if (!write_str_to_file(SYSFS_PATH_TRACING "events/enable", "0"))
		return false;

	bool error = false;
	bool enable_tracing;

	if (mode == 1) {
		/* gpu_scheduler events. */
		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/gpu_scheduler/drm_sched_job_add_dep/enable", "1");
		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/gpu_scheduler/drm_sched_job_unschedulable/enable", "1");
		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/gpu_scheduler/drm_sched_job_queue/enable", "1");
		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/gpu_scheduler/drm_sched_job_run/enable", "1");
		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/gpu_scheduler/drm_sched_job_done/enable", "1");
		enable_tracing = true;
	} else if (mode == 2) {
		char filter[512];

		if (asic == NULL)
			return false;

		error |= !write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/enable", "1");
		/* Disable previous filter + trigger. */
		write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/trigger", "!stacktrace");
		write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/filter", "0");

		if (json_object_has_value(request, "reg_offset")) {
			sprintf(filter, "did == 0x%x && reg == 0x%x", asic->did, (uint32_t) json_object_get_number(request, "reg_offset"));
			error |= !write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/filter", filter);

			sprintf(filter, "stacktrace if reg == 0x%x", (uint32_t) json_object_get_number(request, "reg_offset"));
			error |= !write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/trigger", filter);
		} else {
			sprintf(filter, "did == 0x%x", asic->did);

			error |= !write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/filter", filter);
			error |= !write_str_to_file(SYSFS_PATH_TRACING "events/amdgpu/amdgpu_device_wreg/trigger", "stacktrace");
		}

		enable_tracing = true;
	} else {
		enable_tracing = false;
	}

	if (error) {
		fprintf(stderr, "Failed to enable the required kernel events. Maybe your kernel is too old?\n");
		return false;
	}

	/* Clear buffer */
	if (!write_str_to_file(SYSFS_PATH_TRACING "trace", "a"))
		return false;

	if (enable_tracing) {
		struct activity_capture_data *data = calloc(1, sizeof(struct activity_capture_data));
		data->run = true;
		data->verbose = verbose;
		data->tracing_pipe_fd = fopen(SYSFS_PATH_TRACING "trace_pipe", "r");
		if (!data->tracing_pipe_fd) {
			fprintf(stderr, "Failed to open " SYSFS_PATH_TRACING "trace_pipe\n");
			free(data);
			return false;
		}
		fcntl(fileno(data->tracing_pipe_fd), F_SETFL, O_NONBLOCK);
		data->mapping = calloc(8, sizeof(struct activity_capture_data));
		data->mapping_count = 0;
		data->mapping_capacity = 8;
		data->client_names = mode == 1;
		string_array_init(&data->tasks);

		__sensor_data = data;
		pthread_mutex_init(&data->mtx, NULL);
		data->event_thread_is_valid = pthread_create(&__sensor_data->event_thread, NULL, read_trace_buffer_thread, data) == 0;
	} else if (__sensor_data) {
		__sensor_data->run = false;
		if (__sensor_data->event_thread_is_valid)
			pthread_join(__sensor_data->event_thread, NULL);
		free(__sensor_data->mapping);
		free(__sensor_data->event_buffer);
		fclose(__sensor_data->tracing_pipe_fd);
		string_array_deinit(&__sensor_data->tasks);
		free(__sensor_data);
		__sensor_data = NULL;
	}

	if (!write_str_to_file(SYSFS_PATH_TRACING "tracing_on", enable_tracing ? "1" : "0"))
		return false;

	return true;
}

static int get_pid_name(int pid, char process_name[32]) {
	char path[1024];

	if (pid == 0) {
		strcpy(process_name, "kernel");
		return 0;
	}

	sprintf(path, "/proc/%d/status", pid);
	char *content = read_file_a(path);
	if (!content)
		return -1;

	char *p = strstr(content, "Name:");
	if (!p) {
		free(content);
		return -1;
	}
	p += strlen("Name:");
	while (isspace(*p)) p++;
	char *e = p + 1;
	while (*e != '\n') e++;
	int s = e - p;
	if (s > 31)
		s = 31;
	strncpy(process_name, p, s);
	process_name[s] = '\0';

	free(content);
	return 0;
}

static uint32_t get_tgid_for_tid(uint32_t tid) {
	char path[1024];
	sprintf(path, "/proc/%d/status", tid);
	char *content = read_file_a(path);
	if (!content)
		return tid;

	char *n = strstr(content, "Tgid:");
	if (!n) {
		free(content);
		return tid;
	}
	n += strlen("Tgid:");
	while (isspace(*n)) n++;

	uint32_t tgid = strtol(n, NULL, 10);
	free(content);
	return tgid;
}

static int8_t *ensure_capacity(int8_t *buffer, int *capacity, int used, int extra) {
	int total = used + extra;

	if (total < *capacity)
		return buffer;

	while ((*capacity) <= total)
		*capacity *= 2;

	buffer = realloc(buffer, *capacity);
	return buffer;
}

static bool parse_one_event(struct activity_capture_data *data, char *buffer,
									 int len, int8_t **out,
									 int *raw_data_used, int *raw_data_capacity) {
	char *task_name_start, *task_name_end;
	char *pid_end;
	char *cursor, *eol;
	char *process_name;

	if (data->verbose)
		printf("'%.*s'\n", len, buffer);
	cursor = buffer;
	eol = buffer + len;

	while (isspace(*cursor)) cursor++;

	task_name_start = cursor;

	/* Jump after taskname-pid */
	pid_end = strchr(cursor, '[');
	if (pid_end == NULL)
		return false;

	if (memcmp(pid_end, "[LOST", 5) == 0) {
		int n = strtol(pid_end + strlen("[LOST"), NULL, 10);
		data->lost_events += n;
		char *end = strchr(pid_end, ']');
		printf("warn: %.*s\n", (int)(end - pid_end), pid_end);
		return false;
	}

	/* Track back to the pid */
	cursor = pid_end;
	while (*cursor != '-') cursor--;
	task_name_end = cursor;
	cursor++;

	/* Parse the pid */
	int pid = strtol(cursor, NULL, 10);

	/* Figure out the tgid */
	int tgid = -1;
	for (int i = 0; i < data->mapping_count; i++) {
		if (data->mapping[i].pid == pid) {
			tgid = data->mapping[i].tgid;
			process_name = data->mapping[i].process_name;
			break;
		}
	}
	if (tgid < 0) {
		if (data->mapping_count == data->mapping_capacity) {
			data->mapping_capacity *= 2;
			data->mapping = realloc(data->mapping, data->mapping_capacity * sizeof(struct pid_tgid_mapping));
		}

		data->mapping[data->mapping_count].pid = pid;
		tgid = data->mapping[data->mapping_count].tgid = get_tgid_for_tid(pid);
		if (get_pid_name(tgid, data->mapping[data->mapping_count].process_name) < 0) {
			/* Maybe the process exited early. */
			int len = task_name_end - task_name_start;
			if (len > 31)
				len = 31;
			strncpy(data->mapping[data->mapping_count].process_name, task_name_start, sizeof(data->mapping[data->mapping_count].process_name) - 1);
			data->mapping[data->mapping_count].process_name[len] = '\0';
		}

		process_name = data->mapping[data->mapping_count].process_name;

		data->mapping_count++;
	}

	/* Skip the CPU section */
	cursor = pid_end;
	while (*cursor != ']') cursor++;
	cursor++;

	/* Skip until timestamp */
	while (isspace(*cursor)) cursor++;
	cursor += 5;
	while (!isdigit(*cursor)) cursor++;

	/* Parse timestamp. */
	double ts;
	if (sscanf(cursor, "%lf:", &ts) != 1)
		return false;

	cursor = strchr(cursor, ':');
	if (cursor == NULL)
		return false;
	cursor += 2;

	/* Map event name to enum */
	int event_type = 0; /* Unknown. */
	if (strncmp(cursor, "drm_sched_job_", strlen("drm_sched_job_")) == 0) {
		cursor += strlen("drm_sched_job_");
		if (strncmp(cursor, "queue", strlen("queue")) == 0)
			event_type = 1; /* DrmSchedJobQueue */
		else if (strncmp(cursor, "run", strlen("run")) == 0)
			event_type = 2; /* DrmSchedJobRun */
		else if (strncmp(cursor, "done", strlen("done")) == 0)
			event_type = 3; /* DrmSchedJobDone */
		else if (strncmp(cursor, "unschedulable", strlen("unschedulable")) == 0)
			event_type = 4; /* DrmSchedJobUnschedulable */
		else if (strncmp(cursor, "add_dep", strlen("add_dep")) == 0)
			event_type = 5; /* DrmSchedJobAddDep */
		else
			assert(false);
	} else if (strncmp(cursor, "amdgpu_device_wreg", strlen("amdgpu_device_wreg")) == 0) {
		event_type = 7; /* AmdgpuDeviceWreg */
	} else {
		return false;
	}
	cursor = strchr(cursor, ':') + 1;
	while (cursor && *cursor == ' ') cursor++;

	/* Push this to client. */
	int s = eol ? (eol - cursor) : (int)strlen(cursor);

	if (s == 0)
		return false;

	/* Replace task name and process name by an id. */
	assert(task_name_end > task_name_start);
	int process_name_id = string_array_lookup_or_push(&data->tasks, process_name, strlen(process_name));
	int task_name_id = string_array_lookup_or_push(&data->tasks, task_name_start, task_name_end - task_name_start);

	int total_size = sizeof(process_name_id) + sizeof(task_name_id) + sizeof(pid) + sizeof(tgid) +
						  sizeof(ts) + sizeof(event_type) +
						  1 + s;

	int used = *raw_data_used;

	*out = ensure_capacity(*out, raw_data_capacity, used, total_size);

	/* Copy task name. */
	memcpy(&(*out)[used], &task_name_id, 4);
	used += 4;
	/* Copy process name. */
	memcpy(&(*out)[used], &process_name_id, 4);
	used += 4;
	/* Copy pid */
	memcpy(&(*out)[used], &pid, 4);
	used += 4;
	/* Copy tgid */
	memcpy(&(*out)[used], &tgid, 4);
	used += 4;
	/* Copy timestamp */
	memcpy(&(*out)[used], &ts, 8);
	used += 8;
	/* Copy event_type */
	memcpy(&(*out)[used], &event_type, 4);
	used += 4;

	/* Copy line. */
	memcpy(&(*out)[used], cursor, s);
	used += s;

	(*out)[used] = '\0';
	used += 1;

	*raw_data_used = used;

	return true;
}


static void* read_trace_buffer_thread(void *in) {
	char buffer[4096];
	struct activity_capture_data *data = in;
	int store_capacity = 32768;
	int store_used = 0;

	int8_t *out = NULL;
	out = realloc(out, store_capacity);

	/* Read trace buffer, one line at a time */
	struct {
		int start, count;
	} remaining = { 0, 0 };
	bool in_stacktrace = false;

	while (data->run) {
		if (remaining.count)
			memmove(buffer, &buffer[remaining.start], remaining.count);

		int n = fread(&buffer[remaining.count], 1, ARRAY_SIZE(buffer) - remaining.count, data->tracing_pipe_fd);

		/* No new bytes read. */
		if (n == 0) {
			if (in_stacktrace) {
				in_stacktrace = false;
			} else {
				struct timespec req;
				req.tv_sec = 0;
				req.tv_nsec = 10000;
				nanosleep(&req, NULL);
				continue;
			}
		} else if (n < 0) {
			printf("Error %s\n", strerror(errno));
			break;
		}

		n += remaining.count;
		remaining.start = 0;
		remaining.count = n;

		/* Split at lines boundaries. */
		int line_start = 0;
		for (int i = 0; i < n; i++) {
			if (buffer[i] == '\n') {
				int len = i - line_start;

				if (i < n - 1) {
					remaining.start = i + 1;
					remaining.count = n - remaining.start;
				} else {
					remaining.count = 0;
				}

				in_stacktrace = false;

				if (buffer[line_start] == '#') {
					printf("dropped: %.*s\n", len, buffer);
				} else if (strncmp(&buffer[line_start], " => ", 4) == 0) {
					in_stacktrace = true;
					line_start += 4;
					len -= 4;

					/* This is a stacktrace element. */
					if (store_used == 0 || strncmp(&buffer[line_start], "trace_event", strlen("trace_event")) == 0) {
						/* ignore. */
					} else {
						out = ensure_capacity(out, &store_capacity, store_used, 1 + len + 1);
						assert(out[store_used - 1] == '\0');
						store_used -= 1;

						out[store_used++] = '|';
						memcpy(&out[store_used], &buffer[line_start], len);
						store_used += len;
						out[store_used++] = '\0';
					}
				} else {
					bool ignore = memmem(&buffer[line_start], len, "<stack trace>", strlen("<stack trace>"));
					if (!ignore)
						parse_one_event(data, &buffer[line_start], len, &out, &store_used, &store_capacity);
				}

				line_start = i + 1;
			}
		}

		if (in_stacktrace)
			continue;

		pthread_mutex_lock(&data->mtx);
		if (data->event_buffer == NULL) {
			data->event_buffer = out;
			data->event_buffer_size = store_used;
			out = realloc(NULL, store_capacity);
			store_used = 0;
		}
		pthread_mutex_unlock(&data->mtx);
	}

	free(out);

	return NULL;
}

static void waves_to_json(struct umr_asic *asic, JSON_Object *out) {
	int start = -1, stop = -1;
	struct umr_wave_data *wd, *owd;
	int maj, min;
	umr_gfx_get_ip_ver(asic, &maj, &min);

	/* Scan ring for disassembly. */
	struct umr_packet_stream *stream = umr_packet_decode_ring(
		asic, NULL, asic->options.ring_name, 0, &start, &stop, UMR_RING_GUESS, NULL);

	/* Get wave data. */
	wd = umr_scan_wave_data(asic);

	JSON_Value *shaders = json_value_init_object();
	JSON_Value *waves = json_value_init_array();

	while (wd) {
		JSON_Value *wave = wave_to_json(asic, wd, maj, stream, shaders);

		json_array_append_value(json_array(waves), wave);

		owd = wd;
		wd = wd->next;
		free(owd);
	}

	json_object_set_value(out, "waves", waves);
	json_object_set_value(out, "shaders", shaders);

	if (stream)
		umr_packet_free(stream);
}

static char *get_asic_devname(struct umr_asic *asic)
{
	char *dev_name = read_file_a(SYSFS_PATH_DEBUG_DRI "%d/name", asic->instance);
	char *name = strstr(dev_name, "dev=");
	if (!name)
		goto error;
	name += strlen("dev=");
	int n = 0;
	while (!isspace(name[n]))
		n++;
	name = strndup(name, n);

error:
	free(dev_name);
	return name;
}

JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsigned *raw_data_size)
{
	JSON_Value *answer = NULL;
	const char *last_error = NULL;
	const char *command = json_object_get_string(request, "command");

	if (!command) {
		last_error = "missing command";
		goto error;
	}

	if (asics[0] == NULL) {
		init_asics();
	}

	struct umr_asic *asic = NULL;
	JSON_Object *asc = json_object_get_object(request, "asic");
	if (asc) {
		unsigned did = json_object_get_number(asc, "did");
		int instance = json_object_get_number(asc, "instance");
		for (int i = 0; !asic; i++) {
			if (asics[i] && asics[i]->did == did && asics[i]->instance == instance)
				asic = asics[i];
		}
	}

	const char *asicless_commands[] = {
		"enumerate", "ping", "tracing", "read-trace-buffer"
	};

	if (!asic) {
		bool ok = false;
		for (size_t i = 0; i < ARRAY_SIZE(asicless_commands) && !ok; i++)
			ok = strcmp(command, asicless_commands[i]) == 0;

		if (!ok) {
			last_error = "asic not found";
			goto error;
		}
	}

	if (strcmp(command, "enumerate") == 0) {
		int i = 0, j;
		answer = json_value_init_array();
		while (asics[i]) {
			JSON_Value *as = json_value_init_object ();
			json_object_set_string(json_object(as), "name", asics[i]->asicname);
			json_object_set_string(json_object(as), "pci_name", asics[i]->options.pci.name);
			json_object_set_number(json_object(as), "index", i);
			json_object_set_number(json_object(as), "instance", asics[i]->instance);
			json_object_set_number(json_object(as), "did", asics[i]->did);
			json_object_set_number(json_object(as), "family", asics[i]->family);
			json_object_set_number(json_object(as), "vram_size", asics[i]->config.vram_size);
			json_object_set_number(json_object(as), "vis_vram_size", asics[i]->config.vis_vram_size);
			json_object_set_string(json_object(as), "vbios_version", asics[i]->config.vbios_version);
			JSON_Value *fws = json_value_init_array();
			j = 0;
			while (asics[i]->config.fw[j].name[0] != '\0') {
				JSON_Value *fw = json_value_init_object();
				json_object_set_string(json_object(fw), "name", asics[i]->config.fw[j].name);
				json_object_set_number(json_object(fw), "feature_version", asics[i]->config.fw[j].feature_version);
				json_object_set_number(json_object(fw), "firmware_version", asics[i]->config.fw[j].firmware_version);
				json_array_append_value(json_array(fws), fw);
				j++;
			}
			json_object_set_value(json_object(as), "firmwares", fws);

			/* Discover the rings */
			{
				JSON_Value *rings = json_value_init_array();
				char fname[256];
				struct dirent *dir;
				sprintf(fname, SYSFS_PATH_DEBUG_DRI "%d/", asics[i]->instance);
				DIR *d = opendir(fname);
				if (d) {
					while ((dir = readdir(d))) {
						if (strncmp(dir->d_name, "amdgpu_ring_", strlen("amdgpu_ring_")) == 0) {
							json_array_append_string(json_array(rings), dir->d_name);
						}
					}
					closedir(d);
				}
				json_object_set_value(json_object(as), "rings", rings);
			}

			/* PCIe link speed/width */
			{
				char fname[256];
				sprintf(fname, SYSFS_PATH_DRM "card%d/device/current_link_speed", asics[i]->instance);
				const char *content = read_file(fname);
				JSON_Value *pcie = json_value_init_object();
				if (content)
					json_object_set_string(json_object(pcie), "speed", content);
				sprintf(fname, SYSFS_PATH_DRM "card%d/device/current_link_width", asics[i]->instance);
				uint64_t width = read_sysfs_uint64(fname);
				if (width)
					json_object_set_number(json_object(pcie), "width", width);
				json_object_set_value(json_object(as), "pcie", pcie);
			}

			/* If this asic has been discovered through ip_discovery, send the dump to the client
			 * so it can recreate it.
			 */
			if (asics[i]->was_ip_discovered && ip_discovery_dumps[i]) {
				int len = strlen(ip_discovery_dumps[i]);
				json_object_set_number(json_object(as), "ip_discovery_offset", *raw_data_size);
				json_object_set_number(json_object(as), "ip_discovery_len", len);
				if (*raw_data) {
					*raw_data = realloc(*raw_data, *raw_data_size + len);
					memcpy(&((uint8_t*)*raw_data)[*raw_data_size], ip_discovery_dumps[i], len);
					*raw_data_size += len;
				} else {
					*raw_data = strdup(ip_discovery_dumps[i]);
					*raw_data_size = len;
				}
			}

			json_array_append_value(json_array(answer), as);
			i++;
		}
	} else if (strcmp(command, "ping") == 0) {
		answer = json_value_init_object();
	} else if (strcmp(command, "read") == 0) {
		const char *block = json_object_get_string(request, "block");
		struct umr_reg *r = umr_find_reg_data_by_ip(
			asic, block, json_object_get_string(request, "register"));

		if (r == NULL) {
			last_error = "unknown register";
			goto error;
		}
		unsigned count = 1;
		if (json_object_has_value(request, "count"))
			count = json_object_get_number(request, "count");

		answer = json_value_init_object();
		if (count == 1) {
			unsigned value = umr_read_reg_by_name_by_ip(asic, (char*) json_object_get_string(request, "block"), r->regname);
			json_object_set_number(json_object(answer), "value", value);
		} else {
			JSON_Value *values = json_value_init_array();
			for (unsigned i = 0; i < count; i++) {
				unsigned v = umr_read_reg_by_name_by_ip(asic, (char*) json_object_get_string(request, "block"), r->regname);
				json_array_append_number(json_array(values), v);
			}
			json_object_set_value(json_object(answer), "value", values);
		}
	} else if (strcmp(command, "accumulate") == 0) {
		JSON_Array *regs = json_object_get_array(request, "registers");
		const int num_reg = json_array_get_count(regs);
		char *ipname = (char*) json_object_get_string(request, "block");
		struct umr_reg **reg = malloc(num_reg * sizeof(struct umr_reg*));
		for (int i = 0; i < num_reg; i++) {
			reg[i] = umr_find_reg_data_by_ip(asic, ipname, json_array_get_string(regs, i));
			if (!reg[i]) {
				printf("Inconsistent state detected: server and client disagree on ASIC definition.\n");
				free(reg);
				goto error;
			}
		}

		answer = json_value_init_object();
		int step_ms = json_object_get_number(request, "step_ms");
		int period_ms = json_object_get_number(request, "period");
		unsigned *counters = calloc(32 * num_reg, sizeof(unsigned));

		/* Disable GFXOFF */
		if (asic->fd.gfxoff >= 0) {
			uint32_t value = 0;
			value = write(asic->fd.gfxoff, &value, sizeof(value));
		}

		/* Get our ID. */
		char *dev_name = get_asic_devname(asic);

		JSON_Array *pids = get_active_amdgpu_clients(asic);
		/* Read fdinfo for each client. */
		JSON_Value *start = json_value_init_object();
		for (size_t i = 0; i < json_array_get_count(pids); i++) {
			JSON_Object *pid = json_object(json_array_get_value(pids, i));
			read_fdinfo(start, pid, dev_name);
		}
		char *content_before =
			read_file_a(SYSFS_PATH_DEBUG_DRI "%d/amdgpu_fence_info", asic->instance);

		struct timespec req, rem;
		int steps = period_ms / step_ms;
		for (int i = 0; i < steps; i++) {
			req.tv_sec = 0;
			req.tv_nsec = step_ms * 1000000;

			for (int j = 0; j < num_reg; j++) {
				uint64_t value = (uint64_t)asic->reg_funcs.read_reg(asic,
																	reg[j]->addr * (reg[j]->type == REG_MMIO ? 4 : 1),
																	reg[j]->type);
				for (int k = 0; k < reg[j]->no_bits; k++) {
					uint64_t v = umr_bitslice_reg_quiet(asic, reg[j], reg[j]->bits[k].regname, value);
					counters[32 * j + k] += (unsigned)v;
				}
			}

			while (nanosleep(&req, &rem) == EINTR) {
				req = rem;
			}
		}

		/* Read fdinfo for each client. */
		JSON_Value *end = json_value_init_object();
		for (size_t i = 0; i < json_array_get_count(pids); i++) {
			JSON_Object *pid = json_object(json_array_get_value(pids, i));
			read_fdinfo(end, pid, dev_name);
		}

		free(dev_name);

		/* Re-enable GFXOFF */
		if (asic->fd.gfxoff >= 0) {
			uint32_t value = 1;
			value = write(asic->fd.gfxoff, &value, sizeof(value));
		}

		JSON_Value *fences = compare_fence_infos(
			content_before,
			read_file("/sys/kernel/debug/dri/%d/amdgpu_fence_info", asic->instance));
		free(content_before);
		json_object_set_value(json_object(answer), "fences", fences);

		JSON_Value *values = json_value_init_array();
		for (int j = 0; j < num_reg; j++) {
			JSON_Value *regvalue = json_value_init_array();
			for (int k = 0; k < reg[j]->no_bits; k++) {
				JSON_Value *v = json_value_init_object();
				json_object_set_string(json_object(v), "name", reg[j]->bits[k].regname);
				json_object_set_number(json_object(v), "counter", counters[num_reg * j + k]);
				json_array_append_value(json_array(regvalue), v);
			}
			json_array_append_value(json_array(values), regvalue);
		}
		json_object_set_value(json_object(answer), "values", values);
		JSON_Object *fdinfo = json_object(json_value_init_object());
		json_object_set_value(json_object(answer), "fdinfo", json_object_get_wrapping_value(fdinfo));
		json_object_set_value(fdinfo, "start", start);
		json_object_set_value(fdinfo, "end", end);
		json_value_free(json_array_get_wrapping_value(pids));
		free(counters);
		free(reg);
	} else if (strcmp(command, "write") == 0) {
		struct umr_reg *r = umr_find_reg_data_by_ip(
			asic, json_object_get_string(request, "block"), json_object_get_string(request, "register"));

		if (r == NULL) {
			last_error = "unknown register";
			goto error;
		}

		answer = json_value_init_object();

		char *block = (char*) json_object_get_string(request, "block");
		unsigned value = json_object_get_number(request, "value");
		if (umr_write_reg_by_name_by_ip(asic, block, r->regname, value)) {
			value = umr_read_reg_by_name_by_ip(asic, block, r->regname);
		}
		json_object_set_number(json_object(answer), "value", value);
	} else if (strcmp(command, "vm-read") == 0 || strcmp(command, "vm-decode") == 0) {
		uint64_t address = json_object_get_number(request, "address");
		JSON_Value *vmidv = json_object_get_value(request, "vmid");
		uint32_t vmid = UMR_LINEAR_HUB;
		if (vmidv)
			vmid = json_number(vmidv);

		uint64_t *buf = NULL;
		unsigned size = json_object_get_number(request, "size");
		if (size % 8) {
			size += 8 - size % 8;
		}

		asic->options.verbose = 1;
		asic->mem_funcs.vm_message = dummy_printf;
		asic->mem_funcs.va_addr_decode = my_va_decode;

		memset(page_table, 0, sizeof(page_table));
		num_page_table_entries = 0;

		if (strcmp(command, "vm-read") == 0) {
			buf = malloc((sizeof(uint64_t) * size) / 8);
		} else {
			size = 4;
		}

		int r = umr_read_vram(asic, asic->options.vm_partition, vmid, address, size, buf);
		if (r && buf) {
			memset(buf, 0, size);
			num_page_table_entries = 0;
		}

		asic->mem_funcs.vm_message = NULL;
		asic->options.verbose = 0;

		answer = json_value_init_object();
		if (buf) {
			*raw_data = buf;
			*raw_data_size = size;
			json_object_set_number(json_object(answer), "values", 0 /* raw_data index */);
		}
		JSON_Value *pt = json_value_init_array();
		for (int i = 0; i < num_page_table_entries; i++) {
			JSON_Value *level = json_value_init_object();
			json_object_set_number(json_object(level), "pba", page_table[i].pba);
			if (page_table[i].type == 2)
				json_object_set_number(json_object(level), "va_mask", page_table[i].va_mask);
			json_object_set_number(json_object(level), "type", page_table[i].type);
			json_object_set_number(json_object(level), "system", page_table[i].system);
			json_object_set_number(json_object(level), "tmz", page_table[i].tmz);
			json_object_set_number(json_object(level), "mtype", page_table[i].mtype);
			json_array_append_value(json_array(pt), level);
		}
		json_object_set_value(json_object(answer), "page_table", pt);
	}
	else if (strcmp(command, "waves") == 0) {
		int resume_waves = json_object_get_boolean(request, "resume_waves");
		int disable_gfxoff = json_object_get_boolean(request, "disable_gfxoff");
		int capture_gprs = json_object_get_boolean(request, "capture_gprs");
		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));

		if (disable_gfxoff && asic->fd.gfxoff >= 0) {
			uint32_t value = 0;
			value = write(asic->fd.gfxoff, &value, sizeof(value));
		}

		asic->options.verbose = 0;
		asic->options.skip_gprs = !capture_gprs;

		int ring_is_halted = umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT, 100) == 0;

		if (ring_is_halted) {
			answer = json_value_init_object();

			if (ring_is_halted)
				waves_to_json(asic, json_object(answer));
		}

		if (resume_waves)
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME, 0);

		if (disable_gfxoff && asic->fd.gfxoff >= 0) {
			uint32_t value = 1;
			value = write(asic->fd.gfxoff, &value, sizeof(value));
		}

		if (!ring_is_halted) {
			last_error = "Failed to halt the ring (or GPU is idle?)";
			goto error;
		}
	} else if (strcmp(command, "singlestep") == 0) {
		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));

		unsigned se = (unsigned)json_object_get_number(request, "se");
		unsigned sh = (unsigned)json_object_get_number(request, "sh");
		unsigned wgp = (unsigned)json_object_get_number(request, "wgp");
		unsigned simd_id = (unsigned)json_object_get_number(request, "simd_id");
		unsigned wave_id = (unsigned)json_object_get_number(request, "wave_id");

		asic->options.skip_gprs = 0;
		asic->options.verbose = 0;

		struct umr_wave_data wd;
		umr_wave_data_init(asic, &wd);

		int r = umr_scan_wave_slot(asic, se, sh, wgp, simd_id, wave_id, &wd);
		if (r < 0) {
			last_error = "failed to scan wave slot";
			goto error;
		}

		r = umr_singlestep_wave(asic, &wd);
		if (r == -2) {
			last_error = "failed to scan wave slot after single-stepping";
			goto error;
		} else if (r == -1) {
			last_error = "failed to single-step wave";
			goto error;
		}

		answer = json_value_init_object();

		if (r == 1) {
			JSON_Value *shaders = json_value_init_object();
			JSON_Value *wave = wave_to_json(asic, &wd, 1, /* todo: stream */NULL, shaders);
			json_object_set_value(json_object(answer), "wave", wave);
			json_object_set_value(json_object(answer), "shaders", shaders);
		}
	} else if (strcmp(command, "resume-waves") == 0) {
		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));
		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME, 0);
		answer = json_value_init_object();
	} else if (strcmp(command, "ring") == 0) {
		char *ring_name = (char*)json_object_get_string(request, "ring");
		uint32_t wptr, rptr, drv_wptr, ringsize, value, *ring_data;
		int halt_waves = json_object_get_boolean(request, "halt_waves");
		enum umr_ring_type rt;
		asic->options.halt_waves = halt_waves;
		strcpy(asic->options.ring_name, ring_name);

		/* Disable gfxoff */
		value = 0;
		if (asic->fd.gfxoff >= 0)
			value = write(asic->fd.gfxoff, &value, sizeof(value));

		if (halt_waves)
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT, 100);

		struct ring_decoding_data data;
		data.ibs = json_array(json_value_init_array());
		data.open_ibs = json_array(json_value_init_array());
		data.shaders = json_array(json_value_init_array());
		data.vcns = json_array(json_value_init_array());
		data.raw_opcodes = NULL;
		data.concatenated.count = 0;
		data.concatenated.opcodes = NULL;
		data.total_ibs = 0;

		answer = json_value_init_object();

		const char *fence_info = read_file(SYSFS_PATH_DEBUG_DRI "%d/amdgpu_fence_info", asic->instance);
		JSON_Array *signaled_fences = get_rings_last_signaled_fences(fence_info, ring_name);

		ring_data = umr_read_ring_data(asic, ring_name, &ringsize);
		/* read pointers */
		ringsize /= 4;
		rptr = ring_data[0] % ringsize;
		wptr = ring_data[1] % ringsize;
		drv_wptr = ring_data[2] % ringsize;

		int start = 0, stop = ringsize;
		if (json_object_get_boolean(request, "rptr_wptr")) {
			start = rptr;
			stop = wptr;
		}

		if (!memcmp(ring_name, "sdma", 4) ||
			!memcmp(ring_name, "page", 4)) {
			rt = UMR_RING_SDMA;
		} else if (!memcmp(ring_name, "mes", 3)) {
			rt = UMR_RING_MES;
		} else if (!memcmp(ring_name, "vcn_enc", 7) ||
			!memcmp(ring_name, "vcn_unified_", 12)) {
			rt = UMR_RING_VCN_ENC;
		} else if (!memcmp(ring_name, "vcn_dec", 7)) {
			rt = UMR_RING_VCN_DEC;
		} else {
			rt = UMR_RING_PM4;
		}

		struct umr_stream_decode_ui ui;
		ui.data = &data;
		ui.rt = rt;
		ui.start_ib = ring_start_ib;
		ui.unhandled_dword = NULL;
		ui.start_opcode = ring_start_opcode;
		ui.add_field = ring_add_field;
		ui.add_shader = ring_add_shader;
		ui.add_vcn = ring_add_vcn;
		ui.add_data = ring_add_data;
		ui.unhandled = ring_unhandled;
		ui.unhandled_size = NULL;
		ui.taint = 0;
		ui.done = ring_done;

		uint32_t *lineardata = calloc(ringsize, sizeof(uint32_t));
		unsigned lineardatasize = 0;
		while (start != stop && lineardatasize < ringsize) {
			lineardata[lineardatasize++] = ring_data[3 + start];
			start = (start + 1) % ringsize;
		}

		struct umr_packet_stream *str = NULL;

		if (lineardatasize)
			str = umr_packet_decode_buffer(asic, &ui, 0, 0, lineardata, lineardatasize, rt, NULL);

		free(lineardata);

		if (str) {
			umr_packet_disassemble_stream(str, 0, 0, 0, 0, ~0UL, 1, 0);
			json_object_set_value(json_object(answer), "shaders", json_array_get_wrapping_value(data.shaders));
			json_object_set_value(json_object(answer), "vcns", json_array_get_wrapping_value(data.vcns));
			json_object_set_value(json_object(answer), "ring", data.ring);
			json_object_set_value(json_object(answer), "ibs", json_array_get_wrapping_value(data.ibs));
			json_object_set_number(json_object(answer), "ring_type", rt);
			umr_packet_free(str);

			*raw_data_size = data.concatenated.count * sizeof(uint32_t);
			*raw_data = data.concatenated.opcodes; /* will be freed later */
		} else {
			if (lineardatasize)
				printf("umr_packet_decode_buffer error.\n");
		}

		free(data.raw_opcodes);

		free(ring_data);
		json_object_set_number(json_object(answer), "read_ptr", rptr);
		json_object_set_number(json_object(answer), "write_ptr", wptr);
		json_object_set_number(json_object(answer), "driver_write_ptr", drv_wptr);
		json_object_set_number(json_object(answer), "last_signaled_fence",
		json_object_get_number(json_object(json_array_get_value(signaled_fences, 0)), "value"));

		if (halt_waves)
			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME, 0);
		/* Reenable gfxoff */
		value = 1;
		if (asic->fd.gfxoff >= 0)
			value = write(asic->fd.gfxoff, &value, sizeof(value));

	} else if (strcmp(command, "power") == 0) {
		const char *profiles[] = {
			"auto",
			"low",
			"high",
			"manual",
			"profile_standard",
			"profile_min_sclk",
			"profile_min_mclk",
			"profile_peak",
			NULL
		};

		answer = json_value_init_object();
		JSON_Value *valid = json_value_init_array();
		for (int i = 0; profiles[i]; i++)
			json_array_append_string(json_array(valid), profiles[i]);
		json_object_set_value(json_object(answer), "profiles", valid);
		const char *write = json_object_get_string(request, "set");
		char path[512];
		sprintf(path, SYSFS_PATH_DRM "card%d/device/power_dpm_force_performance_level", asic->instance);
		if (!write) {
			char *content = read_file(path);
			size_t s = strlen(content);

			if (s > 0 && content[s - 1] == '\n')
				content[s - 1] = '\0';

			int current = -1;
			for (int i = 0; profiles[i] && current < 0; i++) {
				if (!strcmp(content, profiles[i]))
					current = i;
			}
			json_object_set_string(json_object(answer), "current", current >= 0 ? profiles[current] : "");
		} else {
			FILE *fd = fopen(path, "w");
			if (fd) {
				fwrite(write, 1, strlen(write), fd);
				fclose(fd);
				json_object_set_string(json_object(answer), "current", write);
			} else {
				json_object_set_string(json_object(answer), "current", "");
			}
		}
	} else if (strcmp(command, "sensors") == 0) {
		static struct power_bitfield p_info[] = {
			{"GFX_SCLK", 0, AMDGPU_PP_SENSOR_GFX_SCLK, SENSOR_D100 },
			{"GFX_MCLK", 0, AMDGPU_PP_SENSOR_GFX_MCLK, SENSOR_D100 },
			{"AVG_GPU",  0, AMDGPU_PP_SENSOR_GPU_POWER, SENSOR_WAIT },
			{"GPU_LOAD", 0, AMDGPU_PP_SENSOR_GPU_LOAD, SENSOR_IDENTITY },
			{"MEM_LOAD", 0, AMDGPU_PP_SENSOR_MEM_LOAD, SENSOR_IDENTITY },
			{NULL, 0, 0, 0},
		};
		answer = json_value_init_object();
		if (asic->fd.sensors) {
			uint32_t gpu_power_data[32];
			JSON_Array *values = json_array(json_value_init_array());
			for (int i = 0; p_info[i].regname; i++){
				int size = 4;
				p_info[i].value = 0;
				gpu_power_data[0] = 0;
				umr_read_sensor(asic, p_info[i].sensor_id, (uint32_t*)&gpu_power_data[0], &size);
				if (gpu_power_data[0] != 0){
					p_info[i].value = gpu_power_data[0];
					p_info[i].value = parse_sensor_value(p_info[i].map, p_info[i].value);
				}
				JSON_Object *v = json_object(json_value_init_object());
				json_object_set_string(v, "name", p_info[i].regname);
				json_object_set_number(v, "value", p_info[i].value);

				/* Determine min/max */
				{
					int min, max;
					if (i == 0) {
						read_clock_min_max(asic, "sclk", &min, &max);
						json_object_set_string(v, "unit", "MHz");
					} else if (i == 1) {
						read_clock_min_max(asic, "mclk", &min, &max);
						json_object_set_string(v, "unit", "MHz");
					} else if (i == 2) {
						min = 0;
						max = 300;
						json_object_set_string(v, "unit", "W");
					} else if (i >= 3 && i <= 4) {
						min = 0;
						max = 100;
						json_object_set_string(v, "unit", "%");
					} else {
						min = 15;
						max = 120;
						json_object_set_string(v, "unit", "°C");
					}
					json_object_set_number(v, "min", min);
					json_object_set_number(v, "max", max);
				}

				json_array_append_value(values, json_object_get_wrapping_value(v));
			}
			json_object_set_value(json_object(answer), "values", json_array_get_wrapping_value(values));
		}
	} else if (strcmp(command, "runtimepm") == 0) {
		const char *int_attr[] = {
			"suspended_time",
			"active_time",
			"usage",
		};
		const char *str_attr[] = {
			"control",
			"runtime_enabled",
			"runtime_status",
		};
		answer = json_value_init_object();
		for (size_t i = 0; i < ARRAY_SIZE(int_attr); i++) {
			uint64_t v = read_sysfs_uint64(SYSFS_PATH_DRM "card%d/device/power/runtime_%s",
													 asic->instance, int_attr[i]);
			json_object_set_number(json_object(answer), int_attr[i], (double)v);
		}
		for (size_t i = 0; i < ARRAY_SIZE(str_attr); i++) {
			const char *s = read_file(SYSFS_PATH_DRM "card%d/device/power/%s",
											  asic->instance, str_attr[i]);
			size_t len = strlen(s);
			if (len > 0) {
				json_object_set_string_with_len(
					json_object(answer), str_attr[i], s, strlen(s) - 1);
			}
		}
	} else if (strcmp(command, "wakeup") == 0) {
		char path[PATH_MAX];
		sprintf(path, SYSFS_PATH_DRM "card%d/device/power/control", asic->instance);
		FILE *fd = fopen(path, "w");
		if (fd) {
			/* Disable runtimepm */
			fprintf(fd, "on");
			fclose(fd);
		}
		fd = fopen(path, "w");
		if (fd) {
			/* Re-enable runtimepm */
			fprintf(fd, "auto\n");
			fclose(fd);
		}
		answer = json_value_init_object();
	} else if (strcmp(command, "hwmon") == 0) {
		char dname[256], fname[1024];
		int values[4];

		if (json_object_has_value(request, "set")) {
			JSON_Object *set = json_object_get_object(request, "set");
			int fan_idx = json_object_get_number(set, "hwmon");
			int new_mode = json_object_get_number(set, "mode");
			if (new_mode >= 0) {
				snprintf(fname, sizeof(fname)-1, SYSFS_PATH_DRM "card%d/device/hwmon/hwmon%d/pwm1_enable", asic->instance, fan_idx);
				FILE *fd = fopen(fname, "w");
				if (fd) {
					fprintf(fd, "%d", new_mode);
					fclose(fd);
				}
			}
			int new_pwm = json_object_get_number(set, "value");
			if (new_pwm >= 0) {
				snprintf(fname, sizeof(fname)-1, SYSFS_PATH_DRM "card%d/device/hwmon/hwmon%d/pwm1", asic->instance, fan_idx);
				FILE *fd = fopen(fname, "w");
				if (fd) {
					fprintf(fd, "%d", new_pwm);
					fclose(fd);
				}
			}
		}

		const char * files[] = { "pwm1_enable", "fan1_min", "fan1_max", "pwm1" };
		answer = json_value_init_object();
		JSON_Array *hwmons = json_array(json_value_init_array());

		struct dirent *dir;
		sprintf(dname, SYSFS_PATH_DRM "card%d/device/hwmon/", asic->instance);
		DIR *d = opendir(dname);
		if (d) {
			while ((dir = readdir(d))) {
				if (strncmp(dir->d_name, "hwmon", 5) == 0) {
					int hwmon_id = 0;
					if (sscanf(dir->d_name + 5, "%d", &hwmon_id) == 1) {
						int r = 0;

						JSON_Object *hwmon = json_object(json_value_init_object());
						/* Read fan1 data */
						for (int i = 0; i < 4 && r == i; i++) {
							r += sscanf(read_file("%s/%s/%s", dname, dir->d_name, files[i]),
											"%d", &values[i]);
						}
						if (r == 4) {
							JSON_Value *fan = json_value_init_object();
							json_object_set_number(json_object(fan), "mode", values[0]);
							json_object_set_number(json_object(fan), "min", values[1]);
							json_object_set_number(json_object(fan), "max", values[2]);
							json_object_set_number(json_object(fan), "value", values[3]);
							json_object_set_number(hwmon, "id", hwmon_id);
							json_object_set_value(hwmon, "fan", fan);
						} else {
							json_value_free(json_object_get_wrapping_value(hwmon));
							continue;
						}

						json_array_append_value(hwmons, json_object_get_wrapping_value(hwmon));

						JSON_Array *temps = json_array(json_value_init_array());
						/* Read temp data */
						for (int i = 1;; i++) {
							int r = 0;
							r += sscanf(read_file("%s/%s/temp%d_input", dname, dir->d_name, i),
											"%d", &values[0]);
							r += sscanf(read_file("%s/%s/temp%d_crit", dname, dir->d_name, i),
											"%d", &values[1]);
							if (r == 2) {
								const char *label = read_file("%s/%s/temp%d_label", dname, dir->d_name, i);

								JSON_Object *temp = json_object(json_value_init_object());
								json_object_set_string_with_len(temp, "label", label, strlen(label) - 1);
								json_object_set_number(temp, "value", values[0]);
								json_object_set_number(temp, "critical", values[1]);
								json_array_append_value(temps, json_object_get_wrapping_value(temp));
							} else {
								break;
							}
						}
						if (json_array_get_count(temps))
							json_object_set_value(hwmon, "temp", json_array_get_wrapping_value(temps));
						else
							json_value_free(json_array_get_wrapping_value(temps));

					}
				}
			}
			closedir(d);
			if (json_array_get_count(hwmons))
				json_object_set_value(json_object(answer), "hwmons", json_array_get_wrapping_value(hwmons));
		}

	} else if (strcmp(command, "pp_features") == 0) {
		char path[512];
		sprintf(path, SYSFS_PATH_DRM "card%d/device/pp_features", asic->instance);
		if (!json_object_has_value(request, "set")) {
			char *content = read_file(path);
			if (content && strlen(content) > 1) {
				answer = json_object_get_wrapping_value(parse_pp_features_sysfs_file(content));
			} else {
				last_error = "unsupported";
				goto error;
			}
		} else {
			FILE *fd = fopen(path, "w");
			if (fd) {
				char tmp[64];
				sprintf(tmp, "0x%lx", (uint64_t)json_object_get_number(request, "set"));
				fwrite(tmp, 1, strlen(tmp), fd);
				fclose(fd);
			}

			char *content = read_file(path);
			answer = json_object_get_wrapping_value(parse_pp_features_sysfs_file(content));
		}
	} else if (!strcmp(command, "memory-usage")) {
		const char *names[] = {
			"vram", "vis_vram", "gtt", NULL
		};
		const char *suffixes[] = {
			"total", "used", NULL
		};
		char path[256];

		answer = json_value_init_object();

		for (int i = 0; names[i]; i++) {
			JSON_Value *m = json_value_init_object();
			for (int j = 0; suffixes[j]; j++) {
				sprintf(path, SYSFS_PATH_DRM "card%d/device/mem_info_%s_%s", asic->instance, names[i], suffixes[j]);
				uint64_t v = read_sysfs_uint64(path);
				json_object_set_number(json_object(m), suffixes[j], v);
			}
			json_object_set_value(json_object(answer), names[i], m);
		}

		json_object_set_value(json_object(answer), "apps",  json_array_get_wrapping_value(get_bo_infos(asic)));
	} else if (!strcmp(command, "drm-counters")) {
		uint64_t values[3] = { 0 };
		umr_query_drm(asic, 0x0f /* AMDGPU_INFO_NUM_BYTES_MOVED */, &values[0], sizeof(values[0]));
		umr_query_drm(asic, 0x18 /* AMDGPU_INFO_NUM_EVICTIONS */, &values[1], sizeof(values[0]));
		umr_query_drm(asic, 0x1E /* AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS */, &values[2], sizeof(values[0]));
		answer = json_value_init_object();
		json_object_set_number(json_object(answer), "bytes-moved", (double)values[0]);
		json_object_set_number(json_object(answer), "num-evictions", (double)values[1]);
		json_object_set_number(json_object(answer), "cpu-page-faults", (double)values[2]);
	} else if (!strcmp(command, "evict")) {
		int type = json_object_get_number(request, "type");
		const char *mem = type == 0 ? "vram" : "gtt";
		read_file(SYSFS_PATH_DEBUG_DRI "%d/amdgpu_evict_%s", asic->instance, mem);
	} else if (!strcmp(command, "kms")) {
		const char *content = read_file(SYSFS_PATH_DEBUG_DRI "%d/framebuffer", asic->instance);
		JSON_Array *framebuffers = parse_kms_framebuffer_sysfs_file(NULL, content);

		content = read_file(SYSFS_PATH_DEBUG_DRI "%d/state", asic->instance);
		JSON_Object *state = parse_kms_state_sysfs_file(content);

		answer = json_object_get_wrapping_value(state);
		json_object_set_value(json_object(answer), "framebuffers", json_array_get_wrapping_value(framebuffers));

		/* Parse interesting DC registers */
		JSON_Array *crtcs = json_object_get_array(state, "crtcs");
		for (int i = 0; i < (int)json_array_get_count(crtcs); i++) {
			JSON_Object *crtc = json_object(json_array_get_value(crtcs, i));
			if (json_object_get_boolean(crtc, "active")) {
				char reg_name[256];
				sprintf(reg_name, "mmHUBPREQ%d_DCSURF_SURFACE_CONTROL", i);
				struct umr_reg *r = umr_find_reg_by_name(asic, reg_name, NULL);
				if (r) {
					uint64_t value = umr_read_reg_by_name(asic, reg_name);
					int tmz = umr_bitslice_reg(asic, r, "PRIMARY_SURFACE_TMZ", value);
					int dcc = umr_bitslice_reg(asic, r, "PRIMARY_SURFACE_DCC_EN", value);
					json_object_set_number(crtc, "tmz", tmz);
					json_object_set_number(crtc, "dcc", dcc);
				}
			}
		}

		char path[PATH_MAX];
		sprintf(path, SYSFS_PATH_DEBUG_DRI "%d/amdgpu_dm_visual_confirm", asic->instance);
		if (json_object_has_value(request, "dm_visual_confirm")) {
			FILE *fd = fopen(path, "w");
			if (fd) {
				const char *v = json_object_get_boolean(request, "dm_visual_confirm") ? "1" : "0";
				fwrite(v, 1, 1, fd);
				fclose(fd);
			}
		}
		json_object_set_number(json_object(answer), "dm_visual_confirm", read_sysfs_uint64(path));
	} else if (strcmp(command, "tracing") == 0) {
		if (!events_tracing_helper(json_object_get_number(request, "mode"),
								   json_object_get_boolean(request, "verbose"),
								   asic, request)) {
			last_error = "failed to enable trace events";
			goto error;
		}
		answer = json_value_init_object();
	} else if (strcmp(command, "read-trace-buffer") == 0) {
		answer = json_value_init_object();

		if (__sensor_data) {
			pthread_mutex_lock(&__sensor_data->mtx);
			if (__sensor_data->event_buffer) {
				*raw_data = __sensor_data->event_buffer;
				*raw_data_size = __sensor_data->event_buffer_size;
				JSON_Array* names = json_array(json_value_init_array());
				for (int i = 0; i < __sensor_data->tasks.len_off.used; i++) {
					int off = __sensor_data->tasks.len_off.ptr[i].offset;
					int len = __sensor_data->tasks.len_off.ptr[i].len;
					if (json_array_append_string_with_len(names, &__sensor_data->tasks.strings.ptr[off], len) != JSONSuccess) {
						/* Oops... append a dummy string to not break indices */
						json_array_append_string(names, "unknown");
					}
				}
				json_object_set_value(json_object(answer), "names", json_array_get_wrapping_value(names));

				if (__sensor_data->client_names) {
					JSON_Array* drm_clients = json_array(json_value_init_array());
					for (int i = 0; asics[i]; i++)
						parse_drm_clients(asics[i], drm_clients);
					json_object_set_value(json_object(answer), "drm_clients", json_array_get_wrapping_value(drm_clients));
				}

				__sensor_data->event_buffer = NULL;
				__sensor_data->event_buffer_size = 0;
			}
			json_object_set_number(json_object(answer), "lost_events", __sensor_data->lost_events);
			pthread_mutex_unlock(&__sensor_data->mtx);
		}
	} else if (!strcmp(command, "gem-info")) {
		answer = json_value_init_object();
		JSON_Array *apps = get_bo_infos(asic);

		#if CAN_IMPORT_BO
		enrich_bo_data(asic, apps);
		#endif

		json_object_set_value(json_object(answer), "apps", json_array_get_wrapping_value(apps));

		char *content = read_file(SYSFS_PATH_DEBUG_DRI "%d/framebuffer", asic->instance);
		JSON_Array *framebuffers = parse_kms_framebuffer_sysfs_file(asic, content);
		json_object_set_value(json_object(answer), "framebuffers", json_array_get_wrapping_value(framebuffers));
	#if CAN_IMPORT_BO
	} else if (!strcmp(command, "peak-bo")) {
		answer = json_value_init_object();

		char *error;
		if (json_object_has_value(request, "handle"))
			error = peak_bo_using_metadata(asic, json_object_get_number(request, "pid"),
										   json_object_get_number(request, "gpu-fd"),
										   json_object_get_number(request, "handle"),
										   answer, raw_data, raw_data_size);
		else if (json_object_has_value(request, "metadata"))
			error = peak_bo_using_fb_metadata(asic,
											  json_object(json_object_get_value(request, "metadata")),
											  answer, raw_data, raw_data_size);
		else
			error = "Invalid peak-bo request";

		if (error) {
			last_error = error;
			goto error;
		}
	#endif
	} else {
		last_error = "unknown command";
		goto error;
	}

	JSON_Value *out = json_value_init_object();
	json_object_set_value(json_object(out), "answer", answer);
	json_object_set_value(json_object(out), "request", json_object_get_wrapping_value(request));
	json_object_set_boolean(json_object(out), "has_raw_data", *raw_data != NULL && *raw_data_size);
	return out;

error:
	answer = json_value_init_object();
	json_object_set_string(json_object(answer), "error", last_error);
	json_object_set_value(json_object(answer), "request", json_object_get_wrapping_value(request));
	json_object_set_boolean(json_object(answer), "has_raw_data", false);
	return answer;
}
