#!/bin/bash
# simple check for redundant bit/reg definitions
cd src/lib/ip
for f in *.i; do git grep -i ${f} *.c >/dev/null; if [ $? != 0 ];  then echo "${f} not found in any source file"; fi ; done
for f in `git grep "umr_create_" *.c | awk '{ print $3; }' | sed -e 's/[(]struct//g' | cut -b 2-`; do
	git grep -i ${f} ../asic/*.c > /dev/null; if [ $? != 0 ];  then echo "${f} not found in any asic"; fi; done
cd - >/dev/null

