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

echo BEFORE PYEPICS FIXUP
du output/target/usr/lib/python*/site-packages/epics/clibs
rm -Rf output/target/usr/lib/python*/site-packages/epics/clibs/*
if [ ! -e output/target/usr/lib/python3.9/site-packages/epics/clibs ]; then
	echo HOUSTON, we have a problem: output/target/usr/lib/python3.9/site-packages/epics/clibs does not exist
	exit 1
fi
if [ ! -e output/build/python-pyepics-3.5.0/epics/clibs/linuxarm ]; then
	echo HOUSTON, we have a problem: output/build/python-pyepics-3.5.0/epics/clibs/linuxarm does not exist
	exit 1
fi
mkdir output/target/usr/lib/python3.9/site-packages/epics/clibs/linuxarm
cp -R output/build/python-pyepics-3.5.0/epics/clibs/linuxarm/*  output/target/usr/lib/python3.9/site-packages/epics/clibs/linuxarm
echo AFTER PYEPICS FIXUP
du output/target/usr/lib/python*/site-packages/epics/clibs
echo FAKEROOT99
