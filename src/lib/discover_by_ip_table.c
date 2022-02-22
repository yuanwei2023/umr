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
#include <sys/types.h>
#include <dirent.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

struct umr_discovery_table_entry {
	char ipname[128];
	int die, instance, maj, min, rev;
	uint64_t segments[16];
	struct umr_discovery_table_entry *next;
};

// TODO: move this to lowlevel dir

/* dir struct for add_ip_intances
        ├── 1 <= hw_id use name aliases instead
        │   └── 0 <= instance of this IP block
        │       ├── base_addr <= list of segments in hex
        │       ├── hw_id
        │       ├── major <= dec
        │       ├── minor <= dec
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision <= dec
*/
static void add_ip_instances(struct umr_discovery_table_entry **det, int die_num, int *nblocks, char *diepath, char *ipname)
{
	DIR *ipdir;
	char linebuf[512], fname[1024], databuf[256];
	struct dirent *de;
	int x;
	FILE *f;

	snprintf(linebuf, (sizeof linebuf) - 1, "%s/%s", diepath, ipname);
	ipdir = opendir(linebuf);
	if (!ipdir)
		return;
	while ((de = readdir(ipdir))) {
		if (isdigit(de->d_name[0])) {
			snprintf(linebuf, (sizeof linebuf) - 1, "%s/%s/%s", diepath, ipname, de->d_name); // path to instance of ip block on given die
			(*det)->die = die_num;
			// base_addr list
			snprintf(fname, (sizeof fname) - 1, "%s/base_addr", linebuf);
			f = fopen(fname, "r");
				x = 0;
				while (fgets(databuf, sizeof databuf, f)) {
					if (sscanf(databuf, "%"SCNx64, &(*det)->segments[x]) != 1)
						break;
					++x;
				}
			fclose(f);
			// major
			snprintf(fname, (sizeof fname) - 1, "%s/major", linebuf);
			f = fopen(fname, "r");
				fgets(databuf, sizeof databuf, f);
				sscanf(databuf, "%d", &(*det)->maj);
			fclose(f);
			// minor
			snprintf(fname, (sizeof fname) - 1, "%s/minor", linebuf);
			f = fopen(fname, "r");
				fgets(databuf, sizeof databuf, f);
				sscanf(databuf, "%d", &(*det)->min);
			fclose(f);
			// revision
			snprintf(fname, (sizeof fname) - 1, "%s/revision", linebuf);
			f = fopen(fname, "r");
				fgets(databuf, sizeof databuf, f);
				sscanf(databuf, "%d", &(*det)->rev);
			fclose(f);
			// instance
			snprintf(fname, (sizeof fname) - 1, "%s/num_instance", linebuf);
			f = fopen(fname, "r");
				fgets(databuf, sizeof databuf, f);
				sscanf(databuf, "%d", &(*det)->instance);
			fclose(f);
			(*det)->next = calloc(1, sizeof **det);
			strcpy((*det)->ipname, ipname);
			for (x = 0; (*det)->ipname[x]; x++)
				(*det)->ipname[x] = tolower((*det)->ipname[x]);

			*det = (*det)->next;
			++(*nblocks);
		}
	}
	closedir(ipdir);
}

/* Dir structure
 *
.
└── die
    └── 0
        ├── 1 <= hw_id use name aliases instead
        │   └── 0 <= instance of this IP block
        │       ├── base_addr <= list of segments in hex
        │       ├── hw_id
        │       ├── major <= dec
        │       ├── minor <= dec
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision <= dec
*/
struct umr_discovery_table_entry *umr_parse_ip_discovery(int instance, int *nblocks, umr_err_output errout)
{
	DIR *top, *die;
	char linebuf[512];
	struct umr_discovery_table_entry *pdet, *det;
	struct dirent *de;
	int die_num;

	snprintf(linebuf, (sizeof linebuf) - 1, "/sys/class/drm/card%d/device/ip_discovery/die", instance);
	top = opendir(linebuf);
	if (!top) {
		errout("Cannot open IP discovery directory\n");
		return NULL;
	}

