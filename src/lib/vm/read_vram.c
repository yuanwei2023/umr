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
 * Authors: Tom St Denis <tom.stdenis@amd.com>
 *
 */
#include "umr.h"
#include <inttypes.h>

/** round_up_pot -- Round up value to next power of two */
static uint64_t round_up_next_gib(uint64_t x)
{
	uint64_t y = (1024ULL * 1024 * 1024); // start at 1GiB
	while (y < x)
		y += 1024UL * 1024 * 1024;
	return y;
}

/**
 * umr_access_vram - Access GPU mapped memory
 *
 * @vmid:	The VMID that the address belongs to.  The bits 8:15
 * 			indicate which hub the memory belongs to:
 *
 * 				UMR_LINEAR_HUB: The memory is a physical address in the VRAM
 * 				UMR_GFX_HUB: The memory is a virtual address controlled by the GFX hub
 * 				UMR_MM_HUB: The memory is a virtual address controlled by the MM hub
 *
 *			The bits 0:7 indicate which VM to access (if any).
 *
 * @partition: The VM partition to be used (refers to different INST of VM register blocks)
 * @address: The address of the memory to access must be word aligned
 * @size:  The number of bytes to read
 * @data:  The buffer to read from/write to
 * @write_en:  Set to 0 to read, non-zero to write
 *
 * Returns -1 on error.
 */
int umr_access_vram(struct umr_asic *asic, int partition, uint32_t vmid, uint64_t address, uint32_t size, void *data, int write_en, struct umr_vm_pagewalk *vmdata)
{
	int maj, min;

	umr_gfx_get_ip_ver(asic, &maj, &min);

	// only aligned reads
	if ((address & 3) || (size & 3)) {
		asic->err_msg("[ERROR]:  The address and size must be a multiple of 4 to access VRAM\n");
		return -1;
	}

	// only aligned destinations
	if (((intptr_t)data) & 3) {
		asic->err_msg("[BUG]: vram read destination is not 4-byte aligned\n");
		return -1;
	}

	// read/write from process space
	if ((vmid & 0xFF00) == UMR_PROCESS_HUB) {
		if (!write_en)
			memcpy(data, (char *)address, size);
		else
			memcpy((char *)address, data, size);
		return 0;
	}

	// mask VM addresses
	if ((vmid & 0xFF00) != UMR_LINEAR_HUB && asic->family > FAMILY_VI)
		address &= 0xFFFFFFFFFFFFULL;

	if ((vmid & 0xFF00) == UMR_LINEAR_HUB) {
		// if we are using xgmi let's find the device for this address
		// in an XGMI hive the XGMI nodes memory are concatenated together
		// end to end.  so a linear address referenced by one node might
		// be in another node in the hive
		if (asic->options.use_xgmi) {
			// TODO: This code does NOT support a page that
			// spans multiple nodes.  That sort of setup is probably
			// not used in the wild but we should keep note of it
			int n;
			uint64_t addr = address;
			uint64_t segment_size;

			// compute XGMI node segment size based on MC registers
			// this varies depending on the architecture so we try
			// all LFB_SIZE registers
			if (umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "@mmMC_VM_XGMI_LFB_SIZE_ALDE")) {
				segment_size = umr_read_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmMC_VM_XGMI_LFB_SIZE_ALDE") << 24ULL;
			} else if (umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "@mmMC_VM_XGMI_LFB_SIZE")) {
				segment_size = umr_read_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmMC_VM_XGMI_LFB_SIZE") << 24ULL;
			} else if (umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "@mmGCMC_VM_XGMI_LFB_SIZE")) {
				segment_size = umr_read_reg_by_name_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmGCMC_VM_XGMI_LFB_SIZE") << 24ULL;
			} else {
				// fallback to just rounding up vram size
				segment_size = 0;
			}

			// copy callbacks so that sysram/vram accesses
			// go through callbacks when we use other nodes
			if (!asic->config.xgmi.callbacks_applied)
				umr_apply_callbacks(asic, &asic->mem_funcs, &asic->reg_funcs);

			for (n = 0; asic->config.xgmi.nodes[n].asic; n++) {
				// if remaining address is within this nodes VRAM size use it
				if (addr < (segment_size ? segment_size : asic->config.xgmi.nodes[n].asic->config.vram_size)) {
					asic = asic->config.xgmi.nodes[n].asic;
					address = addr;
					if ((address + size) > asic->config.xgmi.nodes[n].asic->config.vram_size) {
						asic->err_msg("[BUG]: Block being read spans multiple XGMI nodes and this isn't supported by UMR.\n");
					}
					break;
				} else {
					// otherwise subtract this vram size from the address and go to the next device
					addr -= segment_size ? segment_size : round_up_next_gib(asic->config.xgmi.nodes[n].asic->config.vram_size);
				}
			}
			// now {asic, address} are the device and it's relative address
			// that corresponds to the hive address the caller passed
		}

		// use callback for linear access if applicable
		return asic->mem_funcs.access_linear_vram(asic, address, size, data, write_en);
	}

	// if we hit this point we have a VM address to pagewalk so we can finally access
	// the page in question, since <= VI and >= AI are different enough
	// we branch depending on the GFX version
	if (maj <= 8) {
			return umr_access_vram_vi(asic, vmid, address, size, data, write_en, vmdata);
	} else {
			return umr_access_vram_ai(asic, partition, vmid, address, size, data, write_en, vmdata);
	}

	return 0;
}
