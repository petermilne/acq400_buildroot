#!/usr/bin/bash


echo FAKEROOT01 promote libtirpc to /lib .. needed by busybox
if [ -e output/target/lib/libtirpc.so.3.0.0 ]; then
	echo FAKEROOT45 job already done
	ls -l output/target/lib/libtirpc.so*
else
	mv output/target/usr/lib/libtirpc.so* output/target/lib
fi

echo FAKEROOT99
