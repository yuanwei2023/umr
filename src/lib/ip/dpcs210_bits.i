static struct umr_bitfield mmDPCSTX0_DPCSTX_TX_CLOCK_CNTL[] = {
	 { "DPCS_SYMCLK_GATE_DIS", 0, 0, &umr_bitfield_default },
	 { "DPCS_SYMCLK_EN", 1, 1, &umr_bitfield_default },
	 { "DPCS_SYMCLK_CLOCK_ON", 2, 2, &umr_bitfield_default },
	 { "DPCS_SYMCLK_DIV2_CLOCK_ON", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_TX_CNTL[] = {
	 { "DPCS_TX_PLL_UPDATE_REQ", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_PLL_UPDATE_PENDING", 13, 13, &umr_bitfield_default },
	 { "DPCS_TX_DATA_SWAP", 14, 14, &umr_bitfield_default },
	 { "DPCS_TX_DATA_ORDER_INVERT", 15, 15, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_RD_START_DELAY", 20, 23, &umr_bitfield_default },
	 { "DPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_CBUS_CNTL[] = {
	 { "DPCS_CBUS_WR_CMD_DELAY", 0, 7, &umr_bitfield_default },
	 { "DPCS_CBUS_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_INTERRUPT_CNTL[] = {
	 { "DPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "DPCS_REG_ERROR_CLR", 1, 1, &umr_bitfield_default },
	 { "DPCS_REG_FIFO_ERROR_MASK", 4, 4, &umr_bitfield_default },
	 { "DPCS_TX0_FIFO_ERROR", 8, 8, &umr_bitfield_default },
	 { "DPCS_TX1_FIFO_ERROR", 9, 9, &umr_bitfield_default },
	 { "DPCS_TX2_FIFO_ERROR", 10, 10, &umr_bitfield_default },
	 { "DPCS_TX3_FIFO_ERROR", 11, 11, &umr_bitfield_default },
	 { "DPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "DPCS_INTERRUPT_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_PLL_UPDATE_ADDR[] = {
	 { "DPCS_PLL_UPDATE_ADDR", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_PLL_UPDATE_DATA[] = {
	 { "DPCS_PLL_UPDATE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX0_DPCSTX_DEBUG_CONFIG[] = {
	 { "DPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "DPCS_DBG_CFGCLK_SEL", 1, 3, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_SEL", 4, 6, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_DIV2_SEL", 8, 10, &umr_bitfield_default },
	 { "DPCS_DBG_CBUS_DIS", 14, 14, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_WRITE_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_INDEX", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_CNTL[] = {
	 { "RDPCS_CBUS_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SRAM_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE0_EN", 12, 12, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE1_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE2_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE3_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_RD_START_DELAY", 20, 24, &umr_bitfield_default },
	 { "RDPCS_DPALT_BLOCK_STATUS", 26, 26, &umr_bitfield_default },
	 { "RDPCS_CR_REGISTER_BLOCK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_NON_DPALT_REGISTER_BLOCK_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_CLOCK_CNTL[] = {
	 { "RDPCS_EXT_REFCLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX0_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX1_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX2_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX3_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_GATE_DIS", 8, 8, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_CLOCK_ON", 10, 10, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_GATE_DIS", 12, 12, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_CLOCK_ON", 14, 14, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_BYPASS", 16, 16, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_GATE_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_EN", 21, 21, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_CLOCK_ON", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_INTERRUPT_CONTROL[] = {
	 { "RDPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_TX0_FIFO_ERROR", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX1_FIFO_ERROR", 5, 5, &umr_bitfield_default },
	 { "RDPCS_TX2_FIFO_ERROR", 6, 6, &umr_bitfield_default },
	 { "RDPCS_TX3_FIFO_ERROR", 7, 7, &umr_bitfield_default },
	 { "RDPCS_REG_ERROR_CLR", 8, 8, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_CLR", 9, 9, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_CLR", 10, 10, &umr_bitfield_default },
	 { "RDPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "RDPCS_REG_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_MASK", 17, 17, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_MASK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_ERROR_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PLL_UPDATE_DATA[] = {
	 { "RDPCS_PLL_UPDATE_DATA", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCS_TX_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCS_TX_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCS_TX_SRAM_CNTL[] = {
	 { "RDPCS_MEM_PWR_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_FORCE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_PWR_STATE", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_SCRATCH[] = {
	 { "RDPCSTX_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_SPARE[] = {
	 { "RDPCSTX_SPARE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_CNTL2[] = {
	 { "RDPCS_CR_CONVERT_FIFO_EMPTY", 0, 0, &umr_bitfield_default },
	 { "RDPCS_CR_CONVERT_FIFO_FULL", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG[] = {
	 { "RDPCS_DMCU_DPALT_DIS_BLOCK_REG", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_FORCE_SYMCLK_DIV2_DIS", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DEBUG_CONFIG[] = {
	 { "RDPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_8BIT", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_SWAP", 7, 7, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_TEST_CLK", 8, 12, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_EXPIRE", 15, 15, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_MAX", 16, 23, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL0[] = {
	 { "RDPCS_PHY_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_PHY_RESET", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_APB_RESET_N", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_TEST_POWERDOWN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DTB_OUT", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMIMODE_ENABLE", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_RANGE", 9, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_REQ", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_PARA_SEL", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_MUX_SEL", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_RESULT", 25, 25, &umr_bitfield_default },
	 { "RDPCS_SRAM_INIT_DONE", 28, 28, &umr_bitfield_default },
	 { "RDPCS_SRAM_EXT_LD_DONE", 29, 29, &umr_bitfield_default },
	 { "RDPCS_SRAM_BYPASS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL1[] = {
	 { "RDPCS_PHY_PG_MODE_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_EN", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_STABLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_STABLE", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_PG_RESET", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_STABLE", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL2[] = {
	 { "RDPCS_PHY_DP4_POR", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_RX2TX_PAR_LB_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_RX2TX_PAR_LB_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_RX2TX_PAR_LB_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_RX2TX_PAR_LB_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_TX2RX_SER_LB_EN", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_TX2RX_SER_LB_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_TX2RX_SER_LB_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_TX2RX_SER_LB_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL4[] = {
	 { "RDPCS_PHY_DP_TX0_TERM_CTRL", 0, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_INVERT", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_BYPASS_EQ_CALC", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_HP_PROT_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_TERM_CTRL", 8, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_INVERT", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_BYPASS_EQ_CALC", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_HP_PROT_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_TERM_CTRL", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_INVERT", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_BYPASS_EQ_CALC", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_HP_PROT_EN", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_TERM_CTRL", 24, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_INVERT", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_BYPASS_EQ_CALC", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_HP_PROT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL5[] = {
	 { "RDPCS_PHY_DP_TX0_LPD", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_RATE", 1, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_WIDTH", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_REQ", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_RESULT", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_LPD", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RATE", 9, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_WIDTH", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_REQ", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_RESULT", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_LPD", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RATE", 17, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_WIDTH", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_REQ", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_RESULT", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_LPD", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RATE", 25, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_WIDTH", 28, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_REQ", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_RESULT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL7[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_DEN", 0, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_QUOT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL8[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_PEAK", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL9[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE", 0, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL10[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_REM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL11[] = {
	 { "RDPCS_PHY_DP_MPLLB_MULTIPLIER", 4, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_DIV", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_MPLLB_DIV", 20, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_PIXEL_CLK_DIV", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL12[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_TX_CLK_DIV", 4, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_STATE", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL13[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER", 20, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_DIV_CLK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FORCE_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_INIT_CAL_DISABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL14[] = {
	 { "RDPCS_PHY_DP_MPLLB_CAL_FORCE", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_PMIX_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_FUSE0[] = {
	 { "RDPCS_PHY_DP_TX0_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_V2I", 18, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FREQ_VCO", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT_GS", 22, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VREF_CTRL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_FUSE1[] = {
	 { "RDPCS_PHY_DP_TX1_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT", 18, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_FUSE2[] = {
	 { "RDPCS_PHY_DP_TX2_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP_GS", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_FUSE3[] = {
	 { "RDPCS_PHY_DP_TX3_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_FINETUNE", 18, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_RANGE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_TX_VBOOST_LVL", 26, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_RX_VCO_VREF_SEL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_RX_LD_VAL[] = {
	 { "RDPCS_PHY_RX_REF_LD_VAL", 0, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VCO_LD_VAL", 8, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DMCU_DPALT_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET_RESERVED", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE_RESERVED", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN_RESERVED", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ_RESERVED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK_RESERVED", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET_RESERVED", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE_RESERVED", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN_RESERVED", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ_RESERVED", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK_RESERVED", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ_RESERVED", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK_RESERVED", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET_RESERVED", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE_RESERVED", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY_RESERVED", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN_RESERVED", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ_RESERVED", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK_RESERVED", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DMCU_DPALT_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE_RESERVED", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE_RESERVED", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN_RESERVED", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE_RESERVED", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE_RESERVED", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN_RESERVED", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ_RESERVED", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DPALT_CONTROL_REG[] = {
	 { "RDPCS_ALLOW_DRIVER_ACCESS", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DRIVER_ACCESS_BLOCKED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL15[] = {
	 { "RDPCS_PHY_SSTX_VREGDRV_BYP", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_VREGDRV_BYP", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_VREGDRV_BYP", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_VREGDRV_BYP", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_VREGDRV_BYP", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_PRE_HP", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL16[] = {
	 { "RDPCS_PHY_DP_TX0_OUT_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_OUT_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_OUT_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_OUT_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_OUT_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_PHY_CNTL17[] = {
	 { "RDPCS_PHY_DP_TX0_IN_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_IN_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_IN_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_IN_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_IN_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX0_RDPCSTX_DEBUG_CONFIG2[] = {
	 { "RDPCS_DBG_OCLA_SRC0", 0, 2, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC1", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC2", 8, 10, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC3", 12, 14, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_VALID_REPLACE_MSB", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR0_DPCSSYS_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR0_DPCSSYS_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_TX_CLOCK_CNTL[] = {
	 { "DPCS_SYMCLK_GATE_DIS", 0, 0, &umr_bitfield_default },
	 { "DPCS_SYMCLK_EN", 1, 1, &umr_bitfield_default },
	 { "DPCS_SYMCLK_CLOCK_ON", 2, 2, &umr_bitfield_default },
	 { "DPCS_SYMCLK_DIV2_CLOCK_ON", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_TX_CNTL[] = {
	 { "DPCS_TX_PLL_UPDATE_REQ", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_PLL_UPDATE_PENDING", 13, 13, &umr_bitfield_default },
	 { "DPCS_TX_DATA_SWAP", 14, 14, &umr_bitfield_default },
	 { "DPCS_TX_DATA_ORDER_INVERT", 15, 15, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_RD_START_DELAY", 20, 23, &umr_bitfield_default },
	 { "DPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_CBUS_CNTL[] = {
	 { "DPCS_CBUS_WR_CMD_DELAY", 0, 7, &umr_bitfield_default },
	 { "DPCS_CBUS_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_INTERRUPT_CNTL[] = {
	 { "DPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "DPCS_REG_ERROR_CLR", 1, 1, &umr_bitfield_default },
	 { "DPCS_REG_FIFO_ERROR_MASK", 4, 4, &umr_bitfield_default },
	 { "DPCS_TX0_FIFO_ERROR", 8, 8, &umr_bitfield_default },
	 { "DPCS_TX1_FIFO_ERROR", 9, 9, &umr_bitfield_default },
	 { "DPCS_TX2_FIFO_ERROR", 10, 10, &umr_bitfield_default },
	 { "DPCS_TX3_FIFO_ERROR", 11, 11, &umr_bitfield_default },
	 { "DPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "DPCS_INTERRUPT_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_PLL_UPDATE_ADDR[] = {
	 { "DPCS_PLL_UPDATE_ADDR", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_PLL_UPDATE_DATA[] = {
	 { "DPCS_PLL_UPDATE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX1_DPCSTX_DEBUG_CONFIG[] = {
	 { "DPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "DPCS_DBG_CFGCLK_SEL", 1, 3, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_SEL", 4, 6, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_DIV2_SEL", 8, 10, &umr_bitfield_default },
	 { "DPCS_DBG_CBUS_DIS", 14, 14, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_WRITE_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_INDEX", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_CNTL[] = {
	 { "RDPCS_CBUS_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SRAM_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE0_EN", 12, 12, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE1_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE2_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE3_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_RD_START_DELAY", 20, 24, &umr_bitfield_default },
	 { "RDPCS_DPALT_BLOCK_STATUS", 26, 26, &umr_bitfield_default },
	 { "RDPCS_CR_REGISTER_BLOCK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_NON_DPALT_REGISTER_BLOCK_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_CLOCK_CNTL[] = {
	 { "RDPCS_EXT_REFCLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX0_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX1_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX2_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX3_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_GATE_DIS", 8, 8, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_CLOCK_ON", 10, 10, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_GATE_DIS", 12, 12, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_CLOCK_ON", 14, 14, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_BYPASS", 16, 16, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_GATE_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_EN", 21, 21, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_CLOCK_ON", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_INTERRUPT_CONTROL[] = {
	 { "RDPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_TX0_FIFO_ERROR", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX1_FIFO_ERROR", 5, 5, &umr_bitfield_default },
	 { "RDPCS_TX2_FIFO_ERROR", 6, 6, &umr_bitfield_default },
	 { "RDPCS_TX3_FIFO_ERROR", 7, 7, &umr_bitfield_default },
	 { "RDPCS_REG_ERROR_CLR", 8, 8, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_CLR", 9, 9, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_CLR", 10, 10, &umr_bitfield_default },
	 { "RDPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "RDPCS_REG_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_MASK", 17, 17, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_MASK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_ERROR_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PLL_UPDATE_DATA[] = {
	 { "RDPCS_PLL_UPDATE_DATA", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCS_TX_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCS_TX_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCS_TX_SRAM_CNTL[] = {
	 { "RDPCS_MEM_PWR_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_FORCE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_PWR_STATE", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_SCRATCH[] = {
	 { "RDPCSTX_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_SPARE[] = {
	 { "RDPCSTX_SPARE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_CNTL2[] = {
	 { "RDPCS_CR_CONVERT_FIFO_EMPTY", 0, 0, &umr_bitfield_default },
	 { "RDPCS_CR_CONVERT_FIFO_FULL", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG[] = {
	 { "RDPCS_DMCU_DPALT_DIS_BLOCK_REG", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_FORCE_SYMCLK_DIV2_DIS", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DEBUG_CONFIG[] = {
	 { "RDPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_8BIT", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_SWAP", 7, 7, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_TEST_CLK", 8, 12, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_EXPIRE", 15, 15, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_MAX", 16, 23, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL0[] = {
	 { "RDPCS_PHY_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_PHY_RESET", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_APB_RESET_N", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_TEST_POWERDOWN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DTB_OUT", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMIMODE_ENABLE", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_RANGE", 9, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_REQ", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_PARA_SEL", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_MUX_SEL", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_RESULT", 25, 25, &umr_bitfield_default },
	 { "RDPCS_SRAM_INIT_DONE", 28, 28, &umr_bitfield_default },
	 { "RDPCS_SRAM_EXT_LD_DONE", 29, 29, &umr_bitfield_default },
	 { "RDPCS_SRAM_BYPASS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL1[] = {
	 { "RDPCS_PHY_PG_MODE_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_EN", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_STABLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_STABLE", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_PG_RESET", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_STABLE", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL2[] = {
	 { "RDPCS_PHY_DP4_POR", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_RX2TX_PAR_LB_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_RX2TX_PAR_LB_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_RX2TX_PAR_LB_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_RX2TX_PAR_LB_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_TX2RX_SER_LB_EN", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_TX2RX_SER_LB_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_TX2RX_SER_LB_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_TX2RX_SER_LB_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL4[] = {
	 { "RDPCS_PHY_DP_TX0_TERM_CTRL", 0, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_INVERT", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_BYPASS_EQ_CALC", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_HP_PROT_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_TERM_CTRL", 8, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_INVERT", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_BYPASS_EQ_CALC", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_HP_PROT_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_TERM_CTRL", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_INVERT", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_BYPASS_EQ_CALC", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_HP_PROT_EN", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_TERM_CTRL", 24, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_INVERT", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_BYPASS_EQ_CALC", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_HP_PROT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL5[] = {
	 { "RDPCS_PHY_DP_TX0_LPD", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_RATE", 1, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_WIDTH", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_REQ", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_RESULT", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_LPD", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RATE", 9, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_WIDTH", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_REQ", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_RESULT", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_LPD", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RATE", 17, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_WIDTH", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_REQ", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_RESULT", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_LPD", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RATE", 25, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_WIDTH", 28, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_REQ", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_RESULT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL7[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_DEN", 0, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_QUOT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL8[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_PEAK", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL9[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE", 0, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL10[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_REM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL11[] = {
	 { "RDPCS_PHY_DP_MPLLB_MULTIPLIER", 4, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_DIV", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_MPLLB_DIV", 20, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_PIXEL_CLK_DIV", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL12[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_TX_CLK_DIV", 4, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_STATE", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL13[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER", 20, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_DIV_CLK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FORCE_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_INIT_CAL_DISABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL14[] = {
	 { "RDPCS_PHY_DP_MPLLB_CAL_FORCE", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_PMIX_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_FUSE0[] = {
	 { "RDPCS_PHY_DP_TX0_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_V2I", 18, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FREQ_VCO", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT_GS", 22, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VREF_CTRL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_FUSE1[] = {
	 { "RDPCS_PHY_DP_TX1_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT", 18, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_FUSE2[] = {
	 { "RDPCS_PHY_DP_TX2_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP_GS", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_FUSE3[] = {
	 { "RDPCS_PHY_DP_TX3_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_FINETUNE", 18, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_RANGE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_TX_VBOOST_LVL", 26, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_RX_VCO_VREF_SEL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_RX_LD_VAL[] = {
	 { "RDPCS_PHY_RX_REF_LD_VAL", 0, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VCO_LD_VAL", 8, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DMCU_DPALT_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET_RESERVED", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE_RESERVED", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN_RESERVED", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ_RESERVED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK_RESERVED", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET_RESERVED", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE_RESERVED", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN_RESERVED", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ_RESERVED", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK_RESERVED", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ_RESERVED", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK_RESERVED", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET_RESERVED", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE_RESERVED", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY_RESERVED", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN_RESERVED", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ_RESERVED", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK_RESERVED", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DMCU_DPALT_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE_RESERVED", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE_RESERVED", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN_RESERVED", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE_RESERVED", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE_RESERVED", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN_RESERVED", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ_RESERVED", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DPALT_CONTROL_REG[] = {
	 { "RDPCS_ALLOW_DRIVER_ACCESS", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DRIVER_ACCESS_BLOCKED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL15[] = {
	 { "RDPCS_PHY_SSTX_VREGDRV_BYP", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_VREGDRV_BYP", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_VREGDRV_BYP", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_VREGDRV_BYP", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_VREGDRV_BYP", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_PRE_HP", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL16[] = {
	 { "RDPCS_PHY_DP_TX0_OUT_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_OUT_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_OUT_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_OUT_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_OUT_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_PHY_CNTL17[] = {
	 { "RDPCS_PHY_DP_TX0_IN_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_IN_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_IN_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_IN_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_IN_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX1_RDPCSTX_DEBUG_CONFIG2[] = {
	 { "RDPCS_DBG_OCLA_SRC0", 0, 2, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC1", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC2", 8, 10, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC3", 12, 14, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_VALID_REPLACE_MSB", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR1_DPCSSYS_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR1_DPCSSYS_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_TX_CLOCK_CNTL[] = {
	 { "DPCS_SYMCLK_GATE_DIS", 0, 0, &umr_bitfield_default },
	 { "DPCS_SYMCLK_EN", 1, 1, &umr_bitfield_default },
	 { "DPCS_SYMCLK_CLOCK_ON", 2, 2, &umr_bitfield_default },
	 { "DPCS_SYMCLK_DIV2_CLOCK_ON", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_TX_CNTL[] = {
	 { "DPCS_TX_PLL_UPDATE_REQ", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_PLL_UPDATE_PENDING", 13, 13, &umr_bitfield_default },
	 { "DPCS_TX_DATA_SWAP", 14, 14, &umr_bitfield_default },
	 { "DPCS_TX_DATA_ORDER_INVERT", 15, 15, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_RD_START_DELAY", 20, 23, &umr_bitfield_default },
	 { "DPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_CBUS_CNTL[] = {
	 { "DPCS_CBUS_WR_CMD_DELAY", 0, 7, &umr_bitfield_default },
	 { "DPCS_CBUS_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_INTERRUPT_CNTL[] = {
	 { "DPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "DPCS_REG_ERROR_CLR", 1, 1, &umr_bitfield_default },
	 { "DPCS_REG_FIFO_ERROR_MASK", 4, 4, &umr_bitfield_default },
	 { "DPCS_TX0_FIFO_ERROR", 8, 8, &umr_bitfield_default },
	 { "DPCS_TX1_FIFO_ERROR", 9, 9, &umr_bitfield_default },
	 { "DPCS_TX2_FIFO_ERROR", 10, 10, &umr_bitfield_default },
	 { "DPCS_TX3_FIFO_ERROR", 11, 11, &umr_bitfield_default },
	 { "DPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "DPCS_INTERRUPT_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_PLL_UPDATE_ADDR[] = {
	 { "DPCS_PLL_UPDATE_ADDR", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_PLL_UPDATE_DATA[] = {
	 { "DPCS_PLL_UPDATE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX2_DPCSTX_DEBUG_CONFIG[] = {
	 { "DPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "DPCS_DBG_CFGCLK_SEL", 1, 3, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_SEL", 4, 6, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_DIV2_SEL", 8, 10, &umr_bitfield_default },
	 { "DPCS_DBG_CBUS_DIS", 14, 14, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_WRITE_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_INDEX", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_CNTL[] = {
	 { "RDPCS_CBUS_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SRAM_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE0_EN", 12, 12, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE1_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE2_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE3_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_RD_START_DELAY", 20, 24, &umr_bitfield_default },
	 { "RDPCS_DPALT_BLOCK_STATUS", 26, 26, &umr_bitfield_default },
	 { "RDPCS_CR_REGISTER_BLOCK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_NON_DPALT_REGISTER_BLOCK_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_CLOCK_CNTL[] = {
	 { "RDPCS_EXT_REFCLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX0_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX1_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX2_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX3_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_GATE_DIS", 8, 8, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_CLOCK_ON", 10, 10, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_GATE_DIS", 12, 12, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_CLOCK_ON", 14, 14, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_BYPASS", 16, 16, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_GATE_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_EN", 21, 21, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_CLOCK_ON", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_INTERRUPT_CONTROL[] = {
	 { "RDPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_TX0_FIFO_ERROR", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX1_FIFO_ERROR", 5, 5, &umr_bitfield_default },
	 { "RDPCS_TX2_FIFO_ERROR", 6, 6, &umr_bitfield_default },
	 { "RDPCS_TX3_FIFO_ERROR", 7, 7, &umr_bitfield_default },
	 { "RDPCS_REG_ERROR_CLR", 8, 8, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_CLR", 9, 9, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_CLR", 10, 10, &umr_bitfield_default },
	 { "RDPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "RDPCS_REG_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_MASK", 17, 17, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_MASK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_ERROR_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PLL_UPDATE_DATA[] = {
	 { "RDPCS_PLL_UPDATE_DATA", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCS_TX_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCS_TX_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCS_TX_SRAM_CNTL[] = {
	 { "RDPCS_MEM_PWR_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_FORCE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_PWR_STATE", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_SCRATCH[] = {
	 { "RDPCSTX_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_SPARE[] = {
	 { "RDPCSTX_SPARE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_CNTL2[] = {
	 { "RDPCS_CR_CONVERT_FIFO_EMPTY", 0, 0, &umr_bitfield_default },
	 { "RDPCS_CR_CONVERT_FIFO_FULL", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG[] = {
	 { "RDPCS_DMCU_DPALT_DIS_BLOCK_REG", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_FORCE_SYMCLK_DIV2_DIS", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DEBUG_CONFIG[] = {
	 { "RDPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_8BIT", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_SWAP", 7, 7, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_TEST_CLK", 8, 12, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_EXPIRE", 15, 15, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_MAX", 16, 23, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL0[] = {
	 { "RDPCS_PHY_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_PHY_RESET", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_APB_RESET_N", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_TEST_POWERDOWN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DTB_OUT", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMIMODE_ENABLE", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_RANGE", 9, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_REQ", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_PARA_SEL", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_MUX_SEL", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_RESULT", 25, 25, &umr_bitfield_default },
	 { "RDPCS_SRAM_INIT_DONE", 28, 28, &umr_bitfield_default },
	 { "RDPCS_SRAM_EXT_LD_DONE", 29, 29, &umr_bitfield_default },
	 { "RDPCS_SRAM_BYPASS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL1[] = {
	 { "RDPCS_PHY_PG_MODE_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_EN", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_STABLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_STABLE", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_PG_RESET", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_STABLE", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL2[] = {
	 { "RDPCS_PHY_DP4_POR", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_RX2TX_PAR_LB_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_RX2TX_PAR_LB_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_RX2TX_PAR_LB_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_RX2TX_PAR_LB_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_TX2RX_SER_LB_EN", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_TX2RX_SER_LB_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_TX2RX_SER_LB_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_TX2RX_SER_LB_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL4[] = {
	 { "RDPCS_PHY_DP_TX0_TERM_CTRL", 0, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_INVERT", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_BYPASS_EQ_CALC", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_HP_PROT_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_TERM_CTRL", 8, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_INVERT", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_BYPASS_EQ_CALC", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_HP_PROT_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_TERM_CTRL", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_INVERT", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_BYPASS_EQ_CALC", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_HP_PROT_EN", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_TERM_CTRL", 24, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_INVERT", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_BYPASS_EQ_CALC", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_HP_PROT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL5[] = {
	 { "RDPCS_PHY_DP_TX0_LPD", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_RATE", 1, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_WIDTH", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_REQ", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_RESULT", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_LPD", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RATE", 9, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_WIDTH", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_REQ", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_RESULT", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_LPD", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RATE", 17, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_WIDTH", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_REQ", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_RESULT", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_LPD", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RATE", 25, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_WIDTH", 28, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_REQ", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_RESULT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL7[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_DEN", 0, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_QUOT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL8[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_PEAK", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL9[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE", 0, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL10[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_REM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL11[] = {
	 { "RDPCS_PHY_DP_MPLLB_MULTIPLIER", 4, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_DIV", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_MPLLB_DIV", 20, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_PIXEL_CLK_DIV", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL12[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_TX_CLK_DIV", 4, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_STATE", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL13[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER", 20, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_DIV_CLK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FORCE_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_INIT_CAL_DISABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL14[] = {
	 { "RDPCS_PHY_DP_MPLLB_CAL_FORCE", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_PMIX_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_FUSE0[] = {
	 { "RDPCS_PHY_DP_TX0_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_V2I", 18, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FREQ_VCO", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT_GS", 22, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VREF_CTRL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_FUSE1[] = {
	 { "RDPCS_PHY_DP_TX1_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT", 18, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_FUSE2[] = {
	 { "RDPCS_PHY_DP_TX2_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP_GS", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_FUSE3[] = {
	 { "RDPCS_PHY_DP_TX3_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_FINETUNE", 18, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_RANGE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_TX_VBOOST_LVL", 26, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_RX_VCO_VREF_SEL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_RX_LD_VAL[] = {
	 { "RDPCS_PHY_RX_REF_LD_VAL", 0, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VCO_LD_VAL", 8, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DMCU_DPALT_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET_RESERVED", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE_RESERVED", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN_RESERVED", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ_RESERVED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK_RESERVED", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET_RESERVED", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE_RESERVED", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN_RESERVED", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ_RESERVED", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK_RESERVED", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ_RESERVED", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK_RESERVED", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET_RESERVED", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE_RESERVED", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY_RESERVED", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN_RESERVED", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ_RESERVED", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK_RESERVED", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DMCU_DPALT_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE_RESERVED", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE_RESERVED", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN_RESERVED", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE_RESERVED", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE_RESERVED", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN_RESERVED", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ_RESERVED", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DPALT_CONTROL_REG[] = {
	 { "RDPCS_ALLOW_DRIVER_ACCESS", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DRIVER_ACCESS_BLOCKED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL15[] = {
	 { "RDPCS_PHY_SSTX_VREGDRV_BYP", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_VREGDRV_BYP", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_VREGDRV_BYP", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_VREGDRV_BYP", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_VREGDRV_BYP", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_PRE_HP", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL16[] = {
	 { "RDPCS_PHY_DP_TX0_OUT_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_OUT_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_OUT_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_OUT_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_OUT_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_PHY_CNTL17[] = {
	 { "RDPCS_PHY_DP_TX0_IN_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_IN_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_IN_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_IN_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_IN_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX2_RDPCSTX_DEBUG_CONFIG2[] = {
	 { "RDPCS_DBG_OCLA_SRC0", 0, 2, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC1", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC2", 8, 10, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC3", 12, 14, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_VALID_REPLACE_MSB", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR2_DPCSSYS_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR2_DPCSSYS_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_TX_CLOCK_CNTL[] = {
	 { "DPCS_SYMCLK_GATE_DIS", 0, 0, &umr_bitfield_default },
	 { "DPCS_SYMCLK_EN", 1, 1, &umr_bitfield_default },
	 { "DPCS_SYMCLK_CLOCK_ON", 2, 2, &umr_bitfield_default },
	 { "DPCS_SYMCLK_DIV2_CLOCK_ON", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_TX_CNTL[] = {
	 { "DPCS_TX_PLL_UPDATE_REQ", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_PLL_UPDATE_PENDING", 13, 13, &umr_bitfield_default },
	 { "DPCS_TX_DATA_SWAP", 14, 14, &umr_bitfield_default },
	 { "DPCS_TX_DATA_ORDER_INVERT", 15, 15, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_RD_START_DELAY", 20, 23, &umr_bitfield_default },
	 { "DPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_CBUS_CNTL[] = {
	 { "DPCS_CBUS_WR_CMD_DELAY", 0, 7, &umr_bitfield_default },
	 { "DPCS_CBUS_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_INTERRUPT_CNTL[] = {
	 { "DPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "DPCS_REG_ERROR_CLR", 1, 1, &umr_bitfield_default },
	 { "DPCS_REG_FIFO_ERROR_MASK", 4, 4, &umr_bitfield_default },
	 { "DPCS_TX0_FIFO_ERROR", 8, 8, &umr_bitfield_default },
	 { "DPCS_TX1_FIFO_ERROR", 9, 9, &umr_bitfield_default },
	 { "DPCS_TX2_FIFO_ERROR", 10, 10, &umr_bitfield_default },
	 { "DPCS_TX3_FIFO_ERROR", 11, 11, &umr_bitfield_default },
	 { "DPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "DPCS_INTERRUPT_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_PLL_UPDATE_ADDR[] = {
	 { "DPCS_PLL_UPDATE_ADDR", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_PLL_UPDATE_DATA[] = {
	 { "DPCS_PLL_UPDATE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX3_DPCSTX_DEBUG_CONFIG[] = {
	 { "DPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "DPCS_DBG_CFGCLK_SEL", 1, 3, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_SEL", 4, 6, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_DIV2_SEL", 8, 10, &umr_bitfield_default },
	 { "DPCS_DBG_CBUS_DIS", 14, 14, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_WRITE_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_INDEX", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_CNTL[] = {
	 { "RDPCS_CBUS_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SRAM_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE0_EN", 12, 12, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE1_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE2_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE3_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_RD_START_DELAY", 20, 24, &umr_bitfield_default },
	 { "RDPCS_DPALT_BLOCK_STATUS", 26, 26, &umr_bitfield_default },
	 { "RDPCS_CR_REGISTER_BLOCK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_NON_DPALT_REGISTER_BLOCK_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_CLOCK_CNTL[] = {
	 { "RDPCS_EXT_REFCLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX0_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX1_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX2_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX3_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_GATE_DIS", 8, 8, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_CLOCK_ON", 10, 10, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_GATE_DIS", 12, 12, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_CLOCK_ON", 14, 14, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_BYPASS", 16, 16, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_GATE_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_EN", 21, 21, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_CLOCK_ON", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_INTERRUPT_CONTROL[] = {
	 { "RDPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_TX0_FIFO_ERROR", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX1_FIFO_ERROR", 5, 5, &umr_bitfield_default },
	 { "RDPCS_TX2_FIFO_ERROR", 6, 6, &umr_bitfield_default },
	 { "RDPCS_TX3_FIFO_ERROR", 7, 7, &umr_bitfield_default },
	 { "RDPCS_REG_ERROR_CLR", 8, 8, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_CLR", 9, 9, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_CLR", 10, 10, &umr_bitfield_default },
	 { "RDPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "RDPCS_REG_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_MASK", 17, 17, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_MASK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_ERROR_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PLL_UPDATE_DATA[] = {
	 { "RDPCS_PLL_UPDATE_DATA", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCS_TX_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCS_TX_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCS_TX_SRAM_CNTL[] = {
	 { "RDPCS_MEM_PWR_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_FORCE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_PWR_STATE", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_SCRATCH[] = {
	 { "RDPCSTX_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_SPARE[] = {
	 { "RDPCSTX_SPARE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_CNTL2[] = {
	 { "RDPCS_CR_CONVERT_FIFO_EMPTY", 0, 0, &umr_bitfield_default },
	 { "RDPCS_CR_CONVERT_FIFO_FULL", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG[] = {
	 { "RDPCS_DMCU_DPALT_DIS_BLOCK_REG", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_FORCE_SYMCLK_DIV2_DIS", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DEBUG_CONFIG[] = {
	 { "RDPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_8BIT", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_SWAP", 7, 7, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_TEST_CLK", 8, 12, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_EXPIRE", 15, 15, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_MAX", 16, 23, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL0[] = {
	 { "RDPCS_PHY_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_PHY_RESET", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_APB_RESET_N", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_TEST_POWERDOWN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DTB_OUT", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMIMODE_ENABLE", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_RANGE", 9, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_REQ", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_PARA_SEL", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_MUX_SEL", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_RESULT", 25, 25, &umr_bitfield_default },
	 { "RDPCS_SRAM_INIT_DONE", 28, 28, &umr_bitfield_default },
	 { "RDPCS_SRAM_EXT_LD_DONE", 29, 29, &umr_bitfield_default },
	 { "RDPCS_SRAM_BYPASS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL1[] = {
	 { "RDPCS_PHY_PG_MODE_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_EN", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_STABLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_STABLE", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_PG_RESET", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_STABLE", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL2[] = {
	 { "RDPCS_PHY_DP4_POR", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_RX2TX_PAR_LB_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_RX2TX_PAR_LB_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_RX2TX_PAR_LB_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_RX2TX_PAR_LB_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_TX2RX_SER_LB_EN", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_TX2RX_SER_LB_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_TX2RX_SER_LB_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_TX2RX_SER_LB_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL4[] = {
	 { "RDPCS_PHY_DP_TX0_TERM_CTRL", 0, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_INVERT", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_BYPASS_EQ_CALC", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_HP_PROT_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_TERM_CTRL", 8, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_INVERT", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_BYPASS_EQ_CALC", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_HP_PROT_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_TERM_CTRL", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_INVERT", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_BYPASS_EQ_CALC", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_HP_PROT_EN", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_TERM_CTRL", 24, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_INVERT", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_BYPASS_EQ_CALC", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_HP_PROT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL5[] = {
	 { "RDPCS_PHY_DP_TX0_LPD", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_RATE", 1, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_WIDTH", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_REQ", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_RESULT", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_LPD", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RATE", 9, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_WIDTH", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_REQ", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_RESULT", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_LPD", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RATE", 17, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_WIDTH", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_REQ", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_RESULT", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_LPD", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RATE", 25, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_WIDTH", 28, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_REQ", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_RESULT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL7[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_DEN", 0, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_QUOT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL8[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_PEAK", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL9[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE", 0, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL10[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_REM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL11[] = {
	 { "RDPCS_PHY_DP_MPLLB_MULTIPLIER", 4, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_DIV", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_MPLLB_DIV", 20, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_PIXEL_CLK_DIV", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL12[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_TX_CLK_DIV", 4, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_STATE", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL13[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER", 20, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_DIV_CLK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FORCE_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_INIT_CAL_DISABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL14[] = {
	 { "RDPCS_PHY_DP_MPLLB_CAL_FORCE", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_PMIX_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_FUSE0[] = {
	 { "RDPCS_PHY_DP_TX0_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_V2I", 18, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FREQ_VCO", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT_GS", 22, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VREF_CTRL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_FUSE1[] = {
	 { "RDPCS_PHY_DP_TX1_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT", 18, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_FUSE2[] = {
	 { "RDPCS_PHY_DP_TX2_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP_GS", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_FUSE3[] = {
	 { "RDPCS_PHY_DP_TX3_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_FINETUNE", 18, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_RANGE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_TX_VBOOST_LVL", 26, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_RX_VCO_VREF_SEL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_RX_LD_VAL[] = {
	 { "RDPCS_PHY_RX_REF_LD_VAL", 0, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VCO_LD_VAL", 8, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DMCU_DPALT_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET_RESERVED", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE_RESERVED", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN_RESERVED", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ_RESERVED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK_RESERVED", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET_RESERVED", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE_RESERVED", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN_RESERVED", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ_RESERVED", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK_RESERVED", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ_RESERVED", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK_RESERVED", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET_RESERVED", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE_RESERVED", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY_RESERVED", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN_RESERVED", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ_RESERVED", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK_RESERVED", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DMCU_DPALT_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE_RESERVED", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE_RESERVED", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN_RESERVED", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE_RESERVED", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE_RESERVED", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN_RESERVED", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ_RESERVED", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DPALT_CONTROL_REG[] = {
	 { "RDPCS_ALLOW_DRIVER_ACCESS", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DRIVER_ACCESS_BLOCKED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL15[] = {
	 { "RDPCS_PHY_SSTX_VREGDRV_BYP", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_VREGDRV_BYP", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_VREGDRV_BYP", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_VREGDRV_BYP", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_VREGDRV_BYP", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_PRE_HP", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL16[] = {
	 { "RDPCS_PHY_DP_TX0_OUT_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_OUT_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_OUT_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_OUT_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_OUT_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_PHY_CNTL17[] = {
	 { "RDPCS_PHY_DP_TX0_IN_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_IN_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_IN_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_IN_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_IN_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX3_RDPCSTX_DEBUG_CONFIG2[] = {
	 { "RDPCS_DBG_OCLA_SRC0", 0, 2, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC1", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC2", 8, 10, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC3", 12, 14, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_VALID_REPLACE_MSB", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR3_DPCSSYS_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR3_DPCSSYS_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_TX_CLOCK_CNTL[] = {
	 { "DPCS_SYMCLK_GATE_DIS", 0, 0, &umr_bitfield_default },
	 { "DPCS_SYMCLK_EN", 1, 1, &umr_bitfield_default },
	 { "DPCS_SYMCLK_CLOCK_ON", 2, 2, &umr_bitfield_default },
	 { "DPCS_SYMCLK_DIV2_CLOCK_ON", 3, 3, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_TX_CNTL[] = {
	 { "DPCS_TX_PLL_UPDATE_REQ", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_PLL_UPDATE_PENDING", 13, 13, &umr_bitfield_default },
	 { "DPCS_TX_DATA_SWAP", 14, 14, &umr_bitfield_default },
	 { "DPCS_TX_DATA_ORDER_INVERT", 15, 15, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_RD_START_DELAY", 20, 23, &umr_bitfield_default },
	 { "DPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_CBUS_CNTL[] = {
	 { "DPCS_CBUS_WR_CMD_DELAY", 0, 7, &umr_bitfield_default },
	 { "DPCS_CBUS_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_INTERRUPT_CNTL[] = {
	 { "DPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "DPCS_REG_ERROR_CLR", 1, 1, &umr_bitfield_default },
	 { "DPCS_REG_FIFO_ERROR_MASK", 4, 4, &umr_bitfield_default },
	 { "DPCS_TX0_FIFO_ERROR", 8, 8, &umr_bitfield_default },
	 { "DPCS_TX1_FIFO_ERROR", 9, 9, &umr_bitfield_default },
	 { "DPCS_TX2_FIFO_ERROR", 10, 10, &umr_bitfield_default },
	 { "DPCS_TX3_FIFO_ERROR", 11, 11, &umr_bitfield_default },
	 { "DPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "DPCS_TX_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "DPCS_INTERRUPT_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_PLL_UPDATE_ADDR[] = {
	 { "DPCS_PLL_UPDATE_ADDR", 0, 17, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_PLL_UPDATE_DATA[] = {
	 { "DPCS_PLL_UPDATE_DATA", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSTX4_DPCSTX_DEBUG_CONFIG[] = {
	 { "DPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "DPCS_DBG_CFGCLK_SEL", 1, 3, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_SEL", 4, 6, &umr_bitfield_default },
	 { "DPCS_DBG_TX_SYMCLK_DIV2_SEL", 8, 10, &umr_bitfield_default },
	 { "DPCS_DBG_CBUS_DIS", 14, 14, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_WRITE_EN", 16, 16, &umr_bitfield_default },
	 { "DPCS_TEST_DEBUG_INDEX", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_CNTL[] = {
	 { "RDPCS_CBUS_SOFT_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SRAM_SOFT_RESET", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE0_EN", 12, 12, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE1_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE2_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_LANE3_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_EN", 16, 16, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_START", 17, 17, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_RD_START_DELAY", 20, 24, &umr_bitfield_default },
	 { "RDPCS_DPALT_BLOCK_STATUS", 26, 26, &umr_bitfield_default },
	 { "RDPCS_CR_REGISTER_BLOCK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_NON_DPALT_REGISTER_BLOCK_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_TX_SOFT_RESET", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_CLOCK_CNTL[] = {
	 { "RDPCS_EXT_REFCLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX0_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX1_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX2_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_TX3_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_GATE_DIS", 8, 8, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_SYMCLK_DIV2_CLOCK_ON", 10, 10, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_GATE_DIS", 12, 12, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_EN", 13, 13, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_CLOCK_ON", 14, 14, &umr_bitfield_default },
	 { "RDPCS_SRAMCLK_BYPASS", 16, 16, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_GATE_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_EN", 21, 21, &umr_bitfield_default },
	 { "RDPCS_OCLACLK_CLOCK_ON", 22, 22, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_INTERRUPT_CONTROL[] = {
	 { "RDPCS_REG_FIFO_OVERFLOW", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_TX0_FIFO_ERROR", 4, 4, &umr_bitfield_default },
	 { "RDPCS_TX1_FIFO_ERROR", 5, 5, &umr_bitfield_default },
	 { "RDPCS_TX2_FIFO_ERROR", 6, 6, &umr_bitfield_default },
	 { "RDPCS_TX3_FIFO_ERROR", 7, 7, &umr_bitfield_default },
	 { "RDPCS_REG_ERROR_CLR", 8, 8, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_CLR", 9, 9, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_CLR", 10, 10, &umr_bitfield_default },
	 { "RDPCS_TX_ERROR_CLR", 12, 12, &umr_bitfield_default },
	 { "RDPCS_REG_FIFO_ERROR_MASK", 16, 16, &umr_bitfield_default },
	 { "RDPCS_DPALT_DISABLE_TOGGLE_MASK", 17, 17, &umr_bitfield_default },
	 { "RDPCS_DPALT_4LANE_TOGGLE_MASK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_TX_FIFO_ERROR_MASK", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PLL_UPDATE_DATA[] = {
	 { "RDPCS_PLL_UPDATE_DATA", 0, 0, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCS_TX_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCS_TX_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCS_TX_SRAM_CNTL[] = {
	 { "RDPCS_MEM_PWR_DIS", 20, 20, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_FORCE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_MEM_PWR_PWR_STATE", 28, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_SCRATCH[] = {
	 { "RDPCSTX_SCRATCH", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_SPARE[] = {
	 { "RDPCSTX_SPARE", 0, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_CNTL2[] = {
	 { "RDPCS_CR_CONVERT_FIFO_EMPTY", 0, 0, &umr_bitfield_default },
	 { "RDPCS_CR_CONVERT_FIFO_FULL", 1, 1, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG[] = {
	 { "RDPCS_DMCU_DPALT_DIS_BLOCK_REG", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_FORCE_SYMCLK_DIV2_DIS", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DMCU_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DEBUG_CONFIG[] = {
	 { "RDPCS_DBG_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_8BIT", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_ASYNC_SWAP", 7, 7, &umr_bitfield_default },
	 { "RDPCS_DBG_SEL_TEST_CLK", 8, 12, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_EXPIRE", 15, 15, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT_MAX", 16, 23, &umr_bitfield_default },
	 { "RDPCS_DBG_CR_COUNT", 24, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL0[] = {
	 { "RDPCS_PHY_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_PHY_RESET", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_TCA_APB_RESET_N", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_TEST_POWERDOWN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DTB_OUT", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMIMODE_ENABLE", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_RANGE", 9, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_REQ", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_RTUNE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_PARA_SEL", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_CR_MUX_SEL", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_REF_CLKDET_RESULT", 25, 25, &umr_bitfield_default },
	 { "RDPCS_SRAM_INIT_DONE", 28, 28, &umr_bitfield_default },
	 { "RDPCS_SRAM_EXT_LD_DONE", 29, 29, &umr_bitfield_default },
	 { "RDPCS_SRAM_BYPASS", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL1[] = {
	 { "RDPCS_PHY_PG_MODE_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_EN", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_PCS_PWR_STABLE", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_PMA_PWR_STABLE", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_PG_RESET", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_ANA_PWR_STABLE", 7, 7, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL2[] = {
	 { "RDPCS_PHY_DP4_POR", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_RX2TX_PAR_LB_EN", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_RX2TX_PAR_LB_EN", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_RX2TX_PAR_LB_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_RX2TX_PAR_LB_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE0_TX2RX_SER_LB_EN", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE1_TX2RX_SER_LB_EN", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE2_TX2RX_SER_LB_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_LANE3_TX2RX_SER_LB_EN", 11, 11, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL4[] = {
	 { "RDPCS_PHY_DP_TX0_TERM_CTRL", 0, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_INVERT", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_BYPASS_EQ_CALC", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_HP_PROT_EN", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_TERM_CTRL", 8, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_INVERT", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_BYPASS_EQ_CALC", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_HP_PROT_EN", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_TERM_CTRL", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_INVERT", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_BYPASS_EQ_CALC", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_HP_PROT_EN", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_TERM_CTRL", 24, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_INVERT", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_BYPASS_EQ_CALC", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_HP_PROT_EN", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL5[] = {
	 { "RDPCS_PHY_DP_TX0_LPD", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_RATE", 1, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_WIDTH", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_REQ", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DETRX_RESULT", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_LPD", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RATE", 9, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_WIDTH", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_REQ", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DETRX_RESULT", 15, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_LPD", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RATE", 17, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_WIDTH", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_REQ", 22, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DETRX_RESULT", 23, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_LPD", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RATE", 25, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_WIDTH", 28, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_REQ", 30, 30, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DETRX_RESULT", 31, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL7[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_DEN", 0, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_QUOT", 16, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL8[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_PEAK", 0, 19, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL9[] = {
	 { "RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE", 0, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD", 24, 24, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL10[] = {
	 { "RDPCS_PHY_DP_MPLLB_FRACN_REM", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL11[] = {
	 { "RDPCS_PHY_DP_MPLLB_MULTIPLIER", 4, 15, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_DIV", 16, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_MPLLB_DIV", 20, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_HDMI_MPLLB_HDMI_PIXEL_CLK_DIV", 24, 25, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL12[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_TX_CLK_DIV", 4, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_STATE", 7, 7, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_SSC_EN", 8, 8, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL13[] = {
	 { "RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER", 20, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_DIV_CLK_EN", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FORCE_EN", 29, 29, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_INIT_CAL_DISABLE", 30, 30, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL14[] = {
	 { "RDPCS_PHY_DP_MPLLB_CAL_FORCE", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FRACN_EN", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_PMIX_EN", 28, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_FUSE0[] = {
	 { "RDPCS_PHY_DP_TX0_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_V2I", 18, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_FREQ_VCO", 20, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT_GS", 22, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VREF_CTRL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_FUSE1[] = {
	 { "RDPCS_PHY_DP_TX1_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_INT", 18, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP", 25, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_FUSE2[] = {
	 { "RDPCS_PHY_DP_TX2_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_MPLLB_CP_PROP_GS", 23, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_FUSE3[] = {
	 { "RDPCS_PHY_DP_TX3_EQ_MAIN", 0, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_PRE", 6, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_EQ_POST", 12, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_FINETUNE", 18, 23, &umr_bitfield_default },
	 { "RDPCS_PHY_DCO_RANGE", 24, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_TX_VBOOST_LVL", 26, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_RX_VCO_VREF_SEL", 29, 31, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_RX_LD_VAL[] = {
	 { "RDPCS_PHY_RX_REF_LD_VAL", 0, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_RX_VCO_LD_VAL", 8, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DMCU_DPALT_PHY_CNTL3[] = {
	 { "RDPCS_PHY_DP_TX0_RESET_RESERVED", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DISABLE_RESERVED", 1, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_CLK_RDY_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_DATA_EN_RESERVED", 3, 3, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_REQ_RESERVED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_ACK_RESERVED", 5, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_RESET_RESERVED", 8, 8, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DISABLE_RESERVED", 9, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_CLK_RDY_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_DATA_EN_RESERVED", 11, 11, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_REQ_RESERVED", 12, 12, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_ACK_RESERVED", 13, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_RESET_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_CLK_RDY_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_DATA_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_REQ_RESERVED", 20, 20, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_ACK_RESERVED", 21, 21, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_RESET_RESERVED", 24, 24, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DISABLE_RESERVED", 25, 25, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_CLK_RDY_RESERVED", 26, 26, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_DATA_EN_RESERVED", 27, 27, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_REQ_RESERVED", 28, 28, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_ACK_RESERVED", 29, 29, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DMCU_DPALT_PHY_CNTL6[] = {
	 { "RDPCS_PHY_DP_TX0_PSTATE_RESERVED", 0, 1, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_MPLL_EN_RESERVED", 2, 2, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_PSTATE_RESERVED", 4, 5, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_MPLL_EN_RESERVED", 6, 6, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_PSTATE_RESERVED", 8, 9, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_MPLL_EN_RESERVED", 10, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_PSTATE_RESERVED", 12, 13, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_MPLL_EN_RESERVED", 14, 14, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DP4_RESERVED", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_RESERVED", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DPALT_DISABLE_ACK_RESERVED", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_EN_RESERVED", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_REF_CLK_REQ_RESERVED", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DPALT_CONTROL_REG[] = {
	 { "RDPCS_ALLOW_DRIVER_ACCESS", 0, 0, &umr_bitfield_default },
	 { "RDPCS_DRIVER_ACCESS_BLOCKED", 4, 4, &umr_bitfield_default },
	 { "RDPCS_DPALT_CONTROL_SPARE", 8, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL15[] = {
	 { "RDPCS_PHY_SSTX_VREGDRV_BYP", 0, 0, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX0_VREGDRV_BYP", 16, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_VREGDRV_BYP", 17, 17, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_VREGDRV_BYP", 18, 18, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_VREGDRV_BYP", 19, 19, &umr_bitfield_default },
	 { "RDPCS_PHY_SUP_PRE_HP", 20, 20, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL16[] = {
	 { "RDPCS_PHY_DP_TX0_OUT_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_OUT_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_OUT_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_OUT_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_OUT_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_PHY_CNTL17[] = {
	 { "RDPCS_PHY_DP_TX0_IN_GENERIC_BUS", 0, 4, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX1_IN_GENERIC_BUS", 6, 10, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX2_IN_GENERIC_BUS", 12, 16, &umr_bitfield_default },
	 { "RDPCS_PHY_DP_TX3_IN_GENERIC_BUS", 18, 22, &umr_bitfield_default },
	 { "RDPCS_PHY_CMN_IN_GENERIC_BUS", 24, 28, &umr_bitfield_default },
};
static struct umr_bitfield mmRDPCSTX4_RDPCSTX_DEBUG_CONFIG2[] = {
	 { "RDPCS_DBG_OCLA_SRC0", 0, 2, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC1", 4, 6, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC2", 8, 10, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_SRC3", 12, 14, &umr_bitfield_default },
	 { "RDPCS_DBG_OCLA_VALID_REPLACE_MSB", 16, 16, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR4_DPCSSYS_CR_ADDR[] = {
	 { "RDPCS_TX_CR_ADDR", 0, 15, &umr_bitfield_default },
};
static struct umr_bitfield mmDPCSSYS_CR4_DPCSSYS_CR_DATA[] = {
	 { "RDPCS_TX_CR_DATA", 0, 15, &umr_bitfield_default },
};
