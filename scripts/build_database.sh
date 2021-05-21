#!/bin/bash
make -C ../comp/

parse_reg_bits() {
	if [ -e ${pk}/include/asic_reg/$1_offset.h ]; then suf="offset"; fi
	if [ -e ${pk}/include/asic_reg/$1_d.h ]; then suf="d"; export UMR_NO_SOC15=1; fi
	../comp/compiler ${pk}/include/asic_reg/$1_${suf}.h ${pk}/include/asic_reg/$1_sh_mask.h > ../database/ip/$2
	unset UMR_NO_SOC15
}

cd ${pk}
git checkout amd-staging-drm-next
git reset --hard origin/amd-staging-drm-next
cd -

# random bits
UMR_NO_SOC15=1 ../comp/compiler ${pk}/include/asic_reg/gca/gfx_7_0_d.h ${pk}/include/asic_reg/gca/gfx_7_2_sh_mask.h > ../database/ip/gfx_7_0_0.reg    # there is no shift/mask for 7.0.0

# regular headers
parse_reg_bits athub/athub_1_0 athub_1_0_0.reg
parse_reg_bits athub/athub_2_0_0 athub_2_0_0.reg
parse_reg_bits athub/athub_2_1_0 athub_2_1_0.reg

parse_reg_bits bif/bif_3_0 bif_3_0_0.reg
parse_reg_bits bif/bif_4_1 bif_4_1_0.reg
parse_reg_bits bif/bif_5_0 bif_5_0_0.reg
parse_reg_bits bif/bif_5_1 bif_5_1_0.reg

parse_reg_bits clk/clk_10_0_2 clk_10_0_2.reg
parse_reg_bits clk/clk_11_0_0 clk_11_0_0.reg
parse_reg_bits clk/clk_11_5_0 clk_11_5_0.reg

parse_reg_bits dce/dce_6_0 dce_6_0_0.reg
parse_reg_bits dce/dce_8_0 dce_8_0_0.reg
parse_reg_bits dce/dce_10_0 dce_10_0_0.reg
parse_reg_bits dce/dce_11_0 dce_11_0_0.reg
parse_reg_bits dce/dce_11_2 dce_11_2_0.reg
parse_reg_bits dce/dce_12_0 dce_12_0_0.reg

parse_reg_bits dcn/dcn_1_0 dcn_1_0_0.reg
parse_reg_bits dcn/dcn_2_0_0 dcn_2_0_0.reg
parse_reg_bits dcn/dcn_2_1_0 dcn_2_1_0.reg
parse_reg_bits dcn/dcn_3_0_0 dcn_3_0_0.reg
parse_reg_bits dcn/dcn_3_0_1 dcn_3_0_1.reg
parse_reg_bits dcn/dcn_3_0_2 dcn_3_0_2.reg
parse_reg_bits dcn/dcn_3_0_3 dcn_3_0_3.reg
parse_reg_bits dcn/dpcs_3_0_0 dpcs_3_0_0.reg

parse_reg_bits df/df_1_7 df_1_7_0.reg
parse_reg_bits df/df_3_6 df_3_6_0.reg

parse_reg_bits dpcs/dpcs_2_0_0 dpcs_2_0_0.reg
parse_reg_bits dpcs/dpcs_2_1_0 dpcs_2_1_0.reg

parse_reg_bits gc/gc_9_0 gc_9_0_0.reg
parse_reg_bits gc/gc_9_1 gc_9_1_0.reg
parse_reg_bits gc/gc_9_2_1 gc_9_2_1.reg
parse_reg_bits gc/gc_9_4_1 gc_9_4_1.reg
parse_reg_bits gc/gc_10_1_0 gc_10_1_0.reg
parse_reg_bits gc/gc_10_3_0 gc_10_3_0.reg

parse_reg_bits gca/gfx_6_0 gfx_6_0_0.reg
parse_reg_bits gca/gfx_7_2 gfx_7_2_0.reg
parse_reg_bits gca/gfx_8_0 gfx_8_0_0.reg
parse_reg_bits gca/gfx_8_1 gfx_8_1_0.reg

