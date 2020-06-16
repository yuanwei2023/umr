#!/bin/bash

# this script generates the *_bits.i and *_regs.i files soc15 ASICs

#this is the path to the tree (not necessarily the one running on your host)
if [ -z "${pk}" ]; then
	pk=/stuff/work/linux/drivers/gpu/drm/amd/include/asic_reg/
fi

# parse_bits /path/to/asic_reg/foo/block /path/to/umr/file
parse_bits() {
regfile=$1_offset.h
bitfile=$1_sh_mask.h
smnfile=$1_smn.h

if [ ! -f ${regfile} ]; then printf "Cannot find reg file ${regfile}\n"; exit 1; fi
if [ ! -f ${bitfile} ]; then printf "Cannot find bit file ${bitfile}\n"; exit 1; fi
if [ ! -f ${smnfile} ]; then smnfile=""; fi

printf "Parsing ${regfile} ${smnfile}\n"

grep -E "(smn|mm|ix)" ${regfile} ${smnfile} | grep -v _BASE_IDX | grep -v "_DEFAULT.+" | grep -v "addressBlock:" | (while read line; do
	reg=`echo "${line}" | awk '{ print $2; }'`
	addr=`echo "${line}" | awk '{ print $3; }'`
	regclean=`echo ${reg} | sed -e 's/^mm//g' | sed -e 's/^ix//g'`
	regidx=`grep ${reg}_BASE_IDX ${regfile} | awk '{ print $3; }'`
	if [ "${regidx}" == "" ]; then regidx="0"; fi

	`echo ${reg} | grep '^smn' > /dev/null`
	if [ $? != 0 ]; then
		`echo ${reg} | grep '^mm' > /dev/null` ;
		if [ $? != 0 ]; then
			class="SMC";
		else
			class="MMIO";
		fi;
	else
		class="PCIE";
	fi
	if grep "[ 	]${regclean}__" ${bitfile} > /dev/null; then
		# has bit definitions ...
		# now we parse out bits
		printf "static struct umr_bitfield ${reg}[] = {\n" >> /tmp/bits.2
		grep "[ 	]${regclean}__" ${bitfile} | grep "_MASK[ 	]" | grep -v "__SHIFT[ 	]" | ( while read bitline; do
			rm -f /tmp/bits.3
			bitmask=`echo ${bitline} | awk '{ print $3; }'`
			bitname=`echo ${bitline} | awk '{ print $2; }'`
			bitnameclean=`echo ${bitname} | sed -e "s/^${regclean}__//" | sed -e 's/_MASK$//'`
			bitidx=`/tmp/countbits ${bitmask}`
			echo $? > /tmp/bits.3
			printf "\t { \"${bitnameclean}\", ${bitidx}, &umr_bitfield_default },\n" >> /tmp/bits.2
		done; )
		# output reg declaration
		bit64=`cat /tmp/bits.3`
		printf "\t{ \"${reg}\", REG_${class}, ${addr}, ${regidx}, &${reg}[0], sizeof(${reg})/sizeof(${reg}[0]), ${bit64}, 0 },\n" >> /tmp/bits.1
		printf "};\n" >> /tmp/bits.2
	else
		printf "\t{ \"${reg}\", REG_${class}, ${addr}, ${regidx}, NULL, 0, 0, 0 },\n" >> /tmp/bits.1
	fi
done; )
	mv -vf /tmp/bits.1 $2_regs.i
	mv -vf /tmp/bits.2 $2_bits.i
}

if [ ! -d ${pk} ]; then
	printf "The kernel headers were not found in [${pk}]\n"
	exit 1
fi

rm -f /tmp/bits.1 /tmp/bits.2 /tmp/bits.3 /tmp/countbits*

(cat <<ENDCB
#include <stdio.h>
#include <stdint.h>
int main(int argc, char **argv)
{
	uint64_t value, x, y;
	y = 0;
	if (sscanf(argv[1], "0x%016lx", &value)) {
		x = 0;
		while (!(value & 1) && x < 64) { x++; value >>= 1; }
		if (x > 31) y |= 1;
		printf("%lu, ", x);
		while ((value & 1) && x < 64) { x++; value >>= 1; }
		if (x > 32) y |= 1;
		printf("%lu", x-1);
	}
	return y;
}
ENDCB
) > /tmp/countbits.c
gcc /tmp/countbits.c -o /tmp/countbits

parse_bits ${pk}/pwr/pwr_10_0 src/lib/ip/pwr1000
parse_bits ${pk}/smuio/smuio_12_0_0 src/lib/ip/smuio1200

parse_bits ${pk}/umc/umc_6_1_1 src/lib/ip/umc611
parse_bits ${pk}/umc/umc_6_1_2 src/lib/ip/umc612

