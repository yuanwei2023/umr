#!/usr/bin/bash

#figure out where scripts are installed and source functions
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#relaunch ourself as root
if [ `whoami` != root ]; then
	sudo ${dir}/dump_all_cpc_info.sh
	exit 0
fi

#save current dir
where=`pwd`

# build a local copy of umr
apt install build-essential libpciaccess-dev libncurses-dev cmake git -y
cd ${dir}/../../
git clean -dxf
cmake -DUMR_NO_GUI=on -DUMR_NO_DRM=ON -DUMR_NO_LLVM=ON -DUMR_NO_SERVER=ON .
make -j umr
export PATH=`pwd`/src/app:${PATH}
cd ${dir}

# start dumping data
source ${dir}/diag_functions.sh
dump_cpc
dump_waves

prefix="$(hostname)_$(date +"%Y-%m-%d_%H_%M")"
kfddbg="/sys/kernel/debug/kfd"
cat "${kfddbg}/rls" 2>&1 >"${prefix}_rls.txt"
cat "${kfddbg}/mqds" 2>&1 >"${prefix}_mqds.txt"

dump_cpc_scratch_mems
dump_cp_regs

#collect results
tar -czvf ${where}/${prefix}_logs.tgz *.txt

#return user to directory they started in
cd ${where}

echo
echo "Logs were tar'ed up in ${where}/${prefix}_logs.tgz"
echo