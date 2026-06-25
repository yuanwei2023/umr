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
	umr -i "${g}" -vmp "${xcc}" -O bits,halt_waves,no_backtrace -wa ${ring} 2>>"$errorlog" >"${filename}"
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
	umr -i "${g}" -vmp "${xcc}" -cpc -O no_backtrace >"${filename}" 2>>"$errorlog"
}

# Dump FW versions
dump_fw_info() {
	filename="${prefix}_fw_info.txt"

	fw_path=$(find /sys/kernel/debug/dri -type f -name amdgpu_firmware_info 2>>"$errorlog" | head -n 1)
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
