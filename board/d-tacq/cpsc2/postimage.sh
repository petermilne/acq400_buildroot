#!/usr/bin/bash

notcpsc2() {
echo POSTIMAGE01
ls -l output/target
ls -l output/images
for arg in BR2_CONFIG HOST_DIR STAGING_DIR TARGET_DIR BUILD_DIR BINARIES_DIR and BASE_DIR
do
	echo $arg $(env | grep $arg)
done

IMAGES_INITRD=$BASE_DIR/initrd
DT=$(dirname $BASE_DIR)/board/d-tacq/acq400
cat > $HOST_DIR/fix-initrd - <<EOF

echo $HOST_DIR/fix-initrd running as fake root
rm -Rf $IMAGES_INITRD
mkdir -p $IMAGES_INITRD
tar --exclude=usr/* -xf $BINARIES_DIR/rootfs.tar -C $IMAGES_INITRD
tar -xf $BINARIES_DIR/rootfs.tar -C $IMAGES_INITRD ./usr/bin/env ./usr/local
#cp -r $DT/root/* $IMAGES_INITRD

#$HOST_DIR/makedevs -d $DT/device_table.txt $IMAGES_INITRD

rm -f $BINARIES_DIR/initrd.ext2*
$HOST_DIR/sbin/mkfs.ext2 -d $IMAGES_INITRD -r 1 -N 0 -m 5 -L "acq400_initrd" $BINARIES_DIR/initrd.ext2  "16M" || \
	{ ret=$?; echo "*** Maybe you need to increase the filesystem size (BR2_TARGET_ROOTFS_EXT2_SIZE)" 1>&2; exit $ret; }
gzip $BINARIES_DIR/initrd.ext2
mkimage -A arm -T ramdisk -C gzip -n "D-TACQ ACQ400 INITRD" -d output/images/initrd.ext2.gz output/images/uramdisk.image.gz

rm -f $BINARIES_DIR/rootfs.ext2.gz
gzip $BINARIES_DIR/rootfs.ext2

EOF
chmod a+rx $HOST_DIR/fix-initrd

unset LD_PRELOAD
LD_LIBRARY_PATH=./output/build/host-fakeroot-1.20.2/.libs ./output/host/bin/fakeroot $HOST_DIR/fix-initrd
echo POSTIMAGE99
}

