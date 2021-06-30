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
#include <regex.h>

int umr_scan_asic(struct umr_asic *asic, char *asicname, char *ipname, char *regname)
{
	int r, fd, first, i, j, k, count = 0, noipreg = 1;
	uint64_t addr, scale;
	char buf[256], regname_copy[256];
	uint32_t mmio_addr = 0, v32;

	regex_t ip_regex, reg_regex;

	if (strcmp(ipname, "*")) {
		if (regcomp(&ip_regex, ipname, REG_ICASE | REG_EXTENDED | REG_NOSUB)) {
			fprintf(stderr, "[ERROR]: Failed to compile ip name regex for [%s]\n", ipname);
			return -1;
		}
		noipreg = 0;
	}

	if (regcomp(&reg_regex, regname, REG_ICASE | REG_EXTENDED | REG_NOSUB)) {
		fprintf(stderr, "[ERROR]: Failed to compile register regex for [%s]\n", regname);
		if (!noipreg)
			regfree(&ip_regex);
		return -1;
	}

	// does the register name contain a trailing star?
	strcpy(regname_copy, regname);
	if (strlen(regname) > 1 && strstr(regname, "*")) {
		regname_copy[strlen(regname_copy)-1] = 0;
	}

	/* scan them all in order */
	if (!asicname[0] || !strcmp(asicname, "*") || !strcmp(asicname, asic->asicname)) {
		for (i = 0; i < asic->no_blocks; i++) {
			if (!ipname[0] || ipname[0] == '*' || !regexec(&ip_regex, asic->blocks[i]->ipname, 0, NULL, 0)) {
				first = 1;
				for (j = 0; j < asic->blocks[i]->no_regs; j++) {
					if (!regname[0] || !strcmp(regname, "*") ||
					    !regexec(&reg_regex, asic->blocks[i]->regs[j].regname, 0, NULL, 0)) {
						++ count;

						// only grant if any regspec matches otherwise it's a waste
						if (first && asic->blocks[i]->grant) {
							first = 0;
							r = asic->blocks[i]->grant(asic);
							if (r) {
								if (ipname[0]) {
									exit(EXIT_FAILURE);
								}
								continue;
							}
						}
						if (asic->pci.mem == NULL) {
							switch(asic->blocks[i]->regs[j].type) {
							case REG_MMIO: fd = asic->fd.mmio; scale = 4; break;
							case REG_DIDT: fd = asic->fd.didt; scale = 1; break;
							case REG_PCIE: fd = asic->fd.pcie; scale = 1; break;
							case REG_SMC:
								if (asic->options.read_smc) {
									fd = asic->fd.smc; scale = 1;
								} else {
									continue;
								}
								break;
							default: return -1;
							}

							if (asic->blocks[i]->regs[j].type == REG_MMIO) {
								addr = umr_apply_bank_selection_address(asic);
								// apply context banking
								mmio_addr = asic->blocks[i]->regs[j].addr*scale;
								if ((mmio_addr >= (0xA000*4)) && (mmio_addr < (0xB000*4)))
									mmio_addr += asic->options.context_reg_bank * 0x1000;
							} else {
								addr = 0;
								mmio_addr = asic->blocks[i]->regs[j].addr * scale;
							}

							if (lseek(fd, addr|mmio_addr, SEEK_SET) == -1) {
								snprintf(buf, sizeof(buf)-1, "Could not seek reading register %s.%s.%s", asic->asicname, asic->blocks[i]->ipname, asic->blocks[i]->regs[j].regname);
								perror(buf);
								r = -1;
								goto error;
							}
							if (read(fd, &v32, 4) != 4) {
								snprintf(buf, sizeof(buf)-1, "Could not read register %s.%s.%s", asic->asicname, asic->blocks[i]->ipname, asic->blocks[i]->regs[j].regname);
								perror(buf);
								r = -1;
								goto error;
							}
							asic->blocks[i]->regs[j].value = v32;
							if (asic->blocks[i]->regs[j].bit64) {
								if (read(fd, &v32, 4) != 4) {
									snprintf(buf, sizeof(buf)-1, "Could not read register %s.%s.%s", asic->asicname, asic->blocks[i]->ipname, asic->blocks[i]->regs[j].regname);
									perror(buf);
									r = -1;
									goto error;
								}
								asic->blocks[i]->regs[j].value |= (uint64_t)v32 << 32;
							}
						} else if (asic->blocks[i]->regs[j].type == REG_MMIO || asic->blocks[i]->regs[j].type == REG_SMC) {
							asic->blocks[i]->regs[j].value = umr_read_reg(asic, umr_apply_bank_selection_address(asic) | (asic->blocks[i]->regs[j].addr * (asic->blocks[i]->regs[j].type == REG_MMIO ? 4 : 1)), asic->blocks[i]->regs[j].type);
							if (asic->blocks[i]->regs[j].bit64)
								asic->blocks[i]->regs[j].value |= (uint64_t)umr_read_reg(asic, umr_apply_bank_selection_address(asic) | ((asic->blocks[i]->regs[j].addr + 1) * (asic->blocks[i]->regs[j].type == REG_MMIO ? 4 : 1)), asic->blocks[i]->regs[j].type) << 32;
						}
						if (regname[0]) {
							printf("%s%s.%s%s => ", CYAN, asic->blocks[i]->ipname,  asic->blocks[i]->regs[j].regname, RST);
							printf("%s0x%08lx%s\n", YELLOW, (unsigned long)asic->blocks[i]->regs[j].value, RST);
							if (asic->options.bitfields)
								for (k = 0; k < asic->blocks[i]->regs[j].no_bits; k++) {
									uint32_t v;
									v = (1UL << (asic->blocks[i]->regs[j].bits[k].stop + 1 - asic->blocks[i]->regs[j].bits[k].start)) - 1;
									v &= (asic->blocks[i]->regs[j].value >> asic->blocks[i]->regs[j].bits[k].start);
									asic->blocks[i]->regs[j].bits[k].bitfield_print(asic, asic->asicname, asic->blocks[i]->ipname, asic->blocks[i]->regs[j].regname, asic->blocks[i]->regs[j].bits[k].regname, asic->blocks[i]->regs[j].bits[k].start, asic->blocks[i]->regs[j].bits[k].stop, v);
								}
						}
					}
				}
				// only release if granted
				if (!first && asic->blocks[i]->release) {
					r = asic->blocks[i]->release(asic);
					if (r)
						goto error;
				}
			}
		}
	}

	if (count == 0) {
		if (!memcmp(regname_copy, "reg", 3)) {
			fprintf(stderr, "[ERROR]: Path <%s.%s.%s> not found on this ASIC\n", asicname, ipname, regname);
			r = -1;
			goto error;
		} else {
			char tmpregname[256];
			// try scanning for reg that starts with reg
			strcpy(tmpregname, "reg");
			strcat(tmpregname, regname + 2);
			fprintf(stderr, "[WARNING]: Retrying operation with new 'reg' name <%s>.\n", tmpregname);
			r = umr_scan_asic(asic, asicname, ipname, tmpregname);
			goto error;
		}
	}

	r = 0;
error:
	if (!noipreg)
		regfree(&ip_regex);
	regfree(&reg_regex);
	return r;
}
