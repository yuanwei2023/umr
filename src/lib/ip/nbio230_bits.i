static struct umr_bitfield mmBIF_BX_PF_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSYSHUB_INDEX_OVLP[] = {
	 { "SYSHUB_OFFSET", 0, 21, &umr_bitfield_default },
};
static struct umr_bitfield mmSYSHUB_DATA_OVLP[] = {
	 { "SYSHUB_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_INDEX[] = {
	 { "PCIE_INDEX", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_DATA[] = {
	 { "PCIE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_INDEX2[] = {
	 { "PCIE_INDEX2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_DATA2[] = {
	 { "PCIE_DATA2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSBIOS_SCRATCH_0[] = {
	 { "SBIOS_SCRATCH_DW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSBIOS_SCRATCH_1[] = {
	 { "SBIOS_SCRATCH_DW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSBIOS_SCRATCH_2[] = {
	 { "SBIOS_SCRATCH_DW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSBIOS_SCRATCH_3[] = {
	 { "SBIOS_SCRATCH_DW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_0[] = {
	 { "BIOS_SCRATCH_0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_1[] = {
	 { "BIOS_SCRATCH_1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_2[] = {
	 { "BIOS_SCRATCH_2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_3[] = {
	 { "BIOS_SCRATCH_3", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_4[] = {
	 { "BIOS_SCRATCH_4", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_5[] = {
	 { "BIOS_SCRATCH_5", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_6[] = {
	 { "BIOS_SCRATCH_6", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_7[] = {
	 { "BIOS_SCRATCH_7", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_8[] = {
	 { "BIOS_SCRATCH_8", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_9[] = {
	 { "BIOS_SCRATCH_9", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_10[] = {
	 { "BIOS_SCRATCH_10", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_11[] = {
	 { "BIOS_SCRATCH_11", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_12[] = {
	 { "BIOS_SCRATCH_12", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_13[] = {
	 { "BIOS_SCRATCH_13", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_14[] = {
	 { "BIOS_SCRATCH_14", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIOS_SCRATCH_15[] = {
	 { "BIOS_SCRATCH_15", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RLC_INTR_CNTL[] = {
	 { "RLC_CMD_COMPLETE", 0, 0, &umr_bitfield_default },
	 { "RLC_HANG_SELF_RECOVERED", 1, 1, &umr_bitfield_default },
	 { "RLC_HANG_NEED_FLR", 2, 2, &umr_bitfield_default },
	 { "RLC_VM_BUSY_TRANSITION", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_VCE_INTR_CNTL[] = {
	 { "VCE_CMD_COMPLETE", 0, 0, &umr_bitfield_default },
	 { "VCE_HANG_SELF_RECOVERED", 1, 1, &umr_bitfield_default },
	 { "VCE_HANG_NEED_FLR", 2, 2, &umr_bitfield_default },
	 { "VCE_VM_BUSY_TRANSITION", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_UVD_INTR_CNTL[] = {
	 { "UVD_CMD_COMPLETE", 0, 0, &umr_bitfield_default },
	 { "UVD_HANG_SELF_RECOVERED", 1, 1, &umr_bitfield_default },
	 { "UVD_HANG_NEED_FLR", 2, 2, &umr_bitfield_default },
	 { "UVD_VM_BUSY_TRANSITION", 3, 3, &umr_bitfield_default },
	 { "UVD_INST_SEL", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR0[] = {
	 { "CAM_ADDR0", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR0[] = {
	 { "CAM_REMAP_ADDR0", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR1[] = {
	 { "CAM_ADDR1", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR1[] = {
	 { "CAM_REMAP_ADDR1", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR2[] = {
	 { "CAM_ADDR2", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR2[] = {
	 { "CAM_REMAP_ADDR2", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR3[] = {
	 { "CAM_ADDR3", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR3[] = {
	 { "CAM_REMAP_ADDR3", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR4[] = {
	 { "CAM_ADDR4", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR4[] = {
	 { "CAM_REMAP_ADDR4", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR5[] = {
	 { "CAM_ADDR5", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR5[] = {
	 { "CAM_REMAP_ADDR5", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR6[] = {
	 { "CAM_ADDR6", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR6[] = {
	 { "CAM_REMAP_ADDR6", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ADDR7[] = {
	 { "CAM_ADDR7", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_REMAP_ADDR7[] = {
	 { "CAM_REMAP_ADDR7", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_CNTL[] = {
	 { "CAM_ENABLE", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ZERO_CPL[] = {
	 { "CAM_ZERO_CPL", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_ONE_CPL[] = {
	 { "CAM_ONE_CPL", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_MMIOREG_CAM_PROGRAMMABLE_CPL[] = {
	 { "CAM_PROGRAMMABLE_CPL", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSYSHUB_INDEX[] = {
	 { "INDEX", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSYSHUB_DATA[] = {
	 { "DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP0[] = {
	 { "STRAP_GEN4_DIS_PIN", 0, 0, &umr_bitfield_default },
	 { "STRAP_CLK_PM_EN_PIN", 1, 1, &umr_bitfield_default },
	 { "STRAP_VGA_DIS_PIN", 2, 2, &umr_bitfield_default },
	 { "STRAP_MEM_AP_SIZE_PIN", 3, 5, &umr_bitfield_default },
	 { "STRAP_BIOS_ROM_EN_PIN", 6, 6, &umr_bitfield_default },
	 { "STRAP_PX_CAPABLE", 7, 7, &umr_bitfield_default },
	 { "STRAP_BIF_KILL_GEN3", 8, 8, &umr_bitfield_default },
	 { "STRAP_MSI_FIRST_BE_FULL_PAYLOAD_EN", 9, 9, &umr_bitfield_default },
	 { "STRAP_NBIF_IGNORE_ERR_INFLR", 10, 10, &umr_bitfield_default },
	 { "STRAP_PME_SUPPORT_COMPLIANCE_EN", 11, 11, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_EP_ERR", 12, 12, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_MSG_ERR", 13, 13, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_MAX_PAYLOAD_ERR", 14, 14, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_SHORTPREFIX_ERR_DN", 15, 15, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_TC_ERR", 16, 16, &umr_bitfield_default },
	 { "STRAP_RX_IGNORE_TC_ERR_DN", 17, 17, &umr_bitfield_default },
	 { "STRAP_AUD_PIN", 18, 19, &umr_bitfield_default },
	 { "STRAP_GEN3_DIS", 24, 24, &umr_bitfield_default },
	 { "STRAP_BIF_KILL_GEN4", 25, 25, &umr_bitfield_default },
	 { "STRAP_QUICKSIM_START", 26, 26, &umr_bitfield_default },
	 { "STRAP_NO_RO_ENABLED_P2P_PASSING", 27, 27, &umr_bitfield_default },
	 { "STRAP_CFG0_RD_VF_BUSNUM_CHK_EN", 29, 29, &umr_bitfield_default },
	 { "STRAP_BIGAPU_MODE", 30, 30, &umr_bitfield_default },
	 { "STRAP_LINK_DOWN_RESET_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP1[] = {
	 { "FUSESTRAP_VALID", 0, 0, &umr_bitfield_default },
	 { "ROMSTRAP_VALID", 1, 1, &umr_bitfield_default },
	 { "WRITE_DISABLE", 2, 2, &umr_bitfield_default },
	 { "STRAP_ECRC_INTERMEDIATE_CHK_EN", 3, 3, &umr_bitfield_default },
	 { "STRAP_TRUE_PM_STATUS_EN", 4, 4, &umr_bitfield_default },
	 { "STRAP_IGNORE_E2E_PREFIX_UR_SWUS", 5, 5, &umr_bitfield_default },
	 { "STRAP_MARGINING_USES_SOFTWARE", 6, 6, &umr_bitfield_default },
	 { "STRAP_MARGINING_READY", 7, 7, &umr_bitfield_default },
	 { "STRAP_SWUS_APER_EN", 8, 8, &umr_bitfield_default },
	 { "STRAP_SWUS_64BAR_EN", 9, 9, &umr_bitfield_default },
	 { "STRAP_SWUS_AP_SIZE", 10, 11, &umr_bitfield_default },
	 { "STRAP_SWUS_APER_PREFETCHABLE", 12, 12, &umr_bitfield_default },
	 { "STRAP_HWREV_LSB2", 13, 14, &umr_bitfield_default },
	 { "STRAP_SWREV_LSB2", 15, 16, &umr_bitfield_default },
	 { "STRAP_LINK_RST_CFG_ONLY", 17, 17, &umr_bitfield_default },
	 { "STRAP_BIF_IOV_LKRST_DIS", 18, 18, &umr_bitfield_default },
	 { "STRAP_DLF_EN", 19, 19, &umr_bitfield_default },
	 { "STRAP_PHY_16GT_EN", 20, 20, &umr_bitfield_default },
	 { "STRAP_MARGIN_EN", 21, 21, &umr_bitfield_default },
	 { "STRAP_BIF_PSN_UR_RPT_EN", 22, 22, &umr_bitfield_default },
	 { "STRAP_BIF_SLOT_POWER_SUPPORT_EN", 23, 23, &umr_bitfield_default },
	 { "STRAP_S5_REGS_ACCESS_DIS", 24, 24, &umr_bitfield_default },
	 { "STRAP_S5_MMREG_WR_POSTED_EN", 25, 25, &umr_bitfield_default },
	 { "STRAP_GFX_FUNC_LTR_MODE", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP2[] = {
	 { "STRAP_PCIESWUS_INDEX_APER_RANGE", 0, 0, &umr_bitfield_default },
	 { "STRAP_SUC_IND_ACCESS_DIS", 3, 3, &umr_bitfield_default },
	 { "STRAP_SUM_IND_ACCESS_DIS", 4, 4, &umr_bitfield_default },
	 { "STRAP_ENDP_LINKDOWN_DROP_DMA", 5, 5, &umr_bitfield_default },
	 { "STRAP_SWITCH_LINKDOWN_DROP_DMA", 6, 6, &umr_bitfield_default },
	 { "STRAP_GMI_DNS_SDP_CLKREQ_TOGGLE_DIS", 8, 8, &umr_bitfield_default },
	 { "STRAP_ACS_MSKSEV_EP_HIDE_DIS", 9, 9, &umr_bitfield_default },
	 { "STRAP_CFG_PG_FW_INTERLOCK_EXIT_EN", 10, 11, &umr_bitfield_default },
	 { "RESERVED_BIF_STRAP2", 12, 13, &umr_bitfield_default },
	 { "STRAP_LTR_IN_ASPML1_DIS", 14, 14, &umr_bitfield_default },
	 { "STRAP_GFXAZ_POWERSTATE_INTERLOCK_EN", 15, 15, &umr_bitfield_default },
	 { "STRAP_PWRBRK_DEGLITCH_CYCLE", 16, 23, &umr_bitfield_default },
	 { "STRAP_PWRBRK_DEGLITCH_BYPASS", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP3[] = {
	 { "STRAP_VLINK_ASPM_IDLE_TIMER", 0, 15, &umr_bitfield_default },
	 { "STRAP_VLINK_PM_L1_ENTRY_TIMER", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP4[] = {
	 { "STRAP_VLINK_L0S_EXIT_TIMER", 0, 15, &umr_bitfield_default },
	 { "STRAP_VLINK_L1_EXIT_TIMER", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP5[] = {
	 { "STRAP_VLINK_LDN_ENTRY_TIMER", 0, 15, &umr_bitfield_default },
	 { "STRAP_VLINK_LDN_ON_SWUS_LDN_EN", 16, 16, &umr_bitfield_default },
	 { "STRAP_VLINK_LDN_ON_SWUS_SECRST_EN", 17, 17, &umr_bitfield_default },
	 { "STRAP_VLINK_ENTER_COMPLIANCE_DIS", 18, 18, &umr_bitfield_default },
	 { "STRAP_IGNORE_PSN_ON_VDM1_DIS", 19, 19, &umr_bitfield_default },
	 { "STRAP_SMN_ERR_STATUS_MASK_EN_UPS", 20, 20, &umr_bitfield_default },
	 { "STRAP_SMN_ERRRSP_DATA_FORCE", 22, 23, &umr_bitfield_default },
	 { "STRAP_INTERMEDIATERSP_DATA_ALLF_DATA_FORCE", 24, 24, &umr_bitfield_default },
	 { "STRAP_EMER_POWER_REDUCTION_SUPPORTED", 25, 26, &umr_bitfield_default },
	 { "STRAP_EMER_POWER_REDUCTION_INIT_REQ", 27, 27, &umr_bitfield_default },
	 { "STRAP_PWRBRK_STATUS_TIMER", 28, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BIF_STRAP6[] = {
	 { "RESERVED_BIF_STRAP3", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP0[] = {
	 { "STRAP_ARI_EN_DN_DEV0", 1, 1, &umr_bitfield_default },
	 { "STRAP_ACS_EN_DN_DEV0", 2, 2, &umr_bitfield_default },
	 { "STRAP_AER_EN_DN_DEV0", 3, 3, &umr_bitfield_default },
	 { "STRAP_CPL_ABORT_ERR_EN_DN_DEV0", 4, 4, &umr_bitfield_default },
	 { "STRAP_DEVICE_ID_DN_DEV0", 5, 20, &umr_bitfield_default },
	 { "STRAP_INTERRUPT_PIN_DN_DEV0", 21, 23, &umr_bitfield_default },
	 { "STRAP_IGNORE_E2E_PREFIX_UR_DN_DEV0", 24, 24, &umr_bitfield_default },
	 { "STRAP_MAX_PAYLOAD_SUPPORT_DN_DEV0", 25, 27, &umr_bitfield_default },
	 { "STRAP_MAX_LINK_WIDTH_SUPPORT_DEV0", 28, 30, &umr_bitfield_default },
	 { "STRAP_EPF0_DUMMY_EN_DEV0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP1[] = {
	 { "STRAP_SUBSYS_ID_DN_DEV0", 0, 15, &umr_bitfield_default },
	 { "STRAP_SUBSYS_VEN_ID_DN_DEV0", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP2[] = {
	 { "STRAP_DE_EMPHASIS_SEL_DN_DEV0", 0, 0, &umr_bitfield_default },
	 { "STRAP_DSN_EN_DN_DEV0", 1, 1, &umr_bitfield_default },
	 { "STRAP_E2E_PREFIX_EN_DEV0", 2, 2, &umr_bitfield_default },
	 { "STRAP_ECN1P1_EN_DEV0", 3, 3, &umr_bitfield_default },
	 { "STRAP_ECRC_CHECK_EN_DEV0", 4, 4, &umr_bitfield_default },
	 { "STRAP_ECRC_GEN_EN_DEV0", 5, 5, &umr_bitfield_default },
	 { "STRAP_ERR_REPORTING_DIS_DEV0", 6, 6, &umr_bitfield_default },
	 { "STRAP_EXTENDED_FMT_SUPPORTED_DEV0", 7, 7, &umr_bitfield_default },
	 { "STRAP_EXTENDED_TAG_ECN_EN_DEV0", 8, 8, &umr_bitfield_default },
	 { "STRAP_EXT_VC_COUNT_DN_DEV0", 9, 11, &umr_bitfield_default },
	 { "STRAP_FIRST_RCVD_ERR_LOG_DN_DEV0", 12, 12, &umr_bitfield_default },
	 { "STRAP_POISONED_ADVISORY_NONFATAL_DN_DEV0", 13, 13, &umr_bitfield_default },
	 { "STRAP_GEN2_COMPLIANCE_DEV0", 14, 14, &umr_bitfield_default },
	 { "STRAP_GEN2_EN_DEV0", 15, 15, &umr_bitfield_default },
	 { "STRAP_GEN3_COMPLIANCE_DEV0", 16, 16, &umr_bitfield_default },
	 { "STRAP_GEN4_COMPLIANCE_DEV0", 17, 17, &umr_bitfield_default },
	 { "STRAP_TARGET_LINK_SPEED_DEV0", 18, 19, &umr_bitfield_default },
	 { "STRAP_L0S_ACCEPTABLE_LATENCY_DEV0", 20, 22, &umr_bitfield_default },
	 { "STRAP_L0S_EXIT_LATENCY_DEV0", 23, 25, &umr_bitfield_default },
	 { "STRAP_L1_ACCEPTABLE_LATENCY_DEV0", 26, 28, &umr_bitfield_default },
	 { "STRAP_L1_EXIT_LATENCY_DEV0", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP3[] = {
	 { "STRAP_LINK_BW_NOTIFICATION_CAP_DN_EN_DEV0", 0, 0, &umr_bitfield_default },
	 { "STRAP_LTR_EN_DEV0", 1, 1, &umr_bitfield_default },
	 { "STRAP_LTR_EN_DN_DEV0", 2, 2, &umr_bitfield_default },
	 { "STRAP_MAX_PAYLOAD_SUPPORT_DEV0", 3, 5, &umr_bitfield_default },
	 { "STRAP_MSI_EN_DN_DEV0", 6, 6, &umr_bitfield_default },
	 { "STRAP_MSTCPL_TIMEOUT_EN_DEV0", 7, 7, &umr_bitfield_default },
	 { "STRAP_NO_SOFT_RESET_DN_DEV0", 8, 8, &umr_bitfield_default },
	 { "STRAP_OBFF_SUPPORTED_DEV0", 9, 10, &umr_bitfield_default },
	 { "STRAP_PCIE_LANE_EQUALIZATION_CNTL_DOWNSTREAM_PORT_RX_PRESET_HINT_DEV0", 11, 13, &umr_bitfield_default },
	 { "STRAP_PCIE_LANE_EQUALIZATION_CNTL_DOWNSTREAM_PORT_TX_PRESET_DEV0", 14, 17, &umr_bitfield_default },
	 { "STRAP_PCIE_LANE_EQUALIZATION_CNTL_UPSTREAM_PORT_RX_PRESET_HINT_DEV0", 18, 20, &umr_bitfield_default },
	 { "STRAP_PCIE_LANE_EQUALIZATION_CNTL_UPSTREAM_PORT_TX_PRESET_DEV0", 21, 24, &umr_bitfield_default },
	 { "STRAP_PM_SUPPORT_DEV0", 25, 26, &umr_bitfield_default },
	 { "STRAP_PM_SUPPORT_DN_DEV0", 27, 28, &umr_bitfield_default },
	 { "STRAP_ATOMIC_EN_DN_DEV0", 29, 29, &umr_bitfield_default },
	 { "STRAP_VENDOR_ID_BIT_DN_DEV0", 30, 30, &umr_bitfield_default },
	 { "STRAP_PMC_DSI_DN_DEV0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP4[] = {
	 { "STRAP_PWR_BUDGET_DATA_8T0_0_DEV0", 0, 7, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_1_DEV0", 8, 15, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_2_DEV0", 16, 23, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_3_DEV0", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP5[] = {
	 { "STRAP_PWR_BUDGET_DATA_8T0_4_DEV0", 0, 7, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_5_DEV0", 8, 15, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_SYSTEM_ALLOCATED_DEV0", 16, 16, &umr_bitfield_default },
	 { "STRAP_ATOMIC_64BIT_EN_DN_DEV0", 17, 17, &umr_bitfield_default },
	 { "STRAP_ATOMIC_ROUTING_EN_DEV0", 18, 18, &umr_bitfield_default },
	 { "STRAP_VC_EN_DN_DEV0", 19, 19, &umr_bitfield_default },
	 { "STRAP_TwoVC_EN_DEV0", 20, 20, &umr_bitfield_default },
	 { "STRAP_TwoVC_EN_DN_DEV0", 21, 21, &umr_bitfield_default },
	 { "STRAP_LOCAL_DLF_SUPPORTED_DEV0", 22, 22, &umr_bitfield_default },
	 { "STRAP_ACS_SOURCE_VALIDATION_DN_DEV0", 23, 23, &umr_bitfield_default },
	 { "STRAP_ACS_TRANSLATION_BLOCKING_DN_DEV0", 24, 24, &umr_bitfield_default },
	 { "STRAP_ACS_P2P_REQUEST_REDIRECT_DN_DEV0", 25, 25, &umr_bitfield_default },
	 { "STRAP_ACS_P2P_COMPLETION_REDIRECT_DN_DEV0", 26, 26, &umr_bitfield_default },
	 { "STRAP_ACS_UPSTREAM_FORWARDING_DN_DEV0", 27, 27, &umr_bitfield_default },
	 { "STRAP_ACS_P2P_EGRESS_CONTROL_DN_DEV0", 28, 28, &umr_bitfield_default },
	 { "STRAP_ACS_DIRECT_TRANSLATED_P2P_DN_DEV0", 29, 29, &umr_bitfield_default },
	 { "STRAP_MSI_MAP_EN_DEV0", 30, 30, &umr_bitfield_default },
	 { "STRAP_SSID_EN_DEV0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP6[] = {
	 { "STRAP_CFG_CRS_EN_DEV0", 0, 0, &umr_bitfield_default },
	 { "STRAP_SMN_ERR_STATUS_MASK_EN_DNS_DEV0", 1, 1, &umr_bitfield_default },
	 { "STRAP_INTERNAL_ERR_EN_DEV0", 2, 2, &umr_bitfield_default },
	 { "STRAP_RTM1_PRESENCE_DET_SUPPORT_DEV0", 3, 3, &umr_bitfield_default },
	 { "STRAP_RTM2_PRESENCE_DET_SUPPORT_DEV0", 4, 4, &umr_bitfield_default },
	 { "STRAP_10BIT_TAG_COMPLETER_SUPPORTED_DEV0", 5, 5, &umr_bitfield_default },
	 { "STRAP_10BIT_TAG_REQUESTER_SUPPORTED_DEV0", 6, 6, &umr_bitfield_default },
	 { "STRAP_VF_10BIT_TAG_REQUESTER_SUPPORTED_DEV0", 7, 7, &umr_bitfield_default },
	 { "STRAP_PCIE_16GT_LANE_EQUALIZATION_CNTL_DSP_TX_PRESET_DEV0", 8, 11, &umr_bitfield_default },
	 { "STRAP_PCIE_16GT_LANE_EQUALIZATION_CNTL_USP_TX_PRESET_DEV0", 12, 15, &umr_bitfield_default },
	 { "STRAP_TPH_CPLR_SUPPORTED_DN_DEV0", 16, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP7[] = {
	 { "STRAP_PORT_NUMBER_DEV0", 0, 7, &umr_bitfield_default },
	 { "STRAP_MAJOR_REV_ID_DN_DEV0", 8, 11, &umr_bitfield_default },
	 { "STRAP_MINOR_REV_ID_DN_DEV0", 12, 15, &umr_bitfield_default },
	 { "STRAP_RP_BUSNUM_DEV0", 16, 23, &umr_bitfield_default },
	 { "STRAP_DN_DEVNUM_DEV0", 24, 28, &umr_bitfield_default },
	 { "STRAP_DN_FUNCID_DEV0", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP8[] = {
	 { "STRAP_PWR_BUDGET_DATA_8T0_6_DEV0", 0, 7, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_7_DEV0", 8, 15, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_8_DEV0", 16, 23, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_9_DEV0", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_PORT_STRAP9[] = {
	 { "STRAP_PWR_BUDGET_DATA_8T0_a_DEV0", 0, 7, &umr_bitfield_default },
	 { "STRAP_PWR_BUDGET_DATA_8T0_b_DEV0", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP0[] = {
	 { "STRAP_DEVICE_ID_DEV0_F0", 0, 15, &umr_bitfield_default },
	 { "STRAP_MAJOR_REV_ID_DEV0_F0", 16, 19, &umr_bitfield_default },
	 { "STRAP_MINOR_REV_ID_DEV0_F0", 20, 23, &umr_bitfield_default },
	 { "STRAP_ATI_REV_ID_DEV0_F0", 24, 27, &umr_bitfield_default },
	 { "STRAP_FUNC_EN_DEV0_F0", 28, 28, &umr_bitfield_default },
	 { "STRAP_LEGACY_DEVICE_TYPE_EN_DEV0_F0", 29, 29, &umr_bitfield_default },
	 { "STRAP_D1_SUPPORT_DEV0_F0", 30, 30, &umr_bitfield_default },
	 { "STRAP_D2_SUPPORT_DEV0_F0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP1[] = {
	 { "STRAP_SRIOV_VF_DEVICE_ID_DEV0_F0", 0, 15, &umr_bitfield_default },
	 { "STRAP_SRIOV_SUPPORTED_PAGE_SIZE_DEV0_F0", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP13[] = {
	 { "STRAP_CLASS_CODE_PIF_DEV0_F0", 0, 7, &umr_bitfield_default },
	 { "STRAP_CLASS_CODE_SUB_DEV0_F0", 8, 15, &umr_bitfield_default },
	 { "STRAP_CLASS_CODE_BASE_DEV0_F0", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP2[] = {
	 { "STRAP_SRIOV_EN_DEV0_F0", 0, 0, &umr_bitfield_default },
	 { "STRAP_SRIOV_TOTAL_VFS_DEV0_F0", 1, 5, &umr_bitfield_default },
	 { "STRAP_64BAR_DIS_DEV0_F0", 6, 6, &umr_bitfield_default },
	 { "STRAP_NO_SOFT_RESET_DEV0_F0", 7, 7, &umr_bitfield_default },
	 { "STRAP_RESIZE_BAR_EN_DEV0_F0", 8, 8, &umr_bitfield_default },
	 { "STRAP_MAX_PASID_WIDTH_DEV0_F0", 9, 13, &umr_bitfield_default },
	 { "STRAP_MSI_PERVECTOR_MASK_CAP_DEV0_F0", 14, 14, &umr_bitfield_default },
	 { "STRAP_ARI_EN_DEV0_F0", 15, 15, &umr_bitfield_default },
	 { "STRAP_AER_EN_DEV0_F0", 16, 16, &umr_bitfield_default },
	 { "STRAP_ACS_EN_DEV0_F0", 17, 17, &umr_bitfield_default },
	 { "STRAP_ATS_EN_DEV0_F0", 18, 18, &umr_bitfield_default },
	 { "STRAP_CPL_ABORT_ERR_EN_DEV0_F0", 20, 20, &umr_bitfield_default },
	 { "STRAP_DPA_EN_DEV0_F0", 21, 21, &umr_bitfield_default },
	 { "STRAP_DSN_EN_DEV0_F0", 22, 22, &umr_bitfield_default },
	 { "STRAP_VC_EN_DEV0_F0", 23, 23, &umr_bitfield_default },
	 { "STRAP_MSI_MULTI_CAP_DEV0_F0", 24, 26, &umr_bitfield_default },
	 { "STRAP_PAGE_REQ_EN_DEV0_F0", 27, 27, &umr_bitfield_default },
	 { "STRAP_PASID_EN_DEV0_F0", 28, 28, &umr_bitfield_default },
	 { "STRAP_PASID_EXE_PERMISSION_SUPPORTED_DEV0_F0", 29, 29, &umr_bitfield_default },
	 { "STRAP_PASID_GLOBAL_INVALIDATE_SUPPORTED_DEV0_F0", 30, 30, &umr_bitfield_default },
	 { "STRAP_PASID_PRIV_MODE_SUPPORTED_DEV0_F0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP3[] = {
	 { "STRAP_POISONED_ADVISORY_NONFATAL_DEV0_F0", 0, 0, &umr_bitfield_default },
	 { "STRAP_PWR_EN_DEV0_F0", 1, 1, &umr_bitfield_default },
	 { "STRAP_SUBSYS_ID_DEV0_F0", 2, 17, &umr_bitfield_default },
	 { "STRAP_MSI_EN_DEV0_F0", 18, 18, &umr_bitfield_default },
	 { "STRAP_MSI_CLR_PENDING_EN_DEV0_F0", 19, 19, &umr_bitfield_default },
	 { "STRAP_MSIX_EN_DEV0_F0", 20, 20, &umr_bitfield_default },
	 { "STRAP_MSIX_TABLE_BIR_DEV0_F0", 21, 23, &umr_bitfield_default },
	 { "STRAP_PMC_DSI_DEV0_F0", 24, 24, &umr_bitfield_default },
	 { "STRAP_VENDOR_ID_BIT_DEV0_F0", 25, 25, &umr_bitfield_default },
	 { "STRAP_ALL_MSI_EVENT_SUPPORT_EN_DEV0_F0", 26, 26, &umr_bitfield_default },
	 { "STRAP_SMN_ERR_STATUS_MASK_EN_EP_DEV0_F0", 27, 27, &umr_bitfield_default },
	 { "STRAP_VF_RESIZE_BAR_EN_DEV0_F0", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP4[] = {
	 { "STRAP_RESERVED_STRAP4_DEV0_F0", 0, 9, &umr_bitfield_default },
	 { "STRAP_ATOMIC_64BIT_EN_DEV0_F0", 20, 20, &umr_bitfield_default },
	 { "STRAP_ATOMIC_EN_DEV0_F0", 21, 21, &umr_bitfield_default },
	 { "STRAP_FLR_EN_DEV0_F0", 22, 22, &umr_bitfield_default },
	 { "STRAP_PME_SUPPORT_DEV0_F0", 23, 27, &umr_bitfield_default },
	 { "STRAP_INTERRUPT_PIN_DEV0_F0", 28, 30, &umr_bitfield_default },
	 { "STRAP_AUXPWR_SUPPORT_DEV0_F0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP5[] = {
	 { "STRAP_SUBSYS_VEN_ID_DEV0_F0", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP8[] = {
	 { "STRAP_DOORBELL_APER_SIZE_DEV0_F0", 0, 2, &umr_bitfield_default },
	 { "STRAP_DOORBELL_BAR_DIS_DEV0_F0", 3, 3, &umr_bitfield_default },
	 { "STRAP_FB_ALWAYS_ON_DEV0_F0", 4, 4, &umr_bitfield_default },
	 { "STRAP_FB_CPL_TYPE_SEL_DEV0_F0", 5, 6, &umr_bitfield_default },
	 { "STRAP_IO_BAR_DIS_DEV0_F0", 7, 7, &umr_bitfield_default },
	 { "STRAP_LFB_ERRMSG_EN_DEV0_F0", 8, 8, &umr_bitfield_default },
	 { "STRAP_MEM_AP_SIZE_DEV0_F0", 9, 12, &umr_bitfield_default },
	 { "STRAP_REG_AP_SIZE_DEV0_F0", 13, 14, &umr_bitfield_default },
	 { "STRAP_ROM_AP_SIZE_DEV0_F0", 15, 16, &umr_bitfield_default },
	 { "STRAP_VF_DOORBELL_APER_SIZE_DEV0_F0", 17, 19, &umr_bitfield_default },
	 { "STRAP_VF_MEM_AP_SIZE_DEV0_F0", 20, 23, &umr_bitfield_default },
	 { "STRAP_VF_REG_AP_SIZE_DEV0_F0", 24, 25, &umr_bitfield_default },
	 { "STRAP_VGA_DIS_DEV0_F0", 26, 26, &umr_bitfield_default },
	 { "STRAP_VF_MSI_MULTI_CAP_DEV0_F0", 27, 29, &umr_bitfield_default },
	 { "STRAP_SRIOV_VF_MAPPING_MODE_DEV0_F0", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_STRAP9[] = {
	 { "STRAP_OUTSTAND_PAGE_REQ_CAP_DEV0_F0", 0, 15, &umr_bitfield_default },
	 { "STRAP_BAR_COMPLIANCE_EN_DEV0_F0", 18, 18, &umr_bitfield_default },
	 { "STRAP_NBIF_ROM_BAR_DIS_CHICKEN_DEV0_F0", 19, 19, &umr_bitfield_default },
	 { "STRAP_VF_REG_PROT_DIS_DEV0_F0", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP0[] = {
	 { "STRAP_DEVICE_ID_DEV0_F1", 0, 15, &umr_bitfield_default },
	 { "STRAP_MAJOR_REV_ID_DEV0_F1", 16, 19, &umr_bitfield_default },
	 { "STRAP_MINOR_REV_ID_DEV0_F1", 20, 23, &umr_bitfield_default },
	 { "STRAP_FUNC_EN_DEV0_F1", 28, 28, &umr_bitfield_default },
	 { "STRAP_LEGACY_DEVICE_TYPE_EN_DEV0_F1", 29, 29, &umr_bitfield_default },
	 { "STRAP_D1_SUPPORT_DEV0_F1", 30, 30, &umr_bitfield_default },
	 { "STRAP_D2_SUPPORT_DEV0_F1", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP10[] = {
	 { "STRAP_APER1_RESIZE_EN_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_APER1_RESIZE_SUPPORT_DEV0_F1", 1, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP11[] = {
	 { "STRAP_APER2_RESIZE_EN_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_APER2_RESIZE_SUPPORT_DEV0_F1", 1, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP12[] = {
	 { "STRAP_APER3_RESIZE_EN_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_APER3_RESIZE_SUPPORT_DEV0_F1", 1, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP13[] = {
	 { "STRAP_CLASS_CODE_PIF_DEV0_F1", 0, 7, &umr_bitfield_default },
	 { "STRAP_CLASS_CODE_SUB_DEV0_F1", 8, 15, &umr_bitfield_default },
	 { "STRAP_CLASS_CODE_BASE_DEV0_F1", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP2[] = {
	 { "STRAP_NO_SOFT_RESET_DEV0_F1", 7, 7, &umr_bitfield_default },
	 { "STRAP_RESIZE_BAR_EN_DEV0_F1", 8, 8, &umr_bitfield_default },
	 { "STRAP_MAX_PASID_WIDTH_DEV0_F1", 9, 13, &umr_bitfield_default },
	 { "STRAP_MSI_PERVECTOR_MASK_CAP_DEV0_F1", 14, 14, &umr_bitfield_default },
	 { "STRAP_AER_EN_DEV0_F1", 16, 16, &umr_bitfield_default },
	 { "STRAP_ACS_EN_DEV0_F1", 17, 17, &umr_bitfield_default },
	 { "STRAP_ATS_EN_DEV0_F1", 18, 18, &umr_bitfield_default },
	 { "STRAP_CPL_ABORT_ERR_EN_DEV0_F1", 20, 20, &umr_bitfield_default },
	 { "STRAP_DPA_EN_DEV0_F1", 21, 21, &umr_bitfield_default },
	 { "STRAP_DSN_EN_DEV0_F1", 22, 22, &umr_bitfield_default },
	 { "STRAP_VC_EN_DEV0_F1", 23, 23, &umr_bitfield_default },
	 { "STRAP_MSI_MULTI_CAP_DEV0_F1", 24, 26, &umr_bitfield_default },
	 { "STRAP_PASID_EN_DEV0_F1", 28, 28, &umr_bitfield_default },
	 { "STRAP_PASID_EXE_PERMISSION_SUPPORTED_DEV0_F1", 29, 29, &umr_bitfield_default },
	 { "STRAP_PASID_GLOBAL_INVALIDATE_SUPPORTED_DEV0_F1", 30, 30, &umr_bitfield_default },
	 { "STRAP_PASID_PRIV_MODE_SUPPORTED_DEV0_F1", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP3[] = {
	 { "STRAP_POISONED_ADVISORY_NONFATAL_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_PWR_EN_DEV0_F1", 1, 1, &umr_bitfield_default },
	 { "STRAP_SUBSYS_ID_DEV0_F1", 2, 17, &umr_bitfield_default },
	 { "STRAP_MSI_EN_DEV0_F1", 18, 18, &umr_bitfield_default },
	 { "STRAP_MSI_CLR_PENDING_EN_DEV0_F1", 19, 19, &umr_bitfield_default },
	 { "STRAP_MSIX_EN_DEV0_F1", 20, 20, &umr_bitfield_default },
	 { "STRAP_PMC_DSI_DEV0_F1", 24, 24, &umr_bitfield_default },
	 { "STRAP_VENDOR_ID_BIT_DEV0_F1", 25, 25, &umr_bitfield_default },
	 { "STRAP_ALL_MSI_EVENT_SUPPORT_EN_DEV0_F1", 26, 26, &umr_bitfield_default },
	 { "STRAP_SMN_ERR_STATUS_MASK_EN_EP_DEV0_F1", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP4[] = {
	 { "STRAP_ATOMIC_64BIT_EN_DEV0_F1", 20, 20, &umr_bitfield_default },
	 { "STRAP_ATOMIC_EN_DEV0_F1", 21, 21, &umr_bitfield_default },
	 { "STRAP_FLR_EN_DEV0_F1", 22, 22, &umr_bitfield_default },
	 { "STRAP_PME_SUPPORT_DEV0_F1", 23, 27, &umr_bitfield_default },
	 { "STRAP_INTERRUPT_PIN_DEV0_F1", 28, 30, &umr_bitfield_default },
	 { "STRAP_AUXPWR_SUPPORT_DEV0_F1", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP5[] = {
	 { "STRAP_SUBSYS_VEN_ID_DEV0_F1", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP6[] = {
	 { "STRAP_APER0_EN_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_APER0_PREFETCHABLE_EN_DEV0_F1", 1, 1, &umr_bitfield_default },
	 { "STRAP_APER0_64BAR_EN_DEV0_F1", 2, 2, &umr_bitfield_default },
	 { "STRAP_APER0_AP_SIZE_DEV0_F1", 4, 6, &umr_bitfield_default },
	 { "STRAP_APER1_EN_DEV0_F1", 8, 8, &umr_bitfield_default },
	 { "STRAP_APER1_PREFETCHABLE_EN_DEV0_F1", 9, 9, &umr_bitfield_default },
	 { "STRAP_APER2_EN_DEV0_F1", 16, 16, &umr_bitfield_default },
	 { "STRAP_APER2_PREFETCHABLE_EN_DEV0_F1", 17, 17, &umr_bitfield_default },
	 { "STRAP_APER3_EN_DEV0_F1", 24, 24, &umr_bitfield_default },
	 { "STRAP_APER3_PREFETCHABLE_EN_DEV0_F1", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF1_STRAP7[] = {
	 { "STRAP_ROM_APER_EN_DEV0_F1", 0, 0, &umr_bitfield_default },
	 { "STRAP_ROM_APER_SIZE_DEV0_F1", 1, 4, &umr_bitfield_default },
	 { "STRAP_TPH_CPLR_SUPPORTED_DEV0_F1", 20, 21, &umr_bitfield_default },
	 { "STRAP_TPH_EN_DEV0_F1", 22, 22, &umr_bitfield_default },
	 { "STRAP_TPH_REQR_DEV_SPC_MODE_SUPPORTED_DEV0_F1", 23, 23, &umr_bitfield_default },
	 { "STRAP_TPH_REQR_ST_TABLE_LOCATION_DEV0_F1", 24, 25, &umr_bitfield_default },
	 { "STRAP_TPH_REQR_ST_TABLE_SIZE_DEV0_F1", 26, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_SCRATCH[] = {
	 { "PCIE_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_CNTL[] = {
	 { "UR_ERR_REPORT_DIS", 7, 7, &umr_bitfield_default },
	 { "PCIE_MALFORM_ATOMIC_OPS", 8, 8, &umr_bitfield_default },
	 { "RX_IGNORE_LTR_MSG_UR", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_INT_CNTL[] = {
	 { "CORR_ERR_INT_EN", 0, 0, &umr_bitfield_default },
	 { "NON_FATAL_ERR_INT_EN", 1, 1, &umr_bitfield_default },
	 { "FATAL_ERR_INT_EN", 2, 2, &umr_bitfield_default },
	 { "USR_DETECTED_INT_EN", 3, 3, &umr_bitfield_default },
	 { "MISC_ERR_INT_EN", 4, 4, &umr_bitfield_default },
	 { "POWER_STATE_CHG_INT_EN", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_INT_STATUS[] = {
	 { "CORR_ERR_INT_STATUS", 0, 0, &umr_bitfield_default },
	 { "NON_FATAL_ERR_INT_STATUS", 1, 1, &umr_bitfield_default },
	 { "FATAL_ERR_INT_STATUS", 2, 2, &umr_bitfield_default },
	 { "USR_DETECTED_INT_STATUS", 3, 3, &umr_bitfield_default },
	 { "MISC_ERR_INT_STATUS", 4, 4, &umr_bitfield_default },
	 { "POWER_STATE_CHG_INT_STATUS", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_RX_CNTL2[] = {
	 { "RX_IGNORE_EP_INVALIDPASID_UR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_BUS_CNTL[] = {
	 { "IMMEDIATE_PMI_DIS", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_CFG_CNTL[] = {
	 { "CFG_EN_DEC_TO_HIDDEN_REG", 0, 0, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN2_HIDDEN_REG", 1, 1, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN3_HIDDEN_REG", 2, 2, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN4_HIDDEN_REG", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_TX_LTR_CNTL[] = {
	 { "LTR_PRIV_S_SHORT_VALUE", 0, 2, &umr_bitfield_default },
	 { "LTR_PRIV_S_LONG_VALUE", 3, 5, &umr_bitfield_default },
	 { "LTR_PRIV_S_REQUIREMENT", 6, 6, &umr_bitfield_default },
	 { "LTR_PRIV_NS_SHORT_VALUE", 7, 9, &umr_bitfield_default },
	 { "LTR_PRIV_NS_LONG_VALUE", 10, 12, &umr_bitfield_default },
	 { "LTR_PRIV_NS_REQUIREMENT", 13, 13, &umr_bitfield_default },
	 { "LTR_PRIV_MSG_DIS_IN_PM_NON_D0", 14, 14, &umr_bitfield_default },
	 { "LTR_PRIV_RST_LTR_IN_DL_DOWN", 15, 15, &umr_bitfield_default },
	 { "TX_CHK_FC_FOR_L1", 16, 16, &umr_bitfield_default },
	 { "LTR_DSTATE_USING_WDATA_EN", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_0[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_1[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_2[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_3[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_4[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_5[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_6[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F1_DPA_SUBSTATE_PWR_ALLOC_7[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_STRAP_MISC[] = {
	 { "STRAP_MST_ADR64_EN", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_STRAP_MISC2[] = {
	 { "STRAP_TPH_SUPPORTED", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_F0_DPA_CAP[] = {
	 { "TRANS_LAT_UNIT", 8, 9, &umr_bitfield_default },
	 { "PWR_ALLOC_SCALE", 12, 13, &umr_bitfield_default },
	 { "TRANS_LAT_VAL_0", 16, 23, &umr_bitfield_default },
	 { "TRANS_LAT_VAL_1", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_F0_DPA_LATENCY_INDICATOR[] = {
	 { "TRANS_LAT_INDICATOR_BITS", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_F0_DPA_CNTL[] = {
	 { "SUBSTATE_STATUS", 0, 4, &umr_bitfield_default },
	 { "DPA_COMPLIANCE_MODE", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_0[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_1[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_2[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_3[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_4[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_5[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_6[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_F0_DPA_SUBSTATE_PWR_ALLOC_7[] = {
	 { "SUBSTATE_PWR_ALLOC", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_PME_CONTROL[] = {
	 { "PME_SERVICE_TIMER", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIEP_RESERVED[] = {
	 { "PCIEP_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_TX_CNTL[] = {
	 { "TX_SNR_OVERRIDE", 10, 11, &umr_bitfield_default },
	 { "TX_RO_OVERRIDE", 12, 13, &umr_bitfield_default },
	 { "TX_F0_TPH_DIS", 24, 24, &umr_bitfield_default },
	 { "TX_F1_TPH_DIS", 25, 25, &umr_bitfield_default },
	 { "TX_F2_TPH_DIS", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_TX_REQUESTER_ID[] = {
	 { "TX_REQUESTER_ID_FUNCTION", 0, 2, &umr_bitfield_default },
	 { "TX_REQUESTER_ID_DEVICE", 3, 7, &umr_bitfield_default },
	 { "TX_REQUESTER_ID_BUS", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_ERR_CNTL[] = {
	 { "ERR_REPORTING_DIS", 0, 0, &umr_bitfield_default },
	 { "AER_HDR_LOG_TIMEOUT", 8, 10, &umr_bitfield_default },
	 { "SEND_ERR_MSG_IMMEDIATELY", 17, 17, &umr_bitfield_default },
	 { "STRAP_POISONED_ADVISORY_NONFATAL", 18, 18, &umr_bitfield_default },
	 { "AER_HDR_LOG_F0_TIMER_EXPIRED", 24, 24, &umr_bitfield_default },
	 { "AER_HDR_LOG_F1_TIMER_EXPIRED", 25, 25, &umr_bitfield_default },
	 { "AER_HDR_LOG_F2_TIMER_EXPIRED", 26, 26, &umr_bitfield_default },
	 { "AER_HDR_LOG_F3_TIMER_EXPIRED", 27, 27, &umr_bitfield_default },
	 { "AER_HDR_LOG_F4_TIMER_EXPIRED", 28, 28, &umr_bitfield_default },
	 { "AER_HDR_LOG_F5_TIMER_EXPIRED", 29, 29, &umr_bitfield_default },
	 { "AER_HDR_LOG_F6_TIMER_EXPIRED", 30, 30, &umr_bitfield_default },
	 { "AER_HDR_LOG_F7_TIMER_EXPIRED", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_RX_CNTL[] = {
	 { "RX_IGNORE_MAX_PAYLOAD_ERR", 8, 8, &umr_bitfield_default },
	 { "RX_IGNORE_TC_ERR", 9, 9, &umr_bitfield_default },
	 { "RX_PCIE_CPL_TIMEOUT_DIS", 20, 20, &umr_bitfield_default },
	 { "RX_IGNORE_SHORTPREFIX_ERR", 21, 21, &umr_bitfield_default },
	 { "RX_IGNORE_MAXPREFIX_ERR", 22, 22, &umr_bitfield_default },
	 { "RX_IGNORE_INVALIDPASID_ERR", 24, 24, &umr_bitfield_default },
	 { "RX_IGNORE_NOT_PASID_UR", 25, 25, &umr_bitfield_default },
	 { "RX_TPH_DIS", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmEP_PCIE_LC_SPEED_CNTL[] = {
	 { "LC_GEN2_EN_STRAP", 0, 0, &umr_bitfield_default },
	 { "LC_GEN3_EN_STRAP", 1, 1, &umr_bitfield_default },
	 { "LC_GEN4_EN_STRAP", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_RESERVED[] = {
	 { "PCIE_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_SCRATCH[] = {
	 { "PCIE_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_CNTL[] = {
	 { "HWINIT_WR_LOCK", 0, 0, &umr_bitfield_default },
	 { "UR_ERR_REPORT_DIS_DN", 7, 7, &umr_bitfield_default },
	 { "RX_IGNORE_LTR_MSG_UR", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_CONFIG_CNTL[] = {
	 { "CI_EXTENDED_TAG_EN_OVERRIDE", 25, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_RX_CNTL2[] = {
	 { "FLR_EXTEND_MODE", 28, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_BUS_CNTL[] = {
	 { "IMMEDIATE_PMI_DIS", 7, 7, &umr_bitfield_default },
	 { "AER_CPL_TIMEOUT_RO_DIS_SWDN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_CFG_CNTL[] = {
	 { "CFG_EN_DEC_TO_HIDDEN_REG", 0, 0, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN2_HIDDEN_REG", 1, 1, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN3_HIDDEN_REG", 2, 2, &umr_bitfield_default },
	 { "CFG_EN_DEC_TO_GEN4_HIDDEN_REG", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_STRAP_F0[] = {
	 { "STRAP_F0_EN", 0, 0, &umr_bitfield_default },
	 { "STRAP_F0_MC_EN", 17, 17, &umr_bitfield_default },
	 { "STRAP_F0_MSI_MULTI_CAP", 21, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_STRAP_MISC[] = {
	 { "STRAP_CLK_PM_EN", 24, 24, &umr_bitfield_default },
	 { "STRAP_MST_ADR64_EN", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmDN_PCIE_STRAP_MISC2[] = {
	 { "STRAP_MSTCPL_TIMEOUT_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_ERR_CNTL[] = {
	 { "ERR_REPORTING_DIS", 0, 0, &umr_bitfield_default },
	 { "AER_HDR_LOG_TIMEOUT", 8, 10, &umr_bitfield_default },
	 { "AER_HDR_LOG_F0_TIMER_EXPIRED", 11, 11, &umr_bitfield_default },
	 { "SEND_ERR_MSG_IMMEDIATELY", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_RX_CNTL[] = {
	 { "RX_IGNORE_MAX_PAYLOAD_ERR", 8, 8, &umr_bitfield_default },
	 { "RX_IGNORE_TC_ERR_DN", 9, 9, &umr_bitfield_default },
	 { "RX_PCIE_CPL_TIMEOUT_DIS", 20, 20, &umr_bitfield_default },
	 { "RX_IGNORE_SHORTPREFIX_ERR_DN", 21, 21, &umr_bitfield_default },
	 { "RX_RCB_FLR_TIMEOUT_DIS", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_LC_SPEED_CNTL[] = {
	 { "LC_GEN2_EN_STRAP", 0, 0, &umr_bitfield_default },
	 { "LC_GEN3_EN_STRAP", 1, 1, &umr_bitfield_default },
	 { "LC_GEN4_EN_STRAP", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIE_LC_CNTL2[] = {
	 { "LC_LINK_BW_NOTIFICATION_DIS", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmPCIEP_STRAP_MISC[] = {
	 { "STRAP_MULTI_FUNC_EN", 10, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmLTR_MSG_INFO_FROM_EP[] = {
	 { "LTR_MSG_INFO_FROM_EP", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_ERR_INT_CNTL[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_INT_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BACO_CNTL_MISC[] = {
	 { "BIF_ROM_REQ_DIS", 0, 0, &umr_bitfield_default },
	 { "BIF_AZ_REQ_DIS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_RESET_EN[] = {
	 { "DB_APER_RESET_EN", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_VDM_SUPPORT[] = {
	 { "MCTP_SUPPORT", 0, 0, &umr_bitfield_default },
	 { "AMPTP_SUPPORT", 1, 1, &umr_bitfield_default },
	 { "OTHER_VDM_SUPPORT", 2, 2, &umr_bitfield_default },
	 { "ROUTE_TO_RC_CHECK_IN_RCMODE", 3, 3, &umr_bitfield_default },
	 { "ROUTE_BROADCAST_CHECK_IN_RCMODE", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_MARGIN_PARAM_CNTL0[] = {
	 { "MARGINING_VOLTAGE_SUPPORTED", 0, 0, &umr_bitfield_default },
	 { "MARGINING_IND_LEFTRIGHT_TIMING", 1, 1, &umr_bitfield_default },
	 { "MARGINING_IND_UPDOWN_VOLTAGE", 2, 2, &umr_bitfield_default },
	 { "MARGINING_IND_ERROR_SAMPLER", 3, 3, &umr_bitfield_default },
	 { "MARGINING_SAMPLE_REPORTING_METHOD", 4, 4, &umr_bitfield_default },
	 { "MARGINING_NUM_TIMING_STEPS", 5, 10, &umr_bitfield_default },
	 { "MARGINING_MAX_TIMING_OFFSET", 11, 17, &umr_bitfield_default },
	 { "MARGINING_NUM_VOLTAGE_STEPS", 18, 24, &umr_bitfield_default },
	 { "MARGINING_MAX_VOLTAGE_OFFSET", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_MARGIN_PARAM_CNTL1[] = {
	 { "MARGINING_SAMPLING_RATE_VOLTAGE", 0, 5, &umr_bitfield_default },
	 { "MARGINING_SAMPLING_RATE_TIMING", 6, 11, &umr_bitfield_default },
	 { "MARGINING_MAX_LANES", 12, 16, &umr_bitfield_default },
	 { "MARGINING_SAMPLE_COUNT", 17, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_GPUIOV_REGION[] = {
	 { "LFB_REGION", 0, 2, &umr_bitfield_default },
	 { "MAX_REGION", 4, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER_REG_RANGE0[] = {
	 { "START_ADDR", 0, 15, &umr_bitfield_default },
	 { "END_ADDR", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER_REG_RANGE1[] = {
	 { "START_ADDR", 0, 15, &umr_bitfield_default },
	 { "END_ADDR", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BUS_CNTL[] = {
	 { "PMI_IO_DIS", 2, 2, &umr_bitfield_default },
	 { "PMI_MEM_DIS", 3, 3, &umr_bitfield_default },
	 { "PMI_BM_DIS", 4, 4, &umr_bitfield_default },
	 { "PMI_IO_DIS_DN", 5, 5, &umr_bitfield_default },
	 { "PMI_MEM_DIS_DN", 6, 6, &umr_bitfield_default },
	 { "PMI_IO_DIS_UP", 7, 7, &umr_bitfield_default },
	 { "PMI_MEM_DIS_UP", 8, 8, &umr_bitfield_default },
	 { "ROOT_ERR_LOG_ON_EVENT", 12, 12, &umr_bitfield_default },
	 { "HOST_CPL_POISONED_LOG_IN_RC", 13, 13, &umr_bitfield_default },
	 { "DN_SEC_SIG_CPLCA_WITH_EP_ERR", 16, 16, &umr_bitfield_default },
	 { "DN_SEC_RCV_CPLCA_WITH_EP_ERR", 17, 17, &umr_bitfield_default },
	 { "DN_SEC_RCV_CPLUR_WITH_EP_ERR", 18, 18, &umr_bitfield_default },
	 { "DN_PRI_SIG_CPLCA_WITH_EP_ERR", 19, 19, &umr_bitfield_default },
	 { "DN_PRI_RCV_CPLCA_WITH_EP_ERR", 20, 20, &umr_bitfield_default },
	 { "DN_PRI_RCV_CPLUR_WITH_EP_ERR", 21, 21, &umr_bitfield_default },
	 { "MAX_PAYLOAD_SIZE_MODE", 24, 24, &umr_bitfield_default },
	 { "PRIV_MAX_PAYLOAD_SIZE", 25, 27, &umr_bitfield_default },
	 { "MAX_READ_REQUEST_SIZE_MODE", 28, 28, &umr_bitfield_default },
	 { "PRIV_MAX_READ_REQUEST_SIZE", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CONFIG_CNTL[] = {
	 { "CFG_VGA_RAM_EN", 0, 0, &umr_bitfield_default },
	 { "GENMO_MONO_ADDRESS_B", 2, 2, &umr_bitfield_default },
	 { "GRPH_ADRSEL", 3, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CONFIG_F0_BASE[] = {
	 { "F0_BASE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CONFIG_APER_SIZE[] = {
	 { "APER_SIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CONFIG_REG_APER_SIZE[] = {
	 { "REG_APER_SIZE", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_XDMA_LO[] = {
	 { "BIF_XDMA_LOWER_BOUND", 0, 30, &umr_bitfield_default },
	 { "BIF_XDMA_APER_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_XDMA_HI[] = {
	 { "BIF_XDMA_UPPER_BOUND", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_FEATURES_CONTROL_MISC[] = {
	 { "UR_PSN_PKT_REPORT_POISON_DIS", 4, 4, &umr_bitfield_default },
	 { "POST_PSN_ONLY_PKT_REPORT_UR_ALL_DIS", 5, 5, &umr_bitfield_default },
	 { "POST_PSN_ONLY_PKT_REPORT_UR_PART_DIS", 6, 6, &umr_bitfield_default },
	 { "INIT_PFFLR_CRS_RET_DIS", 7, 7, &umr_bitfield_default },
	 { "ATC_PRG_RESP_PASID_UR_EN", 8, 8, &umr_bitfield_default },
	 { "RX_IGNORE_TRANSMRD_UR", 9, 9, &umr_bitfield_default },
	 { "RX_IGNORE_TRANSMWR_UR", 10, 10, &umr_bitfield_default },
	 { "RX_IGNORE_ATSTRANSREQ_UR", 11, 11, &umr_bitfield_default },
	 { "RX_IGNORE_PAGEREQMSG_UR", 12, 12, &umr_bitfield_default },
	 { "RX_IGNORE_INVCPL_UR", 13, 13, &umr_bitfield_default },
	 { "CLR_MSI_X_PENDING_WHEN_DISABLED_DIS", 14, 14, &umr_bitfield_default },
	 { "CHECK_BME_ON_PENDING_PKT_GEN_DIS", 15, 15, &umr_bitfield_default },
	 { "PSN_CHECK_ON_PAYLOAD_DIS", 16, 16, &umr_bitfield_default },
	 { "CLR_MSI_PENDING_ON_MULTIEN_DIS", 17, 17, &umr_bitfield_default },
	 { "SET_DEVICE_ERR_FOR_ECRC_EN", 18, 18, &umr_bitfield_default },
	 { "HOST_POISON_FLAG_CHECK_FOR_CHAIN_DIS", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BUSNUM_CNTL1[] = {
	 { "ID_MASK", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BUSNUM_LIST0[] = {
	 { "ID0", 0, 7, &umr_bitfield_default },
	 { "ID1", 8, 15, &umr_bitfield_default },
	 { "ID2", 16, 23, &umr_bitfield_default },
	 { "ID3", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BUSNUM_LIST1[] = {
	 { "ID4", 0, 7, &umr_bitfield_default },
	 { "ID5", 8, 15, &umr_bitfield_default },
	 { "ID6", 16, 23, &umr_bitfield_default },
	 { "ID7", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_BUSNUM_CNTL2[] = {
	 { "AUTOUPDATE_SEL", 0, 7, &umr_bitfield_default },
	 { "AUTOUPDATE_EN", 8, 8, &umr_bitfield_default },
	 { "HDPREG_CNTL", 16, 16, &umr_bitfield_default },
	 { "ERROR_MULTIPLE_ID_MATCH", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CAPTURE_HOST_BUSNUM[] = {
	 { "CHECK_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_HOST_BUSNUM[] = {
	 { "HOST_ID", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER0_FB_OFFSET_HI[] = {
	 { "PEER0_FB_OFFSET_HI", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER0_FB_OFFSET_LO[] = {
	 { "PEER0_FB_OFFSET_LO", 0, 19, &umr_bitfield_default },
	 { "PEER0_FB_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER1_FB_OFFSET_HI[] = {
	 { "PEER1_FB_OFFSET_HI", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER1_FB_OFFSET_LO[] = {
	 { "PEER1_FB_OFFSET_LO", 0, 19, &umr_bitfield_default },
	 { "PEER1_FB_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER2_FB_OFFSET_HI[] = {
	 { "PEER2_FB_OFFSET_HI", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER2_FB_OFFSET_LO[] = {
	 { "PEER2_FB_OFFSET_LO", 0, 19, &umr_bitfield_default },
	 { "PEER2_FB_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER3_FB_OFFSET_HI[] = {
	 { "PEER3_FB_OFFSET_HI", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_PEER3_FB_OFFSET_LO[] = {
	 { "PEER3_FB_OFFSET_LO", 0, 19, &umr_bitfield_default },
	 { "PEER3_FB_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEVFUNCNUM_LIST0[] = {
	 { "DEVFUNC_ID0", 0, 7, &umr_bitfield_default },
	 { "DEVFUNC_ID1", 8, 15, &umr_bitfield_default },
	 { "DEVFUNC_ID2", 16, 23, &umr_bitfield_default },
	 { "DEVFUNC_ID3", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEVFUNCNUM_LIST1[] = {
	 { "DEVFUNC_ID4", 0, 7, &umr_bitfield_default },
	 { "DEVFUNC_ID5", 8, 15, &umr_bitfield_default },
	 { "DEVFUNC_ID6", 16, 23, &umr_bitfield_default },
	 { "DEVFUNC_ID7", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_LINK_CNTL[] = {
	 { "LINK_DOWN_EXIT", 0, 0, &umr_bitfield_default },
	 { "LINK_DOWN_ENTRY", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_CMN_LINK_CNTL[] = {
	 { "BLOCK_PME_ON_L0S_DIS", 0, 0, &umr_bitfield_default },
	 { "BLOCK_PME_ON_L1_DIS", 1, 1, &umr_bitfield_default },
	 { "BLOCK_PME_ON_LDN_DIS", 2, 2, &umr_bitfield_default },
	 { "PM_L1_IDLE_CHECK_DMA_EN", 3, 3, &umr_bitfield_default },
	 { "VLINK_IN_L1LTR_TIMER", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_EP_REQUESTERID_RESTORE[] = {
	 { "EP_REQID_BUS", 0, 7, &umr_bitfield_default },
	 { "EP_REQID_DEV", 8, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_LTR_LSWITCH_CNTL[] = {
	 { "LSWITCH_LATENCY_VALUE", 0, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_MH_ARB_CNTL[] = {
	 { "MH_ARB_MODE", 0, 0, &umr_bitfield_default },
	 { "MH_ARB_FIX_PRIORITY", 1, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmCC_BIF_BX_STRAP0[] = {
	 { "STRAP_RESERVED", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_MM_INDACCESS_CNTL[] = {
	 { "WRITE_DIS", 0, 0, &umr_bitfield_default },
	 { "MM_INDACCESS_DIS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBUS_CNTL[] = {
	 { "VGA_REG_COHERENCY_DIS", 6, 6, &umr_bitfield_default },
	 { "VGA_MEM_COHERENCY_DIS", 7, 7, &umr_bitfield_default },
	 { "SET_AZ_TC", 10, 12, &umr_bitfield_default },
	 { "SET_MC_TC", 13, 15, &umr_bitfield_default },
	 { "ZERO_BE_WR_EN", 16, 16, &umr_bitfield_default },
	 { "ZERO_BE_RD_EN", 17, 17, &umr_bitfield_default },
	 { "RD_STALL_IO_WR", 18, 18, &umr_bitfield_default },
	 { "PRECEEDINGWR_STALL_VGA_FB_FLUSH_DIS", 25, 25, &umr_bitfield_default },
	 { "PRECEEDINGWR_STALL_VGA_REG_FLUSH_DIS", 26, 26, &umr_bitfield_default },
	 { "HDP_REG_FLUSH_VF_MASK_EN", 29, 29, &umr_bitfield_default },
	 { "VGAFB_ZERO_BE_WR_EN", 30, 30, &umr_bitfield_default },
	 { "VGAFB_ZERO_BE_RD_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_SCRATCH0[] = {
	 { "BIF_SCRATCH0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_SCRATCH1[] = {
	 { "BIF_SCRATCH1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBX_RESET_EN[] = {
	 { "RESET_ON_VFENABLE_LOW_EN", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmMM_CFGREGS_CNTL[] = {
	 { "MM_CFG_FUNC_SEL", 0, 2, &umr_bitfield_default },
	 { "MM_CFG_DEV_SEL", 6, 7, &umr_bitfield_default },
	 { "MM_WR_TO_CFG_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBX_RESET_CNTL[] = {
	 { "LINK_TRAIN_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmINTERRUPT_CNTL[] = {
	 { "IH_DUMMY_RD_OVERRIDE", 0, 0, &umr_bitfield_default },
	 { "IH_DUMMY_RD_EN", 1, 1, &umr_bitfield_default },
	 { "IH_REQ_NONSNOOP_EN", 3, 3, &umr_bitfield_default },
	 { "IH_INTR_DLY_CNTR", 4, 7, &umr_bitfield_default },
	 { "GEN_IH_INT_EN", 8, 8, &umr_bitfield_default },
	 { "BIF_RB_REQ_NONSNOOP_EN", 15, 15, &umr_bitfield_default },
	 { "DUMMYRD_BYPASS_IN_MSI_EN", 16, 16, &umr_bitfield_default },
	 { "ALWAYS_SEND_INTPKT_AFTER_DUMMYRD_DIS", 17, 17, &umr_bitfield_default },
	 { "BIF_RB_REQ_RELAX_ORDER_EN", 18, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmINTERRUPT_CNTL2[] = {
	 { "IH_DUMMY_RD_ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmCLKREQB_PAD_CNTL[] = {
	 { "CLKREQB_PAD_A", 0, 0, &umr_bitfield_default },
	 { "CLKREQB_PAD_SEL", 1, 1, &umr_bitfield_default },
	 { "CLKREQB_PAD_MODE", 2, 2, &umr_bitfield_default },
	 { "CLKREQB_PAD_SPARE", 3, 4, &umr_bitfield_default },
	 { "CLKREQB_PAD_SN0", 5, 5, &umr_bitfield_default },
	 { "CLKREQB_PAD_SN1", 6, 6, &umr_bitfield_default },
	 { "CLKREQB_PAD_SN2", 7, 7, &umr_bitfield_default },
	 { "CLKREQB_PAD_SN3", 8, 8, &umr_bitfield_default },
	 { "CLKREQB_PAD_SLEWN", 9, 9, &umr_bitfield_default },
	 { "CLKREQB_PAD_WAKE", 10, 10, &umr_bitfield_default },
	 { "CLKREQB_PAD_SCHMEN", 11, 11, &umr_bitfield_default },
	 { "CLKREQB_PAD_CNTL_EN", 12, 12, &umr_bitfield_default },
	 { "CLKREQB_PAD_Y", 13, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_FEATURES_CONTROL_MISC[] = {
	 { "MST_BIF_REQ_EP_DIS", 0, 0, &umr_bitfield_default },
	 { "SLV_BIF_CPL_EP_DIS", 1, 1, &umr_bitfield_default },
	 { "BIF_SLV_REQ_EP_DIS", 2, 2, &umr_bitfield_default },
	 { "BIF_MST_CPL_EP_DIS", 3, 3, &umr_bitfield_default },
	 { "BIF_RB_MSI_VEC_NOT_ENABLED_MODE", 11, 11, &umr_bitfield_default },
	 { "BIF_RB_SET_OVERFLOW_EN", 12, 12, &umr_bitfield_default },
	 { "ATOMIC_ERR_INT_DIS", 13, 13, &umr_bitfield_default },
	 { "ATOMIC_ONLY_WRITE_DIS", 14, 14, &umr_bitfield_default },
	 { "BME_HDL_NONVIR_EN", 15, 15, &umr_bitfield_default },
	 { "HDP_NP_OSTD_LIMIT", 16, 23, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_CHK_48BIT_ADDR", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_DOORBELL_CNTL[] = {
	 { "SELF_RING_DIS", 0, 0, &umr_bitfield_default },
	 { "TRANS_CHECK_DIS", 1, 1, &umr_bitfield_default },
	 { "UNTRANS_LBACK_EN", 2, 2, &umr_bitfield_default },
	 { "NON_CONSECUTIVE_BE_ZERO_DIS", 3, 3, &umr_bitfield_default },
	 { "DOORBELL_MONITOR_EN", 4, 4, &umr_bitfield_default },
	 { "DB_MNTR_INTGEN_DIS", 24, 24, &umr_bitfield_default },
	 { "DB_MNTR_INTGEN_MODE_0", 25, 25, &umr_bitfield_default },
	 { "DB_MNTR_INTGEN_MODE_1", 26, 26, &umr_bitfield_default },
	 { "DB_MNTR_INTGEN_MODE_2", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_DOORBELL_INT_CNTL[] = {
	 { "DOORBELL_INTERRUPT_STATUS", 0, 0, &umr_bitfield_default },
	 { "RAS_CNTLR_INTERRUPT_STATUS", 1, 1, &umr_bitfield_default },
	 { "RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS", 2, 2, &umr_bitfield_default },
	 { "DOORBELL_INTERRUPT_CLEAR", 16, 16, &umr_bitfield_default },
	 { "RAS_CNTLR_INTERRUPT_CLEAR", 17, 17, &umr_bitfield_default },
	 { "RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR", 18, 18, &umr_bitfield_default },
	 { "DOORBELL_INTERRUPT_DISABLE", 24, 24, &umr_bitfield_default },
	 { "RAS_CNTLR_INTERRUPT_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE", 26, 26, &umr_bitfield_default },
	 { "SET_DB_INTR_STATUS_WHEN_RB_ENABLE", 28, 28, &umr_bitfield_default },
	 { "SET_IOH_RAS_INTR_STATUS_WHEN_RB_ENABLE", 29, 29, &umr_bitfield_default },
	 { "SET_ATH_RAS_INTR_STATUS_WHEN_RB_ENABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_FB_EN[] = {
	 { "FB_READ_EN", 0, 0, &umr_bitfield_default },
	 { "FB_WRITE_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_INTR_CNTL[] = {
	 { "RAS_INTR_VEC_SEL", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_MST_TRANS_PENDING_VF[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_SLV_TRANS_PENDING_VF[] = {
	 { "BIF_SLV_TRANS_PENDING", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmBACO_CNTL[] = {
	 { "BACO_EN", 0, 0, &umr_bitfield_default },
	 { "BACO_DUMMY_EN", 2, 2, &umr_bitfield_default },
	 { "BACO_POWER_OFF", 3, 3, &umr_bitfield_default },
	 { "BACO_DSTATE_BYPASS", 5, 5, &umr_bitfield_default },
	 { "BACO_RST_INTR_MASK", 6, 6, &umr_bitfield_default },
	 { "BACO_MODE", 8, 8, &umr_bitfield_default },
	 { "RCU_BIF_CONFIG_DONE", 9, 9, &umr_bitfield_default },
	 { "PWRGOOD_VDDSOC", 16, 16, &umr_bitfield_default },
	 { "BACO_AUTO_EXIT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BACO_EXIT_TIME0[] = {
	 { "BACO_EXIT_PXEN_CLR_TIMER", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BACO_EXIT_TIMER1[] = {
	 { "BACO_EXIT_SIDEBAND_TIMER", 0, 19, &umr_bitfield_default },
	 { "BACO_HW_AUTO_FLUSH_EN", 24, 24, &umr_bitfield_default },
	 { "BACO_HW_EXIT_DIS", 26, 26, &umr_bitfield_default },
	 { "PX_EN_OE_IN_PX_EN_HIGH", 27, 27, &umr_bitfield_default },
	 { "PX_EN_OE_IN_PX_EN_LOW", 28, 28, &umr_bitfield_default },
	 { "BACO_MODE_SEL", 29, 30, &umr_bitfield_default },
	 { "AUTO_BACO_EXIT_CLR_BY_HW_DIS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BACO_EXIT_TIMER2[] = {
	 { "BACO_EXIT_LCLK_BAK_TIMER", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BACO_EXIT_TIMER3[] = {
	 { "BACO_EXIT_DUMMY_EN_CLR_TIMER", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BACO_EXIT_TIMER4[] = {
	 { "BACO_EXIT_BACO_EN_CLR_TIMER", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmMEM_TYPE_CNTL[] = {
	 { "BF_MEM_PHY_G5_G3", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_CNTL[] = {
	 { "LUT_ENABLE", 0, 0, &umr_bitfield_default },
	 { "MSI_ADDR_MODE", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_0[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_1[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_2[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_3[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_4[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_5[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_6[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_7[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_8[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_9[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_10[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_11[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_12[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_13[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_14[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmNBIF_GFX_ADDR_LUT_15[] = {
	 { "ADDR", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmREMAP_HDP_MEM_FLUSH_CNTL[] = {
	 { "ADDRESS", 2, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmREMAP_HDP_REG_FLUSH_CNTL[] = {
	 { "ADDRESS", 2, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_CNTL[] = {
	 { "RB_ENABLE", 0, 0, &umr_bitfield_default },
	 { "RB_SIZE", 1, 5, &umr_bitfield_default },
	 { "WPTR_WRITEBACK_ENABLE", 8, 8, &umr_bitfield_default },
	 { "WPTR_WRITEBACK_TIMER", 9, 13, &umr_bitfield_default },
	 { "BIF_RB_TRAN", 17, 17, &umr_bitfield_default },
	 { "RB_INTR_FIX_PRIORITY", 26, 28, &umr_bitfield_default },
	 { "RB_INTR_ARB_MODE", 29, 29, &umr_bitfield_default },
	 { "RB_RST_BY_FLR_DISABLE", 30, 30, &umr_bitfield_default },
	 { "WPTR_OVERFLOW_CLEAR", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_BASE[] = {
	 { "ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_RPTR[] = {
	 { "OFFSET", 2, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_WPTR[] = {
	 { "BIF_RB_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "OFFSET", 2, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_WPTR_ADDR_HI[] = {
	 { "ADDR", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_RB_WPTR_ADDR_LO[] = {
	 { "ADDR", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMAILBOX_INDEX[] = {
	 { "MAILBOX_INDEX", 0, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_MP1_INTR_CTRL[] = {
	 { "BACO_EXIT_DONE", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_UVD_GPUIOV_CFG_SIZE[] = {
	 { "UVD_GPUIOV_CFG_SIZE", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_VCE_GPUIOV_CFG_SIZE[] = {
	 { "VCE_GPUIOV_CFG_SIZE", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_GFX_SDMA_GPUIOV_CFG_SIZE[] = {
	 { "GFX_SDMA_GPUIOV_CFG_SIZE", 0, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_PERSTB_PAD_CNTL[] = {
	 { "PERSTB_PAD_CNTL", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_PX_EN_PAD_CNTL[] = {
	 { "PX_EN_PAD_CNTL", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_REFPADKIN_PAD_CNTL[] = {
	 { "REFPADKIN_PAD_CNTL", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_CLKREQB_PAD_CNTL[] = {
	 { "CLKREQB_PAD_CNTL", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_PWRBRK_PAD_CNTL[] = {
	 { "PWRBRK_PAD_CNTL", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_WAKEB_PAD_CNTL[] = {
	 { "GPIO33_ITXIMPSEL", 0, 0, &umr_bitfield_default },
	 { "GPIO33_ICTFEN", 1, 1, &umr_bitfield_default },
	 { "GPIO33_IPD", 2, 2, &umr_bitfield_default },
	 { "GPIO33_IPU", 3, 3, &umr_bitfield_default },
	 { "GPIO33_IRXEN", 4, 4, &umr_bitfield_default },
	 { "GPIO33_IRXSEL0", 5, 5, &umr_bitfield_default },
	 { "GPIO33_IRXSEL1", 6, 6, &umr_bitfield_default },
	 { "GPIO33_RESERVED", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_VAUX_PRESENT_PAD_CNTL[] = {
	 { "GPIO_IPD", 0, 0, &umr_bitfield_default },
	 { "GPIO_IPU", 1, 1, &umr_bitfield_default },
	 { "GPIO_IRXEN", 2, 2, &umr_bitfield_default },
	 { "GPIO_IRXSEL0", 3, 3, &umr_bitfield_default },
	 { "GPIO_IRXSEL1", 4, 4, &umr_bitfield_default },
	 { "GPIO_ITXIMPSEL", 5, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_PF_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL_CL0[] = {
	 { "NSNOOP_MAP", 0, 1, &umr_bitfield_default },
	 { "REQPASSPW_VC0_MAP", 2, 3, &umr_bitfield_default },
	 { "REQPASSPW_NVC0_MAP", 4, 5, &umr_bitfield_default },
	 { "REQRSPPASSPW_VC0_MAP", 6, 7, &umr_bitfield_default },
	 { "REQRSPPASSPW_NVC0_MAP", 8, 9, &umr_bitfield_default },
	 { "BLKLVL_MAP", 10, 11, &umr_bitfield_default },
	 { "DATERR_MAP", 12, 13, &umr_bitfield_default },
	 { "EXOKAY_WR_MAP", 14, 15, &umr_bitfield_default },
	 { "EXOKAY_RD_MAP", 16, 17, &umr_bitfield_default },
	 { "RESP_WR_MAP", 18, 19, &umr_bitfield_default },
	 { "RESP_RD_MAP", 20, 21, &umr_bitfield_default },
	 { "RDRSP_ERRMAP", 22, 23, &umr_bitfield_default },
	 { "RDRSP_SEL_MODE", 24, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL_CL1[] = {
	 { "NSNOOP_MAP", 0, 1, &umr_bitfield_default },
	 { "REQPASSPW_VC0_MAP", 2, 3, &umr_bitfield_default },
	 { "REQPASSPW_NVC0_MAP", 4, 5, &umr_bitfield_default },
	 { "REQRSPPASSPW_VC0_MAP", 6, 7, &umr_bitfield_default },
	 { "REQRSPPASSPW_NVC0_MAP", 8, 9, &umr_bitfield_default },
	 { "BLKLVL_MAP", 10, 11, &umr_bitfield_default },
	 { "DATERR_MAP", 12, 13, &umr_bitfield_default },
	 { "EXOKAY_WR_MAP", 14, 15, &umr_bitfield_default },
	 { "EXOKAY_RD_MAP", 16, 17, &umr_bitfield_default },
	 { "RESP_WR_MAP", 18, 19, &umr_bitfield_default },
	 { "RESP_RD_MAP", 20, 21, &umr_bitfield_default },
	 { "RDRSP_ERRMAP", 22, 23, &umr_bitfield_default },
	 { "RDRSP_SEL_MODE", 24, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL3_CL0[] = {
	 { "FORCE_WR_PH", 0, 1, &umr_bitfield_default },
	 { "FORCE_WR_STEERING", 2, 2, &umr_bitfield_default },
	 { "WR_ST_TAG_MODE", 3, 3, &umr_bitfield_default },
	 { "FORCE_WR_ST_ENTRY", 4, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL3_CL1[] = {
	 { "FORCE_WR_PH", 0, 1, &umr_bitfield_default },
	 { "FORCE_WR_STEERING", 2, 2, &umr_bitfield_default },
	 { "WR_ST_TAG_MODE", 3, 3, &umr_bitfield_default },
	 { "FORCE_WR_ST_ENTRY", 4, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL_SW0[] = {
	 { "SDP_WR_CHAIN_DIS", 9, 9, &umr_bitfield_default },
	 { "WRR_RD_WEIGHT", 16, 23, &umr_bitfield_default },
	 { "WRR_WR_WEIGHT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL_SW1[] = {
	 { "SDP_WR_CHAIN_DIS", 9, 9, &umr_bitfield_default },
	 { "WRR_RD_WEIGHT", 16, 23, &umr_bitfield_default },
	 { "WRR_WR_WEIGHT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CNTL_SW2[] = {
	 { "SDP_WR_CHAIN_DIS", 9, 9, &umr_bitfield_default },
	 { "WRR_RD_WEIGHT", 16, 23, &umr_bitfield_default },
	 { "WRR_WR_WEIGHT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_CPLBUF_ALLOC_CNTL[] = {
	 { "CPLBUF_RSVD_FOR_VC0_RD", 0, 3, &umr_bitfield_default },
	 { "CPLBUF_RSVD_FOR_VC5_RD", 20, 23, &umr_bitfield_default },
	 { "CPLBUF_RSVD_FOR_VC6_RD", 24, 27, &umr_bitfield_default },
	 { "CPLBUF_RSVD_FOR_VC7_RD", 28, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_TAG_ALLOC_0[] = {
	 { "TAG_ALLOC_FOR_VC0_WR", 0, 7, &umr_bitfield_default },
	 { "TAG_ALLOC_FOR_VC0_RD", 8, 15, &umr_bitfield_default },
	 { "TAG_ALLOC_FOR_VC1_WR", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_TAG_ALLOC_1[] = {
	 { "TAG_ALLOC_FOR_VC3_WR", 0, 7, &umr_bitfield_default },
	 { "TAG_ALLOC_FOR_VC7_WR", 16, 23, &umr_bitfield_default },
	 { "TAG_ALLOC_FOR_VC7_RD", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmA2S_MISC_CNTL[] = {
	 { "BLKLVL_FOR_MSG", 0, 1, &umr_bitfield_default },
	 { "RESERVE_2_CRED_FOR_NPWR_REQ_DIS", 2, 2, &umr_bitfield_default },
	 { "WRR_ARB_MODE", 3, 3, &umr_bitfield_default },
	 { "FORCE_RSP_REORDER_EN", 4, 4, &umr_bitfield_default },
	 { "RSP_REORDER_DIS", 5, 5, &umr_bitfield_default },
	 { "WRRSP_ACCUM_SEL", 6, 6, &umr_bitfield_default },
	 { "WRRSP_TAGFIFO_CONT_RD_DIS", 7, 7, &umr_bitfield_default },
	 { "RDRSP_TAGFIFO_CONT_RD_DIS", 8, 8, &umr_bitfield_default },
	 { "RDRSP_STS_DATSTS_PRIORITY", 9, 9, &umr_bitfield_default },
	 { "INSERT_RD_ON_2ND_WDAT_EN", 10, 10, &umr_bitfield_default },
	 { "WR_TAG_SET_MIN", 16, 20, &umr_bitfield_default },
	 { "RD_TAG_SET_MIN", 21, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_SDP_PORT_CTRL[] = {
	 { "SDP_DISCON_HYSTERESIS", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmSHUB_REGS_IF_CTL[] = {
	 { "SHUB_REGS_DROP_NONPF_MMREGREQ_SETERR_DIS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_MGCG_CTRL[] = {
	 { "NGDC_MGCG_EN", 0, 0, &umr_bitfield_default },
	 { "NGDC_MGCG_MODE", 1, 1, &umr_bitfield_default },
	 { "NGDC_MGCG_HYSTERESIS", 2, 9, &umr_bitfield_default },
	 { "NGDC_MGCG_HST_DIS", 10, 10, &umr_bitfield_default },
	 { "NGDC_MGCG_DMA_DIS", 11, 11, &umr_bitfield_default },
	 { "NGDC_MGCG_REG_DIS", 12, 12, &umr_bitfield_default },
	 { "NGDC_MGCG_AER_DIS", 13, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_RESERVED_0[] = {
	 { "RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_RESERVED_1[] = {
	 { "RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_SDP_PORT_CTRL_SOCCLK[] = {
	 { "SDP_DISCON_HYSTERESIS_SOCCLK", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_SDMA0_DOORBELL_RANGE[] = {
	 { "OFFSET", 2, 11, &umr_bitfield_default },
	 { "SIZE", 16, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_SDMA1_DOORBELL_RANGE[] = {
	 { "OFFSET", 2, 11, &umr_bitfield_default },
	 { "SIZE", 16, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_IH_DOORBELL_RANGE[] = {
	 { "OFFSET", 2, 11, &umr_bitfield_default },
	 { "SIZE", 16, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_MMSCH0_DOORBELL_RANGE[] = {
	 { "OFFSET", 2, 11, &umr_bitfield_default },
	 { "SIZE", 16, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_ACV_DOORBELL_RANGE[] = {
	 { "OFFSET", 2, 11, &umr_bitfield_default },
	 { "SIZE", 16, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_DOORBELL_FENCE_CNTL[] = {
	 { "DOORBELL_FENCE_CP_ENABLE", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_FENCE_SDMA0_ENABLE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_FENCE_SDMA1_ENABLE", 2, 2, &umr_bitfield_default },
	 { "DOORBELL_FENCE_ACV_ENABLE", 3, 3, &umr_bitfield_default },
	 { "DOORBELL_FENCE_ONCE_TRIGGER_DIS", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmS2A_MISC_CNTL[] = {
	 { "DOORBELL_64BIT_SUPPORT_SDMA0_DIS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_64BIT_SUPPORT_SDMA1_DIS", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_64BIT_SUPPORT_CP_DIS", 2, 2, &umr_bitfield_default },
	 { "AXI_HST_CPL_EP_DIS", 3, 3, &umr_bitfield_default },
	 { "DOORBELL_64BIT_SUPPORT_ACV_DIS", 4, 4, &umr_bitfield_default },
	 { "ATM_ARB_MODE", 8, 9, &umr_bitfield_default },
	 { "RB_ARB_MODE", 10, 11, &umr_bitfield_default },
	 { "HSTR_ARB_MODE", 12, 13, &umr_bitfield_default },
	 { "WRSP_ARB_MODE", 16, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_PG_MISC_CTRL[] = {
	 { "NGDC_PG_ENDP_D3_ONLY", 10, 10, &umr_bitfield_default },
	 { "NGDC_PG_EARLY_WAKEUP_BY_CLIENT_ACTIVE", 11, 11, &umr_bitfield_default },
	 { "NGDC_PG_EARLY_WAKEUP_BY_CLIENT_DS_EXIT", 12, 12, &umr_bitfield_default },
	 { "NGDC_PG_CLK_PERM", 13, 13, &umr_bitfield_default },
	 { "NGDC_PG_DS_ALLOW_DIS", 14, 14, &umr_bitfield_default },
	 { "NGDC_PG_EARLY_WAKEUP_ALLOW_AER_ACTIVE", 15, 15, &umr_bitfield_default },
	 { "NGDC_CFG_REFCLK_CYCLE_FOR_200NS", 24, 29, &umr_bitfield_default },
	 { "NGDC_CFG_PG_EXIT_OVERRIDE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_PGMST_CTRL[] = {
	 { "NGDC_CFG_PG_HYSTERESIS", 0, 7, &umr_bitfield_default },
	 { "NGDC_CFG_PG_EN", 8, 8, &umr_bitfield_default },
	 { "NGDC_CFG_IDLENESS_COUNT_EN", 10, 13, &umr_bitfield_default },
	 { "NGDC_CFG_FW_PG_EXIT_EN", 14, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmNGDC_PGSLV_CTRL[] = {
	 { "NGDC_CFG_SHUBCLK_0_IDLE_HYSTERESIS", 0, 4, &umr_bitfield_default },
	 { "NGDC_CFG_SHUBCLK_1_IDLE_HYSTERESIS", 5, 9, &umr_bitfield_default },
	 { "NGDC_CFG_GDCCLK_IDLE_HYSTERESIS", 10, 14, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF0_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF0_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF1_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF1_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF2_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF2_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF3_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF3_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF4_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF4_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF5_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF5_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF6_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF6_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF7_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF7_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF8_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF8_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF9_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF9_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF10_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF10_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF11_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF11_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF12_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF12_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF13_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF13_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF14_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF14_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF15_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF15_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF16_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF16_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF17_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF17_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF18_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF18_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF19_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF19_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF20_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF20_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF21_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF21_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF22_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF22_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF23_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF23_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF24_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF24_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF25_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF25_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF26_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF26_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF27_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF27_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF28_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF28_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF29_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF29_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MM_INDEX[] = {
	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
	 { "MM_APER", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MM_DATA[] = {
	 { "MM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MM_INDEX_HI[] = {
	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_RCC_ERR_LOG[] = {
	 { "INVALID_REG_ACCESS_IN_SRIOV_STATUS", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_READ_ACCESS_STATUS", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_RCC_DOORBELL_APER_EN[] = {
	 { "BIF_DOORBELL_APER_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_RCC_CONFIG_MEMSIZE[] = {
	 { "CONFIG_MEMSIZE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_RCC_CONFIG_RESERVED[] = {
	 { "CONFIG_RESERVED", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_RCC_IOV_FUNC_IDENTIFIER[] = {
	 { "FUNC_IDENTIFIER", 0, 0, &umr_bitfield_default },
	 { "IOV_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_BIF_BME_STATUS[] = {
	 { "DMA_ON_BME_LOW", 0, 0, &umr_bitfield_default },
	 { "CLEAR_DMA_ON_BME_LOW", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_BIF_ATOMIC_ERR_LOG[] = {
	 { "UR_ATOMIC_OPCODE", 0, 0, &umr_bitfield_default },
	 { "UR_ATOMIC_REQEN_LOW", 1, 1, &umr_bitfield_default },
	 { "UR_ATOMIC_LENGTH", 2, 2, &umr_bitfield_default },
	 { "UR_ATOMIC_NR", 3, 3, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_OPCODE", 16, 16, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_REQEN_LOW", 17, 17, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_LENGTH", 18, 18, &umr_bitfield_default },
	 { "CLEAR_UR_ATOMIC_NR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_DOORBELL_SELFRING_GPA_APER_BASE_HIGH[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_HIGH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_DOORBELL_SELFRING_GPA_APER_BASE_LOW[] = {
	 { "DOORBELL_SELFRING_GPA_APER_BASE_LOW", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_DOORBELL_SELFRING_GPA_APER_CNTL[] = {
	 { "DOORBELL_SELFRING_GPA_APER_EN", 0, 0, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_MODE", 1, 1, &umr_bitfield_default },
	 { "DOORBELL_SELFRING_GPA_APER_SIZE", 8, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_HDP_REG_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_REG_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_HDP_MEM_COHERENCY_FLUSH_CNTL[] = {
	 { "HDP_MEM_FLUSH_ADDR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_GPU_HDP_FLUSH_REQ[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_GPU_HDP_FLUSH_DONE[] = {
	 { "CP0", 0, 0, &umr_bitfield_default },
	 { "CP1", 1, 1, &umr_bitfield_default },
	 { "CP2", 2, 2, &umr_bitfield_default },
	 { "CP3", 3, 3, &umr_bitfield_default },
	 { "CP4", 4, 4, &umr_bitfield_default },
	 { "CP5", 5, 5, &umr_bitfield_default },
	 { "CP6", 6, 6, &umr_bitfield_default },
	 { "CP7", 7, 7, &umr_bitfield_default },
	 { "CP8", 8, 8, &umr_bitfield_default },
	 { "CP9", 9, 9, &umr_bitfield_default },
	 { "SDMA0", 10, 10, &umr_bitfield_default },
	 { "SDMA1", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_BIF_TRANS_PENDING[] = {
	 { "BIF_MST_TRANS_PENDING", 0, 0, &umr_bitfield_default },
	 { "BIF_SLV_TRANS_PENDING", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_NBIF_GFX_ADDR_LUT_BYPASS[] = {
	 { "LUT_BYPASS", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_TRN_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_TRN_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_TRN_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_TRN_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_RCV_DW0[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_RCV_DW1[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_RCV_DW2[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_MSGBUF_RCV_DW3[] = {
	 { "MSGBUF_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_CONTROL[] = {
	 { "TRN_MSG_VALID", 0, 0, &umr_bitfield_default },
	 { "TRN_MSG_ACK", 1, 1, &umr_bitfield_default },
	 { "RCV_MSG_VALID", 8, 8, &umr_bitfield_default },
	 { "RCV_MSG_ACK", 9, 9, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_MAILBOX_INT_CNTL[] = {
	 { "VALID_INT_EN", 0, 0, &umr_bitfield_default },
	 { "ACK_INT_EN", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmBIF_BX_DEV0_EPF0_VF30_BIF_VMHV_MAILBOX[] = {
	 { "VMHV_MAILBOX_TRN_ACK_INTR_EN", 0, 0, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_VALID_INTR_EN", 1, 1, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_DATA", 8, 11, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_VALID", 15, 15, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_DATA", 16, 19, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_VALID", 23, 23, &umr_bitfield_default },
	 { "VMHV_MAILBOX_TRN_MSG_ACK", 24, 24, &umr_bitfield_default },
	 { "VMHV_MAILBOX_RCV_MSG_ACK", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT0_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT0_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT0_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT0_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT1_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT1_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT1_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT1_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT2_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT2_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT2_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT2_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT3_ADDR_LO[] = {
	 { "MSG_ADDR_LO", 2, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT3_ADDR_HI[] = {
	 { "MSG_ADDR_HI", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT3_MSG_DATA[] = {
	 { "MSG_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_VECT3_CONTROL[] = {
	 { "MASK_BIT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRCC_DEV0_EPF0_VF30_GFXMSIX_PBA[] = {
	 { "MSIX_PENDING_BITS_0", 0, 0, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_1", 1, 1, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_2", 2, 2, &umr_bitfield_default },
	 { "MSIX_PENDING_BITS_3", 3, 3, &umr_bitfield_default },
};
