===========
Wave Status
===========

Active waves can be read and decoded with the --waves command.  Ideally,
one should avoid issuing this command too often if GFX power gating
is enabled.  Typically, this command is used when the GPU has hung
and the status of the waves will aid in debugging as it indicates
the current state of the shaders.

::

	umr --waves [ ${ringname} | uq | vmid@addr.size | none ]

The parameter to the command can be one of the following: the name of a kernel ring,
the word 'uq' to specify using the user queue the user bound to, a triple of
a VMID, virtual address, and buffer size (assumes PM4), or simply the word 'none' to
indicate no packet stream is associated with this command.

The specification of a packet stream source is useful because it tells umr where it might
find information about how the shader (kernel) being debugged was programmed.

--------------
Basic Decoding
--------------

If there are active waves the default output format resembles:

::

	------------------------------------------------------
	se0.sh0.cu2.simd0.wave0


	Main Registers:
				ixSQ_WAVE_STATUS: 08010100 |      ixSQ_WAVE_PC_LO: 00202128 |      ixSQ_WAVE_PC_HI: 00008000 |    ixSQ_WAVE_EXEC_LO: a5ca57c8 | 
			   ixSQ_WAVE_EXEC_HI: 855382fa |      ixSQ_WAVE_HW_ID: 10300200 |   ixSQ_WAVE_INST_DW0: bf8c0071 |   ixSQ_WAVE_INST_DW1: 0a0a0217 | 
			 ixSQ_WAVE_GPR_ALLOC: 01060203 |  ixSQ_WAVE_LDS_ALLOC: 00000000 |    ixSQ_WAVE_TRAPSTS: 20000000 |     ixSQ_WAVE_IB_STS: 00000002 | 
			   ixSQ_WAVE_IB_DBG0: 08000b06 |         ixSQ_WAVE_M0: e4910000 |       ixSQ_WAVE_MODE: 000001c0 | 

The output can be fed through the command 'column -t' to pretty print it.
The first line represents the column headings.  When appropriate
SGPRs and (on GFX9+) VGPRs will be printed if the wave is halted.
Where possible it will attempt to print out the surrounding
instruction words in the shader with disassembly.

On live systems if there is a desire to inspect wave data the 'halt_waves'
option can be used.  This will issue an SQ_CMD halt command which will halt
any waves currently being processed.  If there are no waves being processed
the command is effectively ignored.

::

	umr -O halt_waves --waves gfx_0.0.0

Typically, if the command succeeds the display will hang while umr is
running (it will issue a resume before terminating).  For instance,
if you pipe umr to less the display will appear frozen while umr
is blocked trying to write data to stdout.  If you terminate umr
uncleanly (say with a SIGINT or SIGKILL) the waves will not resume.  This
can be cleaned up by re-issuing umr with halt_waves and letting it terminate
cleanly.

The wave status command supports an alternative output format with the
'bits' option.

---------------
Detailed output
---------------

::

	umr -O bits --waves gfx_0.0.0

Which produces output that resembles:

::

	se0.sh0.cu0.simd0.wave0


	Main Registers:
				ixSQ_WAVE_STATUS: 0801a001 |      ixSQ_WAVE_PC_LO: 00200a48 |      ixSQ_WAVE_PC_HI: 00008000 |    ixSQ_WAVE_EXEC_LO: ffffffff | 
			   ixSQ_WAVE_EXEC_HI: ffffffff |      ixSQ_WAVE_HW_ID: 0f200000 |   ixSQ_WAVE_INST_DW0: bf8c0f70 |   ixSQ_WAVE_INST_DW1: d2960000 | 
			 ixSQ_WAVE_GPR_ALLOC: 01000300 |  ixSQ_WAVE_LDS_ALLOC: 0000203c |    ixSQ_WAVE_TRAPSTS: 20000000 |     ixSQ_WAVE_IB_STS: 00000000 | 
			   ixSQ_WAVE_IB_DBG0: 00000026 |         ixSQ_WAVE_M0: 80100000 |       ixSQ_WAVE_MODE: 000001c0 | 


	Register Bits:
			

	ixSQ_WAVE_STATUS[0801a001]:
							 SCC: 00000001 |             SPI_PRIO: 00000000 |            USER_PRIO: 00000000 |                 PRIV: 00000000 | 
						 TRAP_EN: 00000000 |            TTRACE_EN: 00000000 |           EXPORT_RDY: 00000000 |                EXECZ: 00000000 | 
							VCCZ: 00000000 |                IN_TG: 00000000 |           IN_BARRIER: 00000000 |                 HALT: 00000001 | 
							TRAP: 00000000 |         TTRACE_CU_EN: 00000001 |                VALID: 00000001 |              ECC_ERR: 00000000 | 
					 SKIP_EXPORT: 00000000 |              PERF_EN: 00000000 |        COND_DBG_USER: 00000000 |         COND_DBG_SYS: 00000000 | 
					ALLOW_REPLAY: 00000000 |           FATAL_HALT: 00000000 |          MUST_EXPORT: 00000001 | 


	ixSQ_WAVE_PC_LO[00200a48]:
						   PC_LO: 00200a48 | 


	ixSQ_WAVE_PC_HI[00008000]:
						   PC_HI: 00008000 | 


	ixSQ_WAVE_EXEC_LO[ffffffff]:
						 EXEC_LO: ffffffff | 


	ixSQ_WAVE_EXEC_HI[ffffffff]:
						 EXEC_HI: ffffffff | 


	ixSQ_WAVE_HW_ID[0f200000]:
						 WAVE_ID: 00000000 |              SIMD_ID: 00000000 |              PIPE_ID: 00000000 |                CU_ID: 00000000 | 
						   SH_ID: 00000000 |                SE_ID: 00000000 |                TG_ID: 00000000 |                VM_ID: 00000002 | 
						QUEUE_ID: 00000007 |             STATE_ID: 00000001 |                ME_ID: 00000000 | 


	ixSQ_WAVE_INST_DW0[bf8c0f70]:
						INST_DW0: bf8c0f70 | 


	ixSQ_WAVE_INST_DW1[d2960000]:
						INST_DW1: d2960000 | 


	ixSQ_WAVE_GPR_ALLOC[01000300]:
					   VGPR_BASE: 00000000 |            VGPR_SIZE: 00000003 |            SGPR_BASE: 00000000 |            SGPR_SIZE: 00000001 | 


	ixSQ_WAVE_LDS_ALLOC[0000203c]:
						LDS_BASE: 0000003c |             LDS_SIZE: 00000002 | 


	ixSQ_WAVE_TRAPSTS[20000000]:
							EXCP: 00000000 |              SAVECTX: 00000000 |         ILLEGAL_INST: 00000000 |              EXCP_HI: 00000000 | 
					  EXCP_CYCLE: 00000000 |          XNACK_ERROR: 00000000 |              DP_RATE: 00000001 | 


	ixSQ_WAVE_IB_STS[00000000]:
						  VM_CNT: 00000000 |              EXP_CNT: 00000000 |             LGKM_CNT: 00000000 |             VALU_CNT: 00000000 | 
					FIRST_REPLAY: 00000000 |                 RCNT: 00000000 |            VM_CNT_HI: 00000000 | 


	ixSQ_WAVE_IB_DBG0[00000026]:
						 IBUF_ST: 00000006 |           PC_INVALID: 00000000 |         NEED_NEXT_DW: 00000000 |      NO_PREFETCH_CNT: 00000001 | 
					   IBUF_RPTR: 00000000 |            IBUF_WPTR: 00000000 |          INST_STR_ST: 00000000 |               ECC_ST: 00000000 | 
						  IS_HYB: 00000000 |              HYB_CNT: 00000000 |                 KILL: 00000000 |     NEED_KILL_IFETCH: 00000000 | 
			  NO_PREFETCH_CNT_HI: 00000000 | 


	ixSQ_WAVE_M0[80100000]:
							  M0: 80100000 | 


	ixSQ_WAVE_MODE[000001c0]:
						FP_ROUND: 00000000 |            FP_DENORM: 0000000c |           DX10_CLAMP: 00000001 |                 IEEE: 00000000 | 
					 LOD_CLAMPED: 00000000 |             DEBUG_EN: 00000000 |              EXCP_EN: 00000000 |            FP16_OVFL: 00000000 | 
					POPS_PACKER0: 00000000 |         POPS_PACKER1: 00000000 |         DISABLE_PERF: 00000000 |           GPR_IDX_EN: 00000000 | 
						   VSKIP: 00000000 |                  CSP: 00000000 | 

	>SGPRS[0..3] = { 98000000, 00f00000, c0000000, 00000000 }
	>SGPRS[4..7] = { b8c7ffb5, 80100000, ffffffff, ffffffff }
	>SGPRS[8..11] = { 01018000, 00a00080, 4095c31f, 9190032e }
	>SGPRS[12..15] = { 806fe000, 0d000000, 00600000, 0101a400 }

	VGPRS:        t00      t01      t02      t03      t04      t05      t06      t07      t08      t09      t10      t11      t12      t13      t14      t15      t16      t17      t18      t19      t20      t21      t22      t23      t24      t25      t26      t27      t28      t29      t30      t31      t32      t33      t34      t35      t36      t37      t38      t39      t40      t41      t42      t43      t44      t45      t46      t47      t48      t49      t50      t51      t52      t53      t54      t55      t56      t57      t58      t59      t60      t61      t62      t63     
		[  0] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
		[  1] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
		[  2] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
		[  3] = { 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 3f800000 }
		[  4] = { 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 00000040 3f66147e 3f6520cc 3f66a9b9 3f65b5bb 3f6d04b7 3f6c0d0b 3f6d9c19 3f6ca41e 3f6b15ec 3f6a1f63 3f6bacb3 3f6ab5da 3f6e33a7 3f6d3b5d 3f6ecb5e 3f6dd2c5 3f6c43a2 3f6b4c7b 3f6cdabc 3f6be346 3f692965 3f6833fc 3f69bf8f 3f68c9d8 3f673f1f 3f664ad4 3f67d4ad 3f66e014 3f6a55e2 3f695fdd 3f6aec5e 3f69f60a }
		[  5] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 3c499758 3c3eba4b 3c3320d1 3c2848d1 3c5e1b61 3c532226 3c4779cd 3c3c85b2 3c482f5b 3c3d42fc 3c319808 3c26b0c4 3c30d1ef 3c25e2f8 3c1a23c5 3c0f39f7 3c1afa71 3c10184e 3c045695 3bf2f32a 3c325d02 3c277d66 3c1bcfe7 3c10f564 3c1ca417 3c11d12a 3c06212c 3bf6a6a7 3c053c8f 3bf4ce50 3bdd45ef 3bc7a55f }
		[  6] = { 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000800 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
		[  7] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 }
		[  8] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 }
		[  9] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 }
		[ 10] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 }
		[ 11] = { 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 fffffff0 }
		[ 12] = { 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 0002a600 0002a610 0002a620 0002a630 0002a640 0002a650 0002a660 0002a670 0002a680 0002a690 0002a6a0 0002a6b0 0002a6c0 0002a6d0 0002a6e0 0002a6f0 0002a700 0002a710 0002a720 0002a730 0002a740 0002a750 0002a760 0002a770 0002a780 0002a790 0002a7a0 0002a7b0 0002a7c0 0002a7d0 0002a7e0 0002a7f0 }
		[ 13] = { 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 }
		[ 14] = { 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 00000000 00000000 00000008 00000008 }
		[ 15] = { 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001 }


	PGM_MEM:
		pgm[2@0x800000200a28 + 0x0   ] = 0xd4000002         v_interp_p1_f32_e32 v0, v2, attr0.x                             
		pgm[2@0x800000200a28 + 0x4   ] = 0xd4040102         v_interp_p1_f32_e32 v1, v2, attr0.y                             
		pgm[2@0x800000200a28 + 0x8   ] = 0xd4010003         v_interp_p2_f32_e32 v0, v3, attr0.x                             
		pgm[2@0x800000200a28 + 0xc   ] = 0xd4050103         v_interp_p2_f32_e32 v1, v3, attr0.y                             
		pgm[2@0x800000200a28 + 0x10  ] = 0x86fe067e         s_and_b64 exec, exec, s[6:7]                                    
		pgm[2@0x800000200a28 + 0x14  ] = 0xbf8cc07f         s_waitcnt lgkmcnt(0)                                            
		pgm[2@0x800000200a28 + 0x18  ] = 0xf0800f00         image_sample v[0:3], v0, s[8:15], s[0:3] dmask:0xf              
		pgm[2@0x800000200a28 + 0x1c  ] = 0x00020000 ;;                                                              
	 *	pgm[2@0x800000200a28 + 0x20  ] = 0xbf8c0f70         s_waitcnt vmcnt(0)                                              
		pgm[2@0x800000200a28 + 0x24  ] = 0xd2960000         v_cvt_pkrtz_f16_f32 v0, v0, v1                                  
		pgm[2@0x800000200a28 + 0x28  ] = 0x00020300 ;;                                                              
		pgm[2@0x800000200a28 + 0x2c  ] = 0xd2960001         v_cvt_pkrtz_f16_f32 v1, v2, v3                                  
		pgm[2@0x800000200a28 + 0x30  ] = 0x00020702 ;;                                                              
		pgm[2@0x800000200a28 + 0x34  ] = 0xc4001c0f         exp mrt0 v0, v0, v1, v1 done compr vm                           
		pgm[2@0x800000200a28 + 0x38  ] = 0x00000100 ;;                                                              
		pgm[2@0x800000200a28 + 0x3c  ] = 0xbf810000         s_endpgm                                                        
	End of disassembly.