#renoir
parse_bits ${pk}/mp/mp_12_0_0 src/lib/ip/mp1200
parse_bits ${pk}/clk/clk_10_0_2 src/lib/ip/clk1002
parse_bits ${pk}/dcn/dcn_2_1_0 src/lib/ip/dcn210
parse_bits ${pk}/dpcs/dpcs_2_1_0 src/lib/ip/dpcs210

#arcturus
parse_bits ${pk}/mmhub/mmhub_9_4_1 src/lib/ip/mmhub941
parse_bits ${pk}/sdma0/sdma0_4_2_2 src/lib/ip/sdma0422
parse_bits ${pk}/sdma1/sdma1_4_2_2 src/lib/ip/sdma1422
parse_bits ${pk}/sdma2/sdma2_4_2_2 src/lib/ip/sdma2422
parse_bits ${pk}/sdma3/sdma3_4_2_2 src/lib/ip/sdma3422
parse_bits ${pk}/sdma4/sdma4_4_2_2 src/lib/ip/sdma4422
parse_bits ${pk}/sdma5/sdma5_4_2_2 src/lib/ip/sdma5422
parse_bits ${pk}/sdma6/sdma6_4_2_2 src/lib/ip/sdma6422
parse_bits ${pk}/sdma7/sdma7_4_2_2 src/lib/ip/sdma7422
parse_bits ${pk}/vcn/vcn_2_5 src/lib/ip/vcn250

#navi 10
parse_bits ${pk}/athub/athub_2_0_0 src/lib/ip/athub200
parse_bits ${pk}/clk/clk_11_0_0 src/lib/ip/clk1100
parse_bits ${pk}/dcn/dcn_2_0_0 src/lib/ip/dcn200
parse_bits ${pk}/gc/gc_10_1_0 src/lib/ip/gfx1010
parse_bits ${pk}/hdp/hdp_5_0_0 src/lib/ip/hdp500
parse_bits ${pk}/mmhub/mmhub_2_0_0 src/lib/ip/mmhub200
parse_bits ${pk}/mp/mp_11_0 src/lib/ip/mp1100
parse_bits ${pk}/nbio/nbio_2_3 src/lib/ip/nbio230
parse_bits ${pk}/oss/osssys_5_0_0 src/lib/ip/oss50
parse_bits ${pk}/smuio/smuio_11_0_0 src/lib/ip/smu1100
parse_bits ${pk}/thm/thm_11_0_2 src/lib/ip/thm1102
parse_bits ${pk}/vcn/vcn_2_0_0 src/lib/ip/vcn200

parse_bits ${pk}/sdma1/sdma1_4_2 src/lib/ip/sdma142
parse_bits ${pk}/sdma0/sdma0_4_2 src/lib/ip/sdma042

parse_bits ${pk}/dce/dce_12_0 src/lib/ip/dce120
parse_bits ${pk}/vce/vce_4_0 src/lib/ip/vce40
parse_bits ${pk}/uvd/uvd_7_0 src/lib/ip/uvd70
parse_bits ${pk}/sdma1/sdma1_4_0 src/lib/ip/sdma140
parse_bits ${pk}/sdma0/sdma0_4_0 src/lib/ip/sdma040
parse_bits ${pk}/thm/thm_9_0 src/lib/ip/thm90
parse_bits ${pk}/oss/osssys_4_0 src/lib/ip/oss40
parse_bits ${pk}/gc/gc_9_0 src/lib/ip/gfx90
parse_bits ${pk}/nbio/nbio_6_1 src/lib/ip/nbio61
parse_bits ${pk}/hdp/hdp_4_0 src/lib/ip/hdp40
parse_bits ${pk}/mmhub/mmhub_1_0 src/lib/ip/mmhub10
parse_bits ${pk}/mp/mp_9_0 src/lib/ip/mp90
parse_bits ${pk}/umc/umc_6_0 src/lib/ip/umc60

parse_bits ${pk}/vcn/vcn_1_0 src/lib/ip/vcn10
parse_bits ${pk}/dcn/dcn_1_0 src/lib/ip/dcn10
parse_bits ${pk}/mmhub/mmhub_9_1 src/lib/ip/mmhub91
parse_bits ${pk}/mp/mp_10_0 src/lib/ip/mp100
parse_bits ${pk}/nbio/nbio_7_0 src/lib/ip/nbio70
parse_bits ${pk}/sdma0/sdma0_4_1 src/lib/ip/sdma041
parse_bits ${pk}/mp/mp_10_0 src/lib/ip/mp100
parse_bits ${pk}/gc/gc_9_1 src/lib/ip/gfx91

parse_bits ${pk}/gc/gc_9_2_1 src/lib/ip/gfx921
parse_bits ${pk}/mmhub/mmhub_9_3_0 src/lib/ip/mmhub930
parse_bits ${pk}/oss/osssys_4_0_1 src/lib/ip/oss401
