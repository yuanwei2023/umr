static struct umr_bitfield mmMMSCH_UCODE_ADDR[] = {
	 { "UCODE_ADDR", 2, 13, &umr_bitfield_default },
	 { "UCODE_LOCK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_UCODE_DATA[] = {
	 { "UCODE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SRAM_ADDR[] = {
	 { "SRAM_ADDR", 2, 12, &umr_bitfield_default },
	 { "SRAM_LOCK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SRAM_DATA[] = {
	 { "SRAM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_SRAM_OFFSET[] = {
	 { "VF_SRAM_OFFSET", 2, 12, &umr_bitfield_default },
	 { "VF_SRAM_NUM_DW_PER_VF", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_DB_SRAM_OFFSET[] = {
	 { "DB_SRAM_OFFSET", 2, 12, &umr_bitfield_default },
	 { "DB_SRAM_NUM_ENG", 16, 23, &umr_bitfield_default },
	 { "DB_SRAM_NUM_RING_PER_ENG", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_CTX_SRAM_OFFSET[] = {
	 { "CTX_SRAM_OFFSET", 2, 12, &umr_bitfield_default },
	 { "CTX_SRAM_SIZE", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_CTL[] = {
	 { "P_RUNSTALL", 0, 0, &umr_bitfield_default },
	 { "P_RESET", 1, 1, &umr_bitfield_default },
	 { "VFID_FIFO_EN", 4, 4, &umr_bitfield_default },
	 { "P_LOCK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_INTR[] = {
	 { "INTR", 0, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_INTR_ACK[] = {
	 { "INTR", 0, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_INTR_STATUS[] = {
	 { "INTR", 0, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_VMID[] = {
	 { "VF_CTX_VMID", 0, 4, &umr_bitfield_default },
	 { "VF_GPCOM_VMID", 5, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_CTX_ADDR_LO[] = {
	 { "VF_CTX_ADDR_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_CTX_ADDR_HI[] = {
	 { "VF_CTX_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_CTX_SIZE[] = {
	 { "VF_CTX_SIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_GPCOM_ADDR_LO[] = {
	 { "VF_GPCOM_ADDR_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_GPCOM_ADDR_HI[] = {
	 { "VF_GPCOM_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_GPCOM_SIZE[] = {
	 { "VF_GPCOM_SIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_HOST[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_RESP[] = {
	 { "RESP", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_0[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_0_RESP[] = {
	 { "RESP", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_1[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX_1_RESP[] = {
	 { "RESP", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_CNTL[] = {
	 { "CLK_EN", 0, 0, &umr_bitfield_default },
	 { "ED_ENABLE", 1, 1, &umr_bitfield_default },
	 { "MMSCH_IRQ_ERR", 5, 8, &umr_bitfield_default },
	 { "MMSCH_NACK_INTR_EN", 9, 9, &umr_bitfield_default },
	 { "MMSCH_DB_BUSY_INTR_EN", 10, 10, &umr_bitfield_default },
	 { "PRB_TIMEOUT_VAL", 20, 27, &umr_bitfield_default },
	 { "TIMEOUT_DIS", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_NONCACHE_OFFSET0[] = {
	 { "OFFSET", 0, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_NONCACHE_SIZE0[] = {
	 { "SIZE", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_NONCACHE_OFFSET1[] = {
	 { "OFFSET", 0, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_NONCACHE_SIZE1[] = {
	 { "SIZE", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_PROC_STATE1[] = {
	 { "PC", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_LAST_MC_ADDR[] = {
	 { "MC_ADDR", 0, 27, &umr_bitfield_default },
	 { "RW", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_LAST_MEM_ACCESS_HI[] = {
	 { "PROC_CMD", 0, 2, &umr_bitfield_default },
	 { "FIFO_RPTR", 8, 10, &umr_bitfield_default },
	 { "FIFO_WPTR", 12, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_LAST_MEM_ACCESS_LO[] = {
	 { "PROC_ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_IOV_ACTIVE_FCN_ID[] = {
	 { "ACTIVE_VF_ID", 0, 4, &umr_bitfield_default },
	 { "ACTIVE_PF_VF", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_0[] = {
	 { "SCRATCH_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_1[] = {
	 { "SCRATCH_1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_0[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_CONTROL_0[] = {
	 { "CMD_TYPE", 0, 3, &umr_bitfield_default },
	 { "CMD_EXECUTE", 4, 4, &umr_bitfield_default },
	 { "CMD_EXECUTE_INTR_EN", 5, 5, &umr_bitfield_default },
	 { "VM_BUSY_INTR_EN", 6, 6, &umr_bitfield_default },
	 { "FUNCTINO_ID", 8, 15, &umr_bitfield_default },
	 { "NEXT_FUNCTINO_ID", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_0[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_VM_BUSY_STATUS_0[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCNS_0[] = {
	 { "ACTIVE_FCNS", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW6_0[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW7_0[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW8_0[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_1[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_CONTROL_1[] = {
	 { "CMD_TYPE", 0, 3, &umr_bitfield_default },
	 { "CMD_EXECUTE", 4, 4, &umr_bitfield_default },
	 { "CMD_EXECUTE_INTR_EN", 5, 5, &umr_bitfield_default },
	 { "VM_BUSY_INTR_EN", 6, 6, &umr_bitfield_default },
	 { "FUNCTINO_ID", 8, 15, &umr_bitfield_default },
	 { "NEXT_FUNCTINO_ID", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_1[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_VM_BUSY_STATUS_1[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCNS_1[] = {
	 { "ACTIVE_FCNS", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW6_1[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW7_1[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW8_1[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CNTXT[] = {
	 { "CNTXT_SIZE", 0, 6, &umr_bitfield_default },
	 { "CNTXT_LOCATION", 7, 7, &umr_bitfield_default },
	 { "CNTXT_OFFSET", 10, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_2[] = {
	 { "SCRATCH_2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_3[] = {
	 { "SCRATCH_3", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_4[] = {
	 { "SCRATCH_4", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_5[] = {
	 { "SCRATCH_5", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_6[] = {
	 { "SCRATCH_6", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_SCRATCH_7[] = {
	 { "SCRATCH_7", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_HEAD_0[] = {
	 { "HEAD", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_TAIL_0[] = {
	 { "TAIL", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_HEAD_1[] = {
	 { "HEAD", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_TAIL_1[] = {
	 { "TAIL", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_NACK_STATUS[] = {
	 { "WR_NACK_STATUS", 0, 1, &umr_bitfield_default },
	 { "RD_NACK_STATUS", 2, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX0_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VF_MAILBOX1_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_IP_0[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_IP_0[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_IP_1[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_IP_1[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CNTXT_IP[] = {
	 { "CNTXT_SIZE", 0, 6, &umr_bitfield_default },
	 { "CNTXT_LOCATION", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_2[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_CONTROL_2[] = {
	 { "CMD_TYPE", 0, 3, &umr_bitfield_default },
	 { "CMD_EXECUTE", 4, 4, &umr_bitfield_default },
	 { "CMD_EXECUTE_INTR_EN", 5, 5, &umr_bitfield_default },
	 { "VM_BUSY_INTR_EN", 6, 6, &umr_bitfield_default },
	 { "FUNCTINO_ID", 8, 15, &umr_bitfield_default },
	 { "NEXT_FUNCTINO_ID", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_2[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_VM_BUSY_STATUS_2[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCNS_2[] = {
	 { "ACTIVE_FCNS", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW6_2[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW7_2[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_DW8_2[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_SCH_BLOCK_IP_2[] = {
	 { "ID", 0, 3, &umr_bitfield_default },
	 { "VERSION", 4, 7, &umr_bitfield_default },
	 { "SIZE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_CMD_STATUS_IP_2[] = {
	 { "CMD_STATUS", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2[] = {
	 { "ID", 0, 7, &umr_bitfield_default },
	 { "ID_STATUS", 8, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_HEAD_2[] = {
	 { "HEAD", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VFID_FIFO_TAIL_2[] = {
	 { "TAIL", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VM_BUSY_STATUS_0[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VM_BUSY_STATUS_1[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMMSCH_VM_BUSY_STATUS_2[] = {
	 { "BUSY", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_CNTL[] = {
	 { "REQUEST_EN", 1, 1, &umr_bitfield_default },
	 { "ERR_RST_EN", 2, 2, &umr_bitfield_default },
	 { "HUFF_SPEED_EN", 3, 3, &umr_bitfield_default },
	 { "HUFF_SPEED_STATUS", 4, 4, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JPEG_DEC_CNT[] = {
	 { "DECODE_COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_SPS_INFO[] = {
	 { "PIC_WIDTH", 0, 15, &umr_bitfield_default },
	 { "PIC_HEIGHT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_SPS1_INFO[] = {
	 { "CHROMA_FORMAT_IDC", 0, 2, &umr_bitfield_default },
	 { "YUV422_SUBFORMAT", 3, 3, &umr_bitfield_default },
	 { "OUT_FMT_422", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_RE_TIMER[] = {
	 { "TIMER_OUT", 0, 7, &umr_bitfield_default },
	 { "TIMER_OUT_EN", 16, 16, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JPEG_TIER_CNTL0[] = {
	 { "TIER_SEL", 0, 1, &umr_bitfield_default },
	 { "Y_COMP_ID", 2, 3, &umr_bitfield_default },
	 { "U_COMP_ID", 4, 5, &umr_bitfield_default },
	 { "V_COMP_ID", 6, 7, &umr_bitfield_default },
	 { "Y_H_SAMP_FAC", 8, 10, &umr_bitfield_default },
	 { "Y_V_SAMP_FAC", 11, 13, &umr_bitfield_default },
	 { "U_H_SAMP_FAC", 14, 16, &umr_bitfield_default },
	 { "U_V_SAMP_FAC", 17, 19, &umr_bitfield_default },
	 { "V_H_SAMP_FAC", 20, 22, &umr_bitfield_default },
	 { "V_V_SAMP_FAC", 23, 25, &umr_bitfield_default },
	 { "Y_TQ", 26, 27, &umr_bitfield_default },
	 { "U_TQ", 28, 29, &umr_bitfield_default },
	 { "V_TQ", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_TIER_CNTL1[] = {
	 { "SRC_WIDTH", 0, 15, &umr_bitfield_default },
	 { "SRC_HEIGHT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_TIER_CNTL2[] = {
	 { "TBL_ECS_SEL", 0, 0, &umr_bitfield_default },
	 { "TBL_TYPE", 1, 1, &umr_bitfield_default },
	 { "TQ", 2, 3, &umr_bitfield_default },
	 { "TH", 4, 5, &umr_bitfield_default },
	 { "TC", 6, 6, &umr_bitfield_default },
	 { "TD", 7, 9, &umr_bitfield_default },
	 { "TA", 10, 12, &umr_bitfield_default },
	 { "TIER2_HTBL_CNTLEN", 14, 14, &umr_bitfield_default },
	 { "DRI_VAL", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_TIER_STATUS[] = {
	 { "BSI_FETCH_DONE", 0, 0, &umr_bitfield_default },
	 { "DECODE_DONE", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_OUTBUF_CNTL[] = {
	 { "OUTBUF_CNT", 0, 1, &umr_bitfield_default },
	 { "HGT_ALIGN", 2, 2, &umr_bitfield_default },
	 { "JPEG0_DECODE_DONE_FIX", 6, 6, &umr_bitfield_default },
	 { "JPEG0_WR_COMB_MAX_CNT", 7, 8, &umr_bitfield_default },
	 { "JPEG0_WR_COMB_TIMER", 9, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_OUTBUF_WPTR[] = {
	 { "OUTBUF_WPTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_OUTBUF_RPTR[] = {
	 { "OUTBUF_RPTR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_PITCH[] = {
	 { "PITCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_UV_PITCH[] = {
	 { "UV_PITCH", 0, 31, &umr_bitfield_default },
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
	 { "NUM_PKRS", 8, 10, &umr_bitfield_default },
	 { "NUM_BANKS", 12, 14, &umr_bitfield_default },
	 { "NUM_SHADER_ENGINES", 19, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_DEC_ADDR_MODE[] = {
	 { "ADDR_MODE_Y", 0, 1, &umr_bitfield_default },
	 { "ADDR_MODE_UV", 2, 3, &umr_bitfield_default },
	 { "ADDR_LIB_SEL", 12, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_OUTPUT_XY[] = {
	 { "OUTPUT_X", 0, 13, &umr_bitfield_default },
	 { "OUTPUT_Y", 16, 29, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JPEG_INDEX[] = {
	 { "INDEX", 0, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_SCRATCH1[] = {
	 { "SCRATCH1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_DEC_SOFT_RST[] = {
	 { "SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RESET_STATUS", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_SPS_INFO[] = {
	 { "SRC_FORMAT", 0, 2, &umr_bitfield_default },
	 { "YUY2_SUBFORMAT", 3, 3, &umr_bitfield_default },
	 { "OUT_FMT_422", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_SPS_INFO1[] = {
	 { "SRC_WIDTH", 0, 15, &umr_bitfield_default },
	 { "SRC_HEIGHT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_TBL_SIZE[] = {
	 { "TBL_SIZE", 6, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_TBL_CNTL[] = {
	 { "TBL_PEL_SEL", 0, 0, &umr_bitfield_default },
	 { "TBL_TYPE", 1, 1, &umr_bitfield_default },
	 { "TBL_SUBTYPE", 2, 3, &umr_bitfield_default },
	 { "HTBL_CNTLEN", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_MC_REQ_CNTL[] = {
	 { "RD_REQ_PRIORITY_MARK", 0, 5, &umr_bitfield_default },
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
	 { "NUM_PKRS", 8, 10, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JPEG_TBL_DAT0[] = {
	 { "TBL_DAT_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_TBL_DAT1[] = {
	 { "TBL_DAT_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_TBL_IDX[] = {
	 { "TBL_IDX", 0, 7, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JADP_MCIF_URGENT_CTRL[] = {
	 { "WR_WATERMARK", 0, 5, &umr_bitfield_default },
	 { "RD_WATERMARK", 6, 10, &umr_bitfield_default },
	 { "WR_RD_URGENT_TIMER", 11, 16, &umr_bitfield_default },
	 { "WR_URGENT_PROG_STEP", 17, 20, &umr_bitfield_default },
	 { "RD_URGENT_PROG_STEP", 21, 24, &umr_bitfield_default },
	 { "WR_QOS_EN", 25, 25, &umr_bitfield_default },
	 { "RD_QOS_EN", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_URGENT_CTRL[] = {
	 { "ENABLE_MC_RD_URGENT_STALL", 0, 0, &umr_bitfield_default },
	 { "ASSERT_MC_RD_URGENT", 4, 7, &umr_bitfield_default },
	 { "ENABLE_MC_WR_URGENT_STALL", 16, 16, &umr_bitfield_default },
	 { "ASSERT_MC_WR_URGENT", 20, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_DEC_PF_CTRL[] = {
	 { "DEC_PF_HANDLING_DIS", 0, 0, &umr_bitfield_default },
	 { "DEC_PF_SW_GATING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_ENC_PF_CTRL[] = {
	 { "ENC_PF_HANDLING_DIS", 0, 0, &umr_bitfield_default },
	 { "ENC_PF_SW_GATING", 1, 1, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JMI_SCALER_CTRL[] = {
	 { "ARB_RD_WAIT_EN", 0, 0, &umr_bitfield_default },
	 { "ARB_WR_WAIT_EN", 1, 1, &umr_bitfield_default },
	 { "RD_MAX_BURST", 4, 7, &umr_bitfield_default },
	 { "WR_MAX_BURST", 8, 11, &umr_bitfield_default },
	 { "RD_SWAP", 20, 21, &umr_bitfield_default },
	 { "WR_SWAP", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_LMI_DROP[] = {
	 { "JPEG_WR_DROP", 0, 0, &umr_bitfield_default },
	 { "JRBC_WR_DROP", 1, 1, &umr_bitfield_default },
	 { "JPEG_RD_DROP", 2, 2, &umr_bitfield_default },
	 { "JRBC_RD_DROP", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_EJPEG_DROP[] = {
	 { "EJRBC_RD_DROP", 0, 0, &umr_bitfield_default },
	 { "EJRBC_WR_DROP", 1, 1, &umr_bitfield_default },
	 { "EJPEG_RD_DROP", 2, 2, &umr_bitfield_default },
	 { "EJPEG_WR_DROP", 3, 3, &umr_bitfield_default },
	 { "SCALAR_RD_DROP", 4, 4, &umr_bitfield_default },
	 { "SCALAR_WR_DROP", 5, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MEMCHECK_CLAMPING[] = {
	 { "JPEG_WR_CLAMPING_EN", 13, 13, &umr_bitfield_default },
	 { "JPEG2_WR_CLAMPING_EN", 14, 14, &umr_bitfield_default },
	 { "JPEG_RD_CLAMPING_EN", 22, 22, &umr_bitfield_default },
	 { "JPEG2_RD_CLAMPING_EN", 23, 23, &umr_bitfield_default },
	 { "JRBC_RD_CLAMPING_EN", 25, 25, &umr_bitfield_default },
	 { "JRBC_WR_CLAMPING_EN", 26, 26, &umr_bitfield_default },
	 { "CLAMP_TO_SAFE_ADDR_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_EJPEG_MEMCHECK_CLAMPING[] = {
	 { "JRBC_RD_CLAMPING_EN", 0, 0, &umr_bitfield_default },
	 { "JRBC_WR_CLAMPING_EN", 1, 1, &umr_bitfield_default },
	 { "JPEG_RD_CLAMPING_EN", 2, 2, &umr_bitfield_default },
	 { "JPEG_WR_CLAMPING_EN", 3, 3, &umr_bitfield_default },
	 { "SCALAR_RD_CLAMPING_EN", 4, 4, &umr_bitfield_default },
	 { "SCALAR_WR_CLAMPING_EN", 5, 5, &umr_bitfield_default },
	 { "CLAMP_TO_SAFE_ADDR_EN", 31, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmJPEG_MEMCHECK_SAFE_ADDR[] = {
	 { "MEMCHECK_SAFE_ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MEMCHECK_SAFE_ADDR_64BIT[] = {
	 { "MEMCHECK_SAFE_ADDR_64BIT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_LAT_CTRL[] = {
	 { "SCALE", 0, 7, &umr_bitfield_default },
	 { "MAX_START", 8, 8, &umr_bitfield_default },
	 { "MIN_START", 9, 9, &umr_bitfield_default },
	 { "AVG_START", 10, 10, &umr_bitfield_default },
	 { "PERFMON_SYNC", 11, 11, &umr_bitfield_default },
	 { "SKIP", 16, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_LAT_CNTR[] = {
	 { "MAX_LAT", 0, 7, &umr_bitfield_default },
	 { "MIN_LAT", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_AVG_LAT_CNTR[] = {
	 { "ENV_LOW", 0, 7, &umr_bitfield_default },
	 { "ENV_HIGH", 8, 15, &umr_bitfield_default },
	 { "ENV_HIT", 16, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JMI_CLEAN_STATUS[] = {
	 { "LMI_READ_CLEAN", 0, 0, &umr_bitfield_default },
	 { "LMI_READ_CLEAN_RAW", 1, 1, &umr_bitfield_default },
	 { "LMI_WRITE_CLEAN", 2, 2, &umr_bitfield_default },
	 { "LMI_WRITE_CLEAN_RAW", 3, 3, &umr_bitfield_default },
	 { "DJRBC_READ_CLEAN", 4, 4, &umr_bitfield_default },
	 { "EJRBC_READ_CLEAN", 5, 5, &umr_bitfield_default },
	 { "JPEG_READ_CLEAN", 6, 6, &umr_bitfield_default },
	 { "PEL_READ_CLEAN", 7, 7, &umr_bitfield_default },
	 { "SCALAR_READ_CLEAN", 8, 8, &umr_bitfield_default },
	 { "DJRBC_WRITE_CLEAN", 9, 9, &umr_bitfield_default },
	 { "EJRBC_WRITE_CLEAN", 10, 10, &umr_bitfield_default },
	 { "BS_WRITE_CLEAN", 11, 11, &umr_bitfield_default },
	 { "JPEG_WRITE_CLEAN", 12, 12, &umr_bitfield_default },
	 { "SCALAR_WRITE_CLEAN", 13, 13, &umr_bitfield_default },
	 { "MC_WRITE_PENDING", 14, 14, &umr_bitfield_default },
	 { "JPEG2_WRITE_CLEAN", 15, 15, &umr_bitfield_default },
	 { "JPEG2_READ_CLEAN", 16, 16, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JMI_PEL_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_PEL_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_BS_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_BS_WR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_SCALAR_RD_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_SCALAR_RD_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_SCALAR_WR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_SCALAR_WR_64BIT_BAR_HIGH[] = {
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
static struct umr_bitfield mmUVD_JMI_ATOMIC_CNTL[] = {
	 { "atomic_arb_wait_en", 0, 0, &umr_bitfield_default },
	 { "atomic_max_burst", 1, 4, &umr_bitfield_default },
	 { "atomic_wr_drop", 5, 5, &umr_bitfield_default },
	 { "atomic_wr_clamping_en", 6, 6, &umr_bitfield_default },
	 { "ATOMIC_WR_URG", 7, 10, &umr_bitfield_default },
	 { "ATOMIC_SW_GATE", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ATOMIC_CNTL2[] = {
	 { "atomic_uvd_swap", 16, 23, &umr_bitfield_default },
	 { "ATOMIC_MC_SWAP", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ATOMIC_USER0_WRITE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ATOMIC_USER0_WRITE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ATOMIC_USER1_WRITE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JMI_ATOMIC_USER1_WRITE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG2_LMI_DROP[] = {
	 { "JPEG2_WR_DROP", 0, 0, &umr_bitfield_default },
	 { "JPEG2_RD_DROP", 1, 1, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_JPEG_DEC2_PF_CTRL[] = {
	 { "DEC2_PF_HANDLING_DIS", 0, 0, &umr_bitfield_default },
	 { "DEC2_PF_SW_GATING", 1, 1, &umr_bitfield_default },
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
	 { "DJPEG2_PF_RPT", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SYS_INT_STATUS[] = {
	 { "DJPEG_CORE", 0, 0, &umr_bitfield_default },
	 { "DJRBC", 1, 1, &umr_bitfield_default },
	 { "DJPEG_PF_RPT", 2, 2, &umr_bitfield_default },
	 { "EJPEG_PF_RPT", 3, 3, &umr_bitfield_default },
	 { "EJPEG_CORE", 4, 4, &umr_bitfield_default },
	 { "EJRBC", 5, 5, &umr_bitfield_default },
	 { "DJPEG_CORE2", 6, 6, &umr_bitfield_default },
	 { "DJPEG2_PF_RPT", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_SYS_INT_ACK[] = {
	 { "DJPEG_CORE", 0, 0, &umr_bitfield_default },
	 { "DJRBC", 1, 1, &umr_bitfield_default },
	 { "DJPEG_PF_RPT", 2, 2, &umr_bitfield_default },
	 { "EJPEG_PF_RPT", 3, 3, &umr_bitfield_default },
	 { "EJPEG_CORE", 4, 4, &umr_bitfield_default },
	 { "EJRBC", 5, 5, &umr_bitfield_default },
	 { "DJPEG_CORE2", 6, 6, &umr_bitfield_default },
	 { "DJPEG2_PF_RPT", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MEMCHECK_SYS_INT_EN[] = {
	 { "DJRBC_RD_ERR_EN", 0, 0, &umr_bitfield_default },
	 { "EJRBC_RD_ERR_EN", 1, 1, &umr_bitfield_default },
	 { "BSFETCH_RD_ERR_EN", 2, 2, &umr_bitfield_default },
	 { "PELFETCH_RD_ERR_EN", 3, 3, &umr_bitfield_default },
	 { "SCALAR_RD_ERR_EN", 4, 4, &umr_bitfield_default },
	 { "JPEG2_RD_ERR_EN", 5, 5, &umr_bitfield_default },
	 { "DJRBC_WR_ERR_EN", 6, 6, &umr_bitfield_default },
	 { "EJRBC_WR_ERR_EN", 7, 7, &umr_bitfield_default },
	 { "BS_WR_ERR_EN", 8, 8, &umr_bitfield_default },
	 { "OBUF_WR_ERR_EN", 9, 9, &umr_bitfield_default },
	 { "SCALAR_WR_ERR_EN", 10, 10, &umr_bitfield_default },
	 { "JPEG2_WR_ERR_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MEMCHECK_SYS_INT_STAT[] = {
	 { "DJRBC_RD_HI_ERR", 0, 0, &umr_bitfield_default },
	 { "DJRBC_RD_LO_ERR", 1, 1, &umr_bitfield_default },
	 { "EJRBC_RD_HI_ERR", 2, 2, &umr_bitfield_default },
	 { "EJRBC_RD_LO_ERR", 3, 3, &umr_bitfield_default },
	 { "BSFETCH_RD_HI_ERR", 4, 4, &umr_bitfield_default },
	 { "BSFETCH_RD_LO_ERR", 5, 5, &umr_bitfield_default },
	 { "PELFETCH_RD_HI_ERR", 6, 6, &umr_bitfield_default },
	 { "PELFETCH_RD_LO_ERR", 7, 7, &umr_bitfield_default },
	 { "SCALAR_RD_HI_ERR", 8, 8, &umr_bitfield_default },
	 { "SCALAR_RD_LO_ERR", 9, 9, &umr_bitfield_default },
	 { "JPEG2_RD_HI_ERR", 10, 10, &umr_bitfield_default },
	 { "JPEG2_RD_LO_ERR", 11, 11, &umr_bitfield_default },
	 { "DJRBC_WR_HI_ERR", 12, 12, &umr_bitfield_default },
	 { "DJRBC_WR_LO_ERR", 13, 13, &umr_bitfield_default },
	 { "EJRBC_WR_HI_ERR", 14, 14, &umr_bitfield_default },
	 { "EJRBC_WR_LO_ERR", 15, 15, &umr_bitfield_default },
	 { "BS_WR_HI_ERR", 16, 16, &umr_bitfield_default },
	 { "BS_WR_LO_ERR", 17, 17, &umr_bitfield_default },
	 { "OBUF_WR_HI_ERR", 18, 18, &umr_bitfield_default },
	 { "OBUF_WR_LO_ERR", 19, 19, &umr_bitfield_default },
	 { "SCALAR_WR_HI_ERR", 20, 20, &umr_bitfield_default },
	 { "SCALAR_WR_LO_ERR", 21, 21, &umr_bitfield_default },
	 { "JPEG2_WR_HI_ERR", 22, 22, &umr_bitfield_default },
	 { "JPEG2_WR_LO_ERR", 23, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmJPEG_MEMCHECK_SYS_INT_ACK[] = {
	 { "DJRBC_RD_HI_ERR", 0, 0, &umr_bitfield_default },
	 { "DJRBC_RD_LO_ERR", 1, 1, &umr_bitfield_default },
	 { "EJRBC_RD_HI_ERR", 2, 2, &umr_bitfield_default },
	 { "EJRBC_RD_LO_ERR", 3, 3, &umr_bitfield_default },
	 { "BSFETCH_RD_HI_ERR", 4, 4, &umr_bitfield_default },
	 { "BSFETCH_RD_LO_ERR", 5, 5, &umr_bitfield_default },
	 { "PELFETCH_RD_HI_ERR", 6, 6, &umr_bitfield_default },
	 { "PELFETCH_RD_LO_ERR", 7, 7, &umr_bitfield_default },
	 { "SCALAR_RD_HI_ERR", 8, 8, &umr_bitfield_default },
	 { "SCALAR_RD_LO_ERR", 9, 9, &umr_bitfield_default },
	 { "JPEG2_RD_HI_ERR", 10, 10, &umr_bitfield_default },
	 { "JPEG2_RD_LO_ERR", 11, 11, &umr_bitfield_default },
	 { "DJRBC_WR_HI_ERR", 12, 12, &umr_bitfield_default },
	 { "DJRBC_WR_LO_ERR", 13, 13, &umr_bitfield_default },
	 { "EJRBC_WR_HI_ERR", 14, 14, &umr_bitfield_default },
	 { "EJRBC_WR_LO_ERR", 15, 15, &umr_bitfield_default },
	 { "BS_WR_HI_ERR", 16, 16, &umr_bitfield_default },
	 { "BS_WR_LO_ERR", 17, 17, &umr_bitfield_default },
	 { "OBUF_WR_HI_ERR", 18, 18, &umr_bitfield_default },
	 { "OBUF_WR_LO_ERR", 19, 19, &umr_bitfield_default },
	 { "SCALAR_WR_HI_ERR", 20, 20, &umr_bitfield_default },
	 { "SCALAR_WR_LO_ERR", 21, 21, &umr_bitfield_default },
	 { "JPEG2_WR_HI_ERR", 22, 22, &umr_bitfield_default },
	 { "JPEG2_WR_LO_ERR", 23, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_JPEG_IOV_ACTIVE_FCN_ID[] = {
	 { "VF_ID", 0, 5, &umr_bitfield_default },
	 { "PF_VF", 31, 31, &umr_bitfield_default },
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
	 { "UVDIRL_PWR_CONFIG", 10, 11, &umr_bitfield_default },
	 { "UVDLM_PWR_CONFIG", 12, 13, &umr_bitfield_default },
	 { "UVDTD_PWR_CONFIG", 14, 15, &umr_bitfield_default },
	 { "UVDTE_PWR_CONFIG", 16, 17, &umr_bitfield_default },
	 { "UVDE_PWR_CONFIG", 18, 19, &umr_bitfield_default },
	 { "UVDAB_PWR_CONFIG", 20, 21, &umr_bitfield_default },
	 { "UVDJ_PWR_CONFIG", 22, 23, &umr_bitfield_default },
	 { "UVDATD_PWR_CONFIG", 24, 25, &umr_bitfield_default },
	 { "UVDNA_PWR_CONFIG", 26, 27, &umr_bitfield_default },
	 { "UVDNB_PWR_CONFIG", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PGFSM_STATUS[] = {
	 { "UVDM_PWR_STATUS", 0, 1, &umr_bitfield_default },
	 { "UVDU_PWR_STATUS", 2, 3, &umr_bitfield_default },
	 { "UVDF_PWR_STATUS", 4, 5, &umr_bitfield_default },
	 { "UVDC_PWR_STATUS", 6, 7, &umr_bitfield_default },
	 { "UVDB_PWR_STATUS", 8, 9, &umr_bitfield_default },
	 { "UVDIRL_PWR_STATUS", 10, 11, &umr_bitfield_default },
	 { "UVDLM_PWR_STATUS", 12, 13, &umr_bitfield_default },
	 { "UVDTD_PWR_STATUS", 14, 15, &umr_bitfield_default },
	 { "UVDTE_PWR_STATUS", 16, 17, &umr_bitfield_default },
	 { "UVDE_PWR_STATUS", 18, 19, &umr_bitfield_default },
	 { "UVDAB_PWR_STATUS", 20, 21, &umr_bitfield_default },
	 { "UVDJ_PWR_STATUS", 22, 23, &umr_bitfield_default },
	 { "UVDATD_PWR_STATUS", 24, 25, &umr_bitfield_default },
	 { "UVDNA_PWR_STATUS", 26, 27, &umr_bitfield_default },
	 { "UVDNB_PWR_STATUS", 28, 29, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_MC_DJPEG_RD_SPACE[] = {
	 { "DJPEG_RD_SPACE", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MC_DJPEG_WR_SPACE[] = {
	 { "DJPEG_WR_SPACE", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MC_EJPEG_RD_SPACE[] = {
	 { "EJPEG_RD_SPACE", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MC_EJPEG_WR_SPACE[] = {
	 { "EJPEG_WR_SPACE", 0, 17, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_REG_FILTER_EN[] = {
	 { "UVD_REG_FILTER_EN", 0, 0, &umr_bitfield_default },
	 { "MMSCH_HI_PRIV", 1, 1, &umr_bitfield_default },
	 { "VIDEO_PRIV_EN", 2, 2, &umr_bitfield_default },
	 { "JPEG_PRIV_EN", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_DETECT_BOT_LO[] = {
	 { "UVD_VCPU_ERR_DETECT_BOT_LO", 12, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_DETECT_BOT_HI[] = {
	 { "UVD_VCPU_ERR_DETECT_BOT_HI", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_DETECT_TOP_LO[] = {
	 { "UVD_VCPU_ERR_DETECT_TOP_LO", 12, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_DETECT_TOP_HI[] = {
	 { "UVD_VCPU_ERR_DETECT_TOP_HI", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR[] = {
	 { "UVD_VCPU_ERR_STATUS", 0, 0, &umr_bitfield_default },
	 { "UVD_VCPU_ERR_CLEAR", 1, 1, &umr_bitfield_default },
	 { "UVD_VCPU_ERR_DETECT_EN", 2, 2, &umr_bitfield_default },
	 { "RESET_ON_FAULT", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_INST_ADDR_LO[] = {
	 { "UVD_VCPU_ERR_INST_ADDR_LO", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_UVD_VCPU_ERR_INST_ADDR_HI[] = {
	 { "UVD_VCPU_ERR_INST_ADDR_HI", 0, 15, &umr_bitfield_default },
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
	 { "JPEG2_PF_OCCURED", 19, 19, &umr_bitfield_default },
	 { "DJ2_ATM_PF_OCCURED", 20, 20, &umr_bitfield_default },
	 { "JPEG2_PF_CLEAR", 21, 21, &umr_bitfield_default },
	 { "ENCODER5_PF_OCCURED", 22, 22, &umr_bitfield_default },
	 { "ENCODER5_PF_CLEAR", 23, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_FW_VERSION[] = {
	 { "FW_VERSION", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DPG_CLK_EN_VCPU_REPORT[] = {
	 { "CLK_EN", 0, 0, &umr_bitfield_default },
	 { "VCPU_REPORT", 1, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SECURITY_REG_VIO_REPORT[] = {
	 { "HOST_REG_VIO", 0, 0, &umr_bitfield_default },
	 { "VCPU_REG_VIO", 1, 1, &umr_bitfield_default },
	 { "VIDEO_REG_VIO", 2, 2, &umr_bitfield_default },
	 { "DPG_REG_VIO", 3, 3, &umr_bitfield_default },
	 { "JPEG_REG_VIO", 4, 4, &umr_bitfield_default },
	 { "JDPG_REG_VIO", 5, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MMSCH_NC_SPACE[] = {
	 { "MMSCH_NC0_SPACE", 0, 2, &umr_bitfield_default },
	 { "MMSCH_NC1_SPACE", 3, 5, &umr_bitfield_default },
	 { "MMSCH_NC2_SPACE", 6, 8, &umr_bitfield_default },
	 { "MMSCH_NC3_SPACE", 9, 11, &umr_bitfield_default },
	 { "MMSCH_NC4_SPACE", 12, 14, &umr_bitfield_default },
	 { "MMSCH_NC5_SPACE", 15, 17, &umr_bitfield_default },
	 { "MMSCH_NC6_SPACE", 18, 20, &umr_bitfield_default },
	 { "MMSCH_NC7_SPACE", 21, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ATOMIC_SPACE[] = {
	 { "ATOMIC_USER0_SPACE", 0, 2, &umr_bitfield_default },
	 { "ATOMIC_USER1_SPACE", 3, 5, &umr_bitfield_default },
	 { "ATOMIC_USER2_SPACE", 6, 8, &umr_bitfield_default },
	 { "ATOMIC_USER3_SPACE", 9, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GFX10_ADDR_CONFIG[] = {
	 { "NUM_PIPES", 0, 2, &umr_bitfield_default },
	 { "PIPE_INTERLEAVE_SIZE", 3, 5, &umr_bitfield_default },
	 { "MAX_COMPRESSED_FRAGS", 6, 7, &umr_bitfield_default },
	 { "NUM_PKRS", 8, 10, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_VCLK_DS_CNTL[] = {
	 { "VCLK_DS_EN", 0, 0, &umr_bitfield_default },
	 { "VCLK_DS_STATUS", 4, 4, &umr_bitfield_default },
	 { "VCLK_DS_HYSTERESIS_CNT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DCLK_DS_CNTL[] = {
	 { "DCLK_DS_EN", 0, 0, &umr_bitfield_default },
	 { "DCLK_DS_STATUS", 4, 4, &umr_bitfield_default },
	 { "DCLK_DS_HYSTERESIS_CNT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_TSC_LOWER[] = {
	 { "COUNT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_TSC_UPPER[] = {
	 { "COUNT", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmVCN_FEATURES[] = {
	 { "HAS_VIDEO_DEC", 0, 0, &umr_bitfield_default },
	 { "HAS_VIDEO_ENC", 1, 1, &umr_bitfield_default },
	 { "HAS_MJPEG_DEC", 2, 2, &umr_bitfield_default },
	 { "HAS_MJPEG_ENC", 3, 3, &umr_bitfield_default },
	 { "HAS_VIDEO_VIRT", 4, 4, &umr_bitfield_default },
	 { "HAS_H264_LEGACY_DEC", 5, 5, &umr_bitfield_default },
	 { "HAS_UDEC_DEC", 6, 6, &umr_bitfield_default },
	 { "HAS_MJPEG2_IDCT_DEC", 7, 7, &umr_bitfield_default },
	 { "HAS_SCLR_DEC", 8, 8, &umr_bitfield_default },
	 { "HAS_VP9_DEC", 9, 9, &umr_bitfield_default },
	 { "HAS_AV1_DEC", 10, 10, &umr_bitfield_default },
	 { "HAS_EFC_ENC", 11, 11, &umr_bitfield_default },
	 { "HAS_EFC_HDR2SDR_ENC", 12, 12, &umr_bitfield_default },
	 { "HAS_DUAL_MJPEG_DEC", 13, 13, &umr_bitfield_default },
	 { "INSTANCE_ID", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_GPUIOV_STATUS[] = {
	 { "UVD_GPUIOV_STATUS_VF_ENABLE", 0, 0, &umr_bitfield_default },
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
	 { "MDM_WR_RECON_BUSY", 10, 10, &umr_bitfield_default },
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
	 { "SAOE_BUSY", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_FW_POWER_STATUS[] = {
	 { "UVDF_PWR_OFF", 0, 0, &umr_bitfield_default },
	 { "UVDC_PWR_OFF", 1, 1, &umr_bitfield_default },
	 { "UVDB_PWR_OFF", 2, 2, &umr_bitfield_default },
	 { "UVDIRL_PWR_OFF", 3, 3, &umr_bitfield_default },
	 { "UVDTD_PWR_OFF", 4, 4, &umr_bitfield_default },
	 { "UVDTE_PWR_OFF", 5, 5, &umr_bitfield_default },
	 { "UVDE_PWR_OFF", 6, 6, &umr_bitfield_default },
	 { "UVDAB_PWR_OFF", 7, 7, &umr_bitfield_default },
	 { "UVDATD_PWR_OFF", 8, 8, &umr_bitfield_default },
	 { "UVDNA_PWR_OFF", 9, 9, &umr_bitfield_default },
	 { "UVDNB_PWR_OFF", 10, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CNTL[] = {
	 { "MIF_WR_LOW_THRESHOLD_BP", 17, 17, &umr_bitfield_default },
	 { "SUVD_EN", 19, 19, &umr_bitfield_default },
	 { "CABAC_MB_ACC", 28, 28, &umr_bitfield_default },
	 { "LRBBM_SAFE_SYNC_DIS", 31, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_WIG_CTRL[] = {
	 { "AVM_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "ACAP_SOFT_RESET", 1, 1, &umr_bitfield_default },
	 { "WIG_SOFT_RESET", 2, 2, &umr_bitfield_default },
	 { "WIG_REGCLK_FORCE_ON", 3, 3, &umr_bitfield_default },
	 { "AVM_REGCLK_FORCE_ON", 4, 4, &umr_bitfield_default },
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
	 { "SAOE", 26, 26, &umr_bitfield_default },
	 { "SRE_AV1", 27, 27, &umr_bitfield_default },
	 { "FBC_PCLK", 28, 28, &umr_bitfield_default },
	 { "FBC_CCLK", 29, 29, &umr_bitfield_default },
	 { "SCM_AV1", 30, 30, &umr_bitfield_default },
	 { "SMPA", 31, 31, &umr_bitfield_default },
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
	 { "SAOE_DCLK", 29, 29, &umr_bitfield_default },
	 { "SRE_AV1_VCLK", 30, 30, &umr_bitfield_default },
	 { "SCM_AV1_DCLK", 31, 31, &umr_bitfield_default },
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
	 { "SAOE_MODE", 11, 11, &umr_bitfield_default },
	 { "SMPA_MODE", 12, 12, &umr_bitfield_default },
	 { "MPBE0_MODE", 13, 13, &umr_bitfield_default },
	 { "MPBE1_MODE", 14, 14, &umr_bitfield_default },
	 { "SIT_AV1_MODE", 15, 15, &umr_bitfield_default },
	 { "SDB_AV1_MODE", 16, 16, &umr_bitfield_default },
	 { "MPC1_MODE", 17, 17, &umr_bitfield_default },
	 { "FBC_PCLK", 28, 28, &umr_bitfield_default },
	 { "FBC_CCLK", 29, 29, &umr_bitfield_default },
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
	 { "SUVD_EN", 15, 15, &umr_bitfield_default },
	 { "RPTR_WR_EN", 16, 16, &umr_bitfield_default },
	 { "JOB_START_EN", 17, 17, &umr_bitfield_default },
	 { "NJ_PF_EN", 18, 18, &umr_bitfield_default },
	 { "CNN_3D_BLOCK_DONE_INT_EN", 19, 19, &umr_bitfield_default },
	 { "CNN_MIF_DMA_DONE_INT_EN", 21, 21, &umr_bitfield_default },
	 { "CNN_FEATURE_THRESHOLD_DONE_INT_EN", 22, 22, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_VCPU_INT_STATUS[] = {
	 { "PIF_ADDR_ERR_INT", 0, 0, &umr_bitfield_default },
	 { "SEMA_WAIT_FAULT_TIMEOUT_INT", 1, 1, &umr_bitfield_default },
	 { "SEMA_SIGNAL_INCOMPLETE_TIMEOUT_INT", 2, 2, &umr_bitfield_default },
	 { "NJ_PF_RPT_INT", 3, 3, &umr_bitfield_default },
	 { "SW_RB1_INT", 4, 4, &umr_bitfield_default },
	 { "SW_RB2_INT", 5, 5, &umr_bitfield_default },
	 { "RBC_REG_PRIV_FAULT_INT", 6, 6, &umr_bitfield_default },
	 { "SW_RB3_INT", 7, 7, &umr_bitfield_default },
	 { "SW_RB4_INT", 9, 9, &umr_bitfield_default },
	 { "SW_RB5_INT", 10, 10, &umr_bitfield_default },
	 { "LBSI_INT", 11, 11, &umr_bitfield_default },
	 { "UDEC_INT", 12, 12, &umr_bitfield_default },
	 { "SUVD_INT", 15, 15, &umr_bitfield_default },
	 { "RPTR_WR_INT", 16, 16, &umr_bitfield_default },
	 { "JOB_START_INT", 17, 17, &umr_bitfield_default },
	 { "NJ_PF_INT", 18, 18, &umr_bitfield_default },
	 { "CNN_3D_BLOCK_DONE_INT", 19, 19, &umr_bitfield_default },
	 { "GPCOM_INT", 20, 20, &umr_bitfield_default },
	 { "CNN_MIF_DMA_DONE_INT", 21, 21, &umr_bitfield_default },
	 { "CNN_FEATURE_THRESHOLD_DONE_INT", 22, 22, &umr_bitfield_default },
	 { "SEMA_WAIT_FAIL_SIG_INT", 23, 23, &umr_bitfield_default },
	 { "IDCT_INT", 24, 24, &umr_bitfield_default },
	 { "MPRD_INT", 25, 25, &umr_bitfield_default },
	 { "AVM_INT", 26, 26, &umr_bitfield_default },
	 { "CLK_SWT_INT", 27, 27, &umr_bitfield_default },
	 { "MIF_HWINT", 28, 28, &umr_bitfield_default },
	 { "MPRD_ERR_INT", 29, 29, &umr_bitfield_default },
	 { "DRV_FW_REQ_INT", 30, 30, &umr_bitfield_default },
	 { "DRV_FW_ACK_INT", 31, 31, &umr_bitfield_default },
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
	 { "SUVD_ACK", 15, 15, &umr_bitfield_default },
	 { "RPTR_WR_ACK", 16, 16, &umr_bitfield_default },
	 { "JOB_START_ACK", 17, 17, &umr_bitfield_default },
	 { "NJ_PF_ACK", 18, 18, &umr_bitfield_default },
	 { "CNN_3D_BLOCK_DONE_INT_ACK", 19, 19, &umr_bitfield_default },
	 { "CNN_MIF_DMA_DONE_INT_ACK", 21, 21, &umr_bitfield_default },
	 { "CNN_FEATURE_THRESHOLD_DONE_INT_ACK", 22, 22, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_DRV_FW_MSG[] = {
	 { "MSG", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_FW_DRV_MSG_ACK[] = {
	 { "ACK", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_EN[] = {
	 { "SRE_FUNC_INT_EN", 0, 4, &umr_bitfield_default },
	 { "SRE_ERR_INT_EN", 5, 5, &umr_bitfield_default },
	 { "SIT_FUNC_INT_EN", 6, 10, &umr_bitfield_default },
	 { "SIT_ERR_INT_EN", 11, 11, &umr_bitfield_default },
	 { "SMP_FUNC_INT_EN", 12, 16, &umr_bitfield_default },
	 { "SMP_ERR_INT_EN", 17, 17, &umr_bitfield_default },
	 { "SCM_FUNC_INT_EN", 18, 22, &umr_bitfield_default },
	 { "SCM_ERR_INT_EN", 23, 23, &umr_bitfield_default },
	 { "SDB_FUNC_INT_EN", 24, 28, &umr_bitfield_default },
	 { "SDB_ERR_INT_EN", 29, 29, &umr_bitfield_default },
	 { "FBC_ERR_INT_EN", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_STATUS[] = {
	 { "SRE_FUNC_INT", 0, 4, &umr_bitfield_default },
	 { "SRE_ERR_INT", 5, 5, &umr_bitfield_default },
	 { "SIT_FUNC_INT", 6, 10, &umr_bitfield_default },
	 { "SIT_ERR_INT", 11, 11, &umr_bitfield_default },
	 { "SMP_FUNC_INT", 12, 16, &umr_bitfield_default },
	 { "SMP_ERR_INT", 17, 17, &umr_bitfield_default },
	 { "SCM_FUNC_INT", 18, 22, &umr_bitfield_default },
	 { "SCM_ERR_INT", 23, 23, &umr_bitfield_default },
	 { "SDB_FUNC_INT", 24, 28, &umr_bitfield_default },
	 { "SDB_ERR_INT", 29, 29, &umr_bitfield_default },
	 { "FBC_ERR_INT", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_ACK[] = {
	 { "SRE_FUNC_INT_ACK", 0, 4, &umr_bitfield_default },
	 { "SRE_ERR_INT_ACK", 5, 5, &umr_bitfield_default },
	 { "SIT_FUNC_INT_ACK", 6, 10, &umr_bitfield_default },
	 { "SIT_ERR_INT_ACK", 11, 11, &umr_bitfield_default },
	 { "SMP_FUNC_INT_ACK", 12, 16, &umr_bitfield_default },
	 { "SMP_ERR_INT_ACK", 17, 17, &umr_bitfield_default },
	 { "SCM_FUNC_INT_ACK", 18, 22, &umr_bitfield_default },
	 { "SCM_ERR_INT_ACK", 23, 23, &umr_bitfield_default },
	 { "SDB_FUNC_INT_ACK", 24, 28, &umr_bitfield_default },
	 { "SDB_ERR_INT_ACK", 29, 29, &umr_bitfield_default },
	 { "FBC_ERR_INT_ACK", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENC_VCPU_INT_EN[] = {
	 { "DCE_UVD_SCAN_IN_BUFMGR_EN", 0, 0, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR2_EN", 1, 1, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR3_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ENC_VCPU_INT_STATUS[] = {
	 { "DCE_UVD_SCAN_IN_BUFMGR_INT", 0, 0, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR2_INT", 1, 1, &umr_bitfield_default },
	 { "DCE_UVD_SCAN_IN_BUFMGR3_INT", 2, 2, &umr_bitfield_default },
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
	 { "SUVD_EN", 15, 15, &umr_bitfield_default },
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
	 { "SUVD_INT", 15, 15, &umr_bitfield_default },
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
	 { "SUVD_ACK", 15, 15, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_IOV_ACTIVE_FCN_ID[] = {
	 { "VF_ID", 0, 5, &umr_bitfield_default },
	 { "PF_VF", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_IOV_MAILBOX[] = {
	 { "MAILBOX", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_IOV_MAILBOX_RESP[] = {
	 { "RESP", 0, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_MPEG2_ERROR[] = {
	 { "STATUS", 0, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_MPRD_INITIAL_XY[] = {
	 { "MPRD_SCREEN_X", 0, 11, &umr_bitfield_default },
	 { "MPRD_SCREEN_Y", 16, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPEG2_CTRL[] = {
	 { "EN", 0, 0, &umr_bitfield_default },
	 { "TRICK_MODE", 1, 1, &umr_bitfield_default },
	 { "NUM_MB_PER_JOB", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MB_CTL_BUF_BASE[] = {
	 { "BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_PIC_CTL_BUF_BASE[] = {
	 { "BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_DXVA_BUF_SIZE[] = {
	 { "PIC_SIZE", 0, 15, &umr_bitfield_default },
	 { "MB_SIZE", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SCRATCH_NP[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_CLK_SWT_HANDSHAKE[] = {
	 { "CLK_SWT_TYPE", 0, 1, &umr_bitfield_default },
	 { "CLK_DOMAIN_SWT", 8, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VERSION[] = {
	 { "VARIANT_TYPE", 0, 7, &umr_bitfield_default },
	 { "MINOR_VERSION", 8, 15, &umr_bitfield_default },
	 { "MAJOR_VERSION", 16, 27, &umr_bitfield_default },
	 { "INSTANCE_ID", 28, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_AUDIO_RB_BASE_LO[] = {
	 { "RB_BASE_LO", 6, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_AUDIO_RB_BASE_HI[] = {
	 { "RB_BASE_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_AUDIO_RB_SIZE[] = {
	 { "RB_SIZE", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_AUDIO_RB_RPTR[] = {
	 { "RB_RPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_AUDIO_RB_WPTR[] = {
	 { "RB_WPTR", 4, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_STATUS2[] = {
	 { "SW_RB6_INT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_ACK2[] = {
	 { "SW_RB6_INT_ACK", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_INT_EN2[] = {
	 { "SW_RB6_INT_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_CGC_STATUS2[] = {
	 { "SMPA_VCLK", 0, 0, &umr_bitfield_default },
	 { "SMPA_DCLK", 1, 1, &umr_bitfield_default },
	 { "MPBE1_DCLK", 3, 3, &umr_bitfield_default },
	 { "SIT_AV1_DCLK", 4, 4, &umr_bitfield_default },
	 { "SDB_AV1_DCLK", 5, 5, &umr_bitfield_default },
	 { "MPC1_DCLK", 6, 6, &umr_bitfield_default },
	 { "MPC1_SCLK", 7, 7, &umr_bitfield_default },
	 { "MPC1_VCLK", 8, 8, &umr_bitfield_default },
	 { "FBC_PCLK", 28, 28, &umr_bitfield_default },
	 { "FBC_CCLK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_CGC_GATE2[] = {
	 { "MPBE0", 0, 0, &umr_bitfield_default },
	 { "MPBE1", 1, 1, &umr_bitfield_default },
	 { "SIT_AV1", 2, 2, &umr_bitfield_default },
	 { "SDB_AV1", 3, 3, &umr_bitfield_default },
	 { "MPC1", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_STATUS2[] = {
	 { "SMPA_FUNC_INT", 0, 4, &umr_bitfield_default },
	 { "SMPA_ERR_INT", 5, 5, &umr_bitfield_default },
	 { "SDB_AV1_FUNC_INT", 6, 10, &umr_bitfield_default },
	 { "SDB_AV1_ERR_INT", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_EN2[] = {
	 { "SMPA_FUNC_INT_EN", 0, 4, &umr_bitfield_default },
	 { "SMPA_ERR_INT_EN", 5, 5, &umr_bitfield_default },
	 { "SDB_AV1_FUNC_INT_EN", 6, 10, &umr_bitfield_default },
	 { "SDB_AV1_ERR_INT_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_SUVD_INT_ACK2[] = {
	 { "SMPA_FUNC_INT_ACK", 0, 4, &umr_bitfield_default },
	 { "SMPA_ERR_INT_ACK", 5, 5, &umr_bitfield_default },
	 { "SDB_AV1_FUNC_INT_ACK", 6, 10, &umr_bitfield_default },
	 { "SDB_AV1_ERR_INT_ACK", 11, 11, &umr_bitfield_default },
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
	 { "RUNSTALL", 29, 29, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_VCPU_IND_INDEX[] = {
	 { "INDEX", 0, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_VCPU_IND_DATA[] = {
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
static struct umr_bitfield mmUVD_MP_SWAP_CNTL2[] = {
	 { "MP_REF16_MC_SWAP", 0, 1, &umr_bitfield_default },
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
	 { "BLK_RST", 0, 0, &umr_bitfield_default },
	 { "REG_MPC1_PERF_SELECT", 1, 1, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_MPC_IND_INDEX[] = {
	 { "INDEX", 0, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MPC_IND_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
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
	 { "BLK_RST", 29, 29, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_FW_SEMAPHORE_CNTL[] = {
	 { "START", 0, 0, &umr_bitfield_default },
	 { "BUSY", 8, 8, &umr_bitfield_default },
	 { "PASS", 9, 9, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_RBC_SWAP_CNTL[] = {
	 { "RB_MC_SWAP", 0, 1, &umr_bitfield_default },
	 { "IB_MC_SWAP", 2, 3, &umr_bitfield_default },
	 { "RB_RPTR_MC_SWAP", 4, 5, &umr_bitfield_default },
	 { "RB_WR_MC_SWAP", 26, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_RE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_IT_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_IT_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MP_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MP_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_CM_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_CM_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_DB_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_DB_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_DBW_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_DBW_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_IDCT_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_IDCT_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_S0_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_S0_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_S1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_S1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_DBW_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPRD_DBW_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPC_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MPC_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_LMI_LBSI_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_LBSI_64BIT_BAR_HIGH[] = {
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
static struct umr_bitfield mmUVD_LMI_CENC_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_CENC_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_SRE_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_SRE_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_REF_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_REF_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_DBW_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_DBW_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP0_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP2_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP3_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD0_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD1_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD2_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD3_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD4_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH[] = {
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
static struct umr_bitfield mmUVD_LMI_MIF_SCLR_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_SPH_64BIT_BAR_HIGH[] = {
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
	 { "PRIV_CLIENT_MMSCH", 2, 2, &umr_bitfield_default },
	 { "MMSCH_R_MC_SWAP", 3, 4, &umr_bitfield_default },
	 { "MMSCH_W_MC_SWAP", 5, 6, &umr_bitfield_default },
	 { "MMSCH_RD", 7, 8, &umr_bitfield_default },
	 { "MMSCH_WR", 9, 10, &umr_bitfield_default },
	 { "MMSCH_RD_DROP", 11, 11, &umr_bitfield_default },
	 { "MMSCH_WR_DROP", 12, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_MMSCH_LMI_STATUS[] = {
	 { "MMSCH_LMI_WRITE_CLEAN", 2, 2, &umr_bitfield_default },
	 { "MMSCH_RD_CLEAN", 13, 13, &umr_bitfield_default },
	 { "MMSCH_WR_CLEAN", 14, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_ADP_ATOMIC_CONFIG[] = {
	 { "ATOMIC_USER0_WR_CACHE", 0, 3, &umr_bitfield_default },
	 { "ATOMIC_USER1_WR_CACHE", 4, 7, &umr_bitfield_default },
	 { "ATOMIC_USER2_WR_CACHE", 8, 11, &umr_bitfield_default },
	 { "ATOMIC_USER3_WR_CACHE", 12, 15, &umr_bitfield_default },
	 { "ATOMIC_RD_URG", 16, 19, &umr_bitfield_default },
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
	 { "DISABLE_ON_FWV_FAIL", 20, 20, &umr_bitfield_default },
	 { "VCPU_DATA_COHERENCY_EN", 21, 21, &umr_bitfield_default },
	 { "CM_DATA_COHERENCY_EN", 22, 22, &umr_bitfield_default },
	 { "DB_DB_DATA_COHERENCY_EN", 23, 23, &umr_bitfield_default },
	 { "DB_IT_DATA_COHERENCY_EN", 24, 24, &umr_bitfield_default },
	 { "IT_IT_DATA_COHERENCY_EN", 25, 25, &umr_bitfield_default },
	 { "MIF_MIF_DATA_COHERENCY_EN", 26, 26, &umr_bitfield_default },
	 { "MIF_LESS_OUTSTANDING_RD_REQ", 27, 27, &umr_bitfield_default },
	 { "MC_BLK_RST", 28, 28, &umr_bitfield_default },
	 { "UMC_BLK_RST", 29, 29, &umr_bitfield_default },
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
	 { "DPB_MPC2_NO_HIT", 28, 28, &umr_bitfield_default },
	 { "DPB_MPC2_MULTI_HIT", 29, 29, &umr_bitfield_default },
	 { "DPB_MPC_NO_HIT", 30, 30, &umr_bitfield_default },
	 { "DPB_MPC_MULTI_HIT", 31, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_LMI_ADP_SWAP_CNTL[] = {
	 { "VCPU_R_MC_SWAP", 6, 7, &umr_bitfield_default },
	 { "VCPU_W_MC_SWAP", 8, 9, &umr_bitfield_default },
	 { "CM_MC_SWAP", 10, 11, &umr_bitfield_default },
	 { "IT_MC_SWAP", 12, 13, &umr_bitfield_default },
	 { "DB_R_MC_SWAP", 14, 15, &umr_bitfield_default },
	 { "DB_W_MC_SWAP", 16, 17, &umr_bitfield_default },
	 { "CSM_MC_SWAP", 18, 19, &umr_bitfield_default },
	 { "PREF_MC_SWAP", 20, 21, &umr_bitfield_default },
	 { "DBW_MC_SWAP", 24, 25, &umr_bitfield_default },
	 { "RE_MC_SWAP", 28, 29, &umr_bitfield_default },
	 { "MP_MC_SWAP", 30, 31, &umr_bitfield_default },
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
static struct umr_bitfield mmUVD_LMI_ADP_IND_INDEX[] = {
	 { "INDEX", 0, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ADP_IND_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ADP_PF_EN[] = {
	 { "VCPU_CACHE0_PF_EN", 0, 0, &umr_bitfield_default },
	 { "VCPU_CACHE1_PF_EN", 1, 1, &umr_bitfield_default },
	 { "VCPU_CACHE2_PF_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_ADP_CNN_CTRL[] = {
	 { "CNN_MODE_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_PREF_CTRL[] = {
	 { "PREF_RST", 0, 0, &umr_bitfield_default },
	 { "PREF_BUSY_STATUS", 1, 1, &umr_bitfield_default },
	 { "PREF_WSTRB", 2, 2, &umr_bitfield_default },
	 { "PREF_WRITE_SIZE", 3, 3, &umr_bitfield_default },
	 { "PREF_STEP_SIZE", 4, 6, &umr_bitfield_default },
	 { "PREF_SIZE", 19, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_LOW[] = {
	 { "BITS_31_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_HIGH[] = {
	 { "BITS_63_32", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_CGC_MEM_CTRL[] = {
	 { "LMI_MC_LS_EN", 0, 0, &umr_bitfield_default },
	 { "MPC_LS_EN", 1, 1, &umr_bitfield_default },
	 { "MPRD_LS_EN", 2, 2, &umr_bitfield_default },
	 { "WCB_LS_EN", 3, 3, &umr_bitfield_default },
	 { "UDEC_RE_LS_EN", 4, 4, &umr_bitfield_default },
	 { "UDEC_CM_LS_EN", 5, 5, &umr_bitfield_default },
	 { "UDEC_IT_LS_EN", 6, 6, &umr_bitfield_default },
	 { "UDEC_DB_LS_EN", 7, 7, &umr_bitfield_default },
	 { "UDEC_MP_LS_EN", 8, 8, &umr_bitfield_default },
	 { "SYS_LS_EN", 9, 9, &umr_bitfield_default },
	 { "VCPU_LS_EN", 10, 10, &umr_bitfield_default },
	 { "MIF_LS_EN", 12, 12, &umr_bitfield_default },
	 { "LCM_LS_EN", 13, 13, &umr_bitfield_default },
	 { "MMSCH_LS_EN", 14, 14, &umr_bitfield_default },
	 { "MPC1_LS_EN", 15, 15, &umr_bitfield_default },
	 { "LS_SET_DELAY", 16, 19, &umr_bitfield_default },
	 { "LS_CLEAR_DELAY", 20, 23, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_CGC_CTRL2[] = {
	 { "DYN_OCLK_RAMP_EN", 0, 0, &umr_bitfield_default },
	 { "DYN_RCLK_RAMP_EN", 1, 1, &umr_bitfield_default },
	 { "GATER_DIV_ID", 2, 4, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_CGC_MEM_DS_CTRL[] = {
	 { "LMI_MC_DS_EN", 0, 0, &umr_bitfield_default },
	 { "MPC_DS_EN", 1, 1, &umr_bitfield_default },
	 { "MPRD_DS_EN", 2, 2, &umr_bitfield_default },
	 { "WCB_DS_EN", 3, 3, &umr_bitfield_default },
	 { "UDEC_RE_DS_EN", 4, 4, &umr_bitfield_default },
	 { "UDEC_CM_DS_EN", 5, 5, &umr_bitfield_default },
	 { "UDEC_IT_DS_EN", 6, 6, &umr_bitfield_default },
	 { "UDEC_DB_DS_EN", 7, 7, &umr_bitfield_default },
	 { "UDEC_MP_DS_EN", 8, 8, &umr_bitfield_default },
	 { "SYS_DS_EN", 9, 9, &umr_bitfield_default },
	 { "VCPU_DS_EN", 10, 10, &umr_bitfield_default },
	 { "MIF_DS_EN", 12, 12, &umr_bitfield_default },
	 { "LCM_DS_EN", 13, 13, &umr_bitfield_default },
	 { "MMSCH_DS_EN", 14, 14, &umr_bitfield_default },
	 { "MPC1_DS_EN", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_CGC_MEM_SD_CTRL[] = {
	 { "LMI_MC_SD_EN", 0, 0, &umr_bitfield_default },
	 { "MPC_SD_EN", 1, 1, &umr_bitfield_default },
	 { "MPRD_SD_EN", 2, 2, &umr_bitfield_default },
	 { "WCB_SD_EN", 3, 3, &umr_bitfield_default },
	 { "UDEC_RE_SD_EN", 4, 4, &umr_bitfield_default },
	 { "UDEC_CM_SD_EN", 5, 5, &umr_bitfield_default },
	 { "UDEC_IT_SD_EN", 6, 6, &umr_bitfield_default },
	 { "UDEC_DB_SD_EN", 7, 7, &umr_bitfield_default },
	 { "UDEC_MP_SD_EN", 8, 8, &umr_bitfield_default },
	 { "SYS_SD_EN", 9, 9, &umr_bitfield_default },
	 { "VCPU_SD_EN", 10, 10, &umr_bitfield_default },
	 { "MIF_SD_EN", 12, 12, &umr_bitfield_default },
	 { "LCM_SD_EN", 13, 13, &umr_bitfield_default },
	 { "MMSCH_SD_EN", 14, 14, &umr_bitfield_default },
	 { "MPC1_SD_EN", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_00[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_01[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_02[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_03[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_04[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_05[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_06[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_07[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_08[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_09[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_10[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_11[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_12[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_13[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_14[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_SW_SCRATCH_15[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_SYS_INT_EN[] = {
	 { "RE_ERR_EN", 0, 0, &umr_bitfield_default },
	 { "IT_ERR_EN", 1, 1, &umr_bitfield_default },
	 { "MP_ERR_EN", 2, 2, &umr_bitfield_default },
	 { "DB_ERR_EN", 3, 3, &umr_bitfield_default },
	 { "DBW_ERR_EN", 4, 4, &umr_bitfield_default },
	 { "CM_ERR_EN", 5, 5, &umr_bitfield_default },
	 { "MIF_REF_ERR_EN", 6, 6, &umr_bitfield_default },
	 { "VCPU_ERR_EN", 7, 7, &umr_bitfield_default },
	 { "MIF_DBW_ERR_EN", 8, 8, &umr_bitfield_default },
	 { "MIF_CM_COLOC_ERR_EN", 9, 9, &umr_bitfield_default },
	 { "MIF_BSP0_ERR_EN", 10, 10, &umr_bitfield_default },
	 { "MIF_BSP1_ERR_EN", 11, 11, &umr_bitfield_default },
	 { "SRE_ERR_EN", 12, 12, &umr_bitfield_default },
	 { "IT_RD_ERR_EN", 15, 15, &umr_bitfield_default },
	 { "CM_RD_ERR_EN", 16, 16, &umr_bitfield_default },
	 { "DB_RD_ERR_EN", 17, 17, &umr_bitfield_default },
	 { "MIF_RD_ERR_EN", 18, 18, &umr_bitfield_default },
	 { "IDCT_RD_ERR_EN", 19, 19, &umr_bitfield_default },
	 { "MPC_RD_ERR_EN", 20, 20, &umr_bitfield_default },
	 { "LBSI_RD_ERR_EN", 21, 21, &umr_bitfield_default },
	 { "RBC_RD_ERR_EN", 24, 24, &umr_bitfield_default },
	 { "MIF_BSP2_ERR_EN", 27, 27, &umr_bitfield_default },
	 { "MIF_BSP3_ERR_EN", 28, 28, &umr_bitfield_default },
	 { "MIF_SCLR_ERR_EN", 29, 29, &umr_bitfield_default },
	 { "MIF_SCLR2_ERR_EN", 30, 30, &umr_bitfield_default },
	 { "PREF_ERR_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_SYS_INT_STAT[] = {
	 { "RE_LO_ERR", 0, 0, &umr_bitfield_default },
	 { "RE_HI_ERR", 1, 1, &umr_bitfield_default },
	 { "IT_LO_ERR", 2, 2, &umr_bitfield_default },
	 { "IT_HI_ERR", 3, 3, &umr_bitfield_default },
	 { "MP_LO_ERR", 4, 4, &umr_bitfield_default },
	 { "MP_HI_ERR", 5, 5, &umr_bitfield_default },
	 { "DB_LO_ERR", 6, 6, &umr_bitfield_default },
	 { "DB_HI_ERR", 7, 7, &umr_bitfield_default },
	 { "DBW_LO_ERR", 8, 8, &umr_bitfield_default },
	 { "DBW_HI_ERR", 9, 9, &umr_bitfield_default },
	 { "CM_LO_ERR", 10, 10, &umr_bitfield_default },
	 { "CM_HI_ERR", 11, 11, &umr_bitfield_default },
	 { "MIF_REF_LO_ERR", 12, 12, &umr_bitfield_default },
	 { "MIF_REF_HI_ERR", 13, 13, &umr_bitfield_default },
	 { "VCPU_LO_ERR", 14, 14, &umr_bitfield_default },
	 { "VCPU_HI_ERR", 15, 15, &umr_bitfield_default },
	 { "MIF_DBW_LO_ERR", 16, 16, &umr_bitfield_default },
	 { "MIF_DBW_HI_ERR", 17, 17, &umr_bitfield_default },
	 { "MIF_CM_COLOC_LO_ERR", 18, 18, &umr_bitfield_default },
	 { "MIF_CM_COLOC_HI_ERR", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP0_LO_ERR", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP0_HI_ERR", 21, 21, &umr_bitfield_default },
	 { "MIF_BSP1_LO_ERR", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP1_HI_ERR", 23, 23, &umr_bitfield_default },
	 { "SRE_LO_ERR", 24, 24, &umr_bitfield_default },
	 { "SRE_HI_ERR", 25, 25, &umr_bitfield_default },
	 { "IT_RD_LO_ERR", 30, 30, &umr_bitfield_default },
	 { "IT_RD_HI_ERR", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_SYS_INT_ACK[] = {
	 { "RE_LO_ACK", 0, 0, &umr_bitfield_default },
	 { "RE_HI_ACK", 1, 1, &umr_bitfield_default },
	 { "IT_LO_ACK", 2, 2, &umr_bitfield_default },
	 { "IT_HI_ACK", 3, 3, &umr_bitfield_default },
	 { "MP_LO_ACK", 4, 4, &umr_bitfield_default },
	 { "MP_HI_ACK", 5, 5, &umr_bitfield_default },
	 { "DB_LO_ACK", 6, 6, &umr_bitfield_default },
	 { "DB_HI_ACK", 7, 7, &umr_bitfield_default },
	 { "DBW_LO_ACK", 8, 8, &umr_bitfield_default },
	 { "DBW_HI_ACK", 9, 9, &umr_bitfield_default },
	 { "CM_LO_ACK", 10, 10, &umr_bitfield_default },
	 { "CM_HI_ACK", 11, 11, &umr_bitfield_default },
	 { "MIF_REF_LO_ACK", 12, 12, &umr_bitfield_default },
	 { "MIF_REF_HI_ACK", 13, 13, &umr_bitfield_default },
	 { "VCPU_LO_ACK", 14, 14, &umr_bitfield_default },
	 { "VCPU_HI_ACK", 15, 15, &umr_bitfield_default },
	 { "MIF_DBW_LO_ACK", 16, 16, &umr_bitfield_default },
	 { "MIF_DBW_HI_ACK", 17, 17, &umr_bitfield_default },
	 { "MIF_CM_COLOC_LO_ACK", 18, 18, &umr_bitfield_default },
	 { "MIF_CM_COLOC_HI_ACK", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP0_LO_ACK", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP0_HI_ACK", 21, 21, &umr_bitfield_default },
	 { "MIF_BSP1_LO_ACK", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP1_HI_ACK", 23, 23, &umr_bitfield_default },
	 { "SRE_LO_ACK", 24, 24, &umr_bitfield_default },
	 { "SRE_HI_ACK", 25, 25, &umr_bitfield_default },
	 { "IT_RD_LO_ACK", 30, 30, &umr_bitfield_default },
	 { "IT_RD_HI_ACK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_VCPU_INT_EN[] = {
	 { "RE_ERR_EN", 0, 0, &umr_bitfield_default },
	 { "IT_ERR_EN", 1, 1, &umr_bitfield_default },
	 { "MP_ERR_EN", 2, 2, &umr_bitfield_default },
	 { "DB_ERR_EN", 3, 3, &umr_bitfield_default },
	 { "DBW_ERR_EN", 4, 4, &umr_bitfield_default },
	 { "CM_ERR_EN", 5, 5, &umr_bitfield_default },
	 { "MIF_REF_ERR_EN", 6, 6, &umr_bitfield_default },
	 { "VCPU_ERR_EN", 7, 7, &umr_bitfield_default },
	 { "MIF_DBW_ERR_EN", 8, 8, &umr_bitfield_default },
	 { "MIF_CM_COLOC_ERR_EN", 9, 9, &umr_bitfield_default },
	 { "MIF_BSP0_ERR_EN", 10, 10, &umr_bitfield_default },
	 { "MIF_BSP1_ERR_EN", 11, 11, &umr_bitfield_default },
	 { "SRE_ERR_EN", 12, 12, &umr_bitfield_default },
	 { "IT_RD_ERR_EN", 15, 15, &umr_bitfield_default },
	 { "CM_RD_ERR_EN", 16, 16, &umr_bitfield_default },
	 { "DB_RD_ERR_EN", 17, 17, &umr_bitfield_default },
	 { "MIF_RD_ERR_EN", 18, 18, &umr_bitfield_default },
	 { "IDCT_RD_ERR_EN", 19, 19, &umr_bitfield_default },
	 { "MPC_RD_ERR_EN", 20, 20, &umr_bitfield_default },
	 { "LBSI_RD_ERR_EN", 21, 21, &umr_bitfield_default },
	 { "RBC_RD_ERR_EN", 24, 24, &umr_bitfield_default },
	 { "MIF_BSP2_ERR_EN", 25, 25, &umr_bitfield_default },
	 { "MIF_BSP3_ERR_EN", 26, 26, &umr_bitfield_default },
	 { "MIF_SCLR_ERR_EN", 27, 27, &umr_bitfield_default },
	 { "MIF_SCLR2_ERR_EN", 28, 28, &umr_bitfield_default },
	 { "PREF_ERR_EN", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_VCPU_INT_STAT[] = {
	 { "RE_LO_ERR", 0, 0, &umr_bitfield_default },
	 { "RE_HI_ERR", 1, 1, &umr_bitfield_default },
	 { "IT_LO_ERR", 2, 2, &umr_bitfield_default },
	 { "IT_HI_ERR", 3, 3, &umr_bitfield_default },
	 { "MP_LO_ERR", 4, 4, &umr_bitfield_default },
	 { "MP_HI_ERR", 5, 5, &umr_bitfield_default },
	 { "DB_LO_ERR", 6, 6, &umr_bitfield_default },
	 { "DB_HI_ERR", 7, 7, &umr_bitfield_default },
	 { "DBW_LO_ERR", 8, 8, &umr_bitfield_default },
	 { "DBW_HI_ERR", 9, 9, &umr_bitfield_default },
	 { "CM_LO_ERR", 10, 10, &umr_bitfield_default },
	 { "CM_HI_ERR", 11, 11, &umr_bitfield_default },
	 { "MIF_REF_LO_ERR", 12, 12, &umr_bitfield_default },
	 { "MIF_REF_HI_ERR", 13, 13, &umr_bitfield_default },
	 { "VCPU_LO_ERR", 14, 14, &umr_bitfield_default },
	 { "VCPU_HI_ERR", 15, 15, &umr_bitfield_default },
	 { "MIF_DBW_LO_ERR", 16, 16, &umr_bitfield_default },
	 { "MIF_DBW_HI_ERR", 17, 17, &umr_bitfield_default },
	 { "MIF_CM_COLOC_LO_ERR", 18, 18, &umr_bitfield_default },
	 { "MIF_CM_COLOC_HI_ERR", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP0_LO_ERR", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP0_HI_ERR", 21, 21, &umr_bitfield_default },
	 { "MIF_BSP1_LO_ERR", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP1_HI_ERR", 23, 23, &umr_bitfield_default },
	 { "SRE_LO_ERR", 24, 24, &umr_bitfield_default },
	 { "SRE_HI_ERR", 25, 25, &umr_bitfield_default },
	 { "IT_RD_LO_ERR", 30, 30, &umr_bitfield_default },
	 { "IT_RD_HI_ERR", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK_VCPU_INT_ACK[] = {
	 { "RE_LO_ACK", 0, 0, &umr_bitfield_default },
	 { "RE_HI_ACK", 1, 1, &umr_bitfield_default },
	 { "IT_LO_ACK", 2, 2, &umr_bitfield_default },
	 { "IT_HI_ACK", 3, 3, &umr_bitfield_default },
	 { "MP_LO_ACK", 4, 4, &umr_bitfield_default },
	 { "MP_HI_ACK", 5, 5, &umr_bitfield_default },
	 { "DB_LO_ACK", 6, 6, &umr_bitfield_default },
	 { "DB_HI_ACK", 7, 7, &umr_bitfield_default },
	 { "DBW_LO_ACK", 8, 8, &umr_bitfield_default },
	 { "DBW_HI_ACK", 9, 9, &umr_bitfield_default },
	 { "CM_LO_ACK", 10, 10, &umr_bitfield_default },
	 { "CM_HI_ACK", 11, 11, &umr_bitfield_default },
	 { "MIF_REF_LO_ACK", 12, 12, &umr_bitfield_default },
	 { "MIF_REF_HI_ACK", 13, 13, &umr_bitfield_default },
	 { "VCPU_LO_ACK", 14, 14, &umr_bitfield_default },
	 { "VCPU_HI_ACK", 15, 15, &umr_bitfield_default },
	 { "MIF_DBW_LO_ACK", 16, 16, &umr_bitfield_default },
	 { "MIF_DBW_HI_ACK", 17, 17, &umr_bitfield_default },
	 { "MIF_CM_COLOC_LO_ACK", 18, 18, &umr_bitfield_default },
	 { "MIF_CM_COLOC_HI_ACK", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP0_LO_ACK", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP0_HI_ACK", 21, 21, &umr_bitfield_default },
	 { "MIF_BSP1_LO_ACK", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP1_HI_ACK", 23, 23, &umr_bitfield_default },
	 { "SRE_LO_ACK", 24, 24, &umr_bitfield_default },
	 { "SRE_HI_ACK", 25, 25, &umr_bitfield_default },
	 { "IT_RD_LO_ACK", 30, 30, &umr_bitfield_default },
	 { "IT_RD_HI_ACK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK2_SYS_INT_STAT[] = {
	 { "CM_RD_LO_ERR", 0, 0, &umr_bitfield_default },
	 { "CM_RD_HI_ERR", 1, 1, &umr_bitfield_default },
	 { "DB_RD_LO_ERR", 2, 2, &umr_bitfield_default },
	 { "DB_RD_HI_ERR", 3, 3, &umr_bitfield_default },
	 { "MIF_RD_LO_ERR", 4, 4, &umr_bitfield_default },
	 { "MIF_RD_HI_ERR", 5, 5, &umr_bitfield_default },
	 { "IDCT_RD_LO_ERR", 6, 6, &umr_bitfield_default },
	 { "IDCT_RD_HI_ERR", 7, 7, &umr_bitfield_default },
	 { "MPC_RD_LO_ERR", 8, 8, &umr_bitfield_default },
	 { "MPC_RD_HI_ERR", 9, 9, &umr_bitfield_default },
	 { "LBSI_RD_LO_ERR", 10, 10, &umr_bitfield_default },
	 { "LBSI_RD_HI_ERR", 11, 11, &umr_bitfield_default },
	 { "RBC_RD_LO_ERR", 16, 16, &umr_bitfield_default },
	 { "RBC_RD_HI_ERR", 17, 17, &umr_bitfield_default },
	 { "MIF_BSP2_LO_ERR", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP2_HI_ERR", 23, 23, &umr_bitfield_default },
	 { "MIF_BSP3_LO_ERR", 24, 24, &umr_bitfield_default },
	 { "MIF_BSP3_HI_ERR", 25, 25, &umr_bitfield_default },
	 { "MIF_SCLR_LO_ERR", 26, 26, &umr_bitfield_default },
	 { "MIF_SCLR_HI_ERR", 27, 27, &umr_bitfield_default },
	 { "MIF_SCLR2_LO_ERR", 28, 28, &umr_bitfield_default },
	 { "MIF_SCLR2_HI_ERR", 29, 29, &umr_bitfield_default },
	 { "PREF_LO_ERR", 30, 30, &umr_bitfield_default },
	 { "PREF_HI_ERR", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK2_SYS_INT_ACK[] = {
	 { "CM_RD_LO_ACK", 0, 0, &umr_bitfield_default },
	 { "CM_RD_HI_ACK", 1, 1, &umr_bitfield_default },
	 { "DB_RD_LO_ACK", 2, 2, &umr_bitfield_default },
	 { "DB_RD_HI_ACK", 3, 3, &umr_bitfield_default },
	 { "MIF_RD_LO_ACK", 4, 4, &umr_bitfield_default },
	 { "MIF_RD_HI_ACK", 5, 5, &umr_bitfield_default },
	 { "IDCT_RD_LO_ACK", 6, 6, &umr_bitfield_default },
	 { "IDCT_RD_HI_ACK", 7, 7, &umr_bitfield_default },
	 { "MPC_RD_LO_ACK", 8, 8, &umr_bitfield_default },
	 { "MPC_RD_HI_ACK", 9, 9, &umr_bitfield_default },
	 { "LBSI_RD_LO_ACK", 10, 10, &umr_bitfield_default },
	 { "LBSI_RD_HI_ACK", 11, 11, &umr_bitfield_default },
	 { "RBC_RD_LO_ACK", 16, 16, &umr_bitfield_default },
	 { "RBC_RD_HI_ACK", 17, 17, &umr_bitfield_default },
	 { "MIF_BSP2_LO_ACK", 22, 22, &umr_bitfield_default },
	 { "MIF_BSP2_HI_ACK", 23, 23, &umr_bitfield_default },
	 { "MIF_BSP3_LO_ACK", 24, 24, &umr_bitfield_default },
	 { "MIF_BSP3_HI_ACK", 25, 25, &umr_bitfield_default },
	 { "MIF_SCLR_LO_ACK", 26, 26, &umr_bitfield_default },
	 { "MIF_SCLR_HI_ACK", 27, 27, &umr_bitfield_default },
	 { "MIF_SCLR2_LO_ACK", 28, 28, &umr_bitfield_default },
	 { "MIF_SCLR2_HI_ACK", 29, 29, &umr_bitfield_default },
	 { "PREF_LO_ACK", 30, 30, &umr_bitfield_default },
	 { "PREF_HI_ACK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK2_VCPU_INT_STAT[] = {
	 { "CM_RD_LO_ERR", 0, 0, &umr_bitfield_default },
	 { "CM_RD_HI_ERR", 1, 1, &umr_bitfield_default },
	 { "DB_RD_LO_ERR", 2, 2, &umr_bitfield_default },
	 { "DB_RD_HI_ERR", 3, 3, &umr_bitfield_default },
	 { "MIF_RD_LO_ERR", 4, 4, &umr_bitfield_default },
	 { "MIF_RD_HI_ERR", 5, 5, &umr_bitfield_default },
	 { "IDCT_RD_LO_ERR", 6, 6, &umr_bitfield_default },
	 { "IDCT_RD_HI_ERR", 7, 7, &umr_bitfield_default },
	 { "MPC_RD_LO_ERR", 8, 8, &umr_bitfield_default },
	 { "MPC_RD_HI_ERR", 9, 9, &umr_bitfield_default },
	 { "LBSI_RD_LO_ERR", 10, 10, &umr_bitfield_default },
	 { "LBSI_RD_HI_ERR", 11, 11, &umr_bitfield_default },
	 { "RBC_RD_LO_ERR", 16, 16, &umr_bitfield_default },
	 { "RBC_RD_HI_ERR", 17, 17, &umr_bitfield_default },
	 { "MIF_BSP2_LO_ERR", 18, 18, &umr_bitfield_default },
	 { "MIF_BSP2_HI_ERR", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP3_LO_ERR", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP3_HI_ERR", 21, 21, &umr_bitfield_default },
	 { "MIF_SCLR_LO_ERR", 22, 22, &umr_bitfield_default },
	 { "MIF_SCLR_HI_ERR", 23, 23, &umr_bitfield_default },
	 { "MIF_SCLR2_LO_ERR", 24, 24, &umr_bitfield_default },
	 { "MIF_SCLR2_HI_ERR", 25, 25, &umr_bitfield_default },
	 { "PREF_LO_ERR", 26, 26, &umr_bitfield_default },
	 { "PREF_HI_ERR", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_MEMCHECK2_VCPU_INT_ACK[] = {
	 { "CM_RD_LO_ACK", 0, 0, &umr_bitfield_default },
	 { "CM_RD_HI_ACK", 1, 1, &umr_bitfield_default },
	 { "DB_RD_LO_ACK", 2, 2, &umr_bitfield_default },
	 { "DB_RD_HI_ACK", 3, 3, &umr_bitfield_default },
	 { "MIF_RD_LO_ACK", 4, 4, &umr_bitfield_default },
	 { "MIF_RD_HI_ACK", 5, 5, &umr_bitfield_default },
	 { "IDCT_RD_LO_ACK", 6, 6, &umr_bitfield_default },
	 { "IDCT_RD_HI_ACK", 7, 7, &umr_bitfield_default },
	 { "MPC_RD_LO_ACK", 8, 8, &umr_bitfield_default },
	 { "MPC_RD_HI_ACK", 9, 9, &umr_bitfield_default },
	 { "LBSI_RD_LO_ACK", 10, 10, &umr_bitfield_default },
	 { "LBSI_RD_HI_ACK", 11, 11, &umr_bitfield_default },
	 { "RBC_RD_LO_ACK", 16, 16, &umr_bitfield_default },
	 { "RBC_RD_HI_ACK", 17, 17, &umr_bitfield_default },
	 { "MIF_BSP2_LO_ACK", 18, 18, &umr_bitfield_default },
	 { "MIF_BSP2_HI_ACK", 19, 19, &umr_bitfield_default },
	 { "MIF_BSP3_LO_ACK", 20, 20, &umr_bitfield_default },
	 { "MIF_BSP3_HI_ACK", 21, 21, &umr_bitfield_default },
	 { "MIF_SCLR_LO_ACK", 22, 22, &umr_bitfield_default },
	 { "MIF_SCLR_HI_ACK", 23, 23, &umr_bitfield_default },
	 { "MIF_SCLR2_LO_ACK", 24, 24, &umr_bitfield_default },
	 { "MIF_SCLR2_HI_ACK", 25, 25, &umr_bitfield_default },
	 { "PREF_LO_ACK", 26, 26, &umr_bitfield_default },
	 { "PREF_HI_ACK", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield ixUVD_IH_SEM_CTRL[] = {
	 { "IH_STALL_EN", 0, 0, &umr_bitfield_default },
	 { "SEM_STALL_EN", 1, 1, &umr_bitfield_default },
	 { "IH_STATUS_CLEAN", 2, 2, &umr_bitfield_default },
	 { "SEM_STATUS_CLEAN", 3, 3, &umr_bitfield_default },
	 { "IH_VMID", 4, 7, &umr_bitfield_default },
	 { "IH_USER_DATA", 8, 19, &umr_bitfield_default },
	 { "IH_RINGID", 20, 27, &umr_bitfield_default },
};
