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
#include <umr.h>

/**
 * The "packet" routines are meant to be a wrapper around all of the
 * different packet functions supported (pm4, sdma, etc).  Ideally,
 * applications should call the umr_packet_*() functions where possible
 * instead of calling the lower level functions directly.
 */

 struct umr_packet_stream *umr_packet_decode_buffer(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	uint32_t from_vmid, uint64_t from_addr,
	uint32_t *stream, uint32_t nwords, enum umr_ring_type rt, void *queue_data)
{
	return umr_packet_decode_buffer_ex(asic, ui, from_vmid, from_addr, stream, nwords, rt, queue_data, UMR_PACKET_IP_VERSION_AUTO);
}

/**
 * umr_packet_decode_buffer - Decode packets from a process mapped buffer
 * @asic: The ASIC model the packet decoding corresponds to
 * @ui: A user interface to provide sizing and other information for unhandled opcodes
 * @from_vmid: Which VMID space did this buffer come from
 * @from_addr: The address this buffer came from
 * @stream: An array of 32-bit words corresponding to the packet data to decode
 * @nwords: How many words are in the @stream array
 * @rt: What type of packets are to be decoded?
 * @queue_data: Opaque pointer you can pass to be used by the decoder chosen by 'rt'.
 *
 * Returns a pointer to a umr_packet_stream structure if successful.
 */
struct umr_packet_stream *umr_packet_decode_buffer_ex(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	uint32_t from_vmid, uint64_t from_addr,
	uint32_t *stream, uint32_t nwords, enum umr_ring_type rt, void *queue_data, int32_t ip_version)
{
	struct umr_packet_stream *str;
	void *p = NULL;

	str = calloc(1, sizeof *str);
	str->type = rt;
	str->ui = ui;
	str->asic = asic;
	str->from_vmid = from_vmid;
	str->from_addr = from_addr;

	switch (rt) {
		case UMR_RING_PM4:
			p = str->stream.pm4 = umr_pm4_decode_stream(asic, asic->options.vm_partition, from_vmid, from_addr, stream, nwords, queue_data, ip_version);
			break;
		case UMR_RING_PM4_LITE:
			p = str->stream.pm4 = umr_pm4_lite_decode_stream(asic, asic->options.vm_partition, from_vmid, stream, nwords, ip_version);
			break;
		case UMR_RING_SDMA:
			p = str->stream.sdma = umr_sdma_decode_stream(asic, ui, asic->options.vm_partition, from_addr, from_vmid, stream, nwords, ip_version);
			break;
		case UMR_RING_MES:
			p = str->stream.mes = umr_mes_decode_stream(asic, stream, nwords, ip_version);
			break;
		case UMR_RING_VPE:
			p = str->stream.vpe = umr_vpe_decode_stream(asic, asic->options.vm_partition, from_addr, from_vmid, stream, nwords, ip_version);
			break;
		case UMR_RING_UMSCH:
			p = str->stream.umsch = umr_umsch_decode_stream(asic, asic->options.vm_partition, from_addr, from_vmid, stream, nwords, ip_version);
			break;
		case UMR_RING_HSA:
			p = str->stream.hsa = umr_hsa_decode_stream(asic, stream, nwords, ip_version);
			break;
		case UMR_RING_VCN_ENC:
			p = str->stream.enc = umr_vcn_enc_decode_stream(asic, stream, nwords, ip_version);
			break;
		case UMR_RING_VCN_DEC:
			p = str->stream.pm4 = umr_vcn_dec_decode_stream(asic, from_vmid, stream, nwords, ip_version);
			break;
		case UMR_RING_UNK:
		default:
			free(str);
			asic->err_msg("[BUG]: Invalid ring type in packet_decode_buffer()\n");
			return NULL;
	}

	if (!p) {
		asic->err_msg("[ERROR]: Could not create packet stream object in packet_decode_buffer()\n");
		free(str);
		return NULL;
	}
	str->cont = p;

	return str;
}