parse_reg_bits gmc/gmc_6_0 gmc_6_0_0.reg
parse_reg_bits gmc/gmc_7_0 gmc_7_0_0.reg
parse_reg_bits gmc/gmc_7_1 gmc_7_1_0.reg
parse_reg_bits gmc/gmc_8_1 gmc_8_1_0.reg
parse_reg_bits gmc/gmc_8_2 gmc_8_2_0.reg

parse_reg_bits hdp/hdp_4_0 hdp_4_0_0.reg
parse_reg_bits hdp/hdp_5_0_0 hdp_5_0_0.reg

parse_reg_bits mmhub/mmhub_9_1 mmhub_9_1_0.reg
parse_reg_bits mmhub/mmhub_9_3_0 mmhub_9_3_0.reg
parse_reg_bits mmhub/mmhub_9_4_1 mmhub_9_4_1.reg
parse_reg_bits mmhub/mmhub_1_0 mmhub_1_0_0.reg
parse_reg_bits mmhub/mmhub_2_0_0 mmhub_2_0_0.reg
parse_reg_bits mmhub/mmhub_2_3_0 mmhub_2_3_0.reg

parse_reg_bits mp/mp_9_0 mp_9_0_0.reg
parse_reg_bits mp/mp_10_0 mp_10_0_0.reg
parse_reg_bits mp/mp_11_0 mp_11_0_0.reg
parse_reg_bits mp/mp_11_5_0 mp_11_5_0.reg
parse_reg_bits mp/mp_12_0_0 mp_12_0_0.reg

parse_reg_bits nbif/nbif_6_1 nbif_6_1_0.reg

parse_reg_bits nbio/nbio_2_3 nbio_2_3_0.reg
parse_reg_bits nbio/nbio_6_1 nbio_6_1_0.reg
parse_reg_bits nbio/nbio_7_0 nbio_7_0_0.reg
parse_reg_bits nbio/nbio_7_2_0 nbio_7_2_0.reg
parse_reg_bits nbio/nbio_7_4 nbio_7_4_0.reg

parse_reg_bits oss/oss_1_0 oss_1_0_0.reg
parse_reg_bits oss/oss_2_0 oss_2_0_0.reg
parse_reg_bits oss/oss_2_4 oss_2_4_0.reg
parse_reg_bits oss/oss_3_0 oss_3_0_0.reg
parse_reg_bits oss/oss_3_0_1 oss_3_0_1.reg

parse_reg_bits oss/osssys_4_0 osssys_4_0_0.reg
parse_reg_bits oss/osssys_4_0_1 osssys_4_0_1.reg
parse_reg_bits oss/osssys_4_2_0 osssys_4_2_0.reg
parse_reg_bits oss/osssys_5_0_0 osssys_5_0_0.reg

parse_reg_bits pwr/pwr_10_0 pwr_10_0_0.reg

parse_reg_bits rsmu/rsmu_0_0_2 rsmu_0_0_2.reg

parse_reg_bits sdma0/sdma0_4_0 sdma0_4_0_0.reg
parse_reg_bits sdma0/sdma0_4_1 sdma0_4_1_0.reg
parse_reg_bits sdma0/sdma0_4_2 sdma0_4_2_0.reg
parse_reg_bits sdma0/sdma0_4_2_2 sdma0_4_2_2.reg

parse_reg_bits sdma1/sdma1_4_0 sdma1_4_0_0.reg
parse_reg_bits sdma1/sdma1_4_2 sdma1_4_2_0.reg
parse_reg_bits sdma1/sdma1_4_2_2 sdma1_4_2_2.reg

parse_reg_bits sdma2/sdma2_4_2_2 sdma2_4_2_2.reg
parse_reg_bits sdma3/sdma3_4_2_2 sdma3_4_2_2.reg
parse_reg_bits sdma4/sdma4_4_2_2 sdma4_4_2_2.reg
parse_reg_bits sdma5/sdma5_4_2_2 sdma5_4_2_2.reg
parse_reg_bits sdma6/sdma6_4_2_2 sdma6_4_2_2.reg
parse_reg_bits sdma7/sdma7_4_2_2 sdma7_4_2_2.reg

