#dump_waves [did] [ring_name]
#did must start with 0x
dump_waves() {
	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		gpulist=`umr --script pci-instances $1`
		shift
	else
		gpulist=`umr --script instances`
	fi

	if [ "$1" == "" ]; then
		ring="none"
	else
		ring="$1"
	fi

	gpu=0
	for g in ${gpulist}; do
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			filename="${prefix}_umr_waves_gpu${gpu}_xcc${xcc}.txt"
			echo "Generating $filename"
			umr -i "${g}" -vmp "${xcc}" -O bits,halt_waves -wa ${ring} 2>&1 >"${filename}"
		done
		gpu=$((gpu + 1))
	done
}

#dump_cpc [did]
#did must start with 0x
dump_cpc() {
	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		gpulist=`umr --script pci-instances $1`
		shift
	else
		gpulist=`umr --script instances`
	fi

	# Iterate through the GPU list
	gpu=0
	for g in ${gpulist}; do
		# Iterate through XCC values
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			# Generate filename
			filename="${prefix}_umr_cpc_gpu${gpu}_xcc${xcc}.txt"
			echo "Generating $filename"

			# Execute command and redirect output
			umr -i "${g}" -vmp "${xcc}" -cpc >"${filename}" 2>&1
		done
		gpu=$((gpu + 1))
	done
}

#dump_cp_regs [did]
#did must start with 0x
dump_cp_regs() {
	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		gpulist=`umr --script pci-instances $1`
		shift
	else
		gpulist=`umr --script instances`
	fi

	gpu=0
	for g in ${gpulist}; do
		gfxname=`umr --script gfxname ${g}`
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			filename="${prefix}_umr_cp_regs_gpu${gpu}_xcc${xcc}.txt"
			echo "Generating $filename"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCPC_UTCL1_STATUS" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCPF_UTCL1_STATUS" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCPG_UTCL1_STATUS" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_INT_STAT_DEBUG" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_ME1_INT_STAT_DEBUG" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_ME2_INT_STAT_DEBUG" 2>&1 >>"${filename}"

			echo "PQ fetcher" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 0 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			echo "IB fetcher" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 1 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			echo "EOP fetcher" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 2 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			echo "EQ fetcher" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 3 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			echo "PQ RPTR report fetcher utcl1" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 4 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			echo "PQ WPTR poll fetcher utcl1" 1>>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -w "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_CNTL" 5 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR" 2>&1 >>"${filename}"
			umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regCP_HPD_UTCL1_ERROR_ADDR" 2>&1 >>"${filename}"

			for count in {0..7}; do
				umr -i "${g}" -vmp "${xcc}" -r "*.${gfxname}{${xcc}}.regSPI_CSQ_WF_ACTIVE_COUNT_${count}" 2>&1 >>"${filename}"
			done
		done
		gpu=$((gpu + 1))
	done
}

#dump_headers [did]
#did must start with 0x
dump_headers() {
	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		gpulist=`umr --script pci-instances $1`
		shift
	else
		gpulist=`umr --script instances`
	fi

	# Iterate through the GPU list
	gpu=0
	for g in ${gpulist}; do
		# Iterate through XCC values
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			filename="${prefix}_umr_cpc_gpu${gpu}_xcc${xcc}.txt"
			# Generate filename
			echo "Generating $filename"
			for pipe in {0..3}; do
				echo "Pipe ${pipe} headers" >> "${filename}"
				# Execute command and redirect output
				for count in {0..7}; do
					umr -i "${g}" -vmp "${xcc}" -sb 1 "$pipe" 0 -r *.*.CP_MEC_ME1_HEADER_DUMP 2>&1 >> "${filename}"
				done
			done
		done
		gpu=$((gpu + 1))
	done
}

#dump_cp_regs [did]
#did must start with 0x
dump_cpc_scratch_mems() {
	dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		gpulist=`umr --script pci-instances $1`
		shift
	else
		gpulist=`umr --script instances`
	fi

	gpu=0
	for g in $gpulist; do
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			filename="${prefix}_cpc_scratch_gpu${gpu}_xcc${xcc}.bin"
			echo "Generating $filename"
			"${dir}"/cpc_scratch -p "${gpu}" -x "${xcc}" -o "${filename}" 2>>"${filename}"
		done
		gpu=$((gpu + 1))
	done
}