/* apply the rules for start/stop indexing into the packet dword buffer
 *
 * -1,-1 means from rptr to wptr
 * num1,num2 means literally from num1 to num2
 * num1,-1 means from wptr - num1 to wptr
 * -1,num1 means from rptr to rptr + num1
 */
static void apply_start_stop(int *start, int *stop, int rptr, int wptr, int ringsize)
{
	if (*start == -1 && *stop != -1) {
			*start = rptr; // use rptr
			*stop   = *start + *stop; // read k words from RPTR
	} else if (*start != -1 && *stop == -1) {
			*stop = wptr; // use wptr
			*start = *stop - *start; // read k words before WPTR
	} else if (*start == -1 && *stop == -1) {
			*start = rptr;
			*stop = wptr;
	} else if (*start == -1) {
			*start = rptr;
	} else if (*stop == -1) {
			*stop = wptr;
	}

	if (*start < 0) {
			*start = ringsize + *start;
	}
}

struct umr_packet_stream *umr_packet_decode_ring(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	char *ringname, int halt_waves, int *start, int *stop, enum umr_ring_type rt, void *queue_data)
{
	return umr_packet_decode_ring_ex(asic, ui, ringname, halt_waves, start, stop, rt, queue_data, UMR_PACKET_IP_VERSION_AUTO);
}

/**
 * umr_packet_decode_ring - Decode packets from a system kernel ring
 * @asic: The ASIC model the packet decoding corresponds to
 * @ui: A user interface to provide sizing and other information for unhandled opcodes
 * @ringname: The filename of the ring to read from
 * @halt_waves: Should we issue an SQ_CMD HALT command?
 * @start: Where to start reading from in the rings words
 * @stop: Where to stop reading from in the rings words
 * @rt: What type of packets are to be decoded?
 * @queue_data: Opaque pointer to pass to decoder
 *
 * Returns a pointer to a umr_packet_stream structure if successful.
 */
struct umr_packet_stream *umr_packet_decode_ring_ex(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	char *ringname, int halt_waves, int *start, int *stop, enum umr_ring_type rt, void *queue_data, int32_t ip_version)
{
	void *ps = NULL;
	uint32_t *ringdata = NULL, ringsize = 0;
	int only_active = 1;

