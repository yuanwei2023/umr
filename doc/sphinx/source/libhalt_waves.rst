=============
Halting Waves
=============

To halt shaders/compute jobs that are currently being worked on
the following function can be used:

::

	int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mode, int max_retries);

To halt jobs pass **UMR_SQ_CMD_HALT** as 'mode' and to resume pass
**UMR_SQ_CMD_RESUME**.  The 'max_retries' parameter specifies how many
times it should retry issuing the HALT command to halt the waves being
executed.

Note that this does not block the GPU from accepting new jobs it simply
halts (or resumes) jobs that are currently being processed.  

===========
Portability
===========

In order to write more portable code it's better to call this via the callback mechanism in the
'wave_funcs' callback structure.

::
	struct umr_wave_access_funcs {
		/**
		* umr_sq_cmd_halt_waves - Attempt to halt or resume waves
		*
		* @asic: The device to halt waves on
		* @mode: Use UMR_SQ_CMD_HALT to halt waves and
		*        UMR_SQ_CMD_RESUME to resume waves.
		* @max_retries:	If > 0 halting the waves will be retried if it failed
		*/
		int (*sq_cmd_halt_waves)(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mode, int max_retries);

		/**
		* umr_sq_cmd_singlestep - Attempt to single-step a single wave
		*
		* @asic: The ASIC to issue the single-step to
		* @se: The SE selection
		* @sh: The SH selection
		* @wgp: The WGP selection
		* @simd: The SIMD selection
		* @wave: The WAVE selection
		*
		* The wave is assumed to be halted.  Returns -1 on error.
		*/
		int (*sq_cmd_singlestep)(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t wgp, uint32_t simd, uint32_t wave);

		/** get_wave_status -- Populate the umr_wave_status structure
		* @asic: The device the SQ_WAVE data should come from
		* @se, @sh, @cu, @simd, @wave: The specific wave to read data from
		* @ws: where to store the SQ_WAVE_* decoded data (see src/lib/lowlevel/linux/wave_status.c for an example)
		*/
		int (*get_wave_status)(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws);

		/** get_wave_sq_info -- Populate the sq_info sub-structure of the umr_wave_status structure
		* @asic: The device to get SQ information from
		* @se, @sh, @cu: Which engine to read
		* @ws: Where to store the sq information.
		*/
		int (*get_wave_sq_info)(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws);

		/** data -- opaque pointer the callbacks can use for state tracking */
		void *data;
	};

The same logic goes for single stepping.

