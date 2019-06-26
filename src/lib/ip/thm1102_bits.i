static struct umr_bitfield mmCG_MULT_THERMAL_STATUS[] = {
	 { "ASIC_MAX_TEMP", 0, 8, &umr_bitfield_default },
	 { "CTF_TEMP", 9, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmCG_FDO_CTRL0[] = {
	 { "FDO_STATIC_DUTY", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmCG_FDO_CTRL1[] = {
	 { "FMAX_DUTY100", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmCG_FDO_CTRL2[] = {
	 { "TMIN", 0, 7, &umr_bitfield_default },
	 { "FDO_PWM_MODE", 11, 13, &umr_bitfield_default },
};
static struct umr_bitfield mmCG_TACH_CTRL[] = {
	 { "TARGET_PERIOD", 3, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmTHM_THERMAL_INT_ENA[] = {
	 { "THERM_INTH_SET", 0, 0, &umr_bitfield_default },
	 { "THERM_INTL_SET", 1, 1, &umr_bitfield_default },
	 { "THERM_TRIGGER_SET", 2, 2, &umr_bitfield_default },
	 { "THERM_INTH_CLR", 3, 3, &umr_bitfield_default },
	 { "THERM_INTL_CLR", 4, 4, &umr_bitfield_default },
	 { "THERM_TRIGGER_CLR", 5, 5, &umr_bitfield_default },
};
static struct umr_bitfield mmTHM_THERMAL_INT_CTRL[] = {
	 { "DIG_THERM_INTH", 0, 7, &umr_bitfield_default },
	 { "DIG_THERM_INTL", 8, 15, &umr_bitfield_default },
	 { "TEMP_THRESHOLD", 16, 23, &umr_bitfield_default },
	 { "THERM_INTH_MASK", 24, 24, &umr_bitfield_default },
	 { "THERM_INTL_MASK", 25, 25, &umr_bitfield_default },
	 { "THERM_TRIGGER_MASK", 26, 26, &umr_bitfield_default },
	 { "THERM_PROCHOT_MASK", 27, 27, &umr_bitfield_default },
	 { "THERM_IH_HW_ENA", 28, 28, &umr_bitfield_default },
	 { "MAX_IH_CREDIT", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmTHM_TCON_THERM_TRIP[] = {
	 { "CTF_PAD_POLARITY", 0, 0, &umr_bitfield_default },
	 { "THERM_TP", 1, 1, &umr_bitfield_default },
	 { "CTF_THRESHOLD_EXCEEDED", 2, 2, &umr_bitfield_default },
	 { "THERM_TP_SENSE", 3, 3, &umr_bitfield_default },
	 { "RSVD2", 4, 4, &umr_bitfield_default },
	 { "THERM_TP_EN", 5, 5, &umr_bitfield_default },
	 { "THERM_TP_LMT", 6, 13, &umr_bitfield_default },
	 { "RSVD3", 14, 30, &umr_bitfield_default },
	 { "SW_THERM_TP", 31, 31, &umr_bitfield_default },
};