	if (halt_waves && asic->options.halt_waves) {
		strcpy(asic->options.ring_name, ringname);
		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT, 100);
	}

	if (rt == UMR_RING_GUESS) {
		if (!strcmp(ringname, "uq")) {
			if (asic->options.user_queue.state.active) {
				ringdata = calloc(asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size, sizeof *ringdata);
				if (!asic->options.use_full_user_queue) {
					if (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value == asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value) {
						asic->err_msg("[ERROR]: The user queue's RPTR and WPTR are equal.  You can try using -O use_full_user_queue instead to read the entire queue.\n");
						// free the buffer so we don't decode garbage
						free(ringdata);
						ringdata = NULL;
						goto cleanup;
					} else {
						apply_start_stop(start, stop,
							asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_rptr_value,
							asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_wptr_poll_value,
							asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size);
					}
				} else {
					// use the full queue
					*start = 0;
					*stop = asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;
				}
				if (ringdata) {
					// AQL RPTR/WPTR is in terms of 64-byte (16 dword) packets
					// we need to do AQL math in 32-bit word terms because other
					// queues are all in terms of 32-bits
					if (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type == UMR_QUEUE_COMPUTE) {
						*start = (*start * 16) % asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;
						*stop = (*stop * 16) % asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].rb_buf_size;

						// enable disasm_early_term because they don't use the same terminals as mesa
						asic->options.disasm_early_term = 1;
					}
					// continue, so at this point we read the queue like a ring (allowing start > stop)
					if (umr_read_user_queue_buffer(asic, *start, *stop, ringdata, &ringsize)) {
						asic->err_msg("[ERROR]: Could not decode packet stream fetched from the user queue.");
						free(ringdata);
						ringdata = NULL;
						goto cleanup;
					} else {
						switch (asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type) {
							case UMR_QUEUE_COMPUTE_PM4:
							case UMR_QUEUE_GFX: rt = UMR_RING_PM4; break;
							case UMR_QUEUE_COMPUTE: rt = UMR_RING_HSA; break;
							case UMR_QUEUE_SDMA: rt = UMR_RING_SDMA; break;
							default:
								asic->err_msg("[BUG]: Unsupported queue type [%d] (%s:%d)\n", asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].queue_type, __FILE__, __LINE__);
								free(ringdata);
								ringdata = NULL;
								goto cleanup;
						}
						ps = umr_packet_decode_buffer(asic, ui, 0, asic->options.user_queue.client_info.queue[asic->options.user_queue.state.qidx].hqd_base_addr + *start * 4, ringdata, ringsize, rt, queue_data);
						free(ringdata);
						ringdata = NULL;
						goto cleanup;
					}
				}
			} else {
				asic->err_msg("[ERROR]: User queue is not active, did you use a --user-queue command?\n");
				goto cleanup;
			}
		} else if (!memcmp(ringname, "gfx", 3) ||
			!memcmp(ringname, "uvd", 3) ||
			!memcmp(ringname, "mes_kiq", 7) ||
			!memcmp(ringname, "kiq", 3) ||
			!memcmp(ringname, "comp", 4)) {
			// only decode PM4 packets on certain rings
			rt = UMR_RING_PM4;
		} else if (!memcmp(ringname, "vcn_enc", 7) ||
			!memcmp(ringname, "vcn_unified_", 12)) {
			rt = UMR_RING_VCN_ENC;
		} else if (!memcmp(ringname, "vcn_dec", 7)) {
			rt = UMR_RING_VCN_DEC;
		} else if (!memcmp(ringname, "sdma", 4) ||
			   !memcmp(ringname, "page", 4)) {
			rt = UMR_RING_SDMA;
		} else if (!memcmp(ringname, "mes", 3)) {
			rt = UMR_RING_MES;
		} else if (!memcmp(ringname, "vpe", 3)) {
			rt = UMR_RING_VPE;
		} else if (!memcmp(ringname, "umsch", 5)) {
			rt = UMR_RING_UMSCH;
		} else {
			asic->err_msg("[ERROR]: Unknown ring type <%s> for umr_packet_decode_ring()\n", ringname);
			return NULL;
		}
	}

	// read ring data and reduce indeices modulo ring size
	// since the kernel returned values might be unwrapped.
	if (!ringdata) {
		ringdata = asic->ring_func.read_ring_data(asic, ringname, &ringsize);
		if ((*stop != -1) && (uint32_t)(*stop * 4) >= ringsize)
			*stop = (ringsize / 4);
	}

	if (ringdata) {
		ringsize /= 4;
		ringdata[0] %= ringsize;
		ringdata[1] %= ringsize;

		if (*start != -1 || *stop != -1) {
			only_active = 0;
		}

		apply_start_stop(start, stop, ringdata[0], ringdata[1], ringsize);

		// reduce indeices modulo ring size
		if ((uint32_t)*stop > ringsize) {
			*stop = *stop - ringsize;
		}

		// only proceed if there is data to read
		// and then linearize it so that the stream
		// decoder can do it's thing
		if (!only_active || *start != *stop) { // rptr != wptr
			int o_start = *start;
			uint32_t *lineardata, linearsize;

			// copy ring data into linear array
			lineardata = calloc(ringsize, sizeof(*lineardata));
			linearsize = 0;
			while (*start != *stop && linearsize < ringsize) {
				lineardata[linearsize++] = ringdata[3 + *start];  // first 3 words are rptr/wptr/dwptr
				*start = (*start + 1) % ringsize;
			}
			*start = o_start;
			ps = umr_packet_decode_buffer_ex(asic, ui, 0, 0, lineardata, linearsize, rt, queue_data, ip_version);
			free(lineardata);
		}
	}
	free(ringdata);

cleanup:
	if (halt_waves && asic->options.halt_waves)
		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME, 0);

	return ps;
}

struct umr_packet_stream *umr_packet_decode_vm_buffer(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	uint32_t vmid, uint64_t addr, uint32_t nwords, enum umr_ring_type rt, void *queue_data)
{
	return umr_packet_decode_vm_buffer_ex(asic, ui, vmid, addr, nwords, rt, queue_data, UMR_PACKET_IP_VERSION_AUTO);
}

