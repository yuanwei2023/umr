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
#include "umr.h"

/**
 * umr_pcie_read - Read a PCIE register
 *
 * Reads a PCIE register via debugfs or direct MMIO.
 */
static uint32_t umr_pcie_read(struct umr_asic *asic, uint64_t addr)
{
	uint32_t value;
	if (asic->options.use_pci) {
		switch (asic->config.gfx.family) {
#if 0
			case 110: // SI
			case 120: // CIK
			case 125: // KV
			case 130: // VI
				umr_write_reg_by_name(asic, "mmSMC_IND_INDEX_1", addr);
				return umr_read_reg_by_name(asic, "mmSMC_IND_DATA_1");
			case 135: // CZ
				umr_write_reg_by_name(asic, "mmMP0PUB_IND_INDEX_1", addr);
				return umr_read_reg_by_name(asic, "mmMP0PUB_IND_DATA_1");
#endif
			default:
				fprintf(stderr, "[BUG]: Unsupported family type in umr_pcie_read()\n");
				return 0;
		}
	} else {
		if (lseek(asic->fd.pcie, addr, SEEK_SET) < 0)
			perror("Cannot seek to PCIE address");
		if (read(asic->fd.pcie, &value, 4) != 4)
			perror("Cannot read from PCIE reg");
		return value;
	}
}

/**
 * umr_pcie_write - Write a PCIE register
 *
 * Write a PCIE register via debugfs or direct MMIO access.
 */
static uint32_t umr_pcie_write(struct umr_asic *asic, uint64_t addr, uint32_t value)
{
	if (asic->options.use_pci) {
		switch (asic->config.gfx.family) {
#if 0
			case 110: // SI
			case 120: // CIK
			case 125: // KV
			case 130: // VI
				umr_write_reg_by_name(asic, "mmSMC_IND_INDEX_1", addr);
				return umr_write_reg_by_name(asic, "mmSMC_IND_DATA_1", value);
			case 135: // CZ
				umr_write_reg_by_name(asic, "mmMP0PUB_IND_INDEX_1", addr);
				return umr_write_reg_by_name(asic, "mmMP0PUB_IND_DATA_1", value);
#endif
			default:
				fprintf(stderr, "[BUG]: Unsupported family type in umr_pcie_write()\n");
				return -1;
		}
	} else {
		if (lseek(asic->fd.pcie, addr, SEEK_SET) < 0) {
			perror("Cannot seek to PCIE address");
			return -1;
		}
		if (write(asic->fd.pcie, &value, 4) != 4) {
			perror("Cannot write to PCIE reg");
			return -1;
		}
	}
	return 0;
}

/**
 * umr_smc_read - Read an SMC register
 *
 * Reads an SMC register via debugfs or direct MMIO.
 */
static uint32_t umr_smc_read(struct umr_asic *asic, uint64_t addr)
{
	uint32_t value;
	if (asic->options.use_pci) {
		switch (asic->config.gfx.family) {
			case 110: // SI
			case 120: // CIK
			case 125: // KV
			case 130: // VI
				umr_write_reg_by_name(asic, "mmSMC_IND_INDEX_1", addr);
				return umr_read_reg_by_name(asic, "mmSMC_IND_DATA_1");
			case 135: // CZ
				umr_write_reg_by_name(asic, "mmMP0PUB_IND_INDEX_1", addr);
				return umr_read_reg_by_name(asic, "mmMP0PUB_IND_DATA_1");
			default:
				fprintf(stderr, "[BUG]: Unsupported family type in umr_smc_read()\n");
				return 0;
		}
	} else {
		if (lseek(asic->fd.smc, addr, SEEK_SET) < 0)
			perror("Cannot seek to SMC address");
		if (read(asic->fd.smc, &value, 4) != 4)
			perror("Cannot read from SMC reg");
		return value;
	}

}

/**
 * umr_smc_write - Write an SMC register
 *
 * Write an SMC register via debugfs or direct MMIO access.
 */
static uint32_t umr_smc_write(struct umr_asic *asic, uint64_t addr, uint32_t value)
{
	if (asic->options.use_pci) {
		switch (asic->config.gfx.family) {
			case 110: // SI
			case 120: // CIK
			case 125: // KV
			case 130: // VI
				umr_write_reg_by_name(asic, "mmSMC_IND_INDEX_1", addr);
				return umr_write_reg_by_name(asic, "mmSMC_IND_DATA_1", value);
			case 135: // CZ
				umr_write_reg_by_name(asic, "mmMP0PUB_IND_INDEX_1", addr);
				return umr_write_reg_by_name(asic, "mmMP0PUB_IND_DATA_1", value);
			default:
				fprintf(stderr, "[BUG]: Unsupported family type in umr_smc_write()\n");
				return -1;
		}
	} else {
		if (lseek(asic->fd.smc, addr, SEEK_SET) < 0) {
			perror("Cannot seek to SMC address");
			return -1;
		}
		if (write(asic->fd.smc, &value, 4) != 4) {
			perror("Cannot write to SMC reg");
			return -1;
		}
	}
	return 0;
}

