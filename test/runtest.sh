#!/bin/bash

if [ "${1}" != "norebuild" ]; then
	git clean . -dxf
	cmake ${1} .
	make -j

	if [ $? -ne 0 ]; then
		echo FAILED to build umr.  Try adding -DUMR_NO_GUI=ON to the command line.
		exit 1
	fi
fi

echo
echo
echo Running KAT tests...

# run more complicated KATs
for f in test/kat/*.cmd; do
	txt=`echo $f | sed -e 's/.cmd/.txt/'`
	kat=`echo $f | sed -e 's/.cmd/.answer/'`
	cmd=`cat $f`
	echo "Running: umr ${cmd}"
	src/app/umr ${cmd} > /tmp/umr.test
	pass=0
	for kf in ${kat}*; do
		diff /tmp/umr.test ${kf} >/dev/null
		if [ $? -eq 0 ]; then
			pass=1;
			break;
		fi;
	done
	if [ ${pass} -eq 0 ]; then
		echo "FAILED.  Test ${txt} failed..."
		diff -ur $kat /tmp/umr.test
		exit 1;
	fi
done
echo PASSED.

# run simple KATs
echo
echo
echo Running simple KAT/VM tests...

src/test/umrtest test/vm/
if [ $? -eq 1 ]; then
	echo "FAILED."
	exit 1
fi
echo PASSED.

exit 0