This format of output is a lot more verbose but includes human readable
bitfield decodings which may aid in debugging purposes.  Where
possible it will also print out SGPRs and on newer platforms (gfx9+)
it may also include VGPRs.

---------------------
Kernel configurations
---------------------

When a shader (kernel) is found in the packet stream the output of the PGM_MEM area changes:

::

	$ umr --user-queue kfd,comm=test,queue=0 --waves uq -O halt_waves
	------------------------------------------------------
	se2.sa1.wgp2.simd0.wave0 


	Main Registers:
			ixSQ_WAVE_STATUS: 10010040 |      ixSQ_WAVE_PC_LO: a8ff9a08 |      ixSQ_WAVE_PC_HI: 00007fb2 |    ixSQ_WAVE_EXEC_LO: 00000001 | 
			ixSQ_WAVE_EXEC_HI: 00000000 |     ixSQ_WAVE_HW_ID1: 20090800 |     ixSQ_WAVE_HW_ID2: 09000102 |  ixSQ_WAVE_GPR_ALLOC: 00001000 | 
			ixSQ_WAVE_LDS_ALLOC: 00000000 |     ixSQ_WAVE_IB_STS: 00000000 |    ixSQ_WAVE_IB_STS2: 70000000 |    ixSQ_WAVE_IB_DBG1: 01000000 | 
			ixSQ_WAVE_M0: 80000000 |       ixSQ_WAVE_MODE: 000000f0 | ixSQ_WAVE_STATE_PRIV: 00004200 | ixSQ_WAVE_EXCP_FLAG_PRIV: 00000000 | 
			ixSQ_WAVE_EXCP_FLAG_USER: 00000000 |  ixSQ_WAVE_TRAP_CTRL: 00000000 |     ixSQ_WAVE_ACTIVE: 00000000 | ixSQ_WAVE_VALID_AND_IDLE: 00000001 | 
			ixSQ_WAVE_DVGPR_ALLOC_LO: bebebeef | ixSQ_WAVE_DVGPR_ALLOC_HI: bebebeef | ixSQ_WAVE_SCHED_MODE: 00000000 | 

	>SGPRS[0..3] = { ffffffff, 00007fb1, a928a000, 00007fb2 }
	>SGPRS[4..7] = { a4200100, 00007fb1, 00000001, 00000000 }
	>SGPRS[8..11] = { 00000000, 002e5e00, 00000000, 00025180 }
	>SGPRS[12..15] = { 40605000, 0000751c, 32e00000, 00007520 }
	>SGPRS[16..19] = { ffffffff, 00000000, 00000001, 00000000 }
	...<snip>...
	PGM_MEM: (found shader at: 0@0x7fb2a8ff9a00 of 24 bytes)
	Shader registers:
		gfx1201.regCOMPUTE_PGM_RSRC1(0@0x7fb2a8ff0940) == 0xe00f0100
		gfx1201.regCOMPUTE_PGM_RSRC2(0@0x7fb2a8ff0940) == 0x1390
		gfx1201.regCOMPUTE_PGM_RSRC3(0@0x7fb2a8ff0940) == 0x0

		pgm[9@0x7fb2a8ff9a00 + 0x0   ] = 0xbea10080         s_mov_b32 s33, 0                                                
		pgm[9@0x7fb2a8ff9a00 + 0x4   ] = 0xbf830008         s_sleep 8                                                       
	*	pgm[9@0x7fb2a8ff9a00 + 0x8   ] = 0xbe8000c1         s_mov_b32 s0, -1                                                
		pgm[9@0x7fb2a8ff9a00 + 0xc   ] = 0x8b6a007e         s_and_b32 vcc_lo, exec_lo, s0                                   
		pgm[9@0x7fb2a8ff9a00 + 0x10  ] = 0xbfa4fffc         s_cbranch_vccnz 65532                                           
		pgm[9@0x7fb2a8ff9a00 + 0x14  ] = 0xbfb00000         s_endpgm                                                        
	End of disassembly.