parse_reg_bits smu/smu_6_0 smu_6_0_0.reg
parse_reg_bits smu/smu_7_0_0 smu_7_0_0.reg
parse_reg_bits smu/smu_7_0_1 smu_7_0_1.reg
parse_reg_bits smu/smu_7_1_0 smu_7_1_0.reg
parse_reg_bits smu/smu_7_1_1 smu_7_1_1.reg
parse_reg_bits smu/smu_7_1_2 smu_7_1_2.reg
parse_reg_bits smu/smu_7_1_3 smu_7_1_3.reg
parse_reg_bits smu/smu_8_0 smu_8_0_0.reg

parse_reg_bits smuio/smuio_9_0 smuio_9_0_0.reg
parse_reg_bits smuio/smuio_11_0_0 smuio_11_0_0.reg
parse_reg_bits smuio/smuio_11_0_6 smuio_11_0_6.reg
parse_reg_bits smuio/smuio_12_0_0 smuio_12_0_0.reg

parse_reg_bits thm/thm_9_0 thm_9_0_0.reg
parse_reg_bits thm/thm_10_0 thm_10_0_0.reg
parse_reg_bits thm/thm_11_0_2 thm_11_0_2.reg

parse_reg_bits umc/umc_6_0 umc_6_0_0.reg
parse_reg_bits umc/umc_6_1_1 umc_6_1_1.reg
parse_reg_bits umc/umc_6_1_2 umc_6_1_2.reg
parse_reg_bits umc/umc_8_7_0 umc_8_7_0.reg

parse_reg_bits uvd/uvd_3_1 uvd_3_1_0.reg
parse_reg_bits uvd/uvd_4_0 uvd_4_0_0.reg
parse_reg_bits uvd/uvd_4_2 uvd_4_2_0.reg
parse_reg_bits uvd/uvd_5_0 uvd_5_0_0.reg
parse_reg_bits uvd/uvd_6_0 uvd_6_0_0.reg
parse_reg_bits uvd/uvd_7_0 uvd_7_0_0.reg

parse_reg_bits vce/vce_1_0 vce_1_0_0.reg
parse_reg_bits vce/vce_2_0 vce_2_0_0.reg
parse_reg_bits vce/vce_3_0 vce_3_0_0.reg
parse_reg_bits vce/vce_4_0 vce_4_0_0.reg

parse_reg_bits vcn/vcn_1_0 vcn_1_0_0.reg
parse_reg_bits vcn/vcn_2_0_0 vcn_2_0_0.reg
parse_reg_bits vcn/vcn_2_5 vcn_2_5_0.reg
parse_reg_bits vcn/vcn_3_0_0 vcn_3_0_0.reg

../comp/compiler ${pk}/include/arct_ip_offset.h > ../database/arcturus.soc15
../comp/compiler ${pk}/include/dimgrey_cavefish_ip_offset.h > ../database/dimgrey_cavefish.soc15
../comp/compiler ${pk}/include/navi10_ip_offset.h > ../database/navi10.soc15
../comp/compiler ${pk}/include/navi12_ip_offset.h > ../database/navi12.soc15
../comp/compiler ${pk}/include/navi14_ip_offset.h > ../database/navi14.soc15
../comp/compiler ${pk}/include/renoir_ip_offset.h > ../database/renoir.soc15
../comp/compiler ${pk}/include/sienna_cichlid_ip_offset.h > ../database/sienna_cichlid.soc15
../comp/compiler ${pk}/include/vega10_ip_offset.h > ../database/vega10.soc15
../comp/compiler ${pk}/include/vega20_ip_offset.h > ../database/vega20.soc15
../comp/compiler ${pk}/include/vangogh_ip_offset.h > ../database/vangogh.soc15
../comp/compiler ${pk}/include/beige_goby_ip_offset.h > ../database/beige_goby.soc15

make -C ../comp clean