/**
 * umr_read_reg - Read a register
 *
 * Reads an SMC or MMIO register by address.
 */
uint32_t umr_read_reg(struct umr_asic *asic, uint64_t addr, enum regclass type)
{
	uint32_t value=0;
	uint64_t mmio_addr = addr & 0xFFFFFF;
	int use_bank = 0;

	if (addr == 0xFFFFFFFF)
		fprintf(stderr, "[BUG]: reading from addr==0xFFFFFFFF is likely a bug\n");

	// lop off top bits in no-kernel mode
	if (type == REG_MMIO && asic->options.no_kernel) {
		// if bit 62/61 set do bank switch
		if (addr & (1ULL << 62)) {
			use_bank = 1;
			umr_grbm_select_index(asic, (addr >> 24) & 1023, (addr >> 34) & 1023, (addr >> 44) & 1023);
		} else if (addr & (1ULL << 61)) {
			use_bank = 2;
			umr_srbm_select_index(asic, (addr >> 24) & 1023, (addr >> 34) & 1023, (addr >> 44) & 1023, (addr >> 54) & 1023);
		}
		addr &= 0xFFFFFF;
	}

	// apply context banking
	if ((mmio_addr >= (0xA000*4)) && (mmio_addr < (0xB000*4)))
		addr += asic->options.context_reg_bank * 0x1000;

	switch (type) {
		case REG_PCIE:
			value = umr_pcie_read(asic, addr);
			break;
		case REG_MMIO:
			if (asic->pci.mem && !(addr & ~0xFFFFFULL)) { // only use pci if enabled and not using high bits
				value = asic->pci.mem[addr/4];
				break;
			} else {
				if (lseek(asic->fd.mmio, addr, SEEK_SET) < 0)
					perror("Cannot seek to MMIO address");
				if (read(asic->fd.mmio, &value, 4) != 4)
					perror("Cannot read from MMIO reg");
				break;
			}
			break;
		case REG_SMC:
			value = umr_smc_read(asic, addr);
			break;
		default:
			fprintf(stderr, "[BUG]: Unsupported register type in umr_read_reg().\n");
			return 0;
	}

	switch (use_bank) {
		case 1:
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
			break;
		case 2:
			umr_srbm_select_index(asic, 0, 0, 0, 0);
			break;
	}

	return value;
}

/**
 * umr_write_reg - Write a register
 *
 * Write to an SMC or MMIO register by address.
 */
int umr_write_reg(struct umr_asic *asic, uint64_t addr, uint32_t value, enum regclass type)
{
	uint64_t mmio_addr = addr & 0xFFFFFF;
	int use_bank = 0, r = 0;

	if (addr == 0xFFFFFFFF)
		fprintf(stderr, "[BUG]: reading from addr==0xFFFFFFFF is likely a bug\n");

	// lop off top bits in no-kernel mode
	if (type == REG_MMIO && asic->options.no_kernel) {
		// if bit 62/61 set do bank switch
		if (addr & (1ULL << 62)) {
			use_bank = 1;
			umr_grbm_select_index(asic, (addr >> 24) & 1023, (addr >> 34) & 1023, (addr >> 44) & 1023);
		} else if (addr & (1ULL << 61)) {
			use_bank = 2;
			umr_srbm_select_index(asic, (addr >> 24) & 1023, (addr >> 34) & 1023, (addr >> 44) & 1023, (addr >> 54) & 1023);
		}
		addr &= 0xFFFFFF;
	}

	// apply context banking
	if ((mmio_addr >= (0xA000*4)) && (mmio_addr < (0xB000*4)))
		addr += asic->options.context_reg_bank * 0x1000;

	switch (type) {
		case REG_PCIE:
			r = umr_pcie_write(asic, addr, value);
			break;
		case REG_MMIO:
			if (asic->pci.mem && !(addr & ~0xFFFFFULL)) {
				asic->pci.mem[addr/4] = value;
			} else {
				if (lseek(asic->fd.mmio, addr, SEEK_SET) < 0) {
					perror("Cannot seek to MMIO address");
					r = -1;
				} else if (write(asic->fd.mmio, &value, 4) != 4) {
					perror("Cannot write to MMIO reg");
					r = -1;
				}
			}
			break;
		case REG_SMC:
			r = umr_smc_write(asic, addr, value);
			break;
		default:
			fprintf(stderr, "[BUG]: Unsupported register type in umr_write_reg().\n");
			return -1;
	}

	switch (use_bank) {
		case 1:
			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
			break;
		case 2:
			umr_srbm_select_index(asic, 0, 0, 0, 0);
			break;
	}

	return r;
}