	pdet = det = calloc(1, sizeof *det);
	*nblocks = 0;
	// iterate over every die
	while ((de = readdir(top))) {
		if (strcmp(de->d_name, ".") && strcmp(de->d_name, "..")) {
			die_num = atoi(de->d_name);

			// process die directory
			snprintf(linebuf, (sizeof linebuf) - 1, "/sys/class/drm/card%d/device/ip_discovery/die/%s", instance, de->d_name);
			die = opendir(linebuf);
			if (!die) {
				errout("Cannot open IP discovery die directory\n");
				goto error;
			}
			while ((de = readdir(die))) {
				if (isalpha(de->d_name[0])) {
					add_ip_instances(&det, die_num, nblocks, linebuf, de->d_name);
				}
			}
			closedir(die);
		}
	}
	closedir(top);
	return pdet;
error:
	*nblocks = 0;
	closedir(top);
	closedir(die);
	det = pdet;
	while (det) {
		pdet = det->next;
		free(det);
		det = pdet;
	}
	return NULL;
}

static struct umr_ip_block *read_ip_block(struct umr_asic *asic, struct umr_discovery_table_entry *det, struct umr_database_scan_item *nit)
{
	FILE *f;
	char ipcmn[256], linebuf[512];
	uint32_t no_regs, x;
	struct umr_ip_block *ip;

	snprintf(linebuf, (sizeof linebuf) - 1, "%s/%s", nit->path, nit->fname);
	f = fopen(linebuf, "r");
	if (!f) {
		asic->err_msg("Could not open file %s\n", linebuf);
		return NULL;
	}
	ip = calloc(1, sizeof *ip);

	fgets(linebuf, sizeof(linebuf) - 1, f);
	sscanf(linebuf, "%"SCNu32, &no_regs);
	ip->no_regs = no_regs;
	ip->regs = calloc(no_regs, sizeof(*(ip->regs)));

	// swap for common names
	if (!strcmp(det->ipname, "gc")) {
		strcpy(ipcmn, "gfx");
	} else if (!strcmp(det->ipname, "uvd")) { // for any IP that has discovery UVD == VCN
		strcpy(ipcmn, "vcn");
	} else if (!strcmp(det->ipname, "dmu")) {
		strcpy(ipcmn, "dcn");
	} else {
		strcpy(ipcmn, det->ipname);
	}

	if (det->instance) {
		char ipname[512];
		snprintf(ipname, sizeof ipname - 1, "%s%d%d%d{%d}", ipcmn, det->maj, det->min, det->rev, det->instance);
		ip->ipname = strdup(ipname);
	} else {
		char ipname[512];
		snprintf(ipname, sizeof ipname - 1, "%s%d%d%d", ipcmn, det->maj, det->min, det->rev);
		ip->ipname = strdup(ipname);
	}

	x = 0;
	while (fgets(linebuf, sizeof linebuf, f)) {
		uint32_t y;
		struct {
			char name[128];
			int type;
			uint64_t addr;
			uint32_t nobits;
			uint32_t is64;
			uint32_t idx;
		} reg_fields;
		struct {
			char name[128];
			int start, stop;
		} bit_fields;

		if (sscanf(linebuf, "%s %d 0x%"PRIx64" %"PRIu32" %"PRIu32" %"PRIu32,
			reg_fields.name, &reg_fields.type, &reg_fields.addr,
			&reg_fields.nobits, &reg_fields.is64, &reg_fields.idx) != 6) {
				asic->err_msg("[ERROR]: Invalid regfile line [%s]\n", linebuf);
		}

		ip->regs[x].regname = strdup(reg_fields.name);
		ip->regs[x].type    = reg_fields.type;
		ip->regs[x].addr    = reg_fields.addr;
		if (ip->regs[x].type == REG_MMIO)
			ip->regs[x].addr += det->segments[reg_fields.idx];
		ip->regs[x].no_bits = reg_fields.nobits;
		ip->regs[x].bit64   = reg_fields.is64;

		if (reg_fields.nobits) {
			ip->regs[x].bits = calloc(reg_fields.nobits, sizeof(*(ip->regs[x].bits)));
			for (y = 0; y < reg_fields.nobits; y++) {
				fgets(linebuf, sizeof linebuf, f);
				sscanf(linebuf, "\t%s %d %d", bit_fields.name, &bit_fields.start, &bit_fields.stop);
				ip->regs[x].bits[y].regname = strdup(bit_fields.name);
				ip->regs[x].bits[y].start = bit_fields.start;
				ip->regs[x].bits[y].stop = bit_fields.stop;
				ip->regs[x].bits[y].bitfield_print = &umr_bitfield_default;
			}
		}
		++x;
	}
	fclose(f);
	return ip;
}

