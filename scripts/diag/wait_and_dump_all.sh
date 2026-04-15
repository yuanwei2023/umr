#!/usr/bin/bash

REBUILD=""

#figure out where scripts are installed and source functions
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#relaunch ourself as root
if [ `whoami` != root ]; then
    sudo ${dir}/wait_and_dump_all.sh "$@"
    exit 0
fi

if [ "$1" == "rebuild" ]; then
	REBUILD="rebuild"
fi

echo 1 | sudo tee /sys/module/amdgpu/parameters/halt_if_hws_hang

echo "Waiting for failure..."

in_reset=0

stdbuf -oL -eL journalctl -b -f | while IFS= read -r line; do

    if [[ "$line" == *"GPU reset begin!"* ]]; then
        in_reset=1
    fi
    if [[ "$line" =~ GPU\ reset.*\ succeeded! ]]; then
        in_reset=0
    fi

    if [[ "$line" == *"qcm fence wait"* || \
          "$line" == *"preemption failed"* || \
          "$line" == *"failed to respond"* ]]; then
        if [[ $in_reset -eq 0 ]]; then
            ./dump_all_cpc_info.sh $REBUILD
        fi
        break
    fi
done

# Setting halt_if_hws_hang back to 0 will un-halt the hang and get things running again without needing a reset
echo 0 | sudo tee /sys/module/amdgpu/parameters/halt_if_hws_hang