Here it found the compute kernel (shader) was programmed by an AQL packet at **0x7fb2a8ff9a00** in the clients
virtual memory space.  The registers printed are related to the programming of the kernel and will change
depending on the client.  For instance, kgd clients likely program far more registers that control the execution
of the shader.  The *-O bits* option can be specified to get bitfield decoding of the kernel (shader) programming
registers.

On certain architectures UMR supports finding AQL data when the PC address of the wave is *outside* the kernels
understood virtual memory range.  For instance, in this demo the kernel programmed jumps to another kernel that was
not programmed by an AQL packet directly:

::

	$ umr --user-queue kfd,comm=test2,queue=0 --waves uq -O halt_waves
	...<snip>...
		PGM_MEM:
	Found DISPATCH_KERNEL, Shader registers:
		gfx1201.regCOMPUTE_PGM_RSRC1(0@0x7a05428c8940) == 0xe00f0103
		gfx1201.regCOMPUTE_PGM_RSRC2(0@0x7a05428c8940) == 0x1391
		gfx1201.regCOMPUTE_PGM_RSRC3(0@0x7a05428c8940) == 0x0


		pgm[8@0x7a05428d1914 + 0x0   ] = 0xbfc80000         s_wait_loadcnt_dscnt 0x0                                        
		pgm[8@0x7a05428d1914 + 0x4   ] = 0xbfc40000         s_wait_expcnt 0x0                                               
		pgm[8@0x7a05428d1914 + 0x8   ] = 0xbfc20000         s_wait_samplecnt 0x0                                            
		pgm[8@0x7a05428d1914 + 0xc   ] = 0xbfc30000         s_wait_bvhcnt 0x0                                               
		pgm[8@0x7a05428d1914 + 0x10  ] = 0xbfc70000         s_wait_kmcnt 0x0                                                
		pgm[8@0x7a05428d1914 + 0x14  ] = 0xbe810021         s_mov_b32 s1, s33                                               
		pgm[8@0x7a05428d1914 + 0x18  ] = 0xbea10020         s_mov_b32 s33, s32                                              
		pgm[8@0x7a05428d1914 + 0x1c  ] = 0xbf830001         s_sleep 1                                                       
	*	pgm[8@0x7a05428d1914 + 0x20  ] = 0xbe8000c1         s_mov_b32 s0, -1                                                
		pgm[8@0x7a05428d1914 + 0x24  ] = 0xbf88fffe         s_wait_alu 0xfffe                                               
		pgm[8@0x7a05428d1914 + 0x28  ] = 0x8b6a007e         s_and_b32 vcc_lo, exec_lo, s0                                   
		pgm[8@0x7a05428d1914 + 0x2c  ] = 0xbf88fffe         s_wait_alu 0xfffe                                               
		pgm[8@0x7a05428d1914 + 0x30  ] = 0xbfa4fffa         s_cbranch_vccnz 65530                                           
		pgm[8@0x7a05428d1914 + 0x34  ] = 0xbea10001         s_mov_b32 s33, s1                                               
		pgm[8@0x7a05428d1914 + 0x38  ] = 0xbf88fffe         s_wait_alu 0xfffe                                               
		pgm[8@0x7a05428d1914 + 0x3c  ] = 0xbe80481e         s_setpc_b64 s[30:31]                                            
	End of disassembly.