struct umr_asic *umr_discover_asic_by_discovery_table(char *asicname, struct umr_options *options, umr_err_output errout)
{
	struct umr_discovery_table_entry *det, *pdet;
	struct umr_database_scan_item *it, *nit;
	int numblocks, used_blocks, x, y;
	struct umr_asic *asic;

	// create discovery table
	det = umr_parse_ip_discovery(options->instance, &numblocks, errout);

	// create database of IP
	it = umr_database_scan(NULL);

	asic = calloc(1, sizeof *asic);
	asic->asicname = strdup(asicname);
	asic->options = *options;
	asic->no_blocks = numblocks;
	asic->blocks    = calloc(asic->no_blocks, sizeof(*(asic->blocks)));
	asic->family    = FAMILY_CONFIGURE;

	asic->parameters.vgpr_granularity = 2; // TODO: discover this at runtime, note this will break aldebaran support...
	if (!strcmp(asicname, "aldebaran")) // TODO: remove this workaround
		asic->parameters.vgpr_granularity = 3;

	asic->err_msg = errout;

	pdet = det;
	used_blocks = 0;
	while (det) {
		char cmnname[256];

		// some common names have to happen here to match up with ip database
		if (!strcmp(det->ipname, "clka")) {
			strcpy(cmnname, "clk");
		} else if (!strcmp(det->ipname, "clkb")) {
			strcpy(cmnname, "clk");
		} else if (!strcmp(det->ipname, "mp0")) {
			strcpy(cmnname, "mp");
		} else if (!strcmp(det->ipname, "mp1")) {
			strcpy(cmnname, "mp");
		} else if (!strcmp(det->ipname, "sdma1")) {
			strcpy(cmnname, "sdma");
		} else if (!strcmp(det->ipname, "uvd")) {
			strcpy(cmnname, "vcn");
		} else if (!strcmp(det->ipname, "dmu")) {
			strcpy(cmnname, "dcn");
		} else {
			strcpy(cmnname, det->ipname);
		}

		nit = umr_database_find_ip(it, cmnname,
			det->maj, det->min, det->rev, options->desired_path[0] ? options->desired_path : NULL);
		if (nit)
			asic->blocks[used_blocks++] = read_ip_block(asic, det, nit);
		det = det->next;
	}
	asic->no_blocks = used_blocks - 1;

	// scan blocks for missing {0}
	for (x = 0; x < asic->no_blocks; x++) {
		if (!strstr(asic->blocks[x]->ipname, "{")) {
			for (y = 0; y < asic->no_blocks; y++) {
				if (x != y && strstr(asic->blocks[y]->ipname, asic->blocks[x]->ipname))
					break;
			}
			if (y != asic->no_blocks) {
				char tmpbuf[256];
				memset(tmpbuf, 0, sizeof tmpbuf);
				snprintf(tmpbuf, sizeof tmpbuf - 1, "%s{0}", asic->blocks[x]->ipname);
				free(asic->blocks[x]->ipname);
				asic->blocks[x]->ipname = strdup(tmpbuf);
			}
		}
	}

	det = pdet;
	while (det) {
		pdet = det->next;
		free(det);
		det = pdet;
	}
	umr_database_free_scan_items(it);
	return asic;
}
