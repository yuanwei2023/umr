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
		for xcc in `umr --script xcds ${g}`; do
			filename="$(hostname)_$(date +"%Y-%m-%d_%H_%M")_umr_waves_gpu${gpu}_xcc${xcc}.txt"
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
		for xcc in `umr --script xcds ${g}`; do
            # Generate filename
            filename="$(hostname)_$(date +"%Y-%m-%d_%H_%M")_umr_cpc_gpu${gpu}_xcc${xcc}.txt"
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
		for xcc in `umr --script xcds ${g}`; do
			filename="$(hostname)_$(date +"%Y-%m-%d_%H_%M")_umr_cp_regs_gpu${gpu}_xcc${xcc}.txt"
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
		for xcc in `umr --script xcds ${g}`; do
			filename="$(hostname)_$(date +"%Y-%m-%d_%H_%M")_cpc_scratch_gpu${gpu}_xcc${xcc}.bin"
			echo "Generating $filename"
			"${dir}"/cpc_scratch -p "${gpu}" -x "${xcc}" -o "${filename}" 2>>"${filename}"
		done
		gpu=$((gpu + 1))
	done
}