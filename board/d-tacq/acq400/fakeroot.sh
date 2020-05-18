#!/usr/bin/bash


echo FAKEROOT01 promote libtirpc to /lib .. needed by busybox
if [ -e output/target/lib/libtirpc.so.3.0.0 ]; then
	echo FAKEROOT45 job already done
	ls -l output/target/lib/libtirpc.so*
else
	mv output/target/usr/lib/libtirpc.so* output/target/lib
fi

echo BEFORE NTPD FIXUP
ls -l output/target/usr/sbin/nologin
ls -l output/target/usr/sbin/ntpd
rm -f output/target/usr/sbin/ntpd
(cd output/target/usr/sbin/; ln -s ../../bin/busybox ntpd)
cp output/build/ntp-4.2.8p13/ntpd/ntpd output/target/usr/sbin/ntpd.orig
echo AFTER NTPD FIXUP
ls -l output/target/usr/sbin/ntpd*

echo FAKEROOT99