In this example we see the term "**Found DISPATCH_KERNEL**" which means UMR found the AQL
packet that dispatched this wave.  In this event the registers displayed are accurate.  The disassembly
is based on just rewinding the PC value 8 words which may or may not align with a valid opcode in the kernel.

----------------
Full Kernel Text
----------------

By default, UMR outputs upto about 16 words worth of the shader data to dissassemble.  If you want to see
the entire kernel program use the *-O full_shader* option which when the kernel dispatch opcode is found
in the packet stream it will disassemble the entire shader.  If no packet is found it will just revert
to disassembling some data around the waves PC address.

Using the full shader (kernel) is more reliable for decoding since UMR can start at the beginning of the
text section and there is no chance of a misaligned opcode decoding.

::

	$ umr --user-queue kfd,comm=ollama,queue=2 --waves uq -O full_shader,halt_waves
		PGM_MEM: (found shader at: 0@0x7e4d3c182f00 of 1836 bytes)
	Shader registers:
		gfx1201.regCOMPUTE_PGM_RSRC1(0@0x7e4d3c13dd00) == 0x600f0083
		gfx1201.regCOMPUTE_PGM_RSRC2(0@0x7e4d3c13dd00) == 0xb84
		gfx1201.regCOMPUTE_PGM_RSRC3(0@0x7e4d3c13dd00) == 0x0

		pgm[8@0x7e4d3c182f00 + 0x0   ] = 0xf4002080         s_load_b64 s[2:3], s[0:1], 0x10                                 
		pgm[8@0x7e4d3c182f00 + 0x4   ] = 0xf8000010 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x8   ] = 0x8b13ff73         s_and_b32 s19, ttmp7, 0xffff                                    
		pgm[8@0x7e4d3c182f00 + 0xc   ] = 0x0000ffff ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x10  ] = 0xbfc70000         s_wait_kmcnt 0x0                                                
		pgm[8@0x7e4d3c182f00 + 0x14  ] = 0xbf118002         s_cmp_lg_u64 s[2:3], 0                                          
		pgm[8@0x7e4d3c182f00 + 0x18  ] = 0x980c80c1         s_cselect_b32 s12, -1, 0                                        
		pgm[8@0x7e4d3c182f00 + 0x1c  ] = 0xbf108002         s_cmp_eq_u64 s[2:3], 0                                          
		pgm[8@0x7e4d3c182f00 + 0x20  ] = 0xbfa201c2         s_cbranch_scc1 450                                              
		pgm[8@0x7e4d3c182f00 + 0x24  ] = 0x84048213         s_lshl_b32 s4, s19, 2                                           
		pgm[8@0x7e4d3c182f00 + 0x28  ] = 0xf4000081         s_load_b32 s2, s[2:3], s4 offset:0x0                            
		pgm[8@0x7e4d3c182f00 + 0x2c  ] = 0x08000000 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x30  ] = 0xf4006100         s_load_b256 s[4:11], s[0:1], 0x34                               
		pgm[8@0x7e4d3c182f00 + 0x34  ] = 0xf8000034 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x38  ] = 0xbfa60023         s_cbranch_execnz 35                                             
		pgm[8@0x7e4d3c182f00 + 0x3c  ] = 0xbfc70000         s_wait_kmcnt 0x0                                                
		pgm[8@0x7e4d3c182f00 + 0x40  ] = 0x86029f04         s_ashr_i32 s2, s4, 31                                           
		pgm[8@0x7e4d3c182f00 + 0x44  ] = 0xbf870499         s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)      
		...<snip>...
		pgm[8@0x7e4d3c182f00 + 0x3e8 ] = 0x0000000f ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x3ec ] = 0xffffb800 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x3f0 ] = 0xee05007c         global_load_b32 v17, v[0:1], off                                
		pgm[8@0x7e4d3c182f00 + 0x3f4 ] = 0x00000011 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x3f8 ] = 0x00000000 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x3fc ] = 0xd7006a00         v_add_co_u32 v0, vcc_lo, 0x120, v0                              
		pgm[8@0x7e4d3c182f00 + 0x400 ] = 0x000200ff ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x404 ] = 0x00000120 ;;                                                              
		pgm[8@0x7e4d3c182f00 + 0x408 ] = 0x40020280         v_add_co_ci_u32_e32 v1, vcc_lo, 0, v1, vcc_lo                   
		pgm[8@0x7e4d3c182f00 + 0x40c ] = 0xbfc00008         s_wait_loadcnt 0x8                                              
	*	pgm[8@0x7e4d3c182f00 + 0x410 ] = 0x34282905         v_ashrrev_i32_e32 v20, v5, v20                                  
		pgm[8@0x7e4d3c182f00 + 0x414 ] = 0xbfc00007         s_wait_loadcnt 0x7                                              
		pgm[8@0x7e4d3c182f00 + 0x418 ] = 0x322e2484         v_lshrrev_b32_e32 v23, 4, v18                                   
		...<snip>...

Here UMR found a kernel of **1836** bytes length (at address **0x7e4d3c182f00**) where the PC of this particular wave is **0x410** bytes into the kernel text.  