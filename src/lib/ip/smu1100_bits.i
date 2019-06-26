static struct umr_bitfield mmSMUSVI0_TEL_PLANE0[] = {
	 { "SVI0_PLANE0_IDDCOR", 0, 7, &umr_bitfield_default },
	 { "SVI0_PLANE0_VDDCOR", 16, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_MCM_CONFIG[] = {
	 { "DIE_ID", 0, 1, &umr_bitfield_default },
	 { "PKG_TYPE", 2, 4, &umr_bitfield_default },
	 { "SOCKET_ID", 5, 5, &umr_bitfield_default },
	 { "PKG_SUBTYPE", 6, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_MP_RESET_INTR[] = {
	 { "SMUIO_MP_RESET_INTR", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_SOC_HALT[] = {
	 { "WDT_FORCE_PWROK_EN", 2, 2, &umr_bitfield_default },
	 { "WDT_FORCE_RESETn_EN", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_PWRMGT[] = {
	 { "i2c_clk_gate_en", 0, 0, &umr_bitfield_default },
	 { "i2c1_clk_gate_en", 4, 4, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_CNTL[] = {
	 { "CLOCK_GATING_EN", 0, 0, &umr_bitfield_default },
	 { "SPI_TIMING_RELAX", 20, 20, &umr_bitfield_default },
	 { "SPI_TIMING_RELAX_OVERRIDE", 21, 21, &umr_bitfield_default },
	 { "SPI_FAST_MODE", 22, 22, &umr_bitfield_default },
	 { "SPI_FAST_MODE_OVERRIDE", 23, 23, &umr_bitfield_default },
	 { "SCK_PRESCALE_REFCLK", 24, 27, &umr_bitfield_default },
	 { "SCK_PRESCALE_REFCLK_OVERRIDE", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmPAGE_MIRROR_CNTL[] = {
	 { "PAGE_MIRROR_BASE_ADDR", 0, 23, &umr_bitfield_default },
	 { "PAGE_MIRROR_INVALIDATE", 24, 24, &umr_bitfield_default },
	 { "PAGE_MIRROR_ENABLE", 25, 25, &umr_bitfield_default },
	 { "PAGE_MIRROR_USAGE", 26, 27, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_STATUS[] = {
	 { "ROM_BUSY", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmCGTT_ROM_CLK_CTRL0[] = {
	 { "ON_DELAY", 0, 3, &umr_bitfield_default },
	 { "OFF_HYSTERESIS", 4, 11, &umr_bitfield_default },
	 { "SOFT_OVERRIDE1", 30, 30, &umr_bitfield_default },
	 { "SOFT_OVERRIDE0", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_INDEX[] = {
	 { "ROM_INDEX", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_DATA[] = {
	 { "ROM_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_START[] = {
	 { "ROM_START", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_CNTL[] = {
	 { "DATA_SIZE", 0, 15, &umr_bitfield_default },
	 { "COMMAND_SIZE", 16, 17, &umr_bitfield_default },
	 { "ROM_SW_RETURN_DATA_ENABLE", 18, 18, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_STATUS[] = {
	 { "ROM_SW_DONE", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_COMMAND[] = {
	 { "ROM_SW_INSTRUCTION", 0, 7, &umr_bitfield_default },
	 { "ROM_SW_ADDRESS", 8, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_1[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_2[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_3[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_4[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_5[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_6[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_7[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_8[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_9[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_10[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_11[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_12[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_13[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_14[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_15[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_16[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_17[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_18[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_19[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_20[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_21[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_22[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_23[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_24[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_25[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_26[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_27[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_28[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_29[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_30[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_31[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_32[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_33[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_34[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_35[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_36[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_37[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_38[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_39[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_40[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_41[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_42[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_43[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_44[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_45[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_46[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_47[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_48[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_49[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_50[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_51[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_52[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_53[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_54[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_55[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_56[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_57[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_58[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_59[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_60[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_61[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_62[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_63[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_SW_DATA_64[] = {
	 { "ROM_SW_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_SW_INT_STAT[] = {
	 { "SW_INT_STAT", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_MASK[] = {
	 { "GPIO_MASK", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_A[] = {
	 { "GPIO_A", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_TXIMPSEL[] = {
	 { "GPIO_TXIMPSEL", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_EN[] = {
	 { "GPIO_EN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_Y[] = {
	 { "GPIO_Y", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_RXEN[] = {
	 { "GPIO_RXEN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_RCVR_SEL0[] = {
	 { "GPIO_RCVR_SEL0", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_RCVR_SEL1[] = {
	 { "GPIO_RCVR_SEL1", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_PU_EN[] = {
	 { "GPIO_PU_EN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_PD_EN[] = {
	 { "GPIO_PD_EN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_PINSTRAPS[] = {
	 { "GPIO_PINSTRAP_0", 0, 0, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_1", 1, 1, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_2", 2, 2, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_3", 3, 3, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_4", 4, 4, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_5", 5, 5, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_6", 6, 6, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_7", 7, 7, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_8", 8, 8, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_9", 9, 9, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_10", 10, 10, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_11", 11, 11, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_12", 12, 12, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_13", 13, 13, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_14", 14, 14, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_15", 15, 15, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_16", 16, 16, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_17", 17, 17, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_18", 18, 18, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_19", 19, 19, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_20", 20, 20, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_21", 21, 21, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_22", 22, 22, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_23", 23, 23, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_24", 24, 24, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_25", 25, 25, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_26", 26, 26, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_27", 27, 27, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_28", 28, 28, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_29", 29, 29, &umr_bitfield_default },
	 { "GPIO_PINSTRAP_30", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmDFT_PINSTRAPS[] = {
	 { "DFT_PINSTRAPS", 0, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_STAT_EN[] = {
	 { "GPIO_INT_STAT_EN", 0, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_STAT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_STAT[] = {
	 { "GPIO_INT_STAT", 0, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_STAT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_STAT_AK[] = {
	 { "GPIO_INT_STAT_AK_0", 0, 0, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_1", 1, 1, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_2", 2, 2, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_3", 3, 3, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_4", 4, 4, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_5", 5, 5, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_6", 6, 6, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_7", 7, 7, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_8", 8, 8, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_9", 9, 9, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_10", 10, 10, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_11", 11, 11, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_12", 12, 12, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_13", 13, 13, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_14", 14, 14, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_15", 15, 15, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_16", 16, 16, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_17", 17, 17, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_18", 18, 18, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_19", 19, 19, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_20", 20, 20, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_21", 21, 21, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_22", 22, 22, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_23", 23, 23, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_24", 24, 24, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_25", 25, 25, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_26", 26, 26, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_27", 27, 27, &umr_bitfield_default },
	 { "GPIO_INT_STAT_AK_28", 28, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_STAT_AK", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_EN[] = {
	 { "GPIO_INT_EN", 0, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_TYPE[] = {
	 { "GPIO_INT_TYPE", 0, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_TYPE", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_INT_POLARITY[] = {
	 { "GPIO_INT_POLARITY", 0, 28, &umr_bitfield_default },
	 { "SW_INITIATED_INT_POLARITY", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmROM_CC_BIF_PINSTRAP[] = {
	 { "BIOS_ROM_EN", 0, 0, &umr_bitfield_default },
	 { "BIF_MEM_AP_SIZE", 1, 3, &umr_bitfield_default },
	 { "ROM_CONFIG", 4, 6, &umr_bitfield_default },
	 { "BIF_GEN3_DIS_A", 7, 7, &umr_bitfield_default },
	 { "BIF_CLK_PM_EN", 8, 8, &umr_bitfield_default },
	 { "BIF_VGA_DIS", 9, 9, &umr_bitfield_default },
	 { "BIF_LC_TX_SWING", 10, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmIO_SMUIO_PINSTRAP[] = {
	 { "AUD_PORT_CONN", 0, 2, &umr_bitfield_default },
	 { "AUD", 3, 4, &umr_bitfield_default },
	 { "BOARD_CONFIG", 5, 7, &umr_bitfield_default },
	 { "SMBUS_ADDR", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_PCC_CONTROL[] = {
	 { "PCC_POLARITY", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_PCC_GPIO_SELECT[] = {
	 { "GPIO", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_GPIO_INT0_SELECT[] = {
	 { "GPIO_INT0_SELECT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_GPIO_INT1_SELECT[] = {
	 { "GPIO_INT1_SELECT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_GPIO_INT2_SELECT[] = {
	 { "GPIO_INT2_SELECT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMUIO_GPIO_INT3_SELECT[] = {
	 { "GPIO_INT3_SELECT", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_MP_INT0_STAT[] = {
	 { "GPIO_MP_INT0_STAT", 0, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_MP_INT1_STAT[] = {
	 { "GPIO_MP_INT1_STAT", 0, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_MP_INT2_STAT[] = {
	 { "GPIO_MP_INT2_STAT", 0, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_MP_INT3_STAT[] = {
	 { "GPIO_MP_INT3_STAT", 0, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmSMIO_INDEX[] = {
	 { "SW_SMIO_INDEX", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmS0_VID_SMIO_CNTL[] = {
	 { "S0_SMIO_VALUES", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmS1_VID_SMIO_CNTL[] = {
	 { "S1_SMIO_VALUES", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmOPEN_DRAIN_SELECT[] = {
	 { "OPEN_DRAIN_SELECT", 0, 30, &umr_bitfield_default },
	 { "RESERVED", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMIO_ENABLE[] = {
	 { "SMIO_ENABLE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_S0[] = {
	 { "GPIO_S0", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_S1[] = {
	 { "GPIO_S1", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_SCL_EN[] = {
	 { "GPIO_SCL_EN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_SDA_EN[] = {
	 { "GPIO_SDA_EN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmSMU_GPIOPAD_SCHMEN[] = {
	 { "GPIO_SCHMEN", 0, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmIP_DISCOVERY_VERSION[] = {
	 { "IP_DISCOVERY_VERSION", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSOC_GAP_PWROK[] = {
	 { "soc_gap_pwrok", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_GAP_PWROK[] = {
	 { "gfx_gap_pwrok", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmPWROK_REFCLK_GAP_CYCLES[] = {
	 { "Pwrok_PreAssertion_clkgap_cycles", 0, 7, &umr_bitfield_default },
	 { "Pwrok_PostAssertion_clkgap_cycles", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmGOLDEN_TSC_INCREMENT_UPPER[] = {
	 { "GoldenTscIncrementUpper", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmGOLDEN_TSC_INCREMENT_LOWER[] = {
	 { "GoldenTscIncrementLower", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmGOLDEN_TSC_COUNT_UPPER[] = {
	 { "GoldenTscCountUpper", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmGOLDEN_TSC_COUNT_LOWER[] = {
	 { "GoldenTscCountLower", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSOC_GOLDEN_TSC_SHADOW_UPPER[] = {
	 { "SOCGoldenTscShadowUpper", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmSOC_GOLDEN_TSC_SHADOW_LOWER[] = {
	 { "SOCGoldenTscShadowLower", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_GOLDEN_TSC_SHADOW_UPPER[] = {
	 { "GFXGoldenTscShadowUpper", 0, 23, &umr_bitfield_default },
};
static struct umr_bitfield mmGFX_GOLDEN_TSC_SHADOW_LOWER[] = {
	 { "GFXGoldenTscShadowLower", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPWR_VIRT_RESET_REQ[] = {
	 { "VF_FLR", 0, 30, &umr_bitfield_default },
	 { "PF_FLR", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER0[] = {
	 { "ScratchPad0", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER1[] = {
	 { "ScratchPad1", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER2[] = {
	 { "ScratchPad2", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER3[] = {
	 { "ScratchPad3", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER4[] = {
	 { "ScratchPad4", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER5[] = {
	 { "ScratchPad5", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER6[] = {
	 { "ScratchPad6", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmSCRATCH_REGISTER7[] = {
	 { "ScratchPad7", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmPWR_DISP_TIMER_CONTROL[] = {
	 { "DISP_TIMER_INT_COUNT", 0, 24, &umr_bitfield_default },
	 { "DISP_TIMER_INT_ENABLE", 25, 25, &umr_bitfield_default },
	 { "DISP_TIMER_INT_DISABLE", 26, 26, &umr_bitfield_default },
	 { "DISP_TIMER_INT_MASK", 27, 27, &umr_bitfield_default },
	 { "DISP_TIMER_INT_STAT_AK", 28, 28, &umr_bitfield_default },
	 { "DISP_TIMER_INT_TYPE", 29, 29, &umr_bitfield_default },
	 { "DISP_TIMER_INT_MODE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmPWR_DISP_TIMER2_CONTROL[] = {
	 { "DISP_TIMER_INT_COUNT", 0, 24, &umr_bitfield_default },
	 { "DISP_TIMER_INT_ENABLE", 25, 25, &umr_bitfield_default },
	 { "DISP_TIMER_INT_DISABLE", 26, 26, &umr_bitfield_default },
	 { "DISP_TIMER_INT_MASK", 27, 27, &umr_bitfield_default },
	 { "DISP_TIMER_INT_STAT_AK", 28, 28, &umr_bitfield_default },
	 { "DISP_TIMER_INT_TYPE", 29, 29, &umr_bitfield_default },
	 { "DISP_TIMER_INT_MODE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmPWR_DISP_TIMER_GLOBAL_CONTROL[] = {
	 { "DISP_TIMER_PULSE_WIDTH", 0, 9, &umr_bitfield_default },
	 { "DISP_TIMER_PULSE_EN", 10, 10, &umr_bitfield_default },
};
static struct umr_bitfield mmPWR_IH_CONTROL[] = {
	 { "MAX_CREDIT", 0, 4, &umr_bitfield_default },
	 { "DISP_TIMER_TRIGGER_MASK", 5, 5, &umr_bitfield_default },
	 { "DISP_TIMER2_TRIGGER_MASK", 6, 6, &umr_bitfield_default },
};
