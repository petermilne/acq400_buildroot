#!/usr/bin/bash

echo POSTBUILD01 $1
echo $PWD "creates output/target/etc/acq400_version"
echo "acq400_buildroot $(git describe --abbrev=0) ${USER}@$(hostname) $(date) $(git show --quiet --pretty=format:%H)" \
	> output/target/etc/acq400_version
echo POSTBUILD99
echo ----------------------------------------------------------------------
