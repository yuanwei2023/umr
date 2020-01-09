static struct umr_bitfield mmUMCCH0_0_EccErrCntSel[] = {
	 { "EccErrCntCsSel", 0, 3, &umr_bitfield_default },
	 { "EccErrInt", 12, 13, &umr_bitfield_default },
	 { "EccErrCntEn", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUMCCH0_0_EccErrCnt[] = {
	 { "EccErrCnt", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMCA_UMC_UMC0_MCUMC_STATUST0[] = {
	 { "ErrorCode", 32, 31, &umr_bitfield_default },
	 { "ErrorCodeExt", 32, 31, &umr_bitfield_default },
	 { "RESERV0", 32, 31, &umr_bitfield_default },
	 { "ErrCoreId", 0, 5, &umr_bitfield_default },
	 { "RESERV1", 6, 7, &umr_bitfield_default },
	 { "Scrub", 8, 8, &umr_bitfield_default },
	 { "RESERV2", 9, 10, &umr_bitfield_default },
	 { "Poison", 11, 11, &umr_bitfield_default },
	 { "Deferred", 12, 12, &umr_bitfield_default },
	 { "UECC", 13, 13, &umr_bitfield_default },
	 { "CECC", 14, 14, &umr_bitfield_default },
	 { "RESERV3", 15, 19, &umr_bitfield_default },
	 { "Transparent", 20, 20, &umr_bitfield_default },
	 { "SyndV", 21, 21, &umr_bitfield_default },
	 { "RESERV4", 22, 22, &umr_bitfield_default },
	 { "TCC", 23, 23, &umr_bitfield_default },
	 { "ErrCoreIdVal", 24, 24, &umr_bitfield_default },
	 { "PCC", 25, 25, &umr_bitfield_default },
	 { "AddrV", 26, 26, &umr_bitfield_default },
	 { "MiscV", 27, 27, &umr_bitfield_default },
	 { "En", 28, 28, &umr_bitfield_default },
	 { "UC", 29, 29, &umr_bitfield_default },
	 { "Overflow", 30, 30, &umr_bitfield_default },
	 { "Val", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmMCA_UMC_UMC0_MCUMC_ADDRT0[] = {
	 { "ErrorAddr", 0, 23, &umr_bitfield_default },
	 { "LSB", 24, 29, &umr_bitfield_default },
	 { "Reserved", 30, 31, &umr_bitfield_default },
};