/**
 * umr_packet_decode_vm_buffer - Decode packets from a GPU mapped buffer
 * @asic: The ASIC model the packet decoding corresponds to
 * @ui: A user interface to provide sizing and other information for unhandled opcodes
 * @vmid: Which VMID space did this buffer come from
 * @addr: The address this buffer came from
 * @nwords: How many words are in the @stream array
 * @rt: What type of packets are to be decoded?
 * @queue_data: Opaque pointer to pass along to decoder
 *
 * Returns a pointer to a umr_packet_stream structure if successful.
 */
struct umr_packet_stream *umr_packet_decode_vm_buffer_ex(struct umr_asic *asic, struct umr_stream_decode_ui *ui,
	uint32_t vmid, uint64_t addr, uint32_t nwords, enum umr_ring_type rt, void *queue_data, int32_t ip_version)
{
	uint32_t *words;
	struct umr_packet_stream *str;

	words = calloc(nwords, sizeof *words);
	if (!words) {
		asic->err_msg("[ERROR]: Out of memory\n");
		return NULL;
	}
	if (umr_read_vram(asic, asic->options.vm_partition, vmid, addr, nwords * 4, words)) {
		asic->err_msg("[ERROR]: Could not read vram %" PRIx32 "@0x%"PRIx64"\n", vmid, addr);
		free(words);
		return NULL;
	}
	str = umr_packet_decode_buffer_ex(asic, ui, vmid, addr, words, nwords, rt, queue_data, ip_version);
	free(words);
	return str;
}

/**
 * umr_packet_free - Free memory allocated for packet stream
 * @stream: Stream to free memory from.
 *
 */
void umr_packet_free(struct umr_packet_stream *stream)
{
	if (stream) {
		switch (stream->type) {
			case UMR_RING_PM4:
			case UMR_RING_PM4_LITE:
			case UMR_RING_VCN_DEC:
				umr_free_pm4_stream(stream->stream.pm4);
				break;
			case UMR_RING_SDMA:
				umr_free_sdma_stream(stream->stream.sdma);
				break;
			case UMR_RING_MES:
				umr_free_mes_stream(stream->stream.mes);
				break;
			case UMR_RING_VPE:
				umr_free_vpe_stream(stream->stream.vpe);
				break;
			case UMR_RING_UMSCH:
				umr_free_umsch_stream(stream->stream.umsch);
				break;
			case UMR_RING_HSA:
				umr_free_hsa_stream(stream->stream.hsa);
				break;
			case UMR_RING_VCN_ENC:
				umr_free_vcn_enc_stream(stream->stream.enc);
				break;
			case UMR_RING_UNK:
			default:
				stream->asic->err_msg("[BUG]: Invalid ring type in packet_free() call.\n");
		}
		free(stream);
	}
}

/**
 * umr_packet_find_shader - Find a shader or compute kernel in a stream
 * @stream: An array of 32-bit words corresponding to the packet data to decode
 * @vmid: Which VMID space does the kernel belong to
 * @addr: An address inside the kernel program (doesn't have to be start of program)
 *
 * Returns a poiner to a umr_shaders_pgm structure if the shader program is found.
 */
struct umr_shaders_pgm *umr_packet_find_shader(struct umr_asic *asic, struct umr_packet_stream *stream, unsigned vmid, uint64_t addr)
{
	switch (stream->type) {
		case UMR_RING_PM4:
		case UMR_RING_PM4_LITE:
			return umr_find_shader_in_pm4_stream(asic, stream->stream.pm4, vmid, addr);

		case UMR_RING_HSA:
			return umr_find_shader_in_hsa_stream(asic, stream->stream.hsa, vmid, addr);

		case UMR_RING_SDMA:
		case UMR_RING_MES:
		case UMR_RING_VPE:
		case UMR_RING_UMSCH:
		case UMR_RING_VCN_ENC:
		case UMR_RING_VCN_DEC:
			stream->asic->err_msg("[BUG]: Cannot find shader in UMSCH, VPE, MES, SDMA, or VCN enc/dec types of streams\n");
			return NULL;

		case UMR_RING_UNK:
		default:
			stream->asic->err_msg("[BUG]: Invalid ring type in packet_find_shader()\n");
			return NULL;
	}
}

