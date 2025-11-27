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
#include "umr.h"
#include <stdlib.h>
#include <gbm.h>
#include <drm_fourcc.h>
#include <amdgpu_drm.h>
#include <xf86drm.h>
#include <amdgpu.h>
#include <xf86drmMode.h>
#include <sys/mman.h>

#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>
#define EGL_EGLEXT_PROTOTYPES
#include <EGL/egl.h>
#include <EGL/eglext.h> 
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>

#include <sys/syscall.h>

#include "parson.h"
#define QOI_IMPLEMENTATION
#include "qoi/qoi.h"

const char *fullscreen_vs =
	"#version 320 es\n"
	"precision highp float;\n"
	"out vec2 texcoord;\n"
    "void main() {\n"
    "    const vec2 uv[4] = vec2[](\n"
    "        vec2(0, 0),\n"
    "        vec2(1, 0),\n"
    "        vec2(0, 1),\n"
    "        vec2(1, 1)\n"
    "    );\n"
    "    texcoord = uv[gl_VertexID];\n"
    "    gl_Position = vec4(vec2(-1.0, -1.0) + uv[gl_VertexID] * vec2(2.0, 2.0), 0.0, 1.0);\n"
    "}\n";

const char *fullscreen_fs =
	"#version 320 es\n"
	"precision highp float;\n"
	"centroid in vec2 texcoord;\n"
	"uniform sampler2D tex;\n"
	"out vec4 fragColor;\n"
	"void main() {\n"
	"  fragColor = texture(tex, texcoord);\n"
   "}";

static
void* read_gl_tex_as_rgba(GLuint texture, int width, int height) {
	GLuint fbo = 0, tex = 0, vao = 0, fs = 0, vs = 0, prog = 0;
	void *pixels = NULL;

	glGenTextures(1, &tex);

	/* Create a FBO */
	glGenFramebuffers(1, &fbo);
	glBindTexture(GL_TEXTURE_2D, tex);
	glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGBA8, width, height);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glBindFramebuffer(GL_FRAMEBUFFER, fbo);
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, tex, 0);

	fs = glCreateShader(GL_FRAGMENT_SHADER);
	vs = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(fs, 1, &fullscreen_fs, NULL);
	glShaderSource(vs, 1, &fullscreen_vs, NULL);
	glCompileShader(fs);
	glCompileShader(vs);
	prog = glCreateProgram();
	glAttachShader(prog, fs);
	glAttachShader(prog, vs);

	glGenVertexArrays(1, &vao);
	glBindVertexArray(vao);

	glLinkProgram(prog);

	if (glGetError() != GL_NO_ERROR)
		goto end;

	glUseProgram(prog);

	glActiveTexture(GL_TEXTURE0);
	glBindTexture(GL_TEXTURE_2D, texture);
	glUniform1i(glGetUniformLocation(prog, "tex"), 0);

	glViewport(0, 0, width, height);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

	pixels = malloc(width * height * 4);

	glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, pixels);

	glBindFramebuffer(GL_FRAMEBUFFER, 0);

end:
	if (vao)
		glDeleteVertexArrays(1, &vao);
	if (fbo)
		glDeleteFramebuffers(1, &fbo);
	if (tex)
		glDeleteTextures(1, &tex);
	if (fs)
		glDeleteShader(fs);
	if (vs)
		glDeleteShader(vs);
	if (prog)
		glDeleteProgram(prog);

	return pixels;
}

static void read_size_from_md(struct umr_asic *asic, unsigned *metadata,
							  int *width, int *height)
{
	if (asic->family >= FAMILY_NV) {
		*width = (((metadata[2 + 1] >> 30) & 0x3) | ((metadata[2 + 2] & 0xFFF) << 2)) + 1;
		*height = ((metadata[2 + 2] >> 14) & 0x3FFF) + 1;
	} else {
		*width = (metadata[2 + 2] & 0x3FFF) + 1;
		*height = ((metadata[2 + 2] >> 14) & 0x3FFF) + 1;
	}
}

static bool check_bo_metadata(uint32_t gpu_fd, uint32_t bo_handle, struct drm_amdgpu_gem_metadata *metadata)
{
	int r;
	metadata->handle = bo_handle;
	metadata->op = AMDGPU_GEM_METADATA_OP_GET_METADATA;

	r = drmCommandWriteRead(gpu_fd, DRM_AMDGPU_GEM_METADATA, metadata, sizeof(*metadata));
	if (r)
		return false;

	uint32_t md_version = metadata->data.data[0] & 0xffff;
	uint32_t md_flags = metadata->data.data[0] >> 16;

	return metadata->data.data_size_bytes &&
		   md_version > 2 && (md_flags & 1u);
}

