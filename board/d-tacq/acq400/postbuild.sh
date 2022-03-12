#!/usr/bin/bash

echo POSTBUILD01 $1
echo $PWD "creates output/target/etc/acq400_version"

if [ -z "$(git status --porcelain)" ]; then
	GITSTAT=clean
else
	GITSTAT=DIRTY
fi
echo "acq400_buildroot $(git describe --abbrev=0) ${USER}@$(hostname) $(date) $(git show --quiet --pretty=format:%H)" $GITSTAT \
	> output/target/etc/acq400_version
sed -ie '/hostname/d' output/target/etc/inittab
rm output/target/etc/hostname
echo POSTBUILD99
echo ----------------------------------------------------------------------
