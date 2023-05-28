/*
 * Copyright 2022 Advanced Micro Devices, Inc.
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
 * Authors: Tom St Denis <tom.stdenis@amd.com>
 *
 */
#include "umr.h"
#include <linux/ioctl.h>
#include <linux/types.h>
#include <asm/ioctl.h>
#include <sys/ioctl.h>

static void wave_read_regs_via_mmio(struct umr_asic *asic, uint32_t simd,
			   uint32_t wave, uint32_t thread,
			   uint32_t regno, uint32_t num, uint32_t *out)
{
	struct umr_reg *ind_index, *ind_data;
	uint32_t data;

	ind_index = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmSQ_IND_INDEX");
	ind_data  = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmSQ_IND_DATA");

	if (ind_index && ind_data) {
		data = umr_bitslice_compose_value(asic, ind_index, "WAVE_ID", wave);
		data |= umr_bitslice_compose_value(asic, ind_index, "INDEX", regno);
		if (asic->family < FAMILY_NV) {
			data |= umr_bitslice_compose_value(asic, ind_index, "THREAD_ID", thread);
			data |= umr_bitslice_compose_value(asic, ind_index, "FORCE_READ", 1);
			data |= umr_bitslice_compose_value(asic, ind_index, "SIMD_ID", simd);
		} else {
			data |= umr_bitslice_compose_value(asic, ind_index, "WORKITEM_ID", thread);
		}
		data |= umr_bitslice_compose_value(asic, ind_index, "AUTO_INCR", 1);
		umr_write_reg(asic, ind_index->addr * 4, data, REG_MMIO);
		while (num--)
			*(out++) = umr_read_reg(asic, ind_data->addr * 4, REG_MMIO);
	} else {
		asic->err_msg("[BUG]: The required SQ_IND_{INDEX,DATA} registers are not found on the asic <%s>\n", asic->asicname);
		return;
	}
}

struct amdgpu_debugfs_gprwave_iocdata {
	__u32 gpr_or_wave, se, sh, cu, wave, simd, xcc_id;
	struct {
		__u32 thread, vpgr_or_sgpr;
	} gpr;
};


enum AMDGPU_DEBUGFS_GPRWAVE_CMDS {
	AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE=0,
};
#define AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE, struct amdgpu_debugfs_gprwave_iocdata)

