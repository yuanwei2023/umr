static struct umr_bitfield mmUMCCH0_0_EccErrCntSel_ARCT[] = {
	 { "EccErrCntCsSel", 0, 3, &umr_bitfield_default },
	 { "EccErrInt", 12, 13, &umr_bitfield_default },
	 { "EccErrCntEn", 15, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmUMCCH0_0_EccErrCnt_ARCT[] = {
	 { "EccErrCnt", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT[] = {
	 { "ErrorCode", 0, 15, &umr_bitfield_default },
	 { "ErrorCodeExt", 16, 21, &umr_bitfield_default },
	 { "RESERV0", 22, 31, &umr_bitfield_default },
	 { "ErrCoreId", 32, 37, &umr_bitfield_default },
	 { "RESERV1", 38, 39, &umr_bitfield_default },
	 { "Scrub", 40, 40, &umr_bitfield_default },
	 { "RESERV2", 41, 42, &umr_bitfield_default },
	 { "Poison", 43, 43, &umr_bitfield_default },
	 { "Deferred", 44, 44, &umr_bitfield_default },
	 { "UECC", 45, 45, &umr_bitfield_default },
	 { "CECC", 46, 46, &umr_bitfield_default },
	 { "RESERV3", 47, 51, &umr_bitfield_default },
	 { "Transparent", 52, 52, &umr_bitfield_default },
	 { "SyndV", 53, 53, &umr_bitfield_default },
	 { "RESERV4", 54, 54, &umr_bitfield_default },
	 { "TCC", 55, 55, &umr_bitfield_default },
	 { "ErrCoreIdVal", 56, 56, &umr_bitfield_default },
	 { "PCC", 57, 57, &umr_bitfield_default },
	 { "AddrV", 58, 58, &umr_bitfield_default },
	 { "MiscV", 59, 59, &umr_bitfield_default },
	 { "En", 60, 60, &umr_bitfield_default },
	 { "UC", 61, 61, &umr_bitfield_default },
	 { "Overflow", 62, 62, &umr_bitfield_default },
	 { "Val", 63, 63, &umr_bitfield_default },
};
static struct umr_bitfield mmMCA_UMC_UMC0_MCUMC_ADDRT0_ARCT[] = {
	 { "ErrorAddr", 0, 55, &umr_bitfield_default },
	 { "LSB", 56, 61, &umr_bitfield_default },
	 { "Reserved", 62, 63, &umr_bitfield_default },
};
