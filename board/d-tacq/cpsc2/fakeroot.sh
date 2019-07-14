#!/usr/bin/bash


echo FAKEROOT01 promote libtirpc to /lib .. needed by busybox
echo FAKEROOT01 before $(ls -l output/target/dev/null)
echo FAKEROOT01 mknod -m 666 output/target/dev/null c 1 3
mknod -m 666 output/target/dev/null c 1 3
echo FAKEROOT66 after  $(ls -l output/target/dev/null)
#mv output/target/usr/lib/libtirpc.so* output/target/lib
echo FAKEROOT99