struct bo_info {
	uint32_t handle;
	uint64_t size;
	uint64_t tiling_info;
	uint64_t alloc_flags;
	int width, height;
	uint32_t format;
	uint32_t swizzle;
};

static void check_peak_bo_metadata(struct umr_asic *asic, int gpu_fd, int bo_count, struct bo_info *bos_info)
{
	int r;

	for (int j = 0; j < bo_count; j++) {
		struct drm_amdgpu_gem_op gem_op = { 0 };
		struct drm_amdgpu_gem_create_in bo_info = { 0 };

		/* Validate size. */
		gem_op.handle = bos_info[j].handle;
		gem_op.op = AMDGPU_GEM_OP_GET_GEM_CREATE_INFO;
		gem_op.value = (uintptr_t)&bo_info;

		r = drmCommandWriteRead(gpu_fd, DRM_AMDGPU_GEM_OP,
								&gem_op, sizeof(gem_op));

		if (r || bo_info.bo_size != bos_info[j].size)
			continue;

		/* Check metadata. */
		struct drm_amdgpu_gem_metadata metadata;
		if (!check_bo_metadata(gpu_fd, bos_info[j].handle, &metadata))
			continue;

		bos_info[j].alloc_flags = bo_info.domain_flags;
		bos_info[j].tiling_info = metadata.data.tiling_info;
		read_size_from_md(asic, metadata.data.data, &bos_info[j].width, &bos_info[j].height);
		bos_info[j].swizzle = metadata.data.tiling_info & 0x1f;

		if (asic->family < FAMILY_NV)
			bos_info[j].format = (metadata.data.data[2 + 1] >> 20) & 0x3f;
		else
			bos_info[j].format = (metadata.data.data[2 + 1] >> 20) & 0x1FF;
	}
}

