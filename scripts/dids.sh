#!/bin/bash
grep 0x1002 ${pk}/amdgpu_drv.c | grep PCI_ANY_ID | sed -e 's/.AMD_IS_APU//g' | sed -e 's/.AMD_EXP_HW_SUPPORT//g'  | sed -e 's/.AMD_IS_MOBILITY//g' | sed -e 's/, / /g' | sed -e 's/},//g' | awk '{ print $2, $7; }' | (
while read line; do
	did=`echo ${line} | awk '{ print $1 }'`
	name=`echo ${line} | awk '{ print $2 }'`
	grep -i ${did} ../database/pci.did >/dev/null
	if [ $? == 1 ]; then
		echo "${did}, ${name} not found in database"
	fi
done;
)
