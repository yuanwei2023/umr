/*
 * Copyright 2021 Advanced Micro Devices, Inc.
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
#include "umrapp.h"
#include <inttypes.h>

/* set a register based on regpath e.g.
 *
 * stoney.uvd6.mmFOO
 */
int umr_set_register(struct umr_asic *asic, char *regpath, char *regvalue)
{
	char asicname[128], ipname[128], regname[128];
	int i, j, fd;
	uint64_t value, addr, scale;
	uint32_t v32;

	if (sscanf(regpath, "%[^.].%[^.].%[^.]", asicname, ipname, regname) != 3) {
		fprintf(stderr, "[ERROR]: Invalid regpath for write\n");
		return -1;
	}

	if (asicname[0] == '*' || !strcmp(asicname, asic->asicname)) {
		// scan all ip blocks for matching entry
		for (i = 0; i < asic->no_blocks; i++) {
			if (ipname[0] == '*' || !strcmp(ipname, asic->blocks[i]->ipname)) {
				for (j = 0; j < asic->blocks[i]->no_regs; j++) {
					if (!strcmp(regname, asic->blocks[i]->regs[j].regname)) {
						sscanf(regvalue, "%"SCNx64, &value);

						if (asic->pci.mem == NULL) {
							// set this register
							switch (asic->blocks[i]->regs[j].type){
							case REG_MMIO: fd = asic->fd.mmio; scale = 4; break;
							case REG_DIDT: fd = asic->fd.didt; scale = 1; break;
							case REG_PCIE: fd = asic->fd.pcie; scale = 1; break;
							case REG_SMC:  fd = asic->fd.smc; scale = 1; break;
							default: return -1;
							}

							if (asic->blocks[i]->grant) {
								if (asic->blocks[i]->grant(asic)) {
									return -1;
								}
							}

							if (asic->blocks[i]->regs[j].type == REG_MMIO)
								addr = umr_apply_bank_selection_address(asic);
							else
								addr = 0;

							v32 = value & 0xFFFFFFFF;
							lseek(fd, addr | (asic->blocks[i]->regs[j].addr*scale), SEEK_SET);
							if (write(fd, &v32, 4) != 4)
								return -1;

							if (asic->blocks[i]->regs[j].bit64) {
								v32 = value >> 32;
								if (write(fd, &v32, 4) != 4)
									return -1;
							}

							if (asic->blocks[i]->release) {
								if (asic->blocks[i]->release(asic)) {
									return -1;
								}
							}
						} else if (asic->blocks[i]->regs[j].type == REG_MMIO) {
							umr_write_reg(asic, umr_apply_bank_selection_address(asic) | (asic->blocks[i]->regs[j].addr * 4), value & 0xFFFFFFFF, REG_MMIO);
							if (asic->blocks[i]->regs[j].bit64)
								umr_write_reg(asic, umr_apply_bank_selection_address(asic) | ((asic->blocks[i]->regs[j].addr + 1) * 4), value >> 32, REG_MMIO);
						}
						return 0;
					}
				}
			}
		}
	}
	if (!memcmp(regname, "reg", 3)) {
		fprintf(stderr, "[ERROR]: Path <%s> not found on this ASIC\n", regpath);
		return -1;
	} else {
		char newregpath[512];
		sprintf(newregpath, "%s.%s.reg%s", asicname, ipname, regname + 2);
		fprintf(stderr, "[WARNING]: Retrying operation with new 'reg' prefix path <%s>.\n", newregpath);
		return umr_set_register(asic, newregpath, regvalue);
	}
}