static char * peak_bo(struct umr_asic *asic, int dmabuf_fd,
				      int width, int height, unsigned fourcc,
				      uint64_t modifier, int nplanes,
				      unsigned *offsets, unsigned *pitches,
				      void **raw_data, unsigned *size)
{
	char pci_path[512];
	sprintf(pci_path, "/dev/dri/by-path/pci-%s-render", asic->options.pci.name);
	int fd = open(pci_path, O_RDWR | O_CLOEXEC);
	struct gbm_device *gbm = gbm_create_device(fd);
	EGLDisplay display = eglGetPlatformDisplay (EGL_PLATFORM_GBM_MESA, gbm, NULL);
	eglInitialize(display, NULL, NULL);
	EGLConfig config;
	EGLint num_config;
	EGLint const attribute_list_config[] = {
		EGL_RED_SIZE, 8,
		EGL_GREEN_SIZE, 8,
		EGL_BLUE_SIZE, 8,
		EGL_NONE
	};
	eglChooseConfig(display, attribute_list_config, &config, 1, &num_config);
	eglBindAPI(EGL_OPENGL_ES_API);
	EGLint const attrib_list[] = {
		EGL_CONTEXT_MAJOR_VERSION, 3,
		EGL_NONE
	};
	EGLContext context = eglCreateContext(display, config, EGL_NO_CONTEXT, attrib_list);
	if (context == EGL_NO_CONTEXT) {
		gbm_device_destroy(gbm);
		close(fd);
		return "EGL init failure";
	}

	eglMakeCurrent (display, EGL_NO_SURFACE, EGL_NO_SURFACE, context);

	const int base_attrib_cnt = 3;
	const int per_plane_attrib_cnt = 5;
	int nattrib = 0;
	EGLAttrib *attrs = alloca(
		(base_attrib_cnt + per_plane_attrib_cnt * 3) * 2 * sizeof(EGLAttrib));

	attrs[nattrib++] = EGL_WIDTH;
	attrs[nattrib++] = width;
	attrs[nattrib++] = EGL_HEIGHT;
	attrs[nattrib++] = height;
	attrs[nattrib++] = EGL_LINUX_DRM_FOURCC_EXT;
	attrs[nattrib++] = fourcc;

	/* The other attribs are per-plane. */
	if (modifier == DRM_FORMAT_MOD_INVALID) {
		attrs[nattrib++] = EGL_DMA_BUF_PLANE0_FD_EXT;
		attrs[nattrib++] = dmabuf_fd;
		attrs[nattrib++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
		attrs[nattrib++] = 0;
		attrs[nattrib++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
		attrs[nattrib++] = pitches[0];
	} else {
		for (int i = 0; i < nplanes; i++) {
			attrs[nattrib++] = EGL_DMA_BUF_PLANE0_FD_EXT + 3 * i;
			attrs[nattrib++] = dmabuf_fd;
			attrs[nattrib++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT + 3 * i;
			attrs[nattrib++] = offsets[i];
			attrs[nattrib++] = EGL_DMA_BUF_PLANE0_PITCH_EXT + 3 * i;
			attrs[nattrib++] = pitches[i];

			attrs[nattrib++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT + 2 * i;
			attrs[nattrib++] = modifier & 0xffffffff;
			attrs[nattrib++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT + 2 * i;
			attrs[nattrib++] = modifier >> 32;
		}
	}
	attrs[nattrib++] = EGL_NONE;

	EGLImage image = eglCreateImage(display,
		NULL,
		EGL_LINUX_DMA_BUF_EXT,
		(EGLClientBuffer)NULL,
		attrs);

	if (image == EGL_NO_IMAGE) {
		/* The 'modifier' might be incorrect: we get this information from the kernel,
		 * but if the userspace application doesn't use modifier, amdgpu will infer the
		 * modifier matching the layout being used.
		 * So if the eglCreateImage call failed, try again without the modifier.
		 */
		if (modifier != DRM_FORMAT_MOD_INVALID) {
			/* Remove the modifier attribs. */
			for (int a = 12; a < nattrib; a++)
				attrs[a] = EGL_NONE;
			image = eglCreateImage(display,
				NULL,
				EGL_LINUX_DMA_BUF_EXT,
				(EGLClientBuffer)NULL,
				attrs);
		}
	}

	if (image == EGL_NO_IMAGE)
		return "EGL failure (unhandled format?)";
	PFNGLEGLIMAGETARGETTEXTURE2DOESPROC imageTargetTexture2DProc = (PFNGLEGLIMAGETARGETTEXTURE2DOESPROC)eglGetProcAddress("glEGLImageTargetTexture2DOES");
	if (!imageTargetTexture2DProc)
	    return "EGL failure (glEGLImageTargetTexture2DOES not available from extension)";

	GLuint tex[2];
	glGenTextures(2, tex);
	glBindTexture(GL_TEXTURE_EXTERNAL_OES, tex[0]);
	imageTargetTexture2DProc(GL_TEXTURE_EXTERNAL_OES, image);
	glTexParameteri(GL_TEXTURE_EXTERNAL_OES, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_EXTERNAL_OES, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

	glBindTexture(GL_TEXTURE_2D, tex[1]);
	if (fourcc == DRM_FORMAT_XRGB2101010) {
		glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGB10, width, height);
	} else if (fourcc == DRM_FORMAT_ARGB2101010) {
		glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGB10_A2, width, height);
	} else if (fourcc == DRM_FORMAT_XRGB8888) {
		glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGB8, width, height);
	} else if (fourcc == DRM_FORMAT_R8) {
		glTexStorage2D(GL_TEXTURE_2D, 1, GL_R8, width, height);
	} else {
		/* default is DRM_FORMAT_ARGB8888 */
		glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGBA8, width, height);
	}
	if (glGetError() != GL_NO_ERROR)
		return "glTexStorage2D failed";

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

	glCopyImageSubData(tex[0], GL_TEXTURE_EXTERNAL_OES, 0,
					   0, 0, 0,
					   tex[1], GL_TEXTURE_2D, 0,
					   0, 0, 0,
					   width, height, 1);
	if (glGetError() != GL_NO_ERROR)
		return "glCopyImageSubData failed";

	void *pixels = read_gl_tex_as_rgba(tex[1], width, height);

	eglMakeCurrent (display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
	eglDestroyImage(display, image);
	eglTerminate(display);

	gbm_device_destroy(gbm);
	close(fd);

	if (glGetError() != GL_NO_ERROR) {
		free(pixels);
		return "Error while downloading the pixels";
	} else {
		int out_len;
		qoi_desc desc;
		desc.width = width;
		desc.height = height;
		desc.channels = 4;
		desc.colorspace = QOI_LINEAR;
		*raw_data = qoi_encode(pixels, &desc, &out_len);
		*size = out_len;
	}

	free(pixels);
	return NULL;
}

static
char * peak_bo_using_metadata(struct umr_asic *asic, unsigned pid, int remote_gpu_fd, unsigned kms_handle,
							  JSON_Value *answer, void **raw_data, unsigned *size)
{
	uint64_t modifier;
	int width, height, dmabuf_fd;
	int r, stride = 0;
	int gpu_fd = -1;

	int pid_fd = syscall(SYS_pidfd_open, pid, 0);
	if (pid_fd < 0)
		return "SYS_pidfd_open failed";

	gpu_fd = syscall(SYS_pidfd_getfd, pid_fd, remote_gpu_fd, 0);
	if (gpu_fd < 0) {
		close(pid_fd);
		return "Failed to import GPU fd";
	}

	/* Try to import the handle as a dmabuf. Since handle are just integers,
	 * it's possible that this succeeds but that the bo isn't the one we're
	 * looking for.
	 */
	r = drmPrimeHandleToFD(gpu_fd, kms_handle, DRM_CLOEXEC | DRM_RDWR, &dmabuf_fd);
	if (r) {
		close(pid_fd);
		close(gpu_fd);
		return "Handle to dmabuf fd failed";
	}

	/* Query metadata. */
	struct drm_amdgpu_gem_metadata metadata;
	if (!check_bo_metadata(gpu_fd, kms_handle, &metadata)) {
		close(dmabuf_fd);
		close(gpu_fd);
		close(pid_fd);
		return "Invalid metadata";
	}

	read_size_from_md(asic, metadata.data.data, &width, &height);
	if (metadata.data.data_size_bytes > 11 * 4) {
		modifier = (uint64_t)metadata.data.data[11] << 32 | metadata.data.data[10];
	} else {
		stride = metadata.data.data[10];
		modifier = DRM_FORMAT_MOD_INVALID;
	}

	/* Override fourcc for a couple of known formats. */
	unsigned fourcc = DRM_FORMAT_ARGB8888;
	if (asic->family < FAMILY_NV) {
		unsigned format = (metadata.data.data[2 + 1] >> 20) & 0x3f;
		if (format == 9)
			fourcc = DRM_FORMAT_XRGB2101010;
		else if (format == 1)
			fourcc = DRM_FORMAT_R8;
	} else {
		unsigned format = (metadata.data.data[2 + 1] >> 20) & 0x1FF;
		if (format >= 50 && format <= 55) /* GFX10_FORMAT_2_10_10_10_* */
			fourcc = DRM_FORMAT_XRGB2101010;
		else if (format >= 1 && format <= 6)
			fourcc = DRM_FORMAT_R8;
	}

	int nplanes = 1;

	unsigned *offsets = alloca(3 * sizeof(unsigned));
	unsigned *pitches = alloca(3 * sizeof(unsigned));
	if (modifier == DRM_FORMAT_MOD_INVALID) {
		offsets[0] = 0;
		pitches[0] = stride;
	} else {
		nplanes = metadata.data.data[12];
		for (int i = 0; i < nplanes; i++) {
			offsets[i] = metadata.data.data[13 + 2 * i];
			pitches[i] = metadata.data.data[13 + 2 * i + 1];
		}
	}

	void *error = NULL;
	error = peak_bo(asic, dmabuf_fd,
					width, height, fourcc, modifier,
					nplanes,
					offsets, pitches,
					raw_data, size);
	if (error == NULL) {
		json_object_set_number(json_object(answer), "width", width);
		json_object_set_number(json_object(answer), "height", height);
	}
	close(dmabuf_fd);
	close(gpu_fd);
	close(pid_fd);
	return error;
}

static
char * peak_bo_using_fb_metadata(struct umr_asic *asic, JSON_Object *md,
								 JSON_Value *answer, void **raw_data, unsigned *size)
{
	int gpu_fd;
	int width, height, dmabuf_fd;

	int pid_fd = syscall(SYS_pidfd_open, (int) json_object_get_number(md, "pid"), 0);
	if (pid_fd < 0)
		return "SYS_pidfd_open failed";

	gpu_fd = syscall(SYS_pidfd_getfd, pid_fd, (int) json_object_get_number(md, "gpu-fd"), 0);
	if (gpu_fd < 0) {
		close(pid_fd);
		return "Failed to import GPU fd";
	}
	drmModeFB2Ptr fb2 = drmModeGetFB2(gpu_fd, (int) json_object_get_number(md, "fb_id"));
	if (fb2 == NULL) {
		close(gpu_fd);
		close(pid_fd);
		return "drmModeGetFB2 failed";
	}
	if (drmPrimeHandleToFD(gpu_fd, fb2->handles[0], DRM_CLOEXEC, &dmabuf_fd)) {
		close(gpu_fd);
		close(pid_fd);
		return "dmabuf creation failed";
	}

	unsigned fourcc = (unsigned) json_object_get_number(md, "fourcc");
	uint64_t modifier = str_to_uint64(json_object_get_string(md, "modifier"));
	width = (int) json_object_get_number(md, "width");
	height = (int) json_object_get_number(md, "height");

	int nplanes = (int) json_object_get_number(md, "nplanes");

	unsigned *offsets = alloca(nplanes * sizeof(unsigned));
	unsigned *pitches = alloca(nplanes * sizeof(unsigned));
	JSON_Array *j_offsets = json_object_get_array(md, "offsets");
	for (size_t i = 0; i < json_array_get_count(j_offsets); i++)
		offsets[i] = (int) json_array_get_number(j_offsets, i);
	JSON_Array *j_pitches = json_object_get_array(md, "pitches");
	for (size_t i = 0; i < json_array_get_count(j_pitches); i++)
		pitches[i] = (int) json_array_get_number(j_pitches, i);

	void *error;
	error = peak_bo(asic, dmabuf_fd,
					width, height, fourcc, modifier,
					nplanes,
					offsets, pitches,
					raw_data, size);
	close(dmabuf_fd);
	close(gpu_fd);
	close(pid_fd);

	if (error == NULL) {
		json_object_set_number(json_object(answer), "width", width);
		json_object_set_number(json_object(answer), "height", height);
	}
	close(dmabuf_fd);
	close(gpu_fd);
	close(pid_fd);
	return error;
}

static
char * get_bo_md_using_fb_id(struct umr_asic *asic, unsigned pid, int fb_id,
							 int *remote_gpu_fd,
						  	 unsigned *width, unsigned *height,
						  	 unsigned *fourcc, uint64_t *modifier,
						  	 unsigned *nplanes,
						  	 unsigned *offsets, unsigned *pitches)
{
	int gpu_fd = -1;
	int pid_fd = syscall(SYS_pidfd_open, pid, 0);
	if (pid_fd < 0)
		return "SYS_pidfd_open failed";

	int remote_gpu_fds_count = find_amdgpu_fd(pid, asic->options.pci.name, remote_gpu_fd, 1, NULL);
	if (remote_gpu_fds_count == 0)
		return "Couldn't find amdgpu fd";

	gpu_fd = syscall(SYS_pidfd_getfd, pid_fd, *remote_gpu_fd, 0);
	if (gpu_fd < 0) {
		close(pid_fd);
		return "Failed to import GPU fd";
	}

	drmModeFB2Ptr fb2 = drmModeGetFB2(gpu_fd, fb_id);
	if (fb2 == NULL) {
		close(gpu_fd);
		close(pid_fd);
		return "drmModeGetFB2 failed";
	}

	/* Close the handle to not leak it. */
	drmCloseBufferHandle(gpu_fd, fb2->handles[0]);
	*width = fb2->width;
	*height = fb2->height;
	*fourcc = fb2->pixel_format;
	*modifier = fb2->modifier;
	*nplanes = 0;
	for (int i = 0; i < 4; i++)
		(*nplanes) += (fb2->handles[i] != 0);
	memcpy(offsets, fb2->offsets, *nplanes * sizeof(unsigned));
	memcpy(pitches, fb2->pitches, *nplanes * sizeof(unsigned));

	close(gpu_fd);
	close(pid_fd);

	drmModeFreeFB2(fb2);

	return NULL;
}

static
void enrich_bo_data(struct umr_asic *asic, JSON_Array *apps) {
    for (unsigned i = 0; i < json_array_get_count(apps);) {
        JSON_Object *app = json_array_get_object(apps, i);
        JSON_Array *clients = json_object_get_array(app, "clients");
        bool has_non_null = false;
        for (unsigned j = 0; j < json_array_get_count(clients);) {
            JSON_Object *client = json_array_get_object(clients, j);
            int gpu_fd = (int)json_object_get_number(client, "gpu-fd");
            if (gpu_fd == 0) {
                json_array_remove(clients, j);
                continue;
            }

            int client_fd = syscall(SYS_pidfd_open, (int)json_object_get_number(app, "pid"), 0);

            if (client_fd < 0) {
                json_array_remove(clients, j);
                continue;
            }

            int client_gpu_fd = syscall(SYS_pidfd_getfd, client_fd, gpu_fd, 0);
            if (client_gpu_fd < 0) {
                json_array_remove(clients, j);
                close(client_fd);
                continue;
            }

            JSON_Array *bos = json_object_get_array(client, "bos");
            struct bo_info *bos_info = calloc(json_array_get_count(bos), sizeof(*bos_info));
            for (unsigned j = 0; j < json_array_get_count(bos); j++) {
                JSON_Object *bo = json_object(json_array_get_value(bos, j));
                bos_info[j].handle = json_object_get_number(bo, "handle");
                bos_info[j].size = json_object_get_number(bo, "size");
            }

            check_peak_bo_metadata(asic, client_gpu_fd, json_array_get_count(bos), bos_info);

            /* Remove invalid bo. */
            for (unsigned k = 0, l = 0; k < json_array_get_count(bos); l++) {
                if (bos_info[l].width && bos_info[l].height) {
                    JSON_Object *bo = json_array_get_object(bos, k);
                    json_object_set_number(bo, "width", bos_info[l].width);
                    json_object_set_number(bo, "height", bos_info[l].height);
                    json_object_set_number(bo, "format", bos_info[l].format);
                    json_object_set_number(bo, "swizzle", bos_info[l].swizzle);
                    json_object_set_number(bo, "tiling", bos_info[l].tiling_info);
                    json_object_set_number(bo, "alloc_flags", bos_info[l].alloc_flags);
                    k++;
                } else {
                    json_array_remove(bos, k);
                }
            }
            if (json_array_get_count(bos) == 0) {
                json_array_remove(clients, j);
            } else {
                has_non_null = true;
                j++;
            }
            free(bos_info);

            close(client_gpu_fd);
            close(client_fd);
        }
        if (has_non_null)
            i++;
        else
            json_array_remove(apps, i);
    }
}

static
bool use_dmabuf_to_identify_owner_fd(JSON_Array *clients, int pid_fd, int *gpu_fds,
                                     int gpu_fds_count, int *client_ids, bool has_extra_md) {
    int i, j, k;
    int pid_gpu_fds[1024] = {0};
    int n_exported, n_validated, r, dmabuf;
	struct stat st_buf;
	size_t successful_clients = 0;
	uint32_t ino, handle;
	struct drm_amdgpu_gem_metadata metadata;

	/* If extra_md is found within env variable, we'll check BOs for
	 * metatada.
	 */
	for (j = 0; j < (int) json_array_get_count(clients); j++) {
		JSON_Object *client = json_array_get_object(clients, j);
		JSON_Array * bos = json_object_get_array(client, "bos");

		for (i = 0; i < gpu_fds_count; i++) {
			if (j == 0)
				pid_gpu_fds[i] = syscall(SYS_pidfd_getfd, pid_fd, gpu_fds[i], 0);

			if (pid_gpu_fds[i] < 0)
				continue;

			n_exported = n_validated = 0;

			for (k = 0; k < (int) json_array_get_count(bos); k++) {
				JSON_Object * bo = json_array_get_object(bos, k);
				if (!json_object_has_value(bo, "ino")) {
					if (has_extra_md) {
						handle = json_object_get_number(bo, "handle");
						goto check_md;
					}
					continue;
				}

				n_exported++;

				/* Re-exporting a bo should return the same inode number */
				ino = json_object_get_number(bo, "ino");
				handle = json_object_get_number(bo, "handle");

				r = drmPrimeHandleToFD(pid_gpu_fds[i], handle,
										DRM_CLOEXEC | DRM_RDWR, &dmabuf);
				if (r)
					break;

				r = fstat(dmabuf, &st_buf);
				close(dmabuf);

				if (r || st_buf.st_ino != ino)
					break;

				n_validated++;

				check_md:
				if (check_bo_metadata(pid_gpu_fds[i], handle, &metadata))
					json_object_set_number(bo, "has_metadata", 1);
			}

			/* This gpu_fd validated all the exported BO. */
			if (n_exported == n_validated) {
				json_object_set_number(client, "gpu-fd", gpu_fds[i]);
				json_object_set_number(client, "drm-client-id", client_ids[i]);
				close(pid_gpu_fds[i]);
				pid_gpu_fds[i] = -1;
				successful_clients++;
				break;
			}
		}
	}
	for (i = 0; i < gpu_fds_count; i++)
		close(pid_gpu_fds[i]);
	close(pid_fd);

	return successful_clients == json_array_get_count(clients);
}