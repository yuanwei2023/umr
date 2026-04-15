iter_over_gpu_xcc() {
	local func="$1"
	shift

	# Determine GPU list based on vendor
	p=`echo $1 | cut -b1-2`
	if [ "$p" == "0x" ]; then
		local gpulist=`umr --script pci-instances $1`
		shift
	else
		local gpulist=`umr --script instances`
	fi

	local g
	local gpu=0
	for g in ${gpulist}; do
		xccs="$(umr --script xcds ${g})"
		if [ -z "$xccs" ]; then
			xccs=-1
		fi
		for xcc in ${xccs}; do
			${func} ${g} ${xcc} ${gpu} $@
		done
		gpu=$((gpu + 1))
	done
}


#dump_waves [did] [ring_name]
#did must start with 0x
dump_waves() {
	local g="$1"
	local xcc="$2"
	local gpu="$3"

	if [ "$4" == "" ]; then
		ring="none"
	else
		ring="$4"
	fi

	filename="${prefix}_umr_waves_gpu${gpu}_xcc${xcc}.txt"
	if [ "$xcc" = -1 ]; then
		filename="${prefix}_umr_waves_gpu${gpu}.txt"
	fi
	echo "Generating $filename"
	umr -i "${g}" -vmp "${xcc}" -O bits,halt_waves -wa ${ring} 2>&1 >"${filename}"
}

#dump_cpc [did]
#did must start with 0x
dump_cpc() {
	local g="$1"
	local xcc="$2"
	local gpu="$3"

	# Generate filename
	filename="${prefix}_umr_cpc_gpu${gpu}_xcc${xcc}.txt"
	if [ "$xcc" = -1 ]; then
		filename="${prefix}_umr_cpc_gpu${gpu}.txt"
	fi
	echo "Generating $filename"

	# Execute command and redirect output
	umr -i "${g}" -vmp "${xcc}" -cpc >"${filename}" 2>&1
}

#dump_headers [did]
#did must start with 0x
dump_headers() {
	local g="$1"
	local xcc="$2"
	local gpu="$3"
	local gfxname=`umr --script gfxname ${g}`

	filename="${prefix}_umr_cpc_gpu${gpu}_xcc${xcc}.txt"
	# Generate filename
	if [ "$xcc" = -1 ]; then
		filename="${prefix}_umr_cpc_gpu${gpu}.txt"
	fi
	echo "Dumping MEC headers"
	for pipe in {0..3}; do
		echo "Pipe ${pipe} headers" >> "${filename}"
		# Execute command and redirect output
		for count in {0..7}; do
			if [ "$xcc" = -1 ]; then
				umr -i "${g}" -sb 1 "$pipe" 0 -r *.${gfxname}.CP_MEC_ME1_HEADER_DUMP 2>&1 >> "${filename}"
			else
				umr -i "${g}" -vmp "${xcc}" -sb 1 "$pipe" 0 -r *.${gfxname}{${xcc}}.CP_MEC_ME1_HEADER_DUMP 2>&1 >> "${filename}"
			fi
		done
	done
}

#dump_cpc_scratch_mems [did]
#did must start with 0x
dump_cpc_scratch_mems() {
	local g="$1"
	local xcc="$2"
	local gpu="$3"
	local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	filename="${prefix}_cpc_scratch_gpu${gpu}_xcc${xcc}.bin"
	if [ "$xcc" = -1 ]; then
		filename="${prefix}_cpc_scratch_gpu${gpu}.bin"
	fi
	echo "Generating $filename"
	"${dir}"/cpc_scratch -p "${gpu}" -x "${xcc}" -o "${filename}" 2>>"${filename}"
}

# Dump FW versions
dump_fw_info() {
	filename="${prefix}_fw_info.txt"

	fw_path=$(find /sys/kernel/debug/dri -type f -name amdgpu_firmware_info 2>/dev/null | head -n 1)
	echo "Generating $filename"
	cat $fw_path > $filename
}

# Dump amdgpu parameter values
dump_amdgpu_params() {
	filename="${prefix}_params.txt"

	echo "Generating $filename"
	for f in /sys/module/amdgpu/parameters/*; do
                printf "%s = %s\n" "$(basename "$f")" "$(cat "$f")" >> $filename
	done
}
