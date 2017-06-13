#!/bin/bash
cd ../../..

#repo sync -j12
source build/envsetup.sh
lunch h13-eng
cd ./common/
make mrproper
cd ..
#make clean -j12
make otapackage -j12

