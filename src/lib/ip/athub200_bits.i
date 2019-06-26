static struct umr_bitfield mmATC_ATS_CNTL[] = {
	 { "DISABLE_ATC", 0, 0, &umr_bitfield_default },
	 { "DISABLE_PRI", 1, 1, &umr_bitfield_default },
	 { "DISABLE_PASID", 2, 2, &umr_bitfield_default },
	 { "CREDITS_ATS_RPB", 8, 13, &umr_bitfield_default },
	 { "INVALIDATION_LOG_KEEP_ORDER", 20, 20, &umr_bitfield_default },
	 { "TRANS_LOG_KEEP_ORDER", 21, 21, &umr_bitfield_default },
	 { "TRANS_EXE_RETURN", 22, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_STATUS[] = {
	 { "BUSY", 0, 0, &umr_bitfield_default },
	 { "CRASHED", 1, 1, &umr_bitfield_default },
	 { "DEADLOCK_DETECTION", 2, 2, &umr_bitfield_default },
	 { "FLUSH_INVALIDATION_OUTSTANDING", 3, 5, &umr_bitfield_default },
	 { "NONFLUSH_INVALIDATION_OUTSTANDING", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_FAULT_CNTL[] = {
	 { "FAULT_REGISTER_LOG", 0, 8, &umr_bitfield_default },
	 { "FAULT_INTERRUPT_TABLE", 10, 18, &umr_bitfield_default },
	 { "FAULT_CRASH_TABLE", 20, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_FAULT_STATUS_INFO[] = {
	 { "FAULT_TYPE", 0, 8, &umr_bitfield_default },
	 { "VMID", 10, 14, &umr_bitfield_default },
	 { "EXTRA_INFO", 15, 15, &umr_bitfield_default },
	 { "EXTRA_INFO2", 16, 16, &umr_bitfield_default },
	 { "INVALIDATION", 17, 17, &umr_bitfield_default },
	 { "PAGE_REQUEST", 18, 18, &umr_bitfield_default },
	 { "STATUS", 19, 23, &umr_bitfield_default },
	 { "PAGE_ADDR_HIGH", 24, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_FAULT_STATUS_ADDR[] = {
	 { "PAGE_ADDR", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_DEFAULT_PAGE_LOW[] = {
	 { "DEFAULT_PAGE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_TRANS_FAULT_RSPCNTRL[] = {
	 { "VMID0", 0, 0, &umr_bitfield_default },
	 { "VMID1", 1, 1, &umr_bitfield_default },
	 { "VMID2", 2, 2, &umr_bitfield_default },
	 { "VMID3", 3, 3, &umr_bitfield_default },
	 { "VMID4", 4, 4, &umr_bitfield_default },
	 { "VMID5", 5, 5, &umr_bitfield_default },
	 { "VMID6", 6, 6, &umr_bitfield_default },
	 { "VMID7", 7, 7, &umr_bitfield_default },
	 { "VMID8", 8, 8, &umr_bitfield_default },
	 { "VMID9", 9, 9, &umr_bitfield_default },
	 { "VMID10", 10, 10, &umr_bitfield_default },
	 { "VMID11", 11, 11, &umr_bitfield_default },
	 { "VMID12", 12, 12, &umr_bitfield_default },
	 { "VMID13", 13, 13, &umr_bitfield_default },
	 { "VMID14", 14, 14, &umr_bitfield_default },
	 { "VMID15", 15, 15, &umr_bitfield_default },
	 { "VMID16", 16, 16, &umr_bitfield_default },
	 { "VMID17", 17, 17, &umr_bitfield_default },
	 { "VMID18", 18, 18, &umr_bitfield_default },
	 { "VMID19", 19, 19, &umr_bitfield_default },
	 { "VMID20", 20, 20, &umr_bitfield_default },
	 { "VMID21", 21, 21, &umr_bitfield_default },
	 { "VMID22", 22, 22, &umr_bitfield_default },
	 { "VMID23", 23, 23, &umr_bitfield_default },
	 { "VMID24", 24, 24, &umr_bitfield_default },
	 { "VMID25", 25, 25, &umr_bitfield_default },
	 { "VMID26", 26, 26, &umr_bitfield_default },
	 { "VMID27", 27, 27, &umr_bitfield_default },
	 { "VMID28", 28, 28, &umr_bitfield_default },
	 { "VMID29", 29, 29, &umr_bitfield_default },
	 { "VMID30", 30, 30, &umr_bitfield_default },
	 { "VMID31", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_FAULT_STATUS_INFO2[] = {
	 { "VF", 0, 0, &umr_bitfield_default },
	 { "VFID", 1, 5, &umr_bitfield_default },
	 { "MMHUB_INV_VMID", 9, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_MISC_CNTL[] = {
	 { "CG_OFFDLY", 6, 11, &umr_bitfield_default },
	 { "CG_ENABLE", 18, 18, &umr_bitfield_default },
	 { "CG_MEM_LS_ENABLE", 19, 19, &umr_bitfield_default },
	 { "PG_ENABLE", 20, 20, &umr_bitfield_default },
	 { "PG_OFFDLY", 21, 26, &umr_bitfield_default },
	 { "CG_STATUS", 27, 27, &umr_bitfield_default },
	 { "PG_STATUS", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID_PASID_MAPPING_UPDATE_STATUS[] = {
	 { "VMID0_REMAPPING_FINISHED", 0, 0, &umr_bitfield_default },
	 { "VMID1_REMAPPING_FINISHED", 1, 1, &umr_bitfield_default },
	 { "VMID2_REMAPPING_FINISHED", 2, 2, &umr_bitfield_default },
	 { "VMID3_REMAPPING_FINISHED", 3, 3, &umr_bitfield_default },
	 { "VMID4_REMAPPING_FINISHED", 4, 4, &umr_bitfield_default },
	 { "VMID5_REMAPPING_FINISHED", 5, 5, &umr_bitfield_default },
	 { "VMID6_REMAPPING_FINISHED", 6, 6, &umr_bitfield_default },
	 { "VMID7_REMAPPING_FINISHED", 7, 7, &umr_bitfield_default },
	 { "VMID8_REMAPPING_FINISHED", 8, 8, &umr_bitfield_default },
	 { "VMID9_REMAPPING_FINISHED", 9, 9, &umr_bitfield_default },
	 { "VMID10_REMAPPING_FINISHED", 10, 10, &umr_bitfield_default },
	 { "VMID11_REMAPPING_FINISHED", 11, 11, &umr_bitfield_default },
	 { "VMID12_REMAPPING_FINISHED", 12, 12, &umr_bitfield_default },
	 { "VMID13_REMAPPING_FINISHED", 13, 13, &umr_bitfield_default },
	 { "VMID14_REMAPPING_FINISHED", 14, 14, &umr_bitfield_default },
	 { "VMID15_REMAPPING_FINISHED", 15, 15, &umr_bitfield_default },
	 { "VMID16_REMAPPING_FINISHED", 16, 16, &umr_bitfield_default },
	 { "VMID17_REMAPPING_FINISHED", 17, 17, &umr_bitfield_default },
	 { "VMID18_REMAPPING_FINISHED", 18, 18, &umr_bitfield_default },
	 { "VMID19_REMAPPING_FINISHED", 19, 19, &umr_bitfield_default },
	 { "VMID20_REMAPPING_FINISHED", 20, 20, &umr_bitfield_default },
	 { "VMID21_REMAPPING_FINISHED", 21, 21, &umr_bitfield_default },
	 { "VMID22_REMAPPING_FINISHED", 22, 22, &umr_bitfield_default },
	 { "VMID23_REMAPPING_FINISHED", 23, 23, &umr_bitfield_default },
	 { "VMID24_REMAPPING_FINISHED", 24, 24, &umr_bitfield_default },
	 { "VMID25_REMAPPING_FINISHED", 25, 25, &umr_bitfield_default },
	 { "VMID26_REMAPPING_FINISHED", 26, 26, &umr_bitfield_default },
	 { "VMID27_REMAPPING_FINISHED", 27, 27, &umr_bitfield_default },
	 { "VMID28_REMAPPING_FINISHED", 28, 28, &umr_bitfield_default },
	 { "VMID29_REMAPPING_FINISHED", 29, 29, &umr_bitfield_default },
	 { "VMID30_REMAPPING_FINISHED", 30, 30, &umr_bitfield_default },
	 { "VMID31_REMAPPING_FINISHED", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID0_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID1_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID2_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID3_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID4_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID5_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID6_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID7_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID8_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID9_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID10_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID11_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID12_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID13_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID14_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID15_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_VMID_STATUS[] = {
	 { "VMID0_OUTSTANDING", 0, 0, &umr_bitfield_default },
	 { "VMID1_OUTSTANDING", 1, 1, &umr_bitfield_default },
	 { "VMID2_OUTSTANDING", 2, 2, &umr_bitfield_default },
	 { "VMID3_OUTSTANDING", 3, 3, &umr_bitfield_default },
	 { "VMID4_OUTSTANDING", 4, 4, &umr_bitfield_default },
	 { "VMID5_OUTSTANDING", 5, 5, &umr_bitfield_default },
	 { "VMID6_OUTSTANDING", 6, 6, &umr_bitfield_default },
	 { "VMID7_OUTSTANDING", 7, 7, &umr_bitfield_default },
	 { "VMID8_OUTSTANDING", 8, 8, &umr_bitfield_default },
	 { "VMID9_OUTSTANDING", 9, 9, &umr_bitfield_default },
	 { "VMID10_OUTSTANDING", 10, 10, &umr_bitfield_default },
	 { "VMID11_OUTSTANDING", 11, 11, &umr_bitfield_default },
	 { "VMID12_OUTSTANDING", 12, 12, &umr_bitfield_default },
	 { "VMID13_OUTSTANDING", 13, 13, &umr_bitfield_default },
	 { "VMID14_OUTSTANDING", 14, 14, &umr_bitfield_default },
	 { "VMID15_OUTSTANDING", 15, 15, &umr_bitfield_default },
	 { "VMID16_OUTSTANDING", 16, 16, &umr_bitfield_default },
	 { "VMID17_OUTSTANDING", 17, 17, &umr_bitfield_default },
	 { "VMID18_OUTSTANDING", 18, 18, &umr_bitfield_default },
	 { "VMID19_OUTSTANDING", 19, 19, &umr_bitfield_default },
	 { "VMID20_OUTSTANDING", 20, 20, &umr_bitfield_default },
	 { "VMID21_OUTSTANDING", 21, 21, &umr_bitfield_default },
	 { "VMID22_OUTSTANDING", 22, 22, &umr_bitfield_default },
	 { "VMID23_OUTSTANDING", 23, 23, &umr_bitfield_default },
	 { "VMID24_OUTSTANDING", 24, 24, &umr_bitfield_default },
	 { "VMID25_OUTSTANDING", 25, 25, &umr_bitfield_default },
	 { "VMID26_OUTSTANDING", 26, 26, &umr_bitfield_default },
	 { "VMID27_OUTSTANDING", 27, 27, &umr_bitfield_default },
	 { "VMID28_OUTSTANDING", 28, 28, &umr_bitfield_default },
	 { "VMID29_OUTSTANDING", 29, 29, &umr_bitfield_default },
	 { "VMID30_OUTSTANDING", 30, 30, &umr_bitfield_default },
	 { "VMID31_OUTSTANDING", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_GFX_ATCL2_STATUS[] = {
	 { "POWERED_DOWN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER0_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER1_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER2_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER3_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER_RSLT_CNTL[] = {
	 { "PERF_COUNTER_SELECT", 0, 3, &umr_bitfield_default },
	 { "START_TRIGGER", 8, 15, &umr_bitfield_default },
	 { "STOP_TRIGGER", 16, 23, &umr_bitfield_default },
	 { "ENABLE_ANY", 24, 24, &umr_bitfield_default },
	 { "CLEAR_ALL", 25, 25, &umr_bitfield_default },
	 { "STOP_ALL_ON_SATURATE", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER_LO[] = {
	 { "COUNTER_LO", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_PERFCOUNTER_HI[] = {
	 { "COUNTER_HI", 0, 15, &umr_bitfield_default },
	 { "COMPARE_VALUE", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL[] = {
	 { "STU", 16, 20, &umr_bitfield_default },
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_PASID_CNTL[] = {
	 { "PASID_EN", 16, 16, &umr_bitfield_default },
	 { "PASID_EXE_PERMISSION_ENABLE", 17, 17, &umr_bitfield_default },
	 { "PASID_PRIV_MODE_SUPPORTED_ENABLE", 18, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_PAGE_REQ_CNTL[] = {
	 { "PRI_ENABLE", 0, 0, &umr_bitfield_default },
	 { "PRI_RESET", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_OUTSTAND_PAGE_REQ_ALLOC[] = {
	 { "OUTSTAND_PAGE_REQ_ALLOC", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_COMMAND[] = {
	 { "BUS_MASTER_EN", 2, 2, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_0[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_1[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_2[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_3[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_4[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_5[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_6[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_7[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_8[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_9[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_10[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_11[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_12[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_13[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_14[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_15[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_16[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_17[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_18[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_19[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_20[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_21[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_22[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_23[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_24[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_25[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_26[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_27[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_28[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_29[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_PCIE_ATS_CNTL_VF_30[] = {
	 { "ATC_ENABLE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_MEM_POWER_LS[] = {
	 { "LS_SETUP", 0, 5, &umr_bitfield_default },
	 { "LS_HOLD", 6, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmATS_IH_CREDIT[] = {
	 { "CREDIT_VALUE", 0, 1, &umr_bitfield_default },
	 { "IH_CLIENT_ID", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_IH_CREDIT[] = {
	 { "CREDIT_VALUE", 0, 1, &umr_bitfield_default },
	 { "IH_CLIENT_ID", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID16_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID17_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID18_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID19_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID20_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID21_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID22_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID23_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID24_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID25_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID26_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID27_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID28_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID29_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID30_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_VMID31_PASID_MAPPING[] = {
	 { "PASID", 0, 15, &umr_bitfield_default },
	 { "NO_INVALIDATION", 30, 30, &umr_bitfield_default },
	 { "VALID", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_MMHUB_ATCL2_STATUS[] = {
	 { "POWERED_DOWN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_SHARED_VIRT_RESET_REQ[] = {
	 { "VF", 0, 30, &umr_bitfield_default },
	 { "PF", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATHUB_SHARED_ACTIVE_FCN_ID[] = {
	 { "VFID", 0, 4, &umr_bitfield_default },
	 { "VF", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_SDPPORT_CNTL[] = {
	 { "ATS_INV_SELF_ACTIVATE", 0, 0, &umr_bitfield_default },
	 { "ATS_INV_CFG_MODE", 1, 2, &umr_bitfield_default },
	 { "ATS_INV_HALT_THRESHOLD", 3, 6, &umr_bitfield_default },
	 { "UTCL2_TRANS_SELF_ACTIVATE", 7, 7, &umr_bitfield_default },
	 { "UTCL2_TRANS_QUICK_COMACK", 8, 8, &umr_bitfield_default },
	 { "UTCL2_TRANS_HALT_THRESHOLD", 9, 12, &umr_bitfield_default },
	 { "UTCL2_TRANS_PASSIVE_MODE", 13, 13, &umr_bitfield_default },
	 { "UTCL2_GFX_RDY_MODE", 14, 14, &umr_bitfield_default },
	 { "UTCL2_MMHUB_RDY_MODE", 15, 15, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_RDRSPCKEN", 16, 16, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_RDRSPCKENRCV", 17, 17, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_RDRSPDATACKEN", 18, 18, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_RDRSPDATACKENRCV", 19, 19, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_WRRSPCKEN", 20, 20, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_WRRSPCKENRCV", 21, 21, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_REQCKEN", 22, 22, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_REQCKENRCV", 23, 23, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_ORIGDATACKEN", 24, 24, &umr_bitfield_default },
	 { "UTCL2_GFX_SDPVDCI_ORIGDATACKENRCV", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_VMID_SNAPSHOT_GFX_STAT[] = {
	 { "VMID0", 0, 0, &umr_bitfield_default },
	 { "VMID1", 1, 1, &umr_bitfield_default },
	 { "VMID2", 2, 2, &umr_bitfield_default },
	 { "VMID3", 3, 3, &umr_bitfield_default },
	 { "VMID4", 4, 4, &umr_bitfield_default },
	 { "VMID5", 5, 5, &umr_bitfield_default },
	 { "VMID6", 6, 6, &umr_bitfield_default },
	 { "VMID7", 7, 7, &umr_bitfield_default },
	 { "VMID8", 8, 8, &umr_bitfield_default },
	 { "VMID9", 9, 9, &umr_bitfield_default },
	 { "VMID10", 10, 10, &umr_bitfield_default },
	 { "VMID11", 11, 11, &umr_bitfield_default },
	 { "VMID12", 12, 12, &umr_bitfield_default },
	 { "VMID13", 13, 13, &umr_bitfield_default },
	 { "VMID14", 14, 14, &umr_bitfield_default },
	 { "VMID15", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmATC_ATS_VMID_SNAPSHOT_MMHUB_STAT[] = {
	 { "VMID0", 0, 0, &umr_bitfield_default },
	 { "VMID1", 1, 1, &umr_bitfield_default },
	 { "VMID2", 2, 2, &umr_bitfield_default },
	 { "VMID3", 3, 3, &umr_bitfield_default },
	 { "VMID4", 4, 4, &umr_bitfield_default },
	 { "VMID5", 5, 5, &umr_bitfield_default },
	 { "VMID6", 6, 6, &umr_bitfield_default },
	 { "VMID7", 7, 7, &umr_bitfield_default },
	 { "VMID8", 8, 8, &umr_bitfield_default },
	 { "VMID9", 9, 9, &umr_bitfield_default },
	 { "VMID10", 10, 10, &umr_bitfield_default },
	 { "VMID11", 11, 11, &umr_bitfield_default },
	 { "VMID12", 12, 12, &umr_bitfield_default },
	 { "VMID13", 13, 13, &umr_bitfield_default },
	 { "VMID14", 14, 14, &umr_bitfield_default },
	 { "VMID15", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR0[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR1[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR2[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR3[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR4[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR5[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR6[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR7[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR8[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_SRC_APRTR9[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_SRC_APRTR0[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_SRC_APRTR1[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_SRC_APRTR2[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_SRC_APRTR3[] = {
	 { "BASE_ADDR", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP0[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP1[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP2[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP3[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP4[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP5[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP6[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP7[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP8[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_RTR_DEST_MAP9[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_DEST_MAP0[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_DEST_MAP1[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_DEST_MAP2[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_RTR_DEST_MAP3[] = {
	 { "NMR", 0, 0, &umr_bitfield_default },
	 { "DEST_OFFSET", 1, 19, &umr_bitfield_default },
	 { "DEST_SEL", 20, 23, &umr_bitfield_default },
	 { "DEST_SEL_RPB", 24, 24, &umr_bitfield_default },
	 { "SIDE_OK", 25, 25, &umr_bitfield_default },
	 { "APRTR_SIZE", 26, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG0[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG1[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG2[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG3[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG4[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG5[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG6[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_CFG7[] = {
	 { "WCB_NUM", 0, 3, &umr_bitfield_default },
	 { "LB_TYPE", 4, 6, &umr_bitfield_default },
	 { "P2P_BAR", 7, 9, &umr_bitfield_default },
	 { "HOST_FLUSH", 10, 13, &umr_bitfield_default },
	 { "SIDE_FLUSH", 14, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_EXTRA[] = {
	 { "CMP0_HIGH", 0, 5, &umr_bitfield_default },
	 { "CMP0_LOW", 6, 10, &umr_bitfield_default },
	 { "VLD0", 11, 11, &umr_bitfield_default },
	 { "CLG0_NUM", 12, 14, &umr_bitfield_default },
	 { "CMP1_HIGH", 15, 20, &umr_bitfield_default },
	 { "CMP1_LOW", 21, 25, &umr_bitfield_default },
	 { "VLD1", 26, 26, &umr_bitfield_default },
	 { "CLG1_NUM", 27, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_EXTRA_MSK[] = {
	 { "MSK0_HIGH", 0, 5, &umr_bitfield_default },
	 { "MSK0_LOW", 6, 10, &umr_bitfield_default },
	 { "MSK1_HIGH", 11, 16, &umr_bitfield_default },
	 { "MSK1_LOW", 17, 21, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_LB_ADDR[] = {
	 { "CMP0", 0, 9, &umr_bitfield_default },
	 { "MASK0", 10, 19, &umr_bitfield_default },
	 { "CMP1", 20, 25, &umr_bitfield_default },
	 { "MASK1", 26, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_WCB_STS[] = {
	 { "PBUF_VLD", 0, 15, &umr_bitfield_default },
	 { "WCB_HST_DATA_BUF_CNT", 16, 22, &umr_bitfield_default },
	 { "WCB_SID_DATA_BUF_CNT", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_HST_CFG[] = {
	 { "BAR_UP_WR_CMD", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR_CFG[] = {
	 { "ADDR_SIZE", 0, 3, &umr_bitfield_default },
	 { "SEND_BAR", 4, 5, &umr_bitfield_default },
	 { "SNOOP", 6, 6, &umr_bitfield_default },
	 { "SEND_DIS", 7, 7, &umr_bitfield_default },
	 { "COMPRESS_DIS", 8, 8, &umr_bitfield_default },
	 { "UPDATE_DIS", 9, 9, &umr_bitfield_default },
	 { "REGBAR_FROM_SYSBAR", 10, 10, &umr_bitfield_default },
	 { "RD_EN", 11, 11, &umr_bitfield_default },
	 { "ATC_TRANSLATED", 12, 12, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR0[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR1[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR2[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR3[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR4[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR5[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR6[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR7[] = {
	 { "HOST_FLUSH", 0, 3, &umr_bitfield_default },
	 { "REG_SYS_BAR", 4, 7, &umr_bitfield_default },
	 { "MEM_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR_SETUP[] = {
	 { "SEL", 0, 7, &umr_bitfield_default },
	 { "REG_SYS_BAR", 8, 11, &umr_bitfield_default },
	 { "VALID", 12, 12, &umr_bitfield_default },
	 { "SEND_DIS", 13, 13, &umr_bitfield_default },
	 { "COMPRESS_DIS", 14, 14, &umr_bitfield_default },
	 { "RESERVED", 15, 15, &umr_bitfield_default },
	 { "ADDRESS", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR_DELTA_ABOVE[] = {
	 { "EN", 0, 7, &umr_bitfield_default },
	 { "DELTA", 8, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_P2P_BAR_DELTA_BELOW[] = {
	 { "EN", 0, 7, &umr_bitfield_default },
	 { "DELTA", 8, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR0[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR1[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR2[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR3[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR4[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR5[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR6[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR7[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR8[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PEER_SYS_BAR9[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_PEER_SYS_BAR0[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_PEER_SYS_BAR1[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_PEER_SYS_BAR2[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_XDMA_PEER_SYS_BAR3[] = {
	 { "VALID", 0, 0, &umr_bitfield_default },
	 { "ADDR", 1, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLK_GAT[] = {
	 { "ONDLY", 0, 5, &umr_bitfield_default },
	 { "OFFDLY", 6, 11, &umr_bitfield_default },
	 { "RDYDLY", 12, 17, &umr_bitfield_default },
	 { "ENABLE", 18, 18, &umr_bitfield_default },
	 { "MEM_LS_ENABLE", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_INTF_CFG[] = {
	 { "RPB_WRREQ_CRD", 0, 7, &umr_bitfield_default },
	 { "MC_WRRET_ASK", 8, 15, &umr_bitfield_default },
	 { "XSP_REQ_CRD", 16, 22, &umr_bitfield_default },
	 { "BIF_REG_SNOOP_SEL", 23, 23, &umr_bitfield_default },
	 { "BIF_REG_SNOOP_VAL", 24, 24, &umr_bitfield_default },
	 { "BIF_MEM_SNOOP_SEL", 25, 25, &umr_bitfield_default },
	 { "BIF_MEM_SNOOP_VAL", 26, 26, &umr_bitfield_default },
	 { "XSP_SNOOP_SEL", 27, 28, &umr_bitfield_default },
	 { "XSP_SNOOP_VAL", 29, 29, &umr_bitfield_default },
	 { "XSP_ORDERING_SEL", 30, 30, &umr_bitfield_default },
	 { "XSP_ORDERING_VAL", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_INTF_STS[] = {
	 { "RPB_WRREQ_CRD", 0, 7, &umr_bitfield_default },
	 { "XSP_REQ_CRD", 8, 14, &umr_bitfield_default },
	 { "HOP_DATA_BUF_FULL", 15, 15, &umr_bitfield_default },
	 { "HOP_ATTR_BUF_FULL", 16, 16, &umr_bitfield_default },
	 { "CNS_BUF_FULL", 17, 17, &umr_bitfield_default },
	 { "CNS_BUF_BUSY", 18, 18, &umr_bitfield_default },
	 { "RPB_RDREQ_CRD", 19, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PIPE_STS[] = {
	 { "WCB_ANY_PBUF", 0, 0, &umr_bitfield_default },
	 { "WCB_HST_DATA_BUF_CNT", 1, 7, &umr_bitfield_default },
	 { "WCB_SID_DATA_BUF_CNT", 8, 14, &umr_bitfield_default },
	 { "WCB_HST_RD_PTR_BUF_FULL", 15, 15, &umr_bitfield_default },
	 { "WCB_SID_RD_PTR_BUF_FULL", 16, 16, &umr_bitfield_default },
	 { "WCB_HST_REQ_FIFO_FULL", 17, 17, &umr_bitfield_default },
	 { "WCB_SID_REQ_FIFO_FULL", 18, 18, &umr_bitfield_default },
	 { "WCB_HST_REQ_OBUF_FULL", 19, 19, &umr_bitfield_default },
	 { "WCB_SID_REQ_OBUF_FULL", 20, 20, &umr_bitfield_default },
	 { "WCB_HST_DATA_OBUF_FULL", 21, 21, &umr_bitfield_default },
	 { "WCB_SID_DATA_OBUF_FULL", 22, 22, &umr_bitfield_default },
	 { "RET_BUF_FULL", 23, 23, &umr_bitfield_default },
	 { "XPB_CLK_BUSY_BITS", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_SUB_CTRL[] = {
	 { "WRREQ_BYPASS_XPB", 0, 0, &umr_bitfield_default },
	 { "STALL_CNS_RTR_REQ", 1, 1, &umr_bitfield_default },
	 { "STALL_RTR_RPB_WRREQ", 2, 2, &umr_bitfield_default },
	 { "STALL_RTR_MAP_REQ", 3, 3, &umr_bitfield_default },
	 { "STALL_MAP_WCB_REQ", 4, 4, &umr_bitfield_default },
	 { "STALL_WCB_SID_REQ", 5, 5, &umr_bitfield_default },
	 { "STALL_MC_XSP_REQ_SEND", 6, 6, &umr_bitfield_default },
	 { "STALL_WCB_HST_REQ", 7, 7, &umr_bitfield_default },
	 { "STALL_HST_HOP_REQ", 8, 8, &umr_bitfield_default },
	 { "STALL_XPB_RPB_REQ_ATTR", 9, 9, &umr_bitfield_default },
	 { "RESET_CNS", 10, 10, &umr_bitfield_default },
	 { "RESET_RTR", 11, 11, &umr_bitfield_default },
	 { "RESET_RET", 12, 12, &umr_bitfield_default },
	 { "RESET_MAP", 13, 13, &umr_bitfield_default },
	 { "RESET_WCB", 14, 14, &umr_bitfield_default },
	 { "RESET_HST", 15, 15, &umr_bitfield_default },
	 { "RESET_HOP", 16, 16, &umr_bitfield_default },
	 { "RESET_SID", 17, 17, &umr_bitfield_default },
	 { "RESET_SRB", 18, 18, &umr_bitfield_default },
	 { "RESET_CGR", 19, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_MAP_INVERT_FLUSH_NUM_LSB[] = {
	 { "ALTER_FLUSH_NUM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_PERF_KNOBS[] = {
	 { "CNS_FIFO_DEPTH", 0, 5, &umr_bitfield_default },
	 { "WCB_HST_FIFO_DEPTH", 6, 11, &umr_bitfield_default },
	 { "WCB_SID_FIFO_DEPTH", 12, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_STICKY[] = {
	 { "BITS", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_STICKY_W1C[] = {
	 { "BITS", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_MISC_CFG[] = {
	 { "FIELDNAME0", 0, 7, &umr_bitfield_default },
	 { "FIELDNAME1", 8, 15, &umr_bitfield_default },
	 { "FIELDNAME2", 16, 23, &umr_bitfield_default },
	 { "FIELDNAME3", 24, 30, &umr_bitfield_default },
	 { "TRIGGERNAME", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_INTF_CFG2[] = {
	 { "RPB_RDREQ_CRD", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_EXTRA_RD[] = {
	 { "CMP0_HIGH", 0, 5, &umr_bitfield_default },
	 { "CMP0_LOW", 6, 10, &umr_bitfield_default },
	 { "VLD0", 11, 11, &umr_bitfield_default },
	 { "CLG0_NUM", 12, 14, &umr_bitfield_default },
	 { "CMP1_HIGH", 15, 20, &umr_bitfield_default },
	 { "CMP1_LOW", 21, 25, &umr_bitfield_default },
	 { "VLD1", 26, 26, &umr_bitfield_default },
	 { "CLG1_NUM", 27, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_EXTRA_MSK_RD[] = {
	 { "MSK0_HIGH", 0, 5, &umr_bitfield_default },
	 { "MSK0_LOW", 6, 10, &umr_bitfield_default },
	 { "MSK1_HIGH", 11, 16, &umr_bitfield_default },
	 { "MSK1_LOW", 17, 21, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_MATCH[] = {
	 { "FARBIRC0_ID", 0, 5, &umr_bitfield_default },
	 { "FARBIRC1_ID", 6, 11, &umr_bitfield_default },
	 { "FARBIRC2_ID", 12, 17, &umr_bitfield_default },
	 { "FARBIRC3_ID", 18, 23, &umr_bitfield_default },
	 { "FARBIRC0_VLD", 24, 24, &umr_bitfield_default },
	 { "FARBIRC1_VLD", 25, 25, &umr_bitfield_default },
	 { "FARBIRC2_VLD", 26, 26, &umr_bitfield_default },
	 { "FARBIRC3_VLD", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_MATCH_MSK[] = {
	 { "FARBIRC0_ID_MSK", 0, 5, &umr_bitfield_default },
	 { "FARBIRC1_ID_MSK", 6, 11, &umr_bitfield_default },
	 { "FARBIRC2_ID_MSK", 12, 17, &umr_bitfield_default },
	 { "FARBIRC3_ID_MSK", 18, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_MATCH[] = {
	 { "FARBIRC0_ID", 0, 5, &umr_bitfield_default },
	 { "FARBIRC1_ID", 6, 11, &umr_bitfield_default },
	 { "FARBIRC0_VLD", 12, 12, &umr_bitfield_default },
	 { "FARBIRC1_VLD", 13, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_MATCH_MSK[] = {
	 { "FARBIRC0_ID_MSK", 0, 5, &umr_bitfield_default },
	 { "FARBIRC1_ID_MSK", 6, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_MATCH[] = {
	 { "FARBIRC0_ID", 0, 5, &umr_bitfield_default },
	 { "FARBIRC0_VLD", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_MATCH_MSK[] = {
	 { "FARBIRC0_ID_MSK", 0, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING0[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING1[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING2[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING3[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING4[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING5[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING6[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GFX_UNITID_MAPPING7[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_UNITID_MAPPING0[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_UNITID_MAPPING1[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_UNITID_MAPPING2[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_MM_UNITID_MAPPING3[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING0[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING1[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING2[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING3[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING4[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING5[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING6[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmXPB_CLG_GUS_UNITID_MAPPING7[] = {
	 { "UNITID_LOW", 0, 4, &umr_bitfield_default },
	 { "UNITID_VLD", 5, 5, &umr_bitfield_default },
	 { "DEST_CLG_NUM", 6, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PASSPW_CONF[] = {
	 { "XPB_PASSPW_OVERRIDE", 0, 0, &umr_bitfield_default },
	 { "XPB_RSPPASSPW_OVERRIDE", 1, 1, &umr_bitfield_default },
	 { "ATC_TR_PASSPW_OVERRIDE", 2, 2, &umr_bitfield_default },
	 { "ATC_PAGE_PASSPW_OVERRIDE", 3, 3, &umr_bitfield_default },
	 { "WR_PASSPW_OVERRIDE", 4, 4, &umr_bitfield_default },
	 { "RD_PASSPW_OVERRIDE", 5, 5, &umr_bitfield_default },
	 { "WR_RSPPASSPW_OVERRIDE", 6, 6, &umr_bitfield_default },
	 { "RD_RSPPASSPW_OVERRIDE", 7, 7, &umr_bitfield_default },
	 { "ATC_RSPPASSPW_OVERRIDE", 8, 8, &umr_bitfield_default },
	 { "ATOMIC_PASSPW_OVERRIDE", 9, 9, &umr_bitfield_default },
	 { "ATOMIC_RSPPASSPW_OVERRIDE", 10, 10, &umr_bitfield_default },
	 { "ATC_TR_PASSPW_OVERRIDE_EN", 11, 11, &umr_bitfield_default },
	 { "ATC_PAGE_PASSPW_OVERRIDE_EN", 12, 12, &umr_bitfield_default },
	 { "ATC_RSPPASSPW_OVERRIDE_EN", 13, 13, &umr_bitfield_default },
	 { "WRRSP_PASSPW_OVERRIDE", 14, 14, &umr_bitfield_default },
	 { "WRRSP_PASSPW_OVERRIDE_EN", 15, 15, &umr_bitfield_default },
	 { "RDRSP_PASSPW_OVERRIDE", 16, 16, &umr_bitfield_default },
	 { "RDRSP_PASSPW_OVERRIDE_EN", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_BLOCKLEVEL_CONF[] = {
	 { "XPB_BLOCKLEVEL_OVERRIDE", 0, 1, &umr_bitfield_default },
	 { "ATC_TR_BLOCKLEVEL", 2, 3, &umr_bitfield_default },
	 { "ATC_PAGE_BLOCKLEVEL", 4, 5, &umr_bitfield_default },
	 { "ATC_INV_BLOCKLEVEL", 6, 7, &umr_bitfield_default },
	 { "IO_WR_BLOCKLEVEL_OVERRIDE", 8, 9, &umr_bitfield_default },
	 { "IO_RD_BLOCKLEVEL_OVERRIDE", 10, 11, &umr_bitfield_default },
	 { "ATOMIC_BLOCKLEVEL_OVERRIDE", 12, 13, &umr_bitfield_default },
	 { "XPB_BLOCKLEVEL_OVERRIDE_EN", 14, 14, &umr_bitfield_default },
	 { "IO_WR_BLOCKLEVEL_OVERRIDE_EN", 15, 15, &umr_bitfield_default },
	 { "IO_RD_BLOCKLEVEL_OVERRIDE_EN", 16, 16, &umr_bitfield_default },
	 { "ATOMIC_BLOCKLEVEL_OVERRIDE_EN", 17, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_TAG_CONF[] = {
	 { "RPB_ATS_TR", 0, 9, &umr_bitfield_default },
	 { "RPB_IO_WR", 10, 19, &umr_bitfield_default },
	 { "RPB_ATS_PR", 20, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_EFF_CNTL[] = {
	 { "WR_LAZY_TIMER", 0, 7, &umr_bitfield_default },
	 { "RD_LAZY_TIMER", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_ARB_CNTL[] = {
	 { "RD_SWITCH_NUM", 0, 7, &umr_bitfield_default },
	 { "WR_SWITCH_NUM", 8, 15, &umr_bitfield_default },
	 { "ATC_TR_SWITCH_NUM", 16, 23, &umr_bitfield_default },
	 { "ARB_MODE", 24, 24, &umr_bitfield_default },
	 { "SWITCH_NUM_MODE", 25, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_ARB_CNTL2[] = {
	 { "P2P_SWITCH_NUM", 0, 7, &umr_bitfield_default },
	 { "ATOMIC_SWITCH_NUM", 8, 15, &umr_bitfield_default },
	 { "ATC_PAGE_SWITCH_NUM", 16, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_BIF_CNTL[] = {
	 { "VC0_SWITCH_NUM", 0, 7, &umr_bitfield_default },
	 { "VC1_SWITCH_NUM", 8, 15, &umr_bitfield_default },
	 { "ARB_MODE", 16, 16, &umr_bitfield_default },
	 { "DRAIN_VC_NUM", 17, 17, &umr_bitfield_default },
	 { "SWITCH_ENABLE", 18, 18, &umr_bitfield_default },
	 { "SWITCH_THRESHOLD", 19, 26, &umr_bitfield_default },
	 { "PAGE_PRI_EN", 27, 27, &umr_bitfield_default },
	 { "TR_PRI_EN", 28, 28, &umr_bitfield_default },
	 { "VC0_CHAINED_OVERRIDE", 29, 29, &umr_bitfield_default },
	 { "PARITY_CHECK_EN", 30, 30, &umr_bitfield_default },
	 { "NBIF_DMA_ORIGCLKCTL_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_WR_SWITCH_CNTL[] = {
	 { "QUEUE0_SWITCH_NUM", 0, 6, &umr_bitfield_default },
	 { "QUEUE1_SWITCH_NUM", 7, 13, &umr_bitfield_default },
	 { "QUEUE2_SWITCH_NUM", 14, 20, &umr_bitfield_default },
	 { "QUEUE3_SWITCH_NUM", 21, 27, &umr_bitfield_default },
	 { "SWITCH_NUM_MODE", 28, 28, &umr_bitfield_default },
	 { "WORKLOAD_ADJUST_EN", 29, 29, &umr_bitfield_default },
	 { "WEIGHT_ADJUST_STEP", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_WR_COMBINE_CNTL[] = {
	 { "WC_MAX_PACKET_SIZE", 0, 1, &umr_bitfield_default },
	 { "WC_FLUSH_TIMER", 2, 5, &umr_bitfield_default },
	 { "WC_ALIGN", 6, 6, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_RD_SWITCH_CNTL[] = {
	 { "QUEUE0_SWITCH_NUM", 0, 6, &umr_bitfield_default },
	 { "QUEUE1_SWITCH_NUM", 7, 13, &umr_bitfield_default },
	 { "QUEUE2_SWITCH_NUM", 14, 20, &umr_bitfield_default },
	 { "QUEUE3_SWITCH_NUM", 21, 27, &umr_bitfield_default },
	 { "SWITCH_NUM_MODE", 28, 28, &umr_bitfield_default },
	 { "WORKLOAD_ADJUST_EN", 29, 29, &umr_bitfield_default },
	 { "WEIGHT_ADJUST_STEP", 30, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_CID_QUEUE_WR[] = {
	 { "CLIENT_ID_LOW", 0, 4, &umr_bitfield_default },
	 { "CLIENT_ID_HIGH", 5, 10, &umr_bitfield_default },
	 { "UPDATE_MODE", 11, 11, &umr_bitfield_default },
	 { "WRITE_QUEUE", 12, 14, &umr_bitfield_default },
	 { "READ_QUEUE", 15, 17, &umr_bitfield_default },
	 { "UPDATE", 18, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_CID_QUEUE_RD[] = {
	 { "CLIENT_ID_LOW", 0, 4, &umr_bitfield_default },
	 { "CLIENT_ID_HIGH", 5, 10, &umr_bitfield_default },
	 { "WRITE_QUEUE", 11, 13, &umr_bitfield_default },
	 { "READ_QUEUE", 14, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERF_COUNTER_CNTL[] = {
	 { "PERF_COUNTER_SELECT", 0, 1, &umr_bitfield_default },
	 { "CLEAR_SELECTED_PERF_COUNTER", 2, 2, &umr_bitfield_default },
	 { "CLEAR_ALL_PERF_COUNTERS", 3, 3, &umr_bitfield_default },
	 { "STOP_ON_COUNTER_SATURATION", 4, 4, &umr_bitfield_default },
	 { "ENABLE_PERF_COUNTERS", 5, 8, &umr_bitfield_default },
	 { "PERF_COUNTER_ASSIGN_0", 9, 13, &umr_bitfield_default },
	 { "PERF_COUNTER_ASSIGN_1", 14, 18, &umr_bitfield_default },
	 { "PERF_COUNTER_ASSIGN_2", 19, 23, &umr_bitfield_default },
	 { "PERF_COUNTER_ASSIGN_3", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERF_COUNTER_STATUS[] = {
	 { "PERFORMANCE_COUNTER_VALUE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_CID_QUEUE_EX[] = {
	 { "START", 0, 0, &umr_bitfield_default },
	 { "OFFSET", 1, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_CID_QUEUE_EX_DATA[] = {
	 { "WRITE_ENTRIES", 0, 15, &umr_bitfield_default },
	 { "READ_ENTRIES", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_SWITCH_CNTL2[] = {
	 { "RD_QUEUE4_SWITCH_NUM", 0, 6, &umr_bitfield_default },
	 { "RD_QUEUE5_SWITCH_NUM", 7, 13, &umr_bitfield_default },
	 { "WR_QUEUE4_SWITCH_NUM", 14, 20, &umr_bitfield_default },
	 { "WR_QUEUE5_SWITCH_NUM", 21, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_DEINTRLV_COMBINE_CNTL[] = {
	 { "WC_CHAINED_FLUSH_TIMER", 0, 3, &umr_bitfield_default },
	 { "WC_CHAINED_BREAK_EN", 4, 4, &umr_bitfield_default },
	 { "WC_HANDLE_CHECK_DISABLE", 5, 5, &umr_bitfield_default },
	 { "XPB_WRREQ_CRD", 6, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_VC_SWITCH_RDWR[] = {
	 { "MODE", 0, 1, &umr_bitfield_default },
	 { "NUM_RD", 2, 9, &umr_bitfield_default },
	 { "NUM_WR", 10, 17, &umr_bitfield_default },
	 { "XPB_RDREQ_CRD", 18, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER_LO[] = {
	 { "COUNTER_LO", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER_HI[] = {
	 { "COUNTER_HI", 0, 15, &umr_bitfield_default },
	 { "COMPARE_VALUE", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER0_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER1_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER2_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER3_CFG[] = {
	 { "PERF_SEL", 0, 7, &umr_bitfield_default },
	 { "PERF_SEL_END", 8, 15, &umr_bitfield_default },
	 { "PERF_MODE", 24, 27, &umr_bitfield_default },
	 { "ENABLE", 28, 28, &umr_bitfield_default },
	 { "CLEAR", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_PERFCOUNTER_RSLT_CNTL[] = {
	 { "PERF_COUNTER_SELECT", 0, 3, &umr_bitfield_default },
	 { "START_TRIGGER", 8, 15, &umr_bitfield_default },
	 { "STOP_TRIGGER", 16, 23, &umr_bitfield_default },
	 { "ENABLE_ANY", 24, 24, &umr_bitfield_default },
	 { "CLEAR_ALL", 25, 25, &umr_bitfield_default },
	 { "STOP_ALL_ON_SATURATE", 26, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_BIF_CNTL2[] = {
	 { "NBIF_HST_COMPCLKCTL_EN", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_RD_QUEUE_CNTL[] = {
	 { "ARB_MODE", 0, 0, &umr_bitfield_default },
	 { "Q4_SHARED", 1, 1, &umr_bitfield_default },
	 { "Q5_SHARED", 2, 2, &umr_bitfield_default },
	 { "Q4_UNITID_EA_MODE", 3, 3, &umr_bitfield_default },
	 { "Q5_UNITID_EA_MODE", 4, 4, &umr_bitfield_default },
	 { "Q4_PATTERN_LOW", 5, 9, &umr_bitfield_default },
	 { "Q4_PATTERN_HIGH", 10, 15, &umr_bitfield_default },
	 { "Q5_PATTERN_LOW", 16, 20, &umr_bitfield_default },
	 { "Q5_PATTERN_HIGH", 21, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_RD_QUEUE_CNTL2[] = {
	 { "Q4_PATTERN_MASK_LOW", 0, 4, &umr_bitfield_default },
	 { "Q4_PATTERN_MASK_HIGH", 5, 10, &umr_bitfield_default },
	 { "Q5_PATTERN_MASK_LOW", 11, 15, &umr_bitfield_default },
	 { "Q5_PATTERN_MASK_HIGH", 16, 21, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_WR_QUEUE_CNTL[] = {
	 { "ARB_MODE", 0, 0, &umr_bitfield_default },
	 { "Q4_SHARED", 1, 1, &umr_bitfield_default },
	 { "Q5_SHARED", 2, 2, &umr_bitfield_default },
	 { "Q4_UNITID_EA_MODE", 3, 3, &umr_bitfield_default },
	 { "Q5_UNITID_EA_MODE", 4, 4, &umr_bitfield_default },
	 { "Q4_PATTERN_LOW", 5, 9, &umr_bitfield_default },
	 { "Q4_PATTERN_HIGH", 10, 15, &umr_bitfield_default },
	 { "Q5_PATTERN_LOW", 16, 20, &umr_bitfield_default },
	 { "Q5_PATTERN_HIGH", 21, 26, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_WR_QUEUE_CNTL2[] = {
	 { "Q4_PATTERN_MASK_LOW", 0, 4, &umr_bitfield_default },
	 { "Q4_PATTERN_MASK_HIGH", 5, 10, &umr_bitfield_default },
	 { "Q5_PATTERN_MASK_LOW", 11, 15, &umr_bitfield_default },
	 { "Q5_PATTERN_MASK_HIGH", 16, 21, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_EA_QUEUE_WR[] = {
	 { "EA_NUMBER", 0, 4, &umr_bitfield_default },
	 { "WRITE_QUEUE", 5, 7, &umr_bitfield_default },
	 { "READ_QUEUE", 8, 10, &umr_bitfield_default },
	 { "UPDATE", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_ATS_CNTL[] = {
	 { "PAGE_MIN_LATENCY_ENABLE", 0, 0, &umr_bitfield_default },
	 { "TR_MIN_LATENCY_ENABLE", 1, 1, &umr_bitfield_default },
	 { "SWITCH_THRESHOLD", 2, 6, &umr_bitfield_default },
	 { "TIME_SLICE", 7, 14, &umr_bitfield_default },
	 { "ATCTR_SWITCH_NUM", 15, 18, &umr_bitfield_default },
	 { "ATCPAGE_SWITCH_NUM", 19, 22, &umr_bitfield_default },
	 { "WR_AT", 23, 24, &umr_bitfield_default },
	 { "INVAL_COM_CMD", 25, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_ATS_CNTL2[] = {
	 { "TRANS_CMD", 0, 5, &umr_bitfield_default },
	 { "PAGE_REQ_CMD", 6, 11, &umr_bitfield_default },
	 { "PAGE_ROUTING_CODE", 12, 14, &umr_bitfield_default },
	 { "INVAL_COM_ROUTING_CODE", 15, 17, &umr_bitfield_default },
	 { "VENDOR_ID", 18, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_DF_SDPPORT_CNTL[] = {
	 { "DF_REQ_CRD", 0, 5, &umr_bitfield_default },
	 { "DF_DATA_CRD", 6, 11, &umr_bitfield_default },
	 { "DF_HALT_THRESHOLD", 12, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_SDPPORT_CNTL[] = {
	 { "NBIF_DMA_SELF_ACTIVATE", 0, 0, &umr_bitfield_default },
	 { "NBIF_DMA_CFG_MODE", 1, 2, &umr_bitfield_default },
	 { "NBIF_DMA_ENABLE_REISSUE_CREDIT", 3, 3, &umr_bitfield_default },
	 { "NBIF_DMA_ENABLE_SATURATE_COUNTER", 4, 4, &umr_bitfield_default },
	 { "NBIF_DMA_ENABLE_DISRUPT_FULLDIS", 5, 5, &umr_bitfield_default },
	 { "NBIF_DMA_HALT_THRESHOLD", 6, 9, &umr_bitfield_default },
	 { "NBIF_HST_SELF_ACTIVATE", 10, 10, &umr_bitfield_default },
	 { "NBIF_HST_CFG_MODE", 11, 12, &umr_bitfield_default },
	 { "NBIF_HST_ENABLE_REISSUE_CREDIT", 13, 13, &umr_bitfield_default },
	 { "NBIF_HST_ENABLE_SATURATE_COUNTER", 14, 14, &umr_bitfield_default },
	 { "NBIF_HST_ENABLE_DISRUPT_FULLDIS", 15, 15, &umr_bitfield_default },
	 { "NBIF_HST_HALT_THRESHOLD", 16, 19, &umr_bitfield_default },
	 { "NBIF_HST_PASSIVE_MODE", 20, 20, &umr_bitfield_default },
	 { "NBIF_HST_QUICK_COMACK", 21, 21, &umr_bitfield_default },
	 { "DF_SDPVDCI_RDRSPCKEN", 22, 22, &umr_bitfield_default },
	 { "DF_SDPVDCI_RDRSPCKENRCV", 23, 23, &umr_bitfield_default },
	 { "DF_SDPVDCI_RDRSPDATACKEN", 24, 24, &umr_bitfield_default },
	 { "DF_SDPVDCI_RDRSPDATACKENRCV", 25, 25, &umr_bitfield_default },
	 { "DF_SDPVDCI_WRRSPCKEN", 26, 26, &umr_bitfield_default },
	 { "DF_SDPVDCI_WRRSPCKENRCV", 27, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmRPB_NBIF_SDPPORT_CNTL[] = {
	 { "NBIF_DMA_WRRSP_CRD", 0, 7, &umr_bitfield_default },
	 { "NBIF_DMA_RDRSP_CRD", 8, 15, &umr_bitfield_default },
	 { "NBIF_HST_REQ_CRD", 16, 23, &umr_bitfield_default },
	 { "NBIF_HST_DATA_CRD", 24, 31, &umr_bitfield_default },
};
