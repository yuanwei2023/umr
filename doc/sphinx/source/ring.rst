====================
Ring and IB Decoding
====================

UMR can read the contents of the various GPU rings and for certain
rings (gfx/compute/vcn/uvd/sdma) decode the packets.  The ring
read command has the following form:

::

	umr --ring-stream <name>([from:to])

The command reads from a ring with the specified name.  The names
come from the debugfs entries without the amdgpu\_ring\_ prefix.  The
second half of command is optional.  When the range is not included
the entire ring is dumped without decoding enabled.  This is useful
if you know were in the ring you want to inspect but also see the
words surrounding the contents you're interested in.

If the range is  included it must be included in square brackets.  The
start, or stop, or both ranges may be included.  If a stop range is
specified it will read from the read pointer for the specified number of
words.  For instance:

::

	umr --ring-stream gfx[.:k]

Will read from the read pointer for 'k' words.  Alternatively,

::

	umr --ring-stream gfx[k:.]

will read from 'k' words before the write pointer.  Finally,

::

	umr --ring-stream gfx[0:9]

Will read the first 10 words of the gfx ring.

To read the pending data in the ring the form '[.]' may be used.
This will read data from the ring read pointer to the ring write
pointer.  If the read and write pointer are not equal it will enable
the decoder between those ranges.  For instance,

::

	umr --ring-stream gfx[.]

Might produce output similar to:

::

	Decoding IB at 0@0x0 from 0@0x0 of 257 words (type 4)
	[0@0x00000000 + 0x0000]	[0xffff1000]	Opcode 0x10 [PKT3_NOP] (0 words, type: 3, hdr: 0xffff1000)
	[0@0x00000000 + 0x0004]	[0xc0032200]	Opcode 0x22 [PKT3_COND_EXEC] (4 words, type: 3, hdr: 0xc0032200)
	[0@0x00000000 + 0x0008]	[0x00400080]	|---> GPU_ADDR_LO32=0x400080
	[0@0x00000000 + 0x000c]	[0x000000ff]	|---> GPU_ADDR_HI32=0xff
	[0@0x00000000 + 0x0010]	[0x00000000]	|---> TEST_VALUE=0x0
	[0@0x00000000 + 0x0014]	[0x0000002f]	|---> PATCH_VALUE=0x2f
	[0@0x00000000 + 0x0018]	[0xc0053c00]	Opcode 0x3c [PKT3_WAIT_REG_MEM] (6 words, type: 3, hdr: 0xc0053c00)
	[0@0x00000000 + 0x001c]	[0x00000143]	|---> ENGINE=[PFP]/1, MEMSPACE=[REG]/0, OPERATION=1, FUNCTION=[==]/3
	[0@0x00000000 + 0x0020]	[0x00001537]	|---> POLL_ADDRESS_LO=0x1534, SWAP=0x3
	[0@0x00000000 + 0x0024]	[0x00001538]	|---> POLL_ADDRESS_HI=0x1538
	[0@0x00000000 + 0x0028]	[0x00000001]	|---> REFERENCE=0x1
	[0@0x00000000 + 0x002c]	[0x00000001]	|---> MASK=0x1
	[0@0x00000000 + 0x0030]	[0x00000020]	|---> POLL INTERVAL=0x20
	[0@0x00000000 + 0x0034]	[0xc0004600]	Opcode 0x46 [PKT3_EVENT_WRITE] (1 words, type: 3, hdr: 0xc0004600)
	[0@0x00000000 + 0x0038]	[0x0000040f]	|---> EVENT_TYPE=15, EVENT_INDEX=4
	[0@0x00000000 + 0x003c]	[0xc0004600]	Opcode 0x46 [PKT3_EVENT_WRITE] (1 words, type: 3, hdr: 0xc0004600)
	[0@0x00000000 + 0x0040]	[0x00000024]	|---> EVENT_TYPE=36, EVENT_INDEX=0
	[0@0x00000000 + 0x0044]	[0xc0012800]	Opcode 0x28 [PKT3_CONTEXT_CONTROL] (2 words, type: 3, hdr: 0xc0012800)
	[0@0x00000000 + 0x0048]	[0x81018003]	|---> LOAD_EN=1, LOAD_CS=1, LOAD_GFX=1, LOAD_MULTI=1, LOAD_SINGLE=1
	...<snip>...

This mode useful for examining live traffic or traffic that has resulted
in a GPU hang and has yet to be fully read by the packet processor.

When an IB is found it will be decoded after the ring in the
order of appearance.  An example decoding is:

::

	Decoding IB at 7@0x223000 from 0@0x8c of 512 words (type 4)
	[7@0x00223000 + 0x0000] [0xc0012800]    Opcode 0x28 [PKT3_CONTEXT_CONTROL] (2 words, type: 3, hdr: 0xc0012800)
	[7@0x00223000 + 0x0004] [0x80000000]    |---> LOAD_EN=1, LOAD_CS=0, LOAD_GFX=0, LOAD_MULTI=0, LOAD_SINGLE=0
	[7@0x00223000 + 0x0008] [0x80000000]    |---> SHADOW_EN=1, SHADOW_CS=0, SHADOW_GFX=0, SHADOW_MULTI=0, SHADOW_SINGLE=0
	[7@0x00223000 + 0x000c] [0xc0001200]    Opcode 0x12 [PKT3_CLEAR_STATE] (1 words, type: 3, hdr: 0xc0001200)
	[7@0x00223000 + 0x0010] [0x00000000]    |---> CMD=0
	[7@0x00223000 + 0x0014] [0xc0026900]    Opcode 0x69 [PKT3_SET_CONTEXT_REG] (3 words, type: 3, hdr: 0xc0026900)
	[7@0x00223000 + 0x001c] [0x80000000]    |---> gfx800.mmPA_SC_GENERIC_SCISSOR_TL=0x80000000
	[7@0x00223000 + 0x0020] [0x40004000]    |---> gfx800.mmPA_SC_GENERIC_SCISSOR_BR=0x40004000
	[7@0x00223000 + 0x0024] [0xc0016900]    Opcode 0x69 [PKT3_SET_CONTEXT_REG] (2 words, type: 3, hdr: 0xc0016900)
	[7@0x00223000 + 0x002c] [0x42800000]    |---> gfx800.mmVGT_HOS_MAX_TESS_LEVEL=0x42800000
	[7@0x00223000 + 0x0030] [0xc0026900]    Opcode 0x69 [PKT3_SET_CONTEXT_REG] (3 words, type: 3, hdr: 0xc0026900)
	[7@0x00223000 + 0x0038] [0x01000600]    |---> gfx800.mmTA_BC_BASE_ADDR=0x1000600
	[7@0x00223000 + 0x003c] [0x00000000]    |---> gfx800.mmTA_BC_BASE_ADDR_HI=0x0
	...<snip>...

The first line of every IB decoding indicates it's VM placement with
both the hub name (currently gfx or mm) and VMID/offset pair.  Followed
by the number of words and where it came from.

The ring decoder can also detect shader programs and disassemble
them as well.  If the UMD uses the quintuple 0xBF9F0000 opcode
markers to mark the end of the shader then this functionality
can be used automatically.  If your UMD does not then the option
'disasm_early_term' can be used to terminate disassembly once the
first 's_endpgm' opcode is found.

The shader output includes where the shader was source from, it's type, as well as
the register writes detected inside the command submission.  Shader disassemblies resemble:

::

	Shader from 0x3@[0x800000b2a400 + 0xb68] at 0x3@0x800000e00000, type ES (5), size 1912
	Shader registers (unfiltered):
		gfx1201.regCB_BLEND0_CONTROL(3@0xb2adac) == 0x0
			COLOR_SRCBLEND[0:4] == 0x0
			COLOR_COMB_FCN[5:7] == 0x0
			COLOR_DESTBLEND[8:12] == 0x0
			ALPHA_SRCBLEND[16:20] == 0x0
			ALPHA_COMB_FCN[21:23] == 0x0
			ALPHA_DESTBLEND[24:28] == 0x0
			SEPARATE_ALPHA_BLEND[29:29] == 0x0
			ENABLE[30:30] == 0x0
			DISABLE_ROP3[31:31] == 0x0
		gfx1201.regCB_BLEND_ALPHA(3@0xb2aae0) == 0x0
		gfx1201.regCB_BLEND_BLUE(3@0xb2aadc) == 0x0
		gfx1201.regCB_BLEND_GREEN(3@0xb2aad8) == 0x0
		gfx1201.regCB_BLEND_RED(3@0xb2aad4) == 0x0
		gfx1201.regCB_COLOR0_ATTRIB(3@0xb2a918) == 0x0
			NUM_FRAGMENTS[0:1] == 0x0
			FORCE_DST_ALPHA_1[2:2] == 0x0
			FORCE_LIMIT_COLOR_SECTOR_TO_256B_MAX[3:3] == 0x0
	<... snip ...>

	Shader program:
		pgm[3@0x800000e00000 + 0x0   ] = 0xbefe01c1		s_mov_b64 exec, -1                                         	
		pgm[3@0x800000e00000 + 0x4   ] = 0xd71f0001		v_mbcnt_lo_u32_b32 v1, -1, 0                               	
		pgm[3@0x800000e00000 + 0x8   ] = 0x000100c1	;;                                                          	
		pgm[3@0x800000e00000 + 0xc   ] = 0xbe840011		s_mov_b32 s4, s17                                          	
		pgm[3@0x800000e00000 + 0x10  ] = 0xbe9c000a		s_mov_b32 s28, s10                                         	
		pgm[3@0x800000e00000 + 0x14  ] = 0xbf0c9b0c		s_bitcmp0_b32 s12, 27                                      	
		pgm[3@0x800000e00000 + 0x18  ] = 0xbfa20024		s_cbranch_scc1 36                                          	
		pgm[3@0x800000e00000 + 0x1c  ] = 0x7e040281		v_mov_b32_e32 v2, 1                                        	
		pgm[3@0x800000e00000 + 0x20  ] = 0xbf8704b1		s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)	
		pgm[3@0x800000e00000 + 0x24  ] = 0x7c9a0480		v_cmp_ne_u32_e32 vcc_lo, 0, v2                             	
		pgm[3@0x800000e00000 + 0x28  ] = 0xd7200002		v_mbcnt_hi_u32_b32 v2, -1, v1                              	
		pgm[3@0x800000e00000 + 0x2c  ] = 0x000202c1	;;                                                          	
	<... snip ...>
		pgm[3@0x800000e00000 + 0x76c ] = 0xbfa6ff66		s_cbranch_execnz 65382                                     	
		pgm[3@0x800000e00000 + 0x770 ] = 0xbfa0ff76		s_branch 65398                                             	
		pgm[3@0x800000e00000 + 0x774 ] = 0xbf9f0000		s_code_end                                                 	
	Done disassembly of shader