static int read_gpr_gprwave(struct umr_asic *asic, int v_or_s, uint32_t thread, struct umr_wave_status *ws, uint32_t *dst)
{
	struct amdgpu_debugfs_gprwave_iocdata id;
	int r;
	uint32_t size;
	uint64_t addr = 0;

	memset(&id, 0, sizeof id);
	id.gpr_or_wave = 1;
	if (asic->family < FAMILY_NV) {
		id.se = ws->hw_id.se_id;
		id.sh = ws->hw_id.sh_id;
		id.cu = ws->hw_id.cu_id;
		id.wave = ws->hw_id.wave_id;
		id.simd = ws->hw_id.simd_id;

		if (v_or_s == 0) {
			uint32_t shift;
			id.gpr.thread = 0;
			if (asic->family <= FAMILY_CIK)
				shift = 3;  // on SI..CIK allocations were done in 8-dword blocks
			else
				shift = 4;  // on VI allocations are in 16-dword blocks
			size = 4 * ((ws->gpr_alloc.sgpr_size + 1) << shift);
		} else {
			id.gpr.thread = thread;
			size = 4 * ((ws->gpr_alloc.vgpr_size + 1) << asic->parameters.vgpr_granularity);
		}
	} else {
		id.se = ws->hw_id1.se_id;
		id.sh = ws->hw_id1.sa_id;
		id.cu = ((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id);
		id.wave = ws->hw_id1.wave_id;
		if (v_or_s == 0) {
			id.gpr.thread = 0;
			size = 4 * 112;
		} else {
			id.gpr.thread = thread;
			size = 4 * ((ws->gpr_alloc.vgpr_size + 1) << asic->parameters.vgpr_granularity);
		}
	}
	id.gpr.vpgr_or_sgpr = v_or_s;
	id.xcc_id = asic->options.vm_partition == -1 ? 0 : asic->options.vm_partition;

	r = ioctl(asic->fd.gprwave, AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE, &id);
	if (r)
		return r;

	lseek(asic->fd.gprwave, 0, SEEK_SET);
	r = read(asic->fd.gprwave, dst, size);
	if (r < 0)
		return r;

	// if we are reading SGPRS then optionally dump them
	// and then read TRAP registers if necessary
	if (asic->options.test_log && asic->options.test_log_fd) {
		int x;

		// we use addr for test logging
		if (v_or_s == 0) {
			if (asic->family < FAMILY_NV) {
				addr =
					(1ULL << 60)                             | // reading SGPRs
					((uint64_t)0)                            | // starting address to read from
					((uint64_t)ws->hw_id.se_id << 12)        |
					((uint64_t)ws->hw_id.sh_id << 20)        |
					((uint64_t)ws->hw_id.cu_id << 28)        |
					((uint64_t)ws->hw_id.wave_id << 36)      |
					((uint64_t)ws->hw_id.simd_id << 44)      |
					(0ULL << 52); // thread_id
			} else {
				addr =
					(1ULL << 60)                             | // reading SGPRs
					((uint64_t)0)                            | // starting address to read from
					((uint64_t)ws->hw_id1.se_id << 12)       |
					((uint64_t)ws->hw_id1.sa_id << 20)       |
					((uint64_t)((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id) << 28)  |
					((uint64_t)ws->hw_id1.wave_id << 36)     |
					(0ULL << 52); // thread_id
			}
		} else {
			if (asic->family < FAMILY_NV) {
				addr =
					(0ULL << 60)                             | // reading VGPRs
					((uint64_t)0)                            | // starting address to read from
					((uint64_t)ws->hw_id.se_id << 12)        |
					((uint64_t)ws->hw_id.sh_id << 20)        |
					((uint64_t)ws->hw_id.cu_id << 28)        |
					((uint64_t)ws->hw_id.wave_id << 36)      |
					((uint64_t)ws->hw_id.simd_id << 44)      |
					((uint64_t)thread << 52);
			} else {
				addr =
					(0ULL << 60)                             | // reading VGPRs
					((uint64_t)0)                            | // starting address to read from
					((uint64_t)ws->hw_id1.se_id << 12)        |
					((uint64_t)ws->hw_id1.sa_id << 20)        |
					((uint64_t)((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id) << 28)  |
					((uint64_t)ws->hw_id1.wave_id << 36)      |
					((uint64_t)thread << 52);
			}
		}
		fprintf(asic->options.test_log_fd, "%cGPR@0x%"PRIx64" = { ", "SV"[v_or_s], addr);
		for (x = 0; x < r; x += 4) {
			fprintf(asic->options.test_log_fd, "0x%"PRIx32, dst[x/4]);
			if (x < (r - 4))
				fprintf(asic->options.test_log_fd, ", ");
		}
		fprintf(asic->options.test_log_fd, "}\n");
	}

	if (v_or_s == 0) {
		// read trap if any
		if (ws->wave_status.trap_en || ws->wave_status.priv) {
			lseek(asic->fd.gprwave, 4 * 0x6C, SEEK_SET);
			r = read(asic->fd.gprwave, &dst[0x6C], 4 * 16);
			if (r > 0) {
				if (asic->options.test_log && asic->options.test_log_fd) {
					int x;
					fprintf(asic->options.test_log_fd, "SGPR@0x%"PRIx64" = { ", addr + 0x6C * 4);
					for (x = 0; x < r; x += 4) {
						fprintf(asic->options.test_log_fd, "0x%"PRIx32, dst[0x6C + x/4]);
						if (x < (r - 4))
							fprintf(asic->options.test_log_fd, ", ");
					}
					fprintf(asic->options.test_log_fd, "}\n");
				}
			}
		}
	}

	return r;
}

/**
 * umr_read_sgprs - Read SGPR registers for a specific wave
 */
int umr_read_sgprs(struct umr_asic *asic, struct umr_wave_status *ws, uint32_t *dst)
{
	uint64_t addr, shift, size;
	int r;

	if (asic->fd.gprwave >= 0)
		return read_gpr_gprwave(asic, 0, 0, ws, dst);

	if (asic->family <= FAMILY_CIK)
		shift = 3;  // on SI..CIK allocations were done in 8-dword blocks
	else
		shift = 4;  // on VI allocations are in 16-dword blocks

	if (!asic->options.no_kernel) {
		if (asic->family < FAMILY_NV) {
			size = 4 * ((ws->gpr_alloc.sgpr_size + 1) << shift);
			addr =
				(1ULL << 60)                             | // reading SGPRs
				((uint64_t)0)                            | // starting address to read from
				((uint64_t)ws->hw_id.se_id << 12)        |
				((uint64_t)ws->hw_id.sh_id << 20)        |
				((uint64_t)ws->hw_id.cu_id << 28)        |
				((uint64_t)ws->hw_id.wave_id << 36)      |
				((uint64_t)ws->hw_id.simd_id << 44)      |
				(0ULL << 52); // thread_id
		} else {
			size = 4 * 112;
			addr =
				(1ULL << 60)                             | // reading SGPRs
				((uint64_t)0)                            | // starting address to read from
				((uint64_t)ws->hw_id1.se_id << 12)       |
				((uint64_t)ws->hw_id1.sa_id << 20)       |
				((uint64_t)((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id) << 28)  |
				((uint64_t)ws->hw_id1.wave_id << 36)     |
				(0ULL << 52); // thread_id
		}
		lseek(asic->fd.gpr, addr, SEEK_SET);
		r = read(asic->fd.gpr, dst, size);
		if (r < 0)
			return r;

		if (asic->options.test_log && asic->options.test_log_fd) {
			int x;
			fprintf(asic->options.test_log_fd, "SGPR@0x%"PRIx64" = { ", addr);
			for (x = 0; x < r; x += 4) {
				fprintf(asic->options.test_log_fd, "0x%"PRIx32, dst[x/4]);
				if (x < (r - 4))
					fprintf(asic->options.test_log_fd, ", ");
			}
			fprintf(asic->options.test_log_fd, "}\n");
		}

		// read trap if any
		if (ws->wave_status.trap_en || ws->wave_status.priv) {
			addr += 4 * 0x6C; // address in bytes, kernel adds 0x200 to request
			lseek(asic->fd.gpr, addr, SEEK_SET);
			r = read(asic->fd.gpr, &dst[0x6C], 4 * 16);
			if (r > 0) {
				if (asic->options.test_log && asic->options.test_log_fd) {
					int x;
					fprintf(asic->options.test_log_fd, "SGPR@0x%"PRIx64" = { ", addr);
					for (x = 0; x < r; x += 4) {
						fprintf(asic->options.test_log_fd, "0x%"PRIx32, dst[0x6C + x/4]);
						if (x < (r - 4))
							fprintf(asic->options.test_log_fd, ", ");
					}
					fprintf(asic->options.test_log_fd, "}\n");
				}
			}
		}
		return r;
	} else {
		if (asic->family < FAMILY_NV) {
			umr_grbm_select_index(asic, ws->hw_id.se_id, ws->hw_id.sh_id, ws->hw_id.cu_id);
			wave_read_regs_via_mmio(asic, ws->hw_id.simd_id, ws->hw_id.wave_id, 0, 0x200,
						(ws->gpr_alloc.sgpr_size + 1) << shift, dst);
			if (ws->wave_status.trap_en || ws->wave_status.priv)
				wave_read_regs_via_mmio(asic, ws->hw_id.simd_id, ws->hw_id.wave_id, 0, 0x26C,
							16, &dst[0x6C]);
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
		} else {
			umr_grbm_select_index(asic, ws->hw_id1.se_id, ws->hw_id1.sa_id, ((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id));
			wave_read_regs_via_mmio(asic, 0, ws->hw_id1.wave_id, 0, 0x200, 112, dst);
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		return 0;
	}
}

int umr_read_vgprs(struct umr_asic *asic, struct umr_wave_status *ws, uint32_t thread, uint32_t *dst)
{
	uint64_t addr;
	unsigned granularity = asic->parameters.vgpr_granularity; // default is blocks of 4 registers
	int r;

	// reading VGPR is not supported on pre GFX9 devices
	if (asic->family < FAMILY_AI)
		return -1;

	if (asic->fd.gprwave >= 0)
		return read_gpr_gprwave(asic, 1, thread, ws, dst);

	if (!asic->options.no_kernel) {
		if (asic->family < FAMILY_NV) {
			addr =
				(0ULL << 60)                             | // reading VGPRs
				((uint64_t)0)                            | // starting address to read from
				((uint64_t)ws->hw_id.se_id << 12)        |
				((uint64_t)ws->hw_id.sh_id << 20)        |
				((uint64_t)ws->hw_id.cu_id << 28)        |
				((uint64_t)ws->hw_id.wave_id << 36)      |
				((uint64_t)ws->hw_id.simd_id << 44)      |
				((uint64_t)thread << 52);
		} else {
			addr =
				(0ULL << 60)                             | // reading VGPRs
				((uint64_t)0)                            | // starting address to read from
				((uint64_t)ws->hw_id1.se_id << 12)        |
				((uint64_t)ws->hw_id1.sa_id << 20)        |
				((uint64_t)((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id) << 28)  |
				((uint64_t)ws->hw_id1.wave_id << 36)      |
				((uint64_t)thread << 52);
		}
		lseek(asic->fd.gpr, addr, SEEK_SET);
		r = read(asic->fd.gpr, dst, 4 * ((ws->gpr_alloc.vgpr_size + 1) << granularity));
		if (r > 0) {
			if (asic->options.test_log && asic->options.test_log_fd) {
				int x;
				fprintf(asic->options.test_log_fd, "VGPR@0x%"PRIx64" = { ", addr);
				for (x = 0; x < r; x += 4) {
					fprintf(asic->options.test_log_fd, "0x%"PRIx32, dst[x/4]);
					if (x < (r - 4))
						fprintf(asic->options.test_log_fd, ", ");
				}
				fprintf(asic->options.test_log_fd, "}\n");
			}
		}
		return r;
	} else {
		if (asic->family < FAMILY_NV) {
			umr_grbm_select_index(asic, ws->hw_id.se_id, ws->hw_id.sh_id, ws->hw_id.cu_id);
			wave_read_regs_via_mmio(asic, ws->hw_id.simd_id, ws->hw_id.wave_id, thread, 0x400,
						(ws->gpr_alloc.vgpr_size + 1) << granularity, dst);
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
		} else {
			umr_grbm_select_index(asic, ws->hw_id1.se_id, ws->hw_id1.sa_id, ((ws->hw_id1.wgp_id << 2) | ws->hw_id1.simd_id));
			wave_read_regs_via_mmio(asic, 0, ws->hw_id1.wave_id, thread, 0x400,
						(ws->gpr_alloc.vgpr_size + 1) << granularity, dst);
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		return 0;
	}
}

int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws)
{
	uint32_t buf[32];
	int r;
	uint64_t addr = 0;
	struct amdgpu_debugfs_gprwave_iocdata id;

	memset(buf, 0, sizeof buf);

	if (asic->fd.gprwave >= 0) {
		memset(&id, 0, sizeof id);
		id.gpr_or_wave = 0;
		id.se = se;
		id.sh = sh;
		id.cu = cu;
		id.wave = wave;
		id.simd = simd;
		id.xcc_id = asic->options.vm_partition == -1 ? 0 : asic->options.vm_partition;

		r = ioctl(asic->fd.gprwave, AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE, &id);
		if (r)
			return r;

		lseek(asic->fd.gprwave, 0, SEEK_SET);
		r = read(asic->fd.gprwave, buf, 32*4);
		if (r < 0)
			return r;
	} else {
		if (!asic->options.no_kernel) {
			addr = 0 |
				((uint64_t)se << 7) |
				((uint64_t)sh << 15) |
				((uint64_t)cu << 23) |
				((uint64_t)wave << 31) |
				((uint64_t)simd << 37);
			lseek(asic->fd.wave, addr, SEEK_SET);
			r = read(asic->fd.wave, &buf, 32*4);
			if (r <= 0)
				return -1;
		} else {
			int n = 0;
			if (asic->family < FAMILY_NV) {
				umr_grbm_select_index(asic, se, sh, cu);
				umr_read_wave_status_via_mmio_gfx8_9(asic, simd, wave, &buf[0], &n);
				umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
			} else {
				umr_grbm_select_index(asic, se, sh, cu);
				umr_read_wave_status_via_mmio_gfx_10_11(asic, wave, &buf[0], &n);
				umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
			}
		}
	}

	if (asic->options.test_log && asic->options.test_log_fd) {
		int x;
		fprintf(asic->options.test_log_fd, "WAVESTATUS@0x%"PRIx64" = { ", addr);
		for (x = 0; x < r; x += 4) {
			fprintf(asic->options.test_log_fd, "0x%"PRIx32, buf[x/4]);
			if (x < (r - 4))
				fprintf(asic->options.test_log_fd, ", ");
		}
		fprintf(asic->options.test_log_fd, "}\n");
	}


	return umr_parse_wave_data_gfx(asic, ws, buf);
}

int umr_get_wave_sq_info(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws)
{
	if (asic->family <= FAMILY_NV)
		return umr_get_wave_sq_info_vi(asic, se, sh, cu, ws);
	return -1;
}
