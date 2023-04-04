#!/bin/bash

git clean . -dxf
cmake .
make -j

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
	diff /tmp/umr.test $kat >/dev/null
	if [ $? -eq 1 ]; then
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