Which indicates the VMID and address of the shader, how many bytes it
is and where it was found.  In this case this shader was indicated
by a DRAW or DISPATCH packet at VMID 3 offset 0x800000b2a400 + 0xb68.

Each line of disassembly includes the address of the shader opcode,
followed by the opcode in hex, followed by the disassembly provided
by llvm.  If the disassembly indicates ';;' this means this word
is part of the previous disassembled instruction.

-----------
IB Decoding
-----------

Arbitrary IBs can be decoded with the following command:

::

	umr --dump-ib [vmid@]address length [pm]

Which will dump the IB pointed to by the address specified with
an optional VMID.  The length is specified in bytes.  The
default decoder is for PM4 and pm can be omitted in this case.  To
decode SDMA IBs the value of '3' can be specified for pm.

::

	umr --dump-ib 0@0xff00402000 0x10

Might produce:

::


	Decoding IB at 0@0xff00402000 from 0@0x0 of 19 words (type 4)
	[0@0x00000000 + 0x0000] [0xc0032200]    Opcode 0x22 [PKT3_COND_EXEC] (4 words, type: 3, hdr: 0xc0032200)
	[0@0x00000000 + 0x0004] [0x00400080]    |---> GPU_ADDR_LO32=0x400080
	[0@0x00000000 + 0x0008] [0x000000ff]    |---> GPU_ADDR_HI32=0xff
	[0@0x00000000 + 0x000c] [0x00000000]    |---> TEST_VALUE=0x0
	[0@0x00000000 + 0x0010] [0x0000002f]    |---> PATCH_VALUE=0x2f
	[0@0x00000000 + 0x0014] [0xc0053c00]    Opcode 0x3c [PKT3_WAIT_REG_MEM] (6 words, type: 3, hdr: 0xc0053c00)
	[0@0x00000000 + 0x0018] [0x00000143]    |---> ENGINE=[PFP]/1, MEMSPACE=[REG]/0, OPERATION=1, FUNCTION=[==]/3
	[0@0x00000000 + 0x001c] [0x00001537]    |---> POLL_ADDRESS_LO=0x1534, SWAP=0x3
	[0@0x00000000 + 0x0020] [0x00001538]    |---> POLL_ADDRESS_HI=0x1538
	[0@0x00000000 + 0x0024] [0x00000001]    |---> REFERENCE=0x1
	[0@0x00000000 + 0x0028] [0x00000001]    |---> MASK=0x1
	[0@0x00000000 + 0x002c] [0x00000020]    |---> POLL INTERVAL=0x20
	[0@0x00000000 + 0x0030] [0xc0004600]    Opcode 0x46 [PKT3_EVENT_WRITE] (1 words, type: 3, hdr: 0xc0004600)
	[0@0x00000000 + 0x0034] [0x0000040f]    |---> EVENT_TYPE=15, EVENT_INDEX=4
	[0@0x00000000 + 0x0038] [0xc0004600]    Opcode 0x46 [PKT3_EVENT_WRITE] (1 words, type: 3, hdr: 0xc0004600)
	[0@0x00000000 + 0x003c] [0x00000024]    |---> EVENT_TYPE=36, EVENT_INDEX=0
	[0@0x00000000 + 0x0040] [0xc0012800]    Opcode 0x28 [PKT3_CONTEXT_CONTROL] (2 words, type: 3, hdr: 0xc0012800)
	[0@0x00000000 + 0x0044] [0x81018003]    |---> LOAD_EN=1, LOAD_CS=1, LOAD_GFX=1, LOAD_MULTI=1, LOAD_SINGLE=1
	[0@0x00000000 + 0x0048] [0x00000000]    |---> SHADOW_EN=0, SHADOW_CS=0, SHADOW_GFX=0, SHADOW_MULTI=0, SHADOW_SINGLE=0
	Done decoding IB

-----------------
Bitfield Decoding
-----------------

The ring decoders also support decoding bitfields when register
writes are detected.  This is enabled with the 'bits' option.
