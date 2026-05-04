#!/usr/bin/env bash

DUMPSCRATCH=""
DUMPMEC=""
REBUILD=""

#figure out where scripts are installed and source functions
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
appdir="${dir}/../../src/app"

#We need halt_if_hws_hang=1 for the logs to be valid
if [ "$(cat /sys/module/amdgpu/parameters/halt_if_hws_hang)" -ne 1 ]; then
        echo "halt_if_hws_hang must be set to 1. Exiting"
        echo "Please run: echo 1 > /sys/module/amdgpu/parameters/halt_if_hws_hang"
        exit 1
fi

#relaunch ourself as root
if [ `whoami` != root ]; then
	sudo ${dir}/dump_all_cpc_info.sh "$@"
	exit 0
fi

while [ "$1" != "" ]; do
	case "$1" in
		all )
			DUMPSCRATCH="true"; DUMPMEC="true" ;;
		mec )
			DUMPMEC="true" ;;
		rebuild )
			REBUILD="true" ;;
		* )
			echo "Unknown parameter $1. Ignoring" ;;
	esac
	shift 1
done

#save current dir
where=`pwd`

# build a local copy of umr
install_deps() {
        # Cross-distro dependency installation for building UMR
        if command -v apt-get >/dev/null 2>&1; then
                apt-get update -y
                apt-get install -y build-essential libpciaccess-dev libncurses-dev cmake git
        elif command -v dnf >/dev/null 2>&1; then
                dnf install -y gcc gcc-c++ make libpciaccess-devel ncurses-devel cmake git
        elif command -v yum >/dev/null 2>&1; then
                yum install -y gcc gcc-c++ make libpciaccess-devel ncurses-devel cmake git
        elif command -v zypper >/dev/null 2>&1; then
                zypper --non-interactive install -y gcc gcc-c++ make libpciaccess-devel ncurses-devel cmake git
        fi
}

# Install build dependencies and build, only if we haven't built it already
if [[ ! -f "${appdir}/umr" || "$REBUILD" == "true" ]]; then
	install_deps
	cd ${dir}/../../
	git clean -dxf
	cmake -DUMR_NO_GUI=on -DUMR_NO_DRM=ON -DUMR_NO_LLVM=ON -DUMR_NO_SERVER=ON .
	make -j umr
fi
export PATH="${appdir}:${PATH}"
cd ${dir}

prefix="$(hostname)_$(date +"%Y-%m-%d_%H_%M")"
kfddbg="/sys/kernel/debug/kfd"
cat "${kfddbg}/rls" 2>&1 >"${prefix}_rls.txt"

# start dumping data
source ${dir}/diag_functions.sh
iter_over_gpu_xcc dump_cpc
iter_over_gpu_xcc dump_waves
dump_fw_info
dump_amdgpu_params

echo "Generating ${prefix}_dmesg.txt"
journalctl -b -k > "${prefix}_dmesg.txt"

#collect results
tar -czvf ${where}/${prefix}_logs.tgz *.txt

#return user to directory they started in
cd ${where}

echo
echo "Logs were tar'ed up in ${where}/${prefix}_logs.tgz"
echo
