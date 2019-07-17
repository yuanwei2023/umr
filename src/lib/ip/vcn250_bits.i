static struct umr_bitfield mmUVD_JPEG_CNTL[] = {
	 { "REQUEST_EN", 1, 1, &umr_bitfield_default },
	 { "ERR_RST_EN", 2, 2, &umr_bitfield_default },
	 { "HUFF_SPEED_EN", 3, 3, &umr_bitfield_default },
	 { "HUFF_SPEED_STATUS", 4, 4, &umr_bitfield_default },
	 { "DBG_MUX_SEL", 8, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_RB_BASE[] = {
	 { "RB_BYTE_OFF", 0, 5, &umr_bitfield_default },
	 { "RB_BASE", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_RB_WPTR[] = {
	 { "RB_WPTR", 4, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_RB_RPTR[] = {
	 { "RB_RPTR", 4, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_RB_SIZE[] = {
	 { "RB_SIZE", 4, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_DEC_SCRATCH0[] = {
	 { "SCRATCH0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_INT_EN[] = {
	 { "OUTBUF_WPTR_INC_EN", 0, 0, &umr_bitfield_default },
	 { "JOB_AVAIL_EN", 1, 1, &umr_bitfield_default },
	 { "FENCE_VAL_EN", 2, 2, &umr_bitfield_default },
	 { "FIFO_OVERFLOW_ERR_EN", 6, 6, &umr_bitfield_default },
	 { "BLK_CNT_OUT_OF_SYNC_ERR_EN", 7, 7, &umr_bitfield_default },
	 { "EOI_ERR_EN", 8, 8, &umr_bitfield_default },
	 { "HFM_ERR_EN", 9, 9, &umr_bitfield_default },
	 { "RST_ERR_EN", 10, 10, &umr_bitfield_default },
	 { "ECS_MK_ERR_EN", 11, 11, &umr_bitfield_default },
	 { "TIMEOUT_ERR_EN", 12, 12, &umr_bitfield_default },
	 { "MARKER_ERR_EN", 13, 13, &umr_bitfield_default },
	 { "FMT_ERR_EN", 14, 14, &umr_bitfield_default },
	 { "PROFILE_ERR_EN", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_INT_STAT[] = {
	 { "OUTBUF_WPTR_INC_INT", 0, 0, &umr_bitfield_default },
	 { "JOB_AVAIL_INT", 1, 1, &umr_bitfield_default },
	 { "FENCE_VAL_INT", 2, 2, &umr_bitfield_default },
	 { "FIFO_OVERFLOW_ERR_INT", 6, 6, &umr_bitfield_default },
	 { "BLK_CNT_OUT_OF_SYNC_ERR_INT", 7, 7, &umr_bitfield_default },
	 { "EOI_ERR_INT", 8, 8, &umr_bitfield_default },
	 { "HFM_ERR_INT", 9, 9, &umr_bitfield_default },
	 { "RST_ERR_INT", 10, 10, &umr_bitfield_default },
	 { "ECS_MK_ERR_INT", 11, 11, &umr_bitfield_default },
	 { "TIMEOUT_ERR_INT", 12, 12, &umr_bitfield_default },
	 { "MARKER_ERR_INT", 13, 13, &umr_bitfield_default },
	 { "FMT_ERR_INT", 14, 14, &umr_bitfield_default },
	 { "PROFILE_ERR_INT", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_PITCH[] = {
	 { "PITCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_UV_PITCH[] = {
	 { "UV_PITCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_Y_GFX8_TILING_SURFACE[] = {
	 { "BANK_WIDTH", 0, 1, &umr_bitfield_default },
	 { "BANK_HEIGHT", 2, 3, &umr_bitfield_default },
	 { "MACRO_TILE_ASPECT", 4, 5, &umr_bitfield_default },
	 { "NUM_BANKS", 6, 7, &umr_bitfield_default },
	 { "PIPE_CONFIG", 8, 12, &umr_bitfield_default },
	 { "TILE_SPLIT", 13, 15, &umr_bitfield_default },
	 { "ARRAY_MODE", 16, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_UV_GFX8_TILING_SURFACE[] = {
	 { "BANK_WIDTH", 0, 1, &umr_bitfield_default },
	 { "BANK_HEIGHT", 2, 3, &umr_bitfield_default },
	 { "MACRO_TILE_ASPECT", 4, 5, &umr_bitfield_default },
	 { "NUM_BANKS", 6, 7, &umr_bitfield_default },
	 { "PIPE_CONFIG", 8, 12, &umr_bitfield_default },
	 { "TILE_SPLIT", 13, 15, &umr_bitfield_default },
	 { "ARRAY_MODE", 16, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_GFX8_ADDR_CONFIG[] = {
	 { "PIPE_INTERLEAVE_SIZE", 4, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_Y_GFX10_TILING_SURFACE[] = {
	 { "SWIZZLE_MODE", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_UV_GFX10_TILING_SURFACE[] = {
	 { "SWIZZLE_MODE", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_GFX10_ADDR_CONFIG[] = {
	 { "NUM_PIPES", 0, 2, &umr_bitfield_default },
	 { "PIPE_INTERLEAVE_SIZE", 3, 5, &umr_bitfield_default },
	 { "NUM_BANKS", 12, 14, &umr_bitfield_default },
	 { "NUM_SHADER_ENGINES", 19, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_ADDR_MODE[] = {
	 { "ADDR_MODE_Y", 0, 1, &umr_bitfield_default },
	 { "ADDR_MODE_UV", 2, 3, &umr_bitfield_default },
	 { "ADDR_LIB_SEL", 12, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_GPCOM_CMD[] = {
	 { "CMD", 1, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_GPCOM_DATA0[] = {
	 { "DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_GPCOM_DATA1[] = {
	 { "DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_SCRATCH1[] = {
	 { "SCRATCH1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_DEC_SOFT_RST[] = {
	 { "SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RESET_STATUS", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_INT_EN[] = {
	 { "HUFF_JOB_DONE_INT_EN", 0, 0, &umr_bitfield_default },
	 { "SCLR_JOB_DONE_INT_EN", 1, 1, &umr_bitfield_default },
	 { "HUFF_ERROR_INT_EN", 2, 2, &umr_bitfield_default },
	 { "SCLR_ERROR_INT_EN", 3, 3, &umr_bitfield_default },
	 { "QTBL_ERROR_INT_EN", 4, 4, &umr_bitfield_default },
	 { "PIC_SIZE_ERROR_INT_EN", 5, 5, &umr_bitfield_default },
	 { "FENCE_VAL_INT_EN", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_INT_STATUS[] = {
	 { "HUFF_JOB_DONE_STATUS", 0, 0, &umr_bitfield_default },
	 { "SCLR_JOB_DONE_STATUS", 1, 1, &umr_bitfield_default },
	 { "HUFF_ERROR_STATUS", 2, 2, &umr_bitfield_default },
	 { "SCLR_ERROR_STATUS", 3, 3, &umr_bitfield_default },
	 { "QTBL_ERROR_STATUS", 4, 4, &umr_bitfield_default },
	 { "PIC_SIZE_ERROR_STATUS", 5, 5, &umr_bitfield_default },
	 { "FENCE_VAL_STATUS", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_ENGINE_CNTL[] = {
	 { "HUFF_WR_COMB_DIS", 0, 0, &umr_bitfield_default },
	 { "DISTINCT_CHROMA_QUANT_TABLES", 1, 1, &umr_bitfield_default },
	 { "SCALAR_EN", 2, 2, &umr_bitfield_default },
	 { "ENCODE_EN", 3, 3, &umr_bitfield_default },
	 { "CMP_NEEDED", 4, 4, &umr_bitfield_default },
	 { "ECS_RESTRICT_32B_EN", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_SCRATCH1[] = {
	 { "SCRATCH1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_STATUS[] = {
	 { "PEL_FETCH_IDLE", 0, 0, &umr_bitfield_default },
	 { "HUFF_CORE_IDLE", 1, 1, &umr_bitfield_default },
	 { "FDCT_IDLE", 2, 2, &umr_bitfield_default },
	 { "SCALAR_IDLE", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_PITCH[] = {
	 { "PITCH_Y", 0, 11, &umr_bitfield_default },
	 { "PITCH_UV", 16, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_LUMA_BASE[] = {
	 { "LUMA_BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_CHROMAU_BASE[] = {
	 { "CHROMAU_BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_CHROMAV_BASE[] = {
	 { "CHROMAV_BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_ENC_Y_GFX10_TILING_SURFACE[] = {
	 { "SWIZZLE_MODE", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_ENC_UV_GFX10_TILING_SURFACE[] = {
	 { "SWIZZLE_MODE", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_ENC_GFX10_ADDR_CONFIG[] = {
	 { "NUM_PIPES", 0, 2, &umr_bitfield_default },
	 { "PIPE_INTERLEAVE_SIZE", 3, 5, &umr_bitfield_default },
	 { "NUM_BANKS", 12, 14, &umr_bitfield_default },
	 { "NUM_SHADER_ENGINES", 19, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_ENC_ADDR_MODE[] = {
	 { "ADDR_MODE_Y", 0, 1, &umr_bitfield_default },
	 { "ADDR_MODE_UV", 2, 3, &umr_bitfield_default },
	 { "ADDR_LIB_SEL", 12, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_GPCOM_CMD[] = {
	 { "CMD", 1, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_GPCOM_DATA0[] = {
	 { "DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_GPCOM_DATA1[] = {
	 { "DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_CGC_CNTL[] = {
	 { "CGC_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_SCRATCH0[] = {
	 { "SCRATCH0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_SOFT_RST[] = {
	 { "SOFT_RST", 0, 0, &umr_bitfield_default },
	 { "RESET_STATUS", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_CNTL[] = {
	 { "RB_NO_FETCH", 0, 0, &umr_bitfield_default },
	 { "RB_RPTR_WR_EN", 1, 1, &umr_bitfield_default },
	 { "RB_PRE_WRITE_TIMER", 4, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_IB_SIZE[] = {
	 { "IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_URGENT_CNTL[] = {
	 { "CMD_READ_REQ_PRIORITY_MARK", 0, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_REF_DATA[] = {
	 { "REF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_COND_RD_TIMER[] = {
	 { "RETRY_TIMER_CNT", 0, 15, &umr_bitfield_default },
	 { "RETRY_INTERVAL_CNT", 16, 23, &umr_bitfield_default },
	 { "CONTINUOUS_POLL_EN", 24, 24, &umr_bitfield_default },
	 { "MEM_TIMEOUT_EN", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_SOFT_RESET[] = {
	 { "RESET", 0, 0, &umr_bitfield_default },
	 { "SCLK_RESET_STATUS", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_STATUS[] = {
	 { "RB_JOB_DONE", 0, 0, &umr_bitfield_default },
	 { "IB_JOB_DONE", 1, 1, &umr_bitfield_default },
	 { "RB_ILLEGAL_CMD", 2, 2, &umr_bitfield_default },
	 { "RB_COND_REG_RD_TIMEOUT", 3, 3, &umr_bitfield_default },
	 { "RB_MEM_WR_TIMEOUT", 4, 4, &umr_bitfield_default },
	 { "RB_MEM_RD_TIMEOUT", 5, 5, &umr_bitfield_default },
	 { "IB_ILLEGAL_CMD", 6, 6, &umr_bitfield_default },
	 { "IB_COND_REG_RD_TIMEOUT", 7, 7, &umr_bitfield_default },
	 { "IB_MEM_WR_TIMEOUT", 8, 8, &umr_bitfield_default },
	 { "IB_MEM_RD_TIMEOUT", 9, 9, &umr_bitfield_default },
	 { "RB_TRAP_STATUS", 10, 10, &umr_bitfield_default },
	 { "PREEMPT_STATUS", 11, 11, &umr_bitfield_default },
	 { "IB_TRAP_STATUS", 12, 12, &umr_bitfield_default },
	 { "INT_EN", 16, 16, &umr_bitfield_default },
	 { "INT_ACK", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_BUF_STATUS[] = {
	 { "RB_BUF_VALID", 0, 15, &umr_bitfield_default },
	 { "RB_BUF_RD_ADDR", 16, 19, &umr_bitfield_default },
	 { "RB_BUF_WR_ADDR", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_IB_BUF_STATUS[] = {
	 { "IB_BUF_VALID", 0, 15, &umr_bitfield_default },
	 { "IB_BUF_RD_ADDR", 16, 19, &umr_bitfield_default },
	 { "IB_BUF_WR_ADDR", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_IB_SIZE_UPDATE[] = {
	 { "REMAIN_IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_IB_COND_RD_TIMER[] = {
	 { "RETRY_TIMER_CNT", 0, 15, &umr_bitfield_default },
	 { "RETRY_INTERVAL_CNT", 16, 23, &umr_bitfield_default },
	 { "CONTINUOUS_POLL_EN", 24, 24, &umr_bitfield_default },
	 { "MEM_TIMEOUT_EN", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_IB_REF_DATA[] = {
	 { "REF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_PREEMPT_CMD[] = {
	 { "PREEMPT_EN", 0, 0, &umr_bitfield_default },
	 { "WAIT_JPEG_JOB_DONE", 1, 1, &umr_bitfield_default },
	 { "PREEMPT_FENCE_CMD", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_PREEMPT_FENCE_DATA0[] = {
	 { "PREEMPT_FENCE_DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_PREEMPT_FENCE_DATA1[] = {
	 { "PREEMPT_FENCE_DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_RB_SIZE[] = {
	 { "RB_SIZE", 4, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_SCRATCH0[] = {
	 { "SCRATCH0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_CNTL[] = {
	 { "RB_NO_FETCH", 0, 0, &umr_bitfield_default },
	 { "RB_RPTR_WR_EN", 1, 1, &umr_bitfield_default },
	 { "RB_PRE_WRITE_TIMER", 4, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_IB_SIZE[] = {
	 { "IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_URGENT_CNTL[] = {
	 { "CMD_READ_REQ_PRIORITY_MARK", 0, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_REF_DATA[] = {
	 { "REF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_COND_RD_TIMER[] = {
	 { "RETRY_TIMER_CNT", 0, 15, &umr_bitfield_default },
	 { "RETRY_INTERVAL_CNT", 16, 23, &umr_bitfield_default },
	 { "CONTINUOUS_POLL_EN", 24, 24, &umr_bitfield_default },
	 { "MEM_TIMEOUT_EN", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_SOFT_RESET[] = {
	 { "RESET", 0, 0, &umr_bitfield_default },
	 { "SCLK_RESET_STATUS", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_STATUS[] = {
	 { "RB_JOB_DONE", 0, 0, &umr_bitfield_default },
	 { "IB_JOB_DONE", 1, 1, &umr_bitfield_default },
	 { "RB_ILLEGAL_CMD", 2, 2, &umr_bitfield_default },
	 { "RB_COND_REG_RD_TIMEOUT", 3, 3, &umr_bitfield_default },
	 { "RB_MEM_WR_TIMEOUT", 4, 4, &umr_bitfield_default },
	 { "RB_MEM_RD_TIMEOUT", 5, 5, &umr_bitfield_default },
	 { "IB_ILLEGAL_CMD", 6, 6, &umr_bitfield_default },
	 { "IB_COND_REG_RD_TIMEOUT", 7, 7, &umr_bitfield_default },
	 { "IB_MEM_WR_TIMEOUT", 8, 8, &umr_bitfield_default },
	 { "IB_MEM_RD_TIMEOUT", 9, 9, &umr_bitfield_default },
	 { "RB_TRAP_STATUS", 10, 10, &umr_bitfield_default },
	 { "PREEMPT_STATUS", 11, 11, &umr_bitfield_default },
	 { "IB_TRAP_STATUS", 12, 12, &umr_bitfield_default },
	 { "INT_EN", 16, 16, &umr_bitfield_default },
	 { "INT_ACK", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_BUF_STATUS[] = {
	 { "RB_BUF_VALID", 0, 15, &umr_bitfield_default },
	 { "RB_BUF_RD_ADDR", 16, 19, &umr_bitfield_default },
	 { "RB_BUF_WR_ADDR", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_IB_BUF_STATUS[] = {
	 { "IB_BUF_VALID", 0, 15, &umr_bitfield_default },
	 { "IB_BUF_RD_ADDR", 16, 19, &umr_bitfield_default },
	 { "IB_BUF_WR_ADDR", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_IB_SIZE_UPDATE[] = {
	 { "REMAIN_IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_IB_COND_RD_TIMER[] = {
	 { "RETRY_TIMER_CNT", 0, 15, &umr_bitfield_default },
	 { "RETRY_INTERVAL_CNT", 16, 23, &umr_bitfield_default },
	 { "CONTINUOUS_POLL_EN", 24, 24, &umr_bitfield_default },
	 { "MEM_TIMEOUT_EN", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_IB_REF_DATA[] = {
	 { "REF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_PREEMPT_CMD[] = {
	 { "PREEMPT_EN", 0, 0, &umr_bitfield_default },
	 { "WAIT_JPEG_JOB_DONE", 1, 1, &umr_bitfield_default },
	 { "PREEMPT_FENCE_CMD", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_PREEMPT_FENCE_DATA0[] = {
	 { "PREEMPT_FENCE_DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_PREEMPT_FENCE_DATA1[] = {
	 { "PREEMPT_FENCE_DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_RB_SIZE[] = {
	 { "RB_SIZE", 4, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JRBC_ENC_SCRATCH0[] = {
	 { "SCRATCH0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_CTRL[] = {
	 { "STALL_MC_ARB", 0, 0, &umr_bitfield_default },
	 { "MASK_MC_URGENT", 1, 1, &umr_bitfield_default },
	 { "ASSERT_MC_URGENT", 2, 2, &umr_bitfield_default },
	 { "MC_RD_ARB_WAIT_TIMER", 8, 15, &umr_bitfield_default },
	 { "MC_WR_ARB_WAIT_TIMER", 16, 23, &umr_bitfield_default },
	 { "CRC_RESET", 24, 24, &umr_bitfield_default },
	 { "CRC_SEL", 25, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_CTRL[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_CTRL[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_EJRBC_CTRL[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJPEG_CTRL[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_VMID[] = {
	 { "IB_WR_VMID", 0, 3, &umr_bitfield_default },
	 { "IB_RD_VMID", 4, 7, &umr_bitfield_default },
	 { "MEM_RD_VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_VMID[] = {
	 { "RB_WR_VMID", 0, 3, &umr_bitfield_default },
	 { "RB_RD_VMID", 4, 7, &umr_bitfield_default },
	 { "MEM_RD_VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_VMID[] = {
	 { "JPEG_RD_VMID", 0, 3, &umr_bitfield_default },
	 { "JPEG_WR_VMID", 4, 7, &umr_bitfield_default },
	 { "ATOMIC_USER0_WR_VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ENC_JRBC_IB_VMID[] = {
	 { "IB_WR_VMID", 0, 3, &umr_bitfield_default },
	 { "IB_RD_VMID", 4, 7, &umr_bitfield_default },
	 { "MEM_RD_VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ENC_JRBC_RB_VMID[] = {
	 { "RB_WR_VMID", 0, 3, &umr_bitfield_default },
	 { "RB_RD_VMID", 4, 7, &umr_bitfield_default },
	 { "MEM_RD_VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ENC_JPEG_VMID[] = {
	 { "PEL_RD_VMID", 0, 3, &umr_bitfield_default },
	 { "BS_WR_VMID", 5, 8, &umr_bitfield_default },
	 { "SCALAR_RD_VMID", 10, 13, &umr_bitfield_default },
	 { "SCALAR_WR_VMID", 15, 18, &umr_bitfield_default },
	 { "HUFF_FENCE_VMID", 19, 22, &umr_bitfield_default },
	 { "ATOMIC_USER1_WR_VMID", 23, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_PERFMON_CTRL[] = {
	 { "PERFMON_STATE", 0, 1, &umr_bitfield_default },
	 { "PERFMON_SEL", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_PERFMON_COUNT_LO[] = {
	 { "PERFMON_COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_PERFMON_COUNT_HI[] = {
	 { "PERFMON_COUNT", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_READ_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_READ_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_WRITE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_WRITE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_PREEMPT_FENCE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_PREEMPT_FENCE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_MEM_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JRBC_IB_MEM_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJPEG_PREEMPT_FENCE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJPEG_PREEMPT_FENCE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_MEM_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_MEM_WR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_MEM_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_RB_MEM_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_MEM_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_MEM_WR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_MEM_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_EJRBC_IB_MEM_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_PREEMPT_VMID[] = {
	 { "VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ENC_JPEG_PREEMPT_VMID[] = {
	 { "VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG2_VMID[] = {
	 { "JPEG2_RD_VMID", 0, 3, &umr_bitfield_default },
	 { "JPEG2_WR_VMID", 4, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG2_READ_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG2_READ_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG2_WRITE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG2_WRITE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_JPEG_CTRL2[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_DEC_SWAP_CNTL[] = {
	 { "RB_MC_SWAP", 0, 1, &umr_bitfield_default },
	 { "IB_MC_SWAP", 2, 3, &umr_bitfield_default },
	 { "RB_MEM_WR_MC_SWAP", 4, 5, &umr_bitfield_default },
	 { "IB_MEM_WR_MC_SWAP", 6, 7, &umr_bitfield_default },
	 { "RB_MEM_RD_MC_SWAP", 8, 9, &umr_bitfield_default },
	 { "IB_MEM_RD_MC_SWAP", 10, 11, &umr_bitfield_default },
	 { "PREEMPT_WR_MC_SWAP", 12, 13, &umr_bitfield_default },
	 { "JPEG_RD_MC_SWAP", 14, 15, &umr_bitfield_default },
	 { "JPEG_WR_MC_SWAP", 16, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ENC_SWAP_CNTL[] = {
	 { "RB_MC_SWAP", 0, 1, &umr_bitfield_default },
	 { "IB_MC_SWAP", 2, 3, &umr_bitfield_default },
	 { "RB_MEM_WR_MC_SWAP", 4, 5, &umr_bitfield_default },
	 { "IB_MEM_WR_MC_SWAP", 6, 7, &umr_bitfield_default },
	 { "RB_MEM_RD_MC_SWAP", 8, 9, &umr_bitfield_default },
	 { "IB_MEM_RD_MC_SWAP", 10, 11, &umr_bitfield_default },
	 { "PREEMPT_WR_MC_SWAP", 12, 13, &umr_bitfield_default },
	 { "PEL_RD_MC_SWAP", 14, 15, &umr_bitfield_default },
	 { "BS_WR_MC_SWAP", 16, 17, &umr_bitfield_default },
	 { "SCALAR_RD_MC_SWAP", 18, 19, &umr_bitfield_default },
	 { "SCALAR_WR_MC_SWAP", 20, 21, &umr_bitfield_default },
	 { "HUFF_FENCE_MC_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_CNTL[] = {
	 { "SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "MC_RD_REQ_RET_MAX", 8, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_HUFF_FENCE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_HUFF_FENCE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_DEC_SWAP_CNTL2[] = {
	 { "JPEG2_RD_MC_SWAP", 0, 1, &umr_bitfield_default },
	 { "JPEG2_WR_MC_SWAP", 2, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SOFT_RESET_STATUS[] = {
	 { "JPEG_DEC_RESET_STATUS", 0, 0, &umr_bitfield_default },
	 { "JPEG2_DEC_RESET_STATUS", 1, 1, &umr_bitfield_default },
	 { "DJRBC_RESET_STATUS", 2, 2, &umr_bitfield_default },
	 { "JPEG_ENC_RESET_STATUS", 3, 3, &umr_bitfield_default },
	 { "EJRBC_RESET_STATUS", 4, 4, &umr_bitfield_default },
	 { "JMCIF_RESET_STATUS", 5, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SYS_INT_EN[] = {
	 { "DJPEG_CORE", 0, 0, &umr_bitfield_default },
	 { "DJRBC", 1, 1, &umr_bitfield_default },
	 { "DJPEG_PF_RPT", 2, 2, &umr_bitfield_default },
	 { "EJPEG_PF_RPT", 3, 3, &umr_bitfield_default },
	 { "EJPEG_CORE", 4, 4, &umr_bitfield_default },
	 { "EJRBC", 5, 5, &umr_bitfield_default },
	 { "DJPEG_CORE2", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SYS_INT_STATUS[] = {
	 { "DJPEG_CORE", 0, 0, &umr_bitfield_default },
	 { "DJRBC", 1, 1, &umr_bitfield_default },
	 { "DJPEG_PF_RPT", 2, 2, &umr_bitfield_default },
	 { "EJPEG_PF_RPT", 3, 3, &umr_bitfield_default },
	 { "EJPEG_CORE", 4, 4, &umr_bitfield_default },
	 { "EJRBC", 5, 5, &umr_bitfield_default },
	 { "DJPEG_CORE2", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SYS_INT_ACK[] = {
	 { "DJPEG_CORE", 0, 0, &umr_bitfield_default },
	 { "DJRBC", 1, 1, &umr_bitfield_default },
	 { "DJPEG_PF_RPT", 2, 2, &umr_bitfield_default },
	 { "EJPEG_PF_RPT", 3, 3, &umr_bitfield_default },
	 { "EJPEG_CORE", 4, 4, &umr_bitfield_default },
	 { "EJRBC", 5, 5, &umr_bitfield_default },
	 { "DJPEG_CORE2", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MASTINT_EN[] = {
	 { "OVERRUN_RST", 0, 0, &umr_bitfield_default },
	 { "INT_OVERRUN", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_IH_CTRL[] = {
	 { "IH_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "IH_STALL_EN", 1, 1, &umr_bitfield_default },
	 { "IH_STATUS_CLEAN", 2, 2, &umr_bitfield_default },
	 { "IH_VMID", 3, 6, &umr_bitfield_default },
	 { "IH_USER_DATA", 7, 18, &umr_bitfield_default },
	 { "IH_RINGID", 19, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmJRBBM_ARB_CTRL[] = {
	 { "DJRBC_DROP", 0, 0, &umr_bitfield_default },
	 { "EJRBC_DROP", 1, 1, &umr_bitfield_default },
	 { "SRBM_DROP", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_CGC_GATE[] = {
	 { "JPEG_DEC", 0, 0, &umr_bitfield_default },
	 { "JPEG2_DEC", 1, 1, &umr_bitfield_default },
	 { "JPEG_ENC", 2, 2, &umr_bitfield_default },
	 { "JMCIF", 3, 3, &umr_bitfield_default },
	 { "JRBBM", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_CGC_CTRL[] = {
	 { "DYN_CLOCK_MODE", 0, 0, &umr_bitfield_default },
	 { "CLK_GATE_DLY_TIMER", 1, 4, &umr_bitfield_default },
	 { "CLK_OFF_DELAY", 5, 9, &umr_bitfield_default },
	 { "DYN_OCLK_RAMP_EN", 10, 10, &umr_bitfield_default },
	 { "DYN_RCLK_RAMP_EN", 11, 11, &umr_bitfield_default },
	 { "GATER_DIV_ID", 12, 14, &umr_bitfield_default },
	 { "JPEG_DEC_MODE", 16, 16, &umr_bitfield_default },
	 { "JPEG2_DEC_MODE", 17, 17, &umr_bitfield_default },
	 { "JPEG_ENC_MODE", 18, 18, &umr_bitfield_default },
	 { "JMCIF_MODE", 19, 19, &umr_bitfield_default },
	 { "JRBBM_MODE", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_CGC_STATUS[] = {
	 { "JPEG_DEC_VCLK_ACTIVE", 0, 0, &umr_bitfield_default },
	 { "JPEG_DEC_SCLK_ACTIVE", 1, 1, &umr_bitfield_default },
	 { "JPEG2_DEC_VCLK_ACTIVE", 2, 2, &umr_bitfield_default },
	 { "JPEG2_DEC_SCLK_ACTIVE", 3, 3, &umr_bitfield_default },
	 { "JPEG_ENC_VCLK_ACTIVE", 4, 4, &umr_bitfield_default },
	 { "JPEG_ENC_SCLK_ACTIVE", 5, 5, &umr_bitfield_default },
	 { "JMCIF_SCLK_ACTIVE", 6, 6, &umr_bitfield_default },
	 { "JRBBM_VCLK_ACTIVE", 7, 7, &umr_bitfield_default },
	 { "JRBBM_SCLK_ACTIVE", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_COMN_CGC_MEM_CTRL[] = {
	 { "JMCIF_LS_EN", 0, 0, &umr_bitfield_default },
	 { "JMCIF_DS_EN", 1, 1, &umr_bitfield_default },
	 { "JMCIF_SD_EN", 2, 2, &umr_bitfield_default },
	 { "LS_SET_DELAY", 16, 19, &umr_bitfield_default },
	 { "LS_CLEAR_DELAY", 20, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_CGC_MEM_CTRL[] = {
	 { "JPEG_DEC_LS_EN", 0, 0, &umr_bitfield_default },
	 { "JPEG_DEC_DS_EN", 1, 1, &umr_bitfield_default },
	 { "JPEG_DEC_SD_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG2_DEC_CGC_MEM_CTRL[] = {
	 { "JPEG2_DEC_LS_EN", 0, 0, &umr_bitfield_default },
	 { "JPEG2_DEC_DS_EN", 1, 1, &umr_bitfield_default },
	 { "JPEG2_DEC_SD_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_ENC_CGC_MEM_CTRL[] = {
	 { "JPEG_ENC_LS_EN", 0, 0, &umr_bitfield_default },
	 { "JPEG_ENC_DS_EN", 1, 1, &umr_bitfield_default },
	 { "JPEG_ENC_SD_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SOFT_RESET2[] = {
	 { "ATOMIC_SOFT_RESET", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_CONF[] = {
	 { "RESET", 0, 3, &umr_bitfield_default },
	 { "PEEK", 8, 11, &umr_bitfield_default },
	 { "CONCATENATE", 16, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_EVENT_SEL[] = {
	 { "SEL0", 0, 7, &umr_bitfield_default },
	 { "SEL1", 8, 15, &umr_bitfield_default },
	 { "SEL2", 16, 23, &umr_bitfield_default },
	 { "SEL3", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_COUNT0[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_COUNT1[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_COUNT2[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_PERF_BANK_COUNT3[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PGFSM_CONFIG[] = {
	 { "UVDM_PWR_CONFIG", 0, 1, &umr_bitfield_default },
	 { "UVDU_PWR_CONFIG", 2, 3, &umr_bitfield_default },
	 { "UVDF_PWR_CONFIG", 4, 5, &umr_bitfield_default },
	 { "UVDC_PWR_CONFIG", 6, 7, &umr_bitfield_default },
	 { "UVDB_PWR_CONFIG", 8, 9, &umr_bitfield_default },
	 { "UVDIL_PWR_CONFIG", 10, 11, &umr_bitfield_default },
	 { "UVDIR_PWR_CONFIG", 12, 13, &umr_bitfield_default },
	 { "UVDTD_PWR_CONFIG", 14, 15, &umr_bitfield_default },
	 { "UVDTE_PWR_CONFIG", 16, 17, &umr_bitfield_default },
	 { "UVDE_PWR_CONFIG", 18, 19, &umr_bitfield_default },
	 { "UVDW_PWR_CONFIG", 20, 21, &umr_bitfield_default },
	 { "UVDJ_PWR_CONFIG", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PGFSM_STATUS[] = {
	 { "UVDM_PWR_STATUS", 0, 1, &umr_bitfield_default },
	 { "UVDU_PWR_STATUS", 2, 3, &umr_bitfield_default },
	 { "UVDF_PWR_STATUS", 4, 5, &umr_bitfield_default },
	 { "UVDC_PWR_STATUS", 6, 7, &umr_bitfield_default },
	 { "UVDB_PWR_STATUS", 8, 9, &umr_bitfield_default },
	 { "UVDIL_PWR_STATUS", 10, 11, &umr_bitfield_default },
	 { "UVDIR_PWR_STATUS", 12, 13, &umr_bitfield_default },
	 { "UVDTD_PWR_STATUS", 14, 15, &umr_bitfield_default },
	 { "UVDTE_PWR_STATUS", 16, 17, &umr_bitfield_default },
	 { "UVDE_PWR_STATUS", 18, 19, &umr_bitfield_default },
	 { "UVDW_PWR_STATUS", 20, 21, &umr_bitfield_default },
	 { "UVDJ_PWR_STATUS", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_POWER_STATUS[] = {
	 { "UVD_POWER_STATUS", 0, 1, &umr_bitfield_default },
	 { "UVD_PG_MODE", 2, 2, &umr_bitfield_default },
	 { "UVD_CG_MODE", 4, 5, &umr_bitfield_default },
	 { "UVD_PG_EN", 8, 8, &umr_bitfield_default },
	 { "RBC_SNOOP_DIS", 9, 9, &umr_bitfield_default },
	 { "SW_RB_SNOOP_DIS", 11, 11, &umr_bitfield_default },
	 { "STALL_DPG_POWER_UP", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PG_IND_INDEX[] = {
	 { "INDEX", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PG_IND_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_HARVESTING[] = {
	 { "MMSCH_DISABLE", 0, 0, &umr_bitfield_default },
	 { "UVD_DISABLE", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_POWER_STATUS[] = {
	 { "JPEG_POWER_STATUS", 0, 0, &umr_bitfield_default },
	 { "JPEG_PG_MODE", 4, 4, &umr_bitfield_default },
	 { "JRBC_DEC_SNOOP_DIS", 8, 8, &umr_bitfield_default },
	 { "JRBC_ENC_SNOOP_DIS", 9, 9, &umr_bitfield_default },
	 { "STALL_JDPG_POWER_UP", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMA_CTL[] = {
	 { "READ_WRITE", 0, 0, &umr_bitfield_default },
	 { "MASK_EN", 1, 1, &umr_bitfield_default },
	 { "ADDR_AUTO_INCREMENT", 2, 2, &umr_bitfield_default },
	 { "SRAM_SEL", 4, 4, &umr_bitfield_default },
	 { "READ_WRITE_ADDR", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMA_DATA[] = {
	 { "LMA_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMA_MASK[] = {
	 { "LMA_MASK", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_PAUSE[] = {
	 { "JPEG_PAUSE_DPG_REQ", 0, 0, &umr_bitfield_default },
	 { "JPEG_PAUSE_DPG_ACK", 1, 1, &umr_bitfield_default },
	 { "NJ_PAUSE_DPG_REQ", 2, 2, &umr_bitfield_default },
	 { "NJ_PAUSE_DPG_ACK", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH1[] = {
	 { "SCRATCH1_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH2[] = {
	 { "SCRATCH2_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH3[] = {
	 { "SCRATCH3_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH4[] = {
	 { "SCRATCH4_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH5[] = {
	 { "SCRATCH5_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH6[] = {
	 { "SCRATCH6_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH7[] = {
	 { "SCRATCH7_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH8[] = {
	 { "SCRATCH8_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH9[] = {
	 { "SCRATCH9_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH10[] = {
	 { "SCRATCH10_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH11[] = {
	 { "SCRATCH11_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH12[] = {
	 { "SCRATCH12_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH13[] = {
	 { "SCRATCH13_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH14[] = {
	 { "SCRATCH14_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_FREE_COUNTER_REG[] = {
	 { "FREE_COUNTER", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_VCPU_CACHE_OFFSET0[] = {
	 { "CACHE_OFFSET0", 0, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_LMI_VCPU_CACHE_VMID[] = {
	 { "VCPU_CACHE_VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PF_STATUS[] = {
	 { "JPEG_PF_OCCURED", 0, 0, &umr_bitfield_default },
	 { "NJ_PF_OCCURED", 1, 1, &umr_bitfield_default },
	 { "ENCODER0_PF_OCCURED", 2, 2, &umr_bitfield_default },
	 { "ENCODER1_PF_OCCURED", 3, 3, &umr_bitfield_default },
	 { "ENCODER2_PF_OCCURED", 4, 4, &umr_bitfield_default },
	 { "ENCODER3_PF_OCCURED", 5, 5, &umr_bitfield_default },
	 { "ENCODER4_PF_OCCURED", 6, 6, &umr_bitfield_default },
	 { "EJPEG_PF_OCCURED", 7, 7, &umr_bitfield_default },
	 { "JPEG_PF_CLEAR", 8, 8, &umr_bitfield_default },
	 { "NJ_PF_CLEAR", 9, 9, &umr_bitfield_default },
	 { "ENCODER0_PF_CLEAR", 10, 10, &umr_bitfield_default },
	 { "ENCODER1_PF_CLEAR", 11, 11, &umr_bitfield_default },
	 { "ENCODER2_PF_CLEAR", 12, 12, &umr_bitfield_default },
	 { "ENCODER3_PF_CLEAR", 13, 13, &umr_bitfield_default },
	 { "ENCODER4_PF_CLEAR", 14, 14, &umr_bitfield_default },
	 { "EJPEG_PF_CLEAR", 15, 15, &umr_bitfield_default },
	 { "NJ_ATM_PF_OCCURED", 16, 16, &umr_bitfield_default },
	 { "DJ_ATM_PF_OCCURED", 17, 17, &umr_bitfield_default },
	 { "EJ_ATM_PF_OCCURED", 18, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_CLK_EN_VCPU_REPORT[] = {
	 { "CLK_EN", 0, 0, &umr_bitfield_default },
	 { "VCPU_REPORT", 1, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GFX8_ADDR_CONFIG[] = {
	 { "PIPE_INTERLEAVE_SIZE", 4, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GFX10_ADDR_CONFIG[] = {
	 { "NUM_PIPES", 0, 2, &umr_bitfield_default },
	 { "PIPE_INTERLEAVE_SIZE", 3, 5, &umr_bitfield_default },
	 { "NUM_BANKS", 12, 14, &umr_bitfield_default },
	 { "NUM_SHADER_ENGINES", 19, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT2_CNTL[] = {
	 { "CLR", 0, 0, &umr_bitfield_default },
	 { "START", 1, 1, &umr_bitfield_default },
	 { "COUNTUP", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT2_TARGET_LOWER[] = {
	 { "TARGET", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT2_STATUS_LOWER[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT2_TARGET_UPPER[] = {
	 { "TARGET", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT2_STATUS_UPPER[] = {
	 { "COUNT", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT3_CNTL[] = {
	 { "CLR", 0, 0, &umr_bitfield_default },
	 { "START", 1, 1, &umr_bitfield_default },
	 { "COUNTUP", 2, 2, &umr_bitfield_default },
	 { "FREQ", 3, 9, &umr_bitfield_default },
	 { "DIV", 10, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT3_TARGET_LOWER[] = {
	 { "TARGET", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT3_STATUS_LOWER[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT3_TARGET_UPPER[] = {
	 { "TARGET", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCNT3_STATUS_UPPER[] = {
	 { "COUNT", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_STATUS[] = {
	 { "RBC_BUSY", 0, 0, &umr_bitfield_default },
	 { "VCPU_REPORT", 1, 7, &umr_bitfield_default },
	 { "RBC_ACCESS_GPCOM", 16, 16, &umr_bitfield_default },
	 { "SYS_GPCOM_REQ", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENC_PIPE_BUSY[] = {
	 { "IME_BUSY", 0, 0, &umr_bitfield_default },
	 { "SMP_BUSY", 1, 1, &umr_bitfield_default },
	 { "SIT_BUSY", 2, 2, &umr_bitfield_default },
	 { "SDB_BUSY", 3, 3, &umr_bitfield_default },
	 { "ENT_BUSY", 4, 4, &umr_bitfield_default },
	 { "ENT_HEADER_BUSY", 5, 5, &umr_bitfield_default },
	 { "LCM_BUSY", 6, 6, &umr_bitfield_default },
	 { "MDM_RD_CUR_BUSY", 7, 7, &umr_bitfield_default },
	 { "MDM_RD_REF_BUSY", 8, 8, &umr_bitfield_default },
	 { "MDM_RD_GEN_BUSY", 9, 9, &umr_bitfield_default },
	 { "MDM_WR_RECON_BUSY", 10, 10, &umr_bitfield_default },
	 { "MDM_WR_GEN_BUSY", 11, 11, &umr_bitfield_default },
	 { "MIF_RD_CUR_BUSY", 16, 16, &umr_bitfield_default },
	 { "MIF_RD_REF0_BUSY", 17, 17, &umr_bitfield_default },
	 { "MIF_WR_GEN0_BUSY", 18, 18, &umr_bitfield_default },
	 { "MIF_RD_GEN0_BUSY", 19, 19, &umr_bitfield_default },
	 { "MIF_WR_GEN1_BUSY", 20, 20, &umr_bitfield_default },
	 { "MIF_RD_GEN1_BUSY", 21, 21, &umr_bitfield_default },
	 { "MIF_WR_BSP0_BUSY", 22, 22, &umr_bitfield_default },
	 { "MIF_WR_BSP1_BUSY", 23, 23, &umr_bitfield_default },
	 { "MIF_RD_BSD0_BUSY", 24, 24, &umr_bitfield_default },
	 { "MIF_RD_BSD1_BUSY", 25, 25, &umr_bitfield_default },
	 { "MIF_RD_BSD2_BUSY", 26, 26, &umr_bitfield_default },
	 { "MIF_RD_BSD3_BUSY", 27, 27, &umr_bitfield_default },
	 { "MIF_RD_BSD4_BUSY", 28, 28, &umr_bitfield_default },
	 { "MIF_WR_BSP2_BUSY", 29, 29, &umr_bitfield_default },
	 { "MIF_WR_BSP3_BUSY", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SOFT_RESET[] = {
	 { "RBC_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "LBSI_SOFT_RESET", 1, 1, &umr_bitfield_default },
	 { "LMI_SOFT_RESET", 2, 2, &umr_bitfield_default },
	 { "VCPU_SOFT_RESET", 3, 3, &umr_bitfield_default },
	 { "UDEC_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "CXW_SOFT_RESET", 6, 6, &umr_bitfield_default },
	 { "TAP_SOFT_RESET", 7, 7, &umr_bitfield_default },
	 { "MPC_SOFT_RESET", 8, 8, &umr_bitfield_default },
	 { "EFC_SOFT_RESET", 9, 9, &umr_bitfield_default },
	 { "IH_SOFT_RESET", 10, 10, &umr_bitfield_default },
	 { "MPRD_SOFT_RESET", 11, 11, &umr_bitfield_default },
	 { "IDCT_SOFT_RESET", 12, 12, &umr_bitfield_default },
	 { "LMI_UMC_SOFT_RESET", 13, 13, &umr_bitfield_default },
	 { "SPH_SOFT_RESET", 14, 14, &umr_bitfield_default },
	 { "MIF_SOFT_RESET", 15, 15, &umr_bitfield_default },
	 { "LCM_SOFT_RESET", 16, 16, &umr_bitfield_default },
	 { "SUVD_SOFT_RESET", 17, 17, &umr_bitfield_default },
	 { "LBSI_VCLK_RESET_STATUS", 18, 18, &umr_bitfield_default },
	 { "VCPU_VCLK_RESET_STATUS", 19, 19, &umr_bitfield_default },
	 { "UDEC_VCLK_RESET_STATUS", 20, 20, &umr_bitfield_default },
	 { "UDEC_DCLK_RESET_STATUS", 21, 21, &umr_bitfield_default },
	 { "MPC_DCLK_RESET_STATUS", 22, 22, &umr_bitfield_default },
	 { "MPRD_VCLK_RESET_STATUS", 23, 23, &umr_bitfield_default },
	 { "MPRD_DCLK_RESET_STATUS", 24, 24, &umr_bitfield_default },
	 { "IDCT_VCLK_RESET_STATUS", 25, 25, &umr_bitfield_default },
	 { "MIF_DCLK_RESET_STATUS", 26, 26, &umr_bitfield_default },
	 { "LCM_DCLK_RESET_STATUS", 27, 27, &umr_bitfield_default },
	 { "SUVD_VCLK_RESET_STATUS", 28, 28, &umr_bitfield_default },
	 { "SUVD_DCLK_RESET_STATUS", 29, 29, &umr_bitfield_default },
	 { "RE_DCLK_RESET_STATUS", 30, 30, &umr_bitfield_default },
	 { "SRE_DCLK_RESET_STATUS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SOFT_RESET2[] = {
	 { "ATOMIC_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "MMSCH_VCLK_RESET_STATUS", 16, 16, &umr_bitfield_default },
	 { "MMSCH_SCLK_RESET_STATUS", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MMSCH_SOFT_RESET[] = {
	 { "MMSCH_RESET", 0, 0, &umr_bitfield_default },
	 { "TAP_SOFT_RESET", 1, 1, &umr_bitfield_default },
	 { "MMSCH_LOCK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CGC_GATE[] = {
	 { "SYS", 0, 0, &umr_bitfield_default },
	 { "UDEC", 1, 1, &umr_bitfield_default },
	 { "MPEG2", 2, 2, &umr_bitfield_default },
	 { "REGS", 3, 3, &umr_bitfield_default },
	 { "RBC", 4, 4, &umr_bitfield_default },
	 { "LMI_MC", 5, 5, &umr_bitfield_default },
	 { "LMI_UMC", 6, 6, &umr_bitfield_default },
	 { "IDCT", 7, 7, &umr_bitfield_default },
	 { "MPRD", 8, 8, &umr_bitfield_default },
	 { "MPC", 9, 9, &umr_bitfield_default },
	 { "LBSI", 10, 10, &umr_bitfield_default },
	 { "LRBBM", 11, 11, &umr_bitfield_default },
	 { "UDEC_RE", 12, 12, &umr_bitfield_default },
	 { "UDEC_CM", 13, 13, &umr_bitfield_default },
	 { "UDEC_IT", 14, 14, &umr_bitfield_default },
	 { "UDEC_DB", 15, 15, &umr_bitfield_default },
	 { "UDEC_MP", 16, 16, &umr_bitfield_default },
	 { "WCB", 17, 17, &umr_bitfield_default },
	 { "VCPU", 18, 18, &umr_bitfield_default },
	 { "MMSCH", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CGC_STATUS[] = {
	 { "SYS_SCLK", 0, 0, &umr_bitfield_default },
	 { "SYS_DCLK", 1, 1, &umr_bitfield_default },
	 { "SYS_VCLK", 2, 2, &umr_bitfield_default },
	 { "UDEC_SCLK", 3, 3, &umr_bitfield_default },
	 { "UDEC_DCLK", 4, 4, &umr_bitfield_default },
	 { "UDEC_VCLK", 5, 5, &umr_bitfield_default },
	 { "MPEG2_SCLK", 6, 6, &umr_bitfield_default },
	 { "MPEG2_DCLK", 7, 7, &umr_bitfield_default },
	 { "MPEG2_VCLK", 8, 8, &umr_bitfield_default },
	 { "REGS_SCLK", 9, 9, &umr_bitfield_default },
	 { "REGS_VCLK", 10, 10, &umr_bitfield_default },
	 { "RBC_SCLK", 11, 11, &umr_bitfield_default },
	 { "LMI_MC_SCLK", 12, 12, &umr_bitfield_default },
	 { "LMI_UMC_SCLK", 13, 13, &umr_bitfield_default },
	 { "IDCT_SCLK", 14, 14, &umr_bitfield_default },
	 { "IDCT_VCLK", 15, 15, &umr_bitfield_default },
	 { "MPRD_SCLK", 16, 16, &umr_bitfield_default },
	 { "MPRD_DCLK", 17, 17, &umr_bitfield_default },
	 { "MPRD_VCLK", 18, 18, &umr_bitfield_default },
	 { "MPC_SCLK", 19, 19, &umr_bitfield_default },
	 { "MPC_DCLK", 20, 20, &umr_bitfield_default },
	 { "LBSI_SCLK", 21, 21, &umr_bitfield_default },
	 { "LBSI_VCLK", 22, 22, &umr_bitfield_default },
	 { "LRBBM_SCLK", 23, 23, &umr_bitfield_default },
	 { "WCB_SCLK", 24, 24, &umr_bitfield_default },
	 { "VCPU_SCLK", 25, 25, &umr_bitfield_default },
	 { "VCPU_VCLK", 26, 26, &umr_bitfield_default },
	 { "MMSCH_SCLK", 27, 27, &umr_bitfield_default },
	 { "MMSCH_VCLK", 28, 28, &umr_bitfield_default },
	 { "ALL_ENC_ACTIVE", 29, 29, &umr_bitfield_default },
	 { "ALL_DEC_ACTIVE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CGC_CTRL[] = {
	 { "DYN_CLOCK_MODE", 0, 0, &umr_bitfield_default },
	 { "CLK_GATE_DLY_TIMER", 2, 5, &umr_bitfield_default },
	 { "CLK_OFF_DELAY", 6, 10, &umr_bitfield_default },
	 { "UDEC_RE_MODE", 11, 11, &umr_bitfield_default },
	 { "UDEC_CM_MODE", 12, 12, &umr_bitfield_default },
	 { "UDEC_IT_MODE", 13, 13, &umr_bitfield_default },
	 { "UDEC_DB_MODE", 14, 14, &umr_bitfield_default },
	 { "UDEC_MP_MODE", 15, 15, &umr_bitfield_default },
	 { "SYS_MODE", 16, 16, &umr_bitfield_default },
	 { "UDEC_MODE", 17, 17, &umr_bitfield_default },
	 { "MPEG2_MODE", 18, 18, &umr_bitfield_default },
	 { "REGS_MODE", 19, 19, &umr_bitfield_default },
	 { "RBC_MODE", 20, 20, &umr_bitfield_default },
	 { "LMI_MC_MODE", 21, 21, &umr_bitfield_default },
	 { "LMI_UMC_MODE", 22, 22, &umr_bitfield_default },
	 { "IDCT_MODE", 23, 23, &umr_bitfield_default },
	 { "MPRD_MODE", 24, 24, &umr_bitfield_default },
	 { "MPC_MODE", 25, 25, &umr_bitfield_default },
	 { "LBSI_MODE", 26, 26, &umr_bitfield_default },
	 { "LRBBM_MODE", 27, 27, &umr_bitfield_default },
	 { "WCB_MODE", 28, 28, &umr_bitfield_default },
	 { "VCPU_MODE", 29, 29, &umr_bitfield_default },
	 { "MMSCH_MODE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CGC_UDEC_STATUS[] = {
	 { "RE_SCLK", 0, 0, &umr_bitfield_default },
	 { "RE_DCLK", 1, 1, &umr_bitfield_default },
	 { "RE_VCLK", 2, 2, &umr_bitfield_default },
	 { "CM_SCLK", 3, 3, &umr_bitfield_default },
	 { "CM_DCLK", 4, 4, &umr_bitfield_default },
	 { "CM_VCLK", 5, 5, &umr_bitfield_default },
	 { "IT_SCLK", 6, 6, &umr_bitfield_default },
	 { "IT_DCLK", 7, 7, &umr_bitfield_default },
	 { "IT_VCLK", 8, 8, &umr_bitfield_default },
	 { "DB_SCLK", 9, 9, &umr_bitfield_default },
	 { "DB_DCLK", 10, 10, &umr_bitfield_default },
	 { "DB_VCLK", 11, 11, &umr_bitfield_default },
	 { "MP_SCLK", 12, 12, &umr_bitfield_default },
	 { "MP_DCLK", 13, 13, &umr_bitfield_default },
	 { "MP_VCLK", 14, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_CGC_GATE[] = {
	 { "SRE", 0, 0, &umr_bitfield_default },
	 { "SIT", 1, 1, &umr_bitfield_default },
	 { "SMP", 2, 2, &umr_bitfield_default },
	 { "SCM", 3, 3, &umr_bitfield_default },
	 { "SDB", 4, 4, &umr_bitfield_default },
	 { "SRE_H264", 5, 5, &umr_bitfield_default },
	 { "SRE_HEVC", 6, 6, &umr_bitfield_default },
	 { "SIT_H264", 7, 7, &umr_bitfield_default },
	 { "SIT_HEVC", 8, 8, &umr_bitfield_default },
	 { "SCM_H264", 9, 9, &umr_bitfield_default },
	 { "SCM_HEVC", 10, 10, &umr_bitfield_default },
	 { "SDB_H264", 11, 11, &umr_bitfield_default },
	 { "SDB_HEVC", 12, 12, &umr_bitfield_default },
	 { "SCLR", 13, 13, &umr_bitfield_default },
	 { "UVD_SC", 14, 14, &umr_bitfield_default },
	 { "ENT", 15, 15, &umr_bitfield_default },
	 { "IME", 16, 16, &umr_bitfield_default },
	 { "SIT_HEVC_DEC", 17, 17, &umr_bitfield_default },
	 { "SIT_HEVC_ENC", 18, 18, &umr_bitfield_default },
	 { "SITE", 19, 19, &umr_bitfield_default },
	 { "SRE_VP9", 20, 20, &umr_bitfield_default },
	 { "SCM_VP9", 21, 21, &umr_bitfield_default },
	 { "SIT_VP9_DEC", 22, 22, &umr_bitfield_default },
	 { "SDB_VP9", 23, 23, &umr_bitfield_default },
	 { "IME_HEVC", 24, 24, &umr_bitfield_default },
	 { "EFC", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_CGC_STATUS[] = {
	 { "SRE_VCLK", 0, 0, &umr_bitfield_default },
	 { "SRE_DCLK", 1, 1, &umr_bitfield_default },
	 { "SIT_DCLK", 2, 2, &umr_bitfield_default },
	 { "SMP_DCLK", 3, 3, &umr_bitfield_default },
	 { "SCM_DCLK", 4, 4, &umr_bitfield_default },
	 { "SDB_DCLK", 5, 5, &umr_bitfield_default },
	 { "SRE_H264_VCLK", 6, 6, &umr_bitfield_default },
	 { "SRE_HEVC_VCLK", 7, 7, &umr_bitfield_default },
	 { "SIT_H264_DCLK", 8, 8, &umr_bitfield_default },
	 { "SIT_HEVC_DCLK", 9, 9, &umr_bitfield_default },
	 { "SCM_H264_DCLK", 10, 10, &umr_bitfield_default },
	 { "SCM_HEVC_DCLK", 11, 11, &umr_bitfield_default },
	 { "SDB_H264_DCLK", 12, 12, &umr_bitfield_default },
	 { "SDB_HEVC_DCLK", 13, 13, &umr_bitfield_default },
	 { "SCLR_DCLK", 14, 14, &umr_bitfield_default },
	 { "UVD_SC", 15, 15, &umr_bitfield_default },
	 { "ENT_DCLK", 16, 16, &umr_bitfield_default },
	 { "IME_DCLK", 17, 17, &umr_bitfield_default },
	 { "SIT_HEVC_DEC_DCLK", 18, 18, &umr_bitfield_default },
	 { "SIT_HEVC_ENC_DCLK", 19, 19, &umr_bitfield_default },
	 { "SITE_DCLK", 20, 20, &umr_bitfield_default },
	 { "SITE_HEVC_DCLK", 21, 21, &umr_bitfield_default },
	 { "SITE_HEVC_ENC_DCLK", 22, 22, &umr_bitfield_default },
	 { "SRE_VP9_VCLK", 23, 23, &umr_bitfield_default },
	 { "SCM_VP9_VCLK", 24, 24, &umr_bitfield_default },
	 { "SIT_VP9_DEC_DCLK", 25, 25, &umr_bitfield_default },
	 { "SDB_VP9_DCLK", 26, 26, &umr_bitfield_default },
	 { "IME_HEVC_DCLK", 27, 27, &umr_bitfield_default },
	 { "EFC_DCLK", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_CGC_CTRL[] = {
	 { "SRE_MODE", 0, 0, &umr_bitfield_default },
	 { "SIT_MODE", 1, 1, &umr_bitfield_default },
	 { "SMP_MODE", 2, 2, &umr_bitfield_default },
	 { "SCM_MODE", 3, 3, &umr_bitfield_default },
	 { "SDB_MODE", 4, 4, &umr_bitfield_default },
	 { "SCLR_MODE", 5, 5, &umr_bitfield_default },
	 { "UVD_SC_MODE", 6, 6, &umr_bitfield_default },
	 { "ENT_MODE", 7, 7, &umr_bitfield_default },
	 { "IME_MODE", 8, 8, &umr_bitfield_default },
	 { "SITE_MODE", 9, 9, &umr_bitfield_default },
	 { "EFC_MODE", 10, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_VCPU_CMD[] = {
	 { "CMD_SEND", 0, 0, &umr_bitfield_default },
	 { "CMD", 1, 30, &umr_bitfield_default },
	 { "CMD_SOURCE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_VCPU_DATA0[] = {
	 { "DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_VCPU_DATA1[] = {
	 { "DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_SYS_CMD[] = {
	 { "CMD_SEND", 0, 0, &umr_bitfield_default },
	 { "CMD", 1, 30, &umr_bitfield_default },
	 { "CMD_SOURCE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_SYS_DATA0[] = {
	 { "DATA0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPCOM_SYS_DATA1[] = {
	 { "DATA1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_EN[] = {
	 { "PIF_ADDR_ERR_EN", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_EN", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_EN", 2, 2, &umr_bitfield_default },
	 { "NJ_PF_RPT_EN", 3, 3, &umr_bitfield_default },
	 { "SW_RB1_INT_EN", 4, 4, &umr_bitfield_default },
	 { "SW_RB2_INT_EN", 5, 5, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_EN", 6, 6, &umr_bitfield_default },
	 { "SW_RB3_INT_EN", 7, 7, &umr_bitfield_default },
	 { "SW_RB4_INT_EN", 9, 9, &umr_bitfield_default },
	 { "SW_RB5_INT_EN", 10, 10, &umr_bitfield_default },
	 { "LBSI_EN", 11, 11, &umr_bitfield_default },
	 { "UDEC_EN", 12, 12, &umr_bitfield_default },
	 { "RPTR_WR_EN", 16, 16, &umr_bitfield_default },
	 { "JOB_START_EN", 17, 17, &umr_bitfield_default },
	 { "NJ_PF_EN", 18, 18, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_EN", 23, 23, &umr_bitfield_default },
	 { "IDCT_EN", 24, 24, &umr_bitfield_default },
	 { "MPRD_EN", 25, 25, &umr_bitfield_default },
	 { "AVM_INT_EN", 26, 26, &umr_bitfield_default },
	 { "CLK_SWT_EN", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT_EN", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_EN", 29, 29, &umr_bitfield_default },
	 { "DRV_FW_REQ_EN", 30, 30, &umr_bitfield_default },
	 { "DRV_FW_ACK_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_ACK[] = {
	 { "PIF_ADDR_ERR_ACK", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_ACK", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_ACK", 2, 2, &umr_bitfield_default },
	 { "NJ_PF_RPT_ACK", 3, 3, &umr_bitfield_default },
	 { "SW_RB1_INT_ACK", 4, 4, &umr_bitfield_default },
	 { "SW_RB2_INT_ACK", 5, 5, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_ACK", 6, 6, &umr_bitfield_default },
	 { "SW_RB3_INT_ACK", 7, 7, &umr_bitfield_default },
	 { "SW_RB4_INT_ACK", 9, 9, &umr_bitfield_default },
	 { "SW_RB5_INT_ACK", 10, 10, &umr_bitfield_default },
	 { "LBSI_ACK", 11, 11, &umr_bitfield_default },
	 { "UDEC_ACK", 12, 12, &umr_bitfield_default },
	 { "RPTR_WR_ACK", 16, 16, &umr_bitfield_default },
	 { "JOB_START_ACK", 17, 17, &umr_bitfield_default },
	 { "NJ_PF_ACK", 18, 18, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_ACK", 23, 23, &umr_bitfield_default },
	 { "IDCT_ACK", 24, 24, &umr_bitfield_default },
	 { "MPRD_ACK", 25, 25, &umr_bitfield_default },
	 { "AVM_INT_ACK", 26, 26, &umr_bitfield_default },
	 { "CLK_SWT_ACK", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT_ACK", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_ACK", 29, 29, &umr_bitfield_default },
	 { "DRV_FW_REQ_ACK", 30, 30, &umr_bitfield_default },
	 { "DRV_FW_ACK_ACK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_ROUTE[] = {
	 { "DRV_FW_MSG", 0, 0, &umr_bitfield_default },
	 { "FW_DRV_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "VCPU_GPCOM", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENC_VCPU_INT_EN[] = {
	 { "DCE_UVD_SCAN_IN_BUFMGR_EN", 0, 0, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR2_EN", 1, 1, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR3_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENC_VCPU_INT_ACK[] = {
	 { "DCE_UVD_SCAN_IN_BUFMGR_ACK", 0, 0, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR2_ACK", 1, 1, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR3_ACK", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MASTINT_EN[] = {
	 { "OVERRUN_RST", 0, 0, &umr_bitfield_default },
	 { "VCPU_EN", 1, 1, &umr_bitfield_default },
	 { "SYS_EN", 2, 2, &umr_bitfield_default },
	 { "INT_OVERRUN", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SYS_INT_EN[] = {
	 { "PIF_ADDR_ERR_EN", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_EN", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_EN", 2, 2, &umr_bitfield_default },
	 { "CXW_WR_EN", 3, 3, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_EN", 6, 6, &umr_bitfield_default },
	 { "LBSI_EN", 11, 11, &umr_bitfield_default },
	 { "UDEC_EN", 12, 12, &umr_bitfield_default },
	 { "JOB_DONE_EN", 16, 16, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_EN", 23, 23, &umr_bitfield_default },
	 { "IDCT_EN", 24, 24, &umr_bitfield_default },
	 { "MPRD_EN", 25, 25, &umr_bitfield_default },
	 { "CLK_SWT_EN", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT_EN", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_EN", 29, 29, &umr_bitfield_default },
	 { "AVM_INT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SYS_INT_STATUS[] = {
	 { "PIF_ADDR_ERR_INT", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_INT", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_INT", 2, 2, &umr_bitfield_default },
	 { "CXW_WR_INT", 3, 3, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_INT", 6, 6, &umr_bitfield_default },
	 { "LBSI_INT", 11, 11, &umr_bitfield_default },
	 { "UDEC_INT", 12, 12, &umr_bitfield_default },
	 { "JOB_DONE_INT", 16, 16, &umr_bitfield_default },
	 { "GPCOM_INT", 18, 18, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_INT", 23, 23, &umr_bitfield_default },
	 { "IDCT_INT", 24, 24, &umr_bitfield_default },
	 { "MPRD_INT", 25, 25, &umr_bitfield_default },
	 { "CLK_SWT_INT", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_INT", 29, 29, &umr_bitfield_default },
	 { "AVM_INT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SYS_INT_ACK[] = {
	 { "PIF_ADDR_ERR_ACK", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_ACK", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_ACK", 2, 2, &umr_bitfield_default },
	 { "CXW_WR_ACK", 3, 3, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_ACK", 6, 6, &umr_bitfield_default },
	 { "LBSI_ACK", 11, 11, &umr_bitfield_default },
	 { "UDEC_ACK", 12, 12, &umr_bitfield_default },
	 { "JOB_DONE_ACK", 16, 16, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_ACK", 23, 23, &umr_bitfield_default },
	 { "IDCT_ACK", 24, 24, &umr_bitfield_default },
	 { "MPRD_ACK", 25, 25, &umr_bitfield_default },
	 { "CLK_SWT_ACK", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT_ACK", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_ACK", 29, 29, &umr_bitfield_default },
	 { "AVM_INT_ACK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JOB_DONE[] = {
	 { "JOB_DONE", 0, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CBUF_ID[] = {
	 { "CBUF_ID", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CONTEXT_ID[] = {
	 { "CONTEXT_ID", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CONTEXT_ID2[] = {
	 { "CONTEXT_ID2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_NO_OP[] = {
	 { "NO_OP", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_LO[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_HI[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_SIZE[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_LO2[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_HI2[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_SIZE2[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_RPTR2[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_WPTR2[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_LO3[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_HI3[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_SIZE3[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_RPTR3[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_WPTR3[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_LO4[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_BASE_HI4[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_SIZE4[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_RPTR4[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_WPTR4[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_OUT_RB_BASE_LO[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_OUT_RB_BASE_HI[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_OUT_RB_SIZE[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_OUT_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_OUT_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RB_ARB_CTRL[] = {
	 { "SRBM_DROP", 0, 0, &umr_bitfield_default },
	 { "SRBM_DIS", 1, 1, &umr_bitfield_default },
	 { "VCPU_DROP", 2, 2, &umr_bitfield_default },
	 { "VCPU_DIS", 3, 3, &umr_bitfield_default },
	 { "RBC_DROP", 4, 4, &umr_bitfield_default },
	 { "RBC_DIS", 5, 5, &umr_bitfield_default },
	 { "FWOFLD_DROP", 6, 6, &umr_bitfield_default },
	 { "FWOFLD_DIS", 7, 7, &umr_bitfield_default },
	 { "FAST_PATH_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CTX_INDEX[] = {
	 { "INDEX", 0, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CTX_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CXW_WR[] = {
	 { "DAT", 0, 27, &umr_bitfield_default },
	 { "STAT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CXW_WR_INT_ID[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CXW_WR_INT_CTX_ID[] = {
	 { "ID", 0, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CXW_INT_ID[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_TOP_CTRL[] = {
	 { "STANDARD", 0, 3, &umr_bitfield_default },
	 { "STD_VERSION", 4, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_YBASE[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_UVBASE[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PITCH[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_WIDTH[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_HEIGHT[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PICCOUNT[] = {
	 { "DUM", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH_NP[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VERSION[] = {
	 { "MINOR_VERSION", 0, 15, &umr_bitfield_default },
	 { "MAJOR_VERSION", 16, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH0[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH1[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH2[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH3[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH4[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH5[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH6[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH7[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH8[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH9[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH10[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH11[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH12[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH13[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH14[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH15[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH16[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH17[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH18[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH19[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH20[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH21[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH22[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GP_SCRATCH23[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET0[] = {
	 { "CACHE_OFFSET0", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE0[] = {
	 { "CACHE_SIZE0", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET1[] = {
	 { "CACHE_OFFSET1", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE1[] = {
	 { "CACHE_SIZE1", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET2[] = {
	 { "CACHE_OFFSET2", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE2[] = {
	 { "CACHE_SIZE2", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET3[] = {
	 { "CACHE_OFFSET3", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE3[] = {
	 { "CACHE_SIZE3", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET4[] = {
	 { "CACHE_OFFSET4", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE4[] = {
	 { "CACHE_SIZE4", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET5[] = {
	 { "CACHE_OFFSET5", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE5[] = {
	 { "CACHE_SIZE5", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET6[] = {
	 { "CACHE_OFFSET6", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE6[] = {
	 { "CACHE_SIZE6", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET7[] = {
	 { "CACHE_OFFSET7", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE7[] = {
	 { "CACHE_SIZE7", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_OFFSET8[] = {
	 { "CACHE_OFFSET8", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CACHE_SIZE8[] = {
	 { "CACHE_SIZE8", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_NONCACHE_OFFSET0[] = {
	 { "NONCACHE_OFFSET0", 0, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_NONCACHE_SIZE0[] = {
	 { "NONCACHE_SIZE0", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_NONCACHE_OFFSET1[] = {
	 { "NONCACHE_OFFSET1", 0, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_NONCACHE_SIZE1[] = {
	 { "NONCACHE_SIZE1", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_CNTL[] = {
	 { "IRQ_ERR", 0, 3, &umr_bitfield_default },
	 { "PMB_ED_ENABLE", 5, 5, &umr_bitfield_default },
	 { "PMB_SOFT_RESET", 6, 6, &umr_bitfield_default },
	 { "RBBM_SOFT_RESET", 7, 7, &umr_bitfield_default },
	 { "ABORT_REQ", 8, 8, &umr_bitfield_default },
	 { "CLK_EN", 9, 9, &umr_bitfield_default },
	 { "TRCE_EN", 10, 10, &umr_bitfield_default },
	 { "TRCE_MUX", 11, 12, &umr_bitfield_default },
	 { "JTAG_EN", 16, 16, &umr_bitfield_default },
	 { "TIMEOUT_DIS", 18, 18, &umr_bitfield_default },
	 { "PRB_TIMEOUT_VAL", 20, 27, &umr_bitfield_default },
	 { "BLK_RST", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_PRID[] = {
	 { "PRID", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_TRCE[] = {
	 { "PC", 0, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_TRCE_RD[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MP_SWAP_CNTL[] = {
	 { "MP_REF0_MC_SWAP", 0, 1, &umr_bitfield_default },
	 { "MP_REF1_MC_SWAP", 2, 3, &umr_bitfield_default },
	 { "MP_REF2_MC_SWAP", 4, 5, &umr_bitfield_default },
	 { "MP_REF3_MC_SWAP", 6, 7, &umr_bitfield_default },
	 { "MP_REF4_MC_SWAP", 8, 9, &umr_bitfield_default },
	 { "MP_REF5_MC_SWAP", 10, 11, &umr_bitfield_default },
	 { "MP_REF6_MC_SWAP", 12, 13, &umr_bitfield_default },
	 { "MP_REF7_MC_SWAP", 14, 15, &umr_bitfield_default },
	 { "MP_REF8_MC_SWAP", 16, 17, &umr_bitfield_default },
	 { "MP_REF9_MC_SWAP", 18, 19, &umr_bitfield_default },
	 { "MP_REF10_MC_SWAP", 20, 21, &umr_bitfield_default },
	 { "MP_REF11_MC_SWAP", 22, 23, &umr_bitfield_default },
	 { "MP_REF12_MC_SWAP", 24, 25, &umr_bitfield_default },
	 { "MP_REF13_MC_SWAP", 26, 27, &umr_bitfield_default },
	 { "MP_REF14_MC_SWAP", 28, 29, &umr_bitfield_default },
	 { "MP_REF15_MC_SWAP", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_LUMA_SRCH[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_LUMA_HIT[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_LUMA_HITPEND[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_CHROMA_SRCH[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_CHROMA_HIT[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_CHROMA_HITPEND[] = {
	 { "CNTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_CNTL[] = {
	 { "REPLACEMENT_MODE", 3, 5, &umr_bitfield_default },
	 { "PERF_RST", 6, 6, &umr_bitfield_default },
	 { "AVE_WEIGHT", 16, 17, &umr_bitfield_default },
	 { "URGENT_EN", 18, 18, &umr_bitfield_default },
	 { "SMPAT_REQ_SPEED_UP", 19, 19, &umr_bitfield_default },
	 { "TEST_MODE_EN", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_PITCH[] = {
	 { "LUMA_PITCH", 0, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_MUXA0[] = {
	 { "VARA_0", 0, 5, &umr_bitfield_default },
	 { "VARA_1", 6, 11, &umr_bitfield_default },
	 { "VARA_2", 12, 17, &umr_bitfield_default },
	 { "VARA_3", 18, 23, &umr_bitfield_default },
	 { "VARA_4", 24, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_MUXA1[] = {
	 { "VARA_5", 0, 5, &umr_bitfield_default },
	 { "VARA_6", 6, 11, &umr_bitfield_default },
	 { "VARA_7", 12, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_MUXB0[] = {
	 { "VARB_0", 0, 5, &umr_bitfield_default },
	 { "VARB_1", 6, 11, &umr_bitfield_default },
	 { "VARB_2", 12, 17, &umr_bitfield_default },
	 { "VARB_3", 18, 23, &umr_bitfield_default },
	 { "VARB_4", 24, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_MUXB1[] = {
	 { "VARB_5", 0, 5, &umr_bitfield_default },
	 { "VARB_6", 6, 11, &umr_bitfield_default },
	 { "VARB_7", 12, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_MUX[] = {
	 { "SET_0", 0, 2, &umr_bitfield_default },
	 { "SET_1", 3, 5, &umr_bitfield_default },
	 { "SET_2", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_SET_ALU[] = {
	 { "FUNCT", 0, 2, &umr_bitfield_default },
	 { "OPERAND", 4, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_PERF0[] = {
	 { "MAX_LAT", 0, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_PERF1[] = {
	 { "AVE_LAT", 0, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_IB_SIZE[] = {
	 { "IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_IB_SIZE_UPDATE[] = {
	 { "REMAIN_IB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_RB_CNTL[] = {
	 { "RB_BUFSZ", 0, 4, &umr_bitfield_default },
	 { "RB_BLKSZ", 8, 12, &umr_bitfield_default },
	 { "RB_NO_FETCH", 16, 16, &umr_bitfield_default },
	 { "RB_WPTR_POLL_EN", 20, 20, &umr_bitfield_default },
	 { "RB_NO_UPDATE", 24, 24, &umr_bitfield_default },
	 { "RB_RPTR_WR_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_RB_RPTR_ADDR[] = {
	 { "RB_RPTR_ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_VCPU_ACCESS[] = {
	 { "ENABLE_RBC", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_READ_REQ_URGENT_CNTL[] = {
	 { "CMD_READ_REQ_PRIORITY_MARK", 0, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_RB_WPTR_CNTL[] = {
	 { "RB_PRE_WRITE_TIMER", 0, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_WPTR_STATUS[] = {
	 { "RB_WPTR_IN_USE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_WPTR_POLL_CNTL[] = {
	 { "POLL_FREQ", 0, 15, &umr_bitfield_default },
	 { "IDLE_POLL_COUNT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_WPTR_POLL_ADDR[] = {
	 { "POLL_ADDR", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_CMD[] = {
	 { "REQ_CMD", 0, 3, &umr_bitfield_default },
	 { "WR_PHASE", 4, 5, &umr_bitfield_default },
	 { "MODE", 6, 6, &umr_bitfield_default },
	 { "VMID_EN", 7, 7, &umr_bitfield_default },
	 { "VMID", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_ADDR_LOW[] = {
	 { "ADDR_26_3", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_ADDR_HIGH[] = {
	 { "ADDR_47_27", 0, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENGINE_CNTL[] = {
	 { "ENGINE_START", 0, 0, &umr_bitfield_default },
	 { "ENGINE_START_MODE", 1, 1, &umr_bitfield_default },
	 { "NJ_PF_HANDLE_DISABLE", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_TIMEOUT_STATUS[] = {
	 { "SEMAPHORE_WAIT_INCOMPLETE_TIMEOUT_STAT", 0, 0, &umr_bitfield_default },
	 { "SEMAPHORE_WAIT_FAULT_TIMEOUT_STAT", 1, 1, &umr_bitfield_default },
	 { "SEMAPHORE_SIGNAL_INCOMPLETE_TIMEOUT_STAT", 2, 2, &umr_bitfield_default },
	 { "SEMAPHORE_TIMEOUT_CLEAR", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_CNTL[] = {
	 { "SEMAPHORE_EN", 0, 0, &umr_bitfield_default },
	 { "ADVANCED_MODE_DIS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL[] = {
	 { "SIGNAL_INCOMPLETE_EN", 0, 0, &umr_bitfield_default },
	 { "SIGNAL_INCOMPLETE_COUNT", 1, 20, &umr_bitfield_default },
	 { "RESEND_TIMER", 24, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL[] = {
	 { "WAIT_FAULT_EN", 0, 0, &umr_bitfield_default },
	 { "WAIT_FAULT_COUNT", 1, 20, &umr_bitfield_default },
	 { "RESEND_TIMER", 24, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL[] = {
	 { "WAIT_INCOMPLETE_EN", 0, 0, &umr_bitfield_default },
	 { "WAIT_INCOMPLETE_COUNT", 1, 20, &umr_bitfield_default },
	 { "RESEND_TIMER", 24, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JOB_START[] = {
	 { "JOB_START", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_RBC_BUF_STATUS[] = {
	 { "RB_BUF_VALID", 0, 7, &umr_bitfield_default },
	 { "IB_BUF_VALID", 8, 15, &umr_bitfield_default },
	 { "RB_BUF_RD_ADDR", 16, 18, &umr_bitfield_default },
	 { "IB_BUF_RD_ADDR", 19, 21, &umr_bitfield_default },
	 { "RB_BUF_WR_ADDR", 22, 24, &umr_bitfield_default },
	 { "IB_BUF_WR_ADDR", 25, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LCM_CGC_CNTRL[] = {
	 { "FORCE_OFF", 18, 18, &umr_bitfield_default },
	 { "FORCE_ON", 19, 19, &umr_bitfield_default },
	 { "OFF_DELAY", 20, 27, &umr_bitfield_default },
	 { "ON_DELAY", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_RB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_IB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_NC1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE8_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE8_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC0_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC0_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC2_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC2_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC3_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC3_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC4_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC4_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC5_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC5_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC6_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC6_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC7_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC7_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC_VMID[] = {
	 { "MMSCH_NC0_VMID", 0, 3, &umr_bitfield_default },
	 { "MMSCH_NC1_VMID", 4, 7, &umr_bitfield_default },
	 { "MMSCH_NC2_VMID", 8, 11, &umr_bitfield_default },
	 { "MMSCH_NC3_VMID", 12, 15, &umr_bitfield_default },
	 { "MMSCH_NC4_VMID", 16, 19, &umr_bitfield_default },
	 { "MMSCH_NC5_VMID", 20, 23, &umr_bitfield_default },
	 { "MMSCH_NC6_VMID", 24, 27, &umr_bitfield_default },
	 { "MMSCH_NC7_VMID", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_CTRL[] = {
	 { "MMSCH_DATA_COHERENCY_EN", 0, 0, &umr_bitfield_default },
	 { "MMSCH_VM", 1, 1, &umr_bitfield_default },
	 { "MMSCH_R_MC_SWAP", 3, 4, &umr_bitfield_default },
	 { "MMSCH_W_MC_SWAP", 5, 6, &umr_bitfield_default },
	 { "MMSCH_RD", 7, 8, &umr_bitfield_default },
	 { "MMSCH_WR", 9, 10, &umr_bitfield_default },
	 { "MMSCH_RD_DROP", 11, 11, &umr_bitfield_default },
	 { "MMSCH_WR_DROP", 12, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ARB_CTRL2[] = {
	 { "CENC_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ATOMIC_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "CENC_RD_MAX_BURST", 2, 5, &umr_bitfield_default },
	 { "ATOMIC_WR_MAX_BURST", 6, 9, &umr_bitfield_default },
	 { "MIF_RD_REQ_RET_MAX", 10, 19, &umr_bitfield_default },
	 { "MIF_WR_REQ_RET_MAX", 20, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE_VMIDS_MULTI[] = {
	 { "VCPU_CACHE1_VMID", 0, 3, &umr_bitfield_default },
	 { "VCPU_CACHE2_VMID", 4, 7, &umr_bitfield_default },
	 { "VCPU_CACHE3_VMID", 8, 11, &umr_bitfield_default },
	 { "VCPU_CACHE4_VMID", 12, 15, &umr_bitfield_default },
	 { "VCPU_CACHE5_VMID", 16, 19, &umr_bitfield_default },
	 { "VCPU_CACHE6_VMID", 20, 23, &umr_bitfield_default },
	 { "VCPU_CACHE7_VMID", 24, 27, &umr_bitfield_default },
	 { "VCPU_CACHE8_VMID", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_NC_VMIDS_MULTI[] = {
	 { "VCPU_NC2_VMID", 4, 7, &umr_bitfield_default },
	 { "VCPU_NC3_VMID", 8, 11, &umr_bitfield_default },
	 { "VCPU_NC4_VMID", 12, 15, &umr_bitfield_default },
	 { "VCPU_NC5_VMID", 16, 19, &umr_bitfield_default },
	 { "VCPU_NC6_VMID", 20, 23, &umr_bitfield_default },
	 { "VCPU_NC7_VMID", 24, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_LAT_CTRL[] = {
	 { "SCALE", 0, 7, &umr_bitfield_default },
	 { "MAX_START", 8, 8, &umr_bitfield_default },
	 { "MIN_START", 9, 9, &umr_bitfield_default },
	 { "AVG_START", 10, 10, &umr_bitfield_default },
	 { "PERFMON_SYNC", 11, 11, &umr_bitfield_default },
	 { "SKIP", 16, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_LAT_CNTR[] = {
	 { "MAX_LAT", 0, 7, &umr_bitfield_default },
	 { "MIN_LAT", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_AVG_LAT_CNTR[] = {
	 { "ENV_LOW", 0, 7, &umr_bitfield_default },
	 { "ENV_HIGH", 8, 15, &umr_bitfield_default },
	 { "ENV_HIT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_SPH[] = {
	 { "ADDR", 0, 27, &umr_bitfield_default },
	 { "STS", 28, 29, &umr_bitfield_default },
	 { "STS_VALID", 30, 30, &umr_bitfield_default },
	 { "STS_OVERFLOW", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_VCPU_CACHE_VMID[] = {
	 { "VCPU_CACHE_VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_CTRL2[] = {
	 { "SPH_DIS", 0, 0, &umr_bitfield_default },
	 { "STALL_ARB", 1, 1, &umr_bitfield_default },
	 { "ASSERT_UMC_URGENT", 2, 2, &umr_bitfield_default },
	 { "MASK_UMC_URGENT", 3, 3, &umr_bitfield_default },
	 { "CRC1_RESET", 4, 4, &umr_bitfield_default },
	 { "DRCITF_BUBBLE_FIX_DIS", 7, 7, &umr_bitfield_default },
	 { "STALL_ARB_UMC", 8, 8, &umr_bitfield_default },
	 { "MC_READ_ID_SEL", 9, 10, &umr_bitfield_default },
	 { "MC_WRITE_ID_SEL", 11, 12, &umr_bitfield_default },
	 { "VCPU_NC0_EXT_EN", 13, 13, &umr_bitfield_default },
	 { "VCPU_NC1_EXT_EN", 14, 14, &umr_bitfield_default },
	 { "SPU_EXTRA_CID_EN", 15, 15, &umr_bitfield_default },
	 { "RE_OFFLOAD_EN", 16, 16, &umr_bitfield_default },
	 { "RE_OFLD_MIF_WR_REQ_NUM", 17, 24, &umr_bitfield_default },
	 { "CLEAR_NJ_PF_BP", 25, 25, &umr_bitfield_default },
	 { "NJ_MIF_GATING", 26, 26, &umr_bitfield_default },
	 { "CRC1_SEL", 27, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_URGENT_CTRL[] = {
	 { "ENABLE_MC_RD_URGENT_STALL", 0, 0, &umr_bitfield_default },
	 { "ASSERT_MC_RD_STALL", 1, 1, &umr_bitfield_default },
	 { "ASSERT_MC_RD_URGENT", 2, 5, &umr_bitfield_default },
	 { "ENABLE_MC_WR_URGENT_STALL", 8, 8, &umr_bitfield_default },
	 { "ASSERT_MC_WR_STALL", 9, 9, &umr_bitfield_default },
	 { "ASSERT_MC_WR_URGENT", 10, 13, &umr_bitfield_default },
	 { "ENABLE_UMC_RD_URGENT_STALL", 16, 16, &umr_bitfield_default },
	 { "ASSERT_UMC_RD_STALL", 17, 17, &umr_bitfield_default },
	 { "ASSERT_UMC_RD_URGENT", 18, 21, &umr_bitfield_default },
	 { "ENABLE_UMC_WR_URGENT_STALL", 24, 24, &umr_bitfield_default },
	 { "ASSERT_UMC_WR_STALL", 25, 25, &umr_bitfield_default },
	 { "ASSERT_UMC_WR_URGENT", 26, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_CTRL[] = {
	 { "WRITE_CLEAN_TIMER", 0, 7, &umr_bitfield_default },
	 { "WRITE_CLEAN_TIMER_EN", 8, 8, &umr_bitfield_default },
	 { "REQ_MODE", 9, 9, &umr_bitfield_default },
	 { "ASSERT_MC_URGENT", 11, 11, &umr_bitfield_default },
	 { "MASK_MC_URGENT", 12, 12, &umr_bitfield_default },
	 { "DATA_COHERENCY_EN", 13, 13, &umr_bitfield_default },
	 { "CRC_RESET", 14, 14, &umr_bitfield_default },
	 { "CRC_SEL", 15, 19, &umr_bitfield_default },
	 { "VCPU_DATA_COHERENCY_EN", 21, 21, &umr_bitfield_default },
	 { "CM_DATA_COHERENCY_EN", 22, 22, &umr_bitfield_default },
	 { "DB_DB_DATA_COHERENCY_EN", 23, 23, &umr_bitfield_default },
	 { "DB_IT_DATA_COHERENCY_EN", 24, 24, &umr_bitfield_default },
	 { "IT_IT_DATA_COHERENCY_EN", 25, 25, &umr_bitfield_default },
	 { "MIF_MIF_DATA_COHERENCY_EN", 26, 26, &umr_bitfield_default },
	 { "MIF_LESS_OUTSTANDING_RD_REQ", 27, 27, &umr_bitfield_default },
	 { "RFU", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_STATUS[] = {
	 { "READ_CLEAN", 0, 0, &umr_bitfield_default },
	 { "WRITE_CLEAN", 1, 1, &umr_bitfield_default },
	 { "WRITE_CLEAN_RAW", 2, 2, &umr_bitfield_default },
	 { "VCPU_LMI_WRITE_CLEAN", 3, 3, &umr_bitfield_default },
	 { "UMC_READ_CLEAN", 4, 4, &umr_bitfield_default },
	 { "UMC_WRITE_CLEAN", 5, 5, &umr_bitfield_default },
	 { "UMC_WRITE_CLEAN_RAW", 6, 6, &umr_bitfield_default },
	 { "PENDING_UVD_MC_WRITE", 7, 7, &umr_bitfield_default },
	 { "READ_CLEAN_RAW", 8, 8, &umr_bitfield_default },
	 { "UMC_READ_CLEAN_RAW", 9, 9, &umr_bitfield_default },
	 { "UMC_UVD_IDLE", 10, 10, &umr_bitfield_default },
	 { "UMC_AVP_IDLE", 11, 11, &umr_bitfield_default },
	 { "ADP_MC_READ_CLEAN", 12, 12, &umr_bitfield_default },
	 { "ADP_UMC_READ_CLEAN", 13, 13, &umr_bitfield_default },
	 { "BSP0_WRITE_CLEAN", 18, 18, &umr_bitfield_default },
	 { "BSP1_WRITE_CLEAN", 19, 19, &umr_bitfield_default },
	 { "BSP2_WRITE_CLEAN", 20, 20, &umr_bitfield_default },
	 { "BSP3_WRITE_CLEAN", 21, 21, &umr_bitfield_default },
	 { "CENC_READ_CLEAN", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_PERFMON_CTRL[] = {
	 { "PERFMON_STATE", 0, 1, &umr_bitfield_default },
	 { "PERFMON_SEL", 8, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_PERFMON_COUNT_LO[] = {
	 { "PERFMON_COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_PERFMON_COUNT_HI[] = {
	 { "PERFMON_COUNT", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_RB_VMID[] = {
	 { "RB_VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RBC_IB_VMID[] = {
	 { "IB_VMID", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MC_CREDITS[] = {
	 { "UVD_RD_CREDITS", 0, 5, &umr_bitfield_default },
	 { "UVD_WR_CREDITS", 8, 13, &umr_bitfield_default },
	 { "UMC_RD_CREDITS", 16, 21, &umr_bitfield_default },
	 { "UMC_WR_CREDITS", 24, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmMDM_DMA_CMD[] = {
	 { "MDM_DMA_CMD", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMDM_DMA_STATUS[] = {
	 { "SDB_DMA_WR_BUSY", 0, 0, &umr_bitfield_default },
	 { "SCM_DMA_WR_BUSY", 1, 1, &umr_bitfield_default },
	 { "SCM_DMA_RD_BUSY", 2, 2, &umr_bitfield_default },
	 { "RB_DMA_WR_BUSY", 3, 3, &umr_bitfield_default },
	 { "RB_DMA_RD_BUSY", 4, 4, &umr_bitfield_default },
	 { "SDB_DMA_RD_BUSY", 5, 5, &umr_bitfield_default },
	 { "SCLR_DMA_WR_BUSY", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmMDM_DMA_CTL[] = {
	 { "MDM_BYPASS", 0, 0, &umr_bitfield_default },
	 { "FOUR_CMD", 1, 1, &umr_bitfield_default },
	 { "ENCODE_MODE", 2, 2, &umr_bitfield_default },
	 { "VP9_DEC_MODE", 3, 3, &umr_bitfield_default },
	 { "SW_DRST", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMDM_ENC_PIPE_BUSY[] = {
	 { "IME_BUSY", 0, 0, &umr_bitfield_default },
	 { "SMP_BUSY", 1, 1, &umr_bitfield_default },
	 { "SIT_BUSY", 2, 2, &umr_bitfield_default },
	 { "SDB_BUSY", 3, 3, &umr_bitfield_default },
	 { "ENT_BUSY", 4, 4, &umr_bitfield_default },
	 { "ENT_HEADER_BUSY", 5, 5, &umr_bitfield_default },
	 { "LCM_BUSY", 6, 6, &umr_bitfield_default },
	 { "MDM_RD_CUR_BUSY", 7, 7, &umr_bitfield_default },
	 { "MDM_RD_REF_BUSY", 8, 8, &umr_bitfield_default },
	 { "MDM_RD_GEN_BUSY", 9, 9, &umr_bitfield_default },
	 { "MDM_WR_RECON_BUSY", 10, 10, &umr_bitfield_default },
	 { "MDM_WR_GEN_BUSY", 11, 11, &umr_bitfield_default },
	 { "MDM_EFC_BUSY", 12, 12, &umr_bitfield_default },
	 { "MDM_EFC_PROGRAM_BUSY", 13, 13, &umr_bitfield_default },
	 { "MIF_RD_CUR_BUSY", 16, 16, &umr_bitfield_default },
	 { "MIF_RD_REF0_BUSY", 17, 17, &umr_bitfield_default },
	 { "MIF_WR_GEN0_BUSY", 18, 18, &umr_bitfield_default },
	 { "MIF_RD_GEN0_BUSY", 19, 19, &umr_bitfield_default },
	 { "MIF_WR_GEN1_BUSY", 20, 20, &umr_bitfield_default },
	 { "MIF_RD_GEN1_BUSY", 21, 21, &umr_bitfield_default },
	 { "MIF_WR_BSP0_BUSY", 22, 22, &umr_bitfield_default },
	 { "MIF_WR_BSP1_BUSY", 23, 23, &umr_bitfield_default },
	 { "MIF_RD_BSD0_BUSY", 24, 24, &umr_bitfield_default },
	 { "MIF_RD_BSD1_BUSY", 25, 25, &umr_bitfield_default },
	 { "MIF_RD_BSD2_BUSY", 26, 26, &umr_bitfield_default },
	 { "MIF_RD_BSD3_BUSY", 27, 27, &umr_bitfield_default },
	 { "MIF_RD_BSD4_BUSY", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmMDM_WIG_PIPE_BUSY[] = {
	 { "WIG_TBE_BUSY", 0, 0, &umr_bitfield_default },
	 { "WIG_ENT_BUSY", 1, 1, &umr_bitfield_default },
	 { "WIG_ENT_HEADER_BUSY", 2, 2, &umr_bitfield_default },
	 { "WIG_ENT_HEADER_FIFO_FULL", 3, 3, &umr_bitfield_default },
	 { "LCM_BUSY", 4, 4, &umr_bitfield_default },
	 { "MDM_RD_CUR_BUSY", 5, 5, &umr_bitfield_default },
	 { "MDM_RD_REF_BUSY", 6, 6, &umr_bitfield_default },
	 { "MDM_RD_GEN_BUSY", 7, 7, &umr_bitfield_default },
	 { "MDM_WR_RECON_BUSY", 8, 8, &umr_bitfield_default },
	 { "MDM_WR_GEN_BUSY", 9, 9, &umr_bitfield_default },
	 { "MIF_RD_CUR_BUSY", 10, 10, &umr_bitfield_default },
	 { "MIF_RD_REF0_BUSY", 11, 11, &umr_bitfield_default },
	 { "MIF_WR_GEN0_BUSY", 12, 12, &umr_bitfield_default },
	 { "MIF_RD_GEN0_BUSY", 13, 13, &umr_bitfield_default },
	 { "MIF_WR_GEN1_BUSY", 14, 14, &umr_bitfield_default },
	 { "MIF_RD_GEN1_BUSY", 15, 15, &umr_bitfield_default },
	 { "MIF_WR_BSP0_BUSY", 16, 16, &umr_bitfield_default },
	 { "MIF_WR_BSP1_BUSY", 17, 17, &umr_bitfield_default },
	 { "MIF_RD_BSD0_BUSY", 18, 18, &umr_bitfield_default },
	 { "MIF_RD_BSD1_BUSY", 19, 19, &umr_bitfield_default },
	 { "MIF_RD_BSD2_BUSY", 20, 20, &umr_bitfield_default },
	 { "MIF_RD_BSD3_BUSY", 21, 21, &umr_bitfield_default },
	 { "MIF_RD_BSD4_BUSY", 22, 22, &umr_bitfield_default },
	 { "MIF_RD_BSD5_BUSY", 23, 23, &umr_bitfield_default },
	 { "MIF_WR_BSP2_BUSY", 24, 24, &umr_bitfield_default },
	 { "MIF_WR_BSP3_BUSY", 25, 25, &umr_bitfield_default },
	 { "LCM_BSP0_NOT_EMPTY", 26, 26, &umr_bitfield_default },
	 { "LCM_BSP1_NOT_EMPTY", 27, 27, &umr_bitfield_default },
	 { "LCM_BSP2_NOT_EMPTY", 28, 28, &umr_bitfield_default },
	 { "LCM_BSP3_NOT_EMPTY", 29, 29, &umr_bitfield_default },
};