/**
 * umr_packet_disassemble_stream - Disassemble a stream's packets into quantized data
 * @stream: The pre decoded packet stream
 * @ib_addr: The address the stream resides at
 * @ib_vmid: The VMID the stream comes from
 * @from_addr: The address of another packet if any that points to this stream
 * @from_vmid: The VMID of another packet if any that points to this stream
 * @opcodes: How many packets to decode (~0UL for infinite)
 * @follow: Should we follow IBs and BOs to further decode
 * @cont: Are we continuing disassembly or starting at the start of the stream?
 *
 * Returns the pointer to the umr_packet_stream being processed.
 */
struct umr_packet_stream *umr_packet_disassemble_stream(struct umr_packet_stream *stream, uint64_t ib_addr, uint32_t ib_vmid,
							uint64_t from_addr, uint64_t from_vmid, unsigned long opcodes, int follow, int cont)
{
	switch (stream->type) {
		case UMR_RING_PM4:
			stream->cont = umr_pm4_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.pm4, ib_addr, ib_vmid,
							     from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_PM4_LITE:
			stream->cont = umr_pm4_lite_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.pm4, ib_addr, ib_vmid,
							     from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_SDMA:
			stream->cont = umr_sdma_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.sdma, ib_addr, ib_vmid,
							     from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_MES:
			stream->cont = umr_mes_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.mes, ib_addr, ib_vmid, opcodes);
			break;
		case UMR_RING_VPE:
			stream->cont = umr_vpe_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.vpe, ib_addr, ib_vmid,
														 from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_UMSCH:
			stream->cont = umr_umsch_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.umsch, ib_addr, ib_vmid,
														 from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_HSA:
			stream->cont = umr_hsa_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.hsa, ib_addr, ib_vmid, opcodes);
			break;
		case UMR_RING_VCN_ENC:
			stream->cont = umr_vcn_enc_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.enc, ib_addr, ib_vmid,
							     from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_VCN_DEC:
			stream->cont = umr_vcn_dec_decode_stream_opcodes(stream->asic, stream->ui, cont ? stream->cont : stream->stream.pm4, ib_addr, ib_vmid,
							     from_addr, from_vmid, opcodes, follow);
			break;
		case UMR_RING_UNK:
		default:
			stream->asic->err_msg("[BUG]: Invalid ring type in packet_disassemble_stream() call.\n");
			return NULL;
	}
	return stream;
}

/**
 * umr_packet_disassemble_stream - Disassemble a stream's packets into quantized data
 * @asic: The ASIC model the packet decoding corresponds to
 * @ui: A user interface cabllack to present data
 * @ib_addr: The address the stream resides at
 * @ib_vmid: The VMID the stream comes from
 * @from_addr: The address of another packet if any that points to this stream
 * @from_vmid: The VMID of another packet if any that points to this stream
 * @follow: Should we follow IBs and BOs to further decode
 * @rt: What type of packets are to be decoded?
 * @queue_data: Opaque pointer to pass to the decoder
 *
 * Returns -1 on error.
 */
int umr_packet_disassemble_opcodes_vm(struct umr_asic *asic, struct umr_stream_decode_ui *ui, uint64_t ib_addr, uint32_t ib_vmid, uint32_t nwords, uint64_t from_addr, uint64_t from_vmid, int follow, enum umr_ring_type rt, void *queue_data)
{
	struct umr_packet_stream *str;

	str = umr_packet_decode_vm_buffer(asic, ui, ib_vmid, ib_addr, nwords, rt, queue_data);
	if (str) {
		umr_packet_disassemble_stream(str, ib_addr, ib_vmid, from_addr, from_vmid, ~0ULL, follow, 0);
		umr_packet_free(str);
		return 0;
	}
	return -1;
}
