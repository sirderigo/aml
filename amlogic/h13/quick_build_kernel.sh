#!/bin/bash

#  This script use to build boot.img or recovery.img.
#  Compare with 'make bootimage' or 'make recoveryimage'at android top directory , it will not check android makefile, save time to enter build process
#
#  Read me for copy it your project, Configuration between {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{ 
#  and }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} may need modify.
# 
#  This scipt is created by Frank.Chen, any problem with this, let me know


#{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
PROJECT_NAME=h13
PROJECT_DT=meson6tvd_ref
KERNEL_DEFCONFIG=meson6tvd_defconfig
KERNET_ROOTDIR=common
PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-
#}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}

function usage () {
	echo "Usage:"
	echo "   Pelease run the script in android top directory"
	echo "   device/amlogic/$PROJECT_NAME/quick_build_kernel.sh bootimage      --> build uImage"
	echo "   device/amlogic/$PROJECT_NAME/quick_build_kernel.sh recoveryimage  --> build recovery uImage"
	echo "   device/amlogic/$PROJECT_NAME/quick_build_kernel.sh menuconfig     --> go menuconfig"
	echo "   device/amlogic/$PROJECT_NAME/quick_build_kernel.sh saveconfig     --> savedefconfig"
}

if [ $# -lt 1 ]; then
    echo "Error: wrong number of arguments in cmd: $0 $* "
    usage
    exit 1
fi

KERNEL_OUT=out/target/product/$PROJECT_NAME/obj/KERNEL_OBJ
KERNEL_CONFIG=$KERNEL_OUT/.config
PRODUCT_OUT=out/target/product/$PROJECT_NAME
WIFI_OUT=out/target/product/$PROJECT_NAME/obj/hardware/wifi
TARGET_OUT=$PRODUCT_OUT/system

############################## bootimage ####################################
if [ $1 = bootimage ]; then
	
if [ ! -f out/host/linux-x86/bin/mkbootimg ]; then
	echo "No out/host/linux-x86/bin/mkbootimg found! You need build it first"
	echo "make bootimage at android top dir"
	exit 1
fi

if [ ! -d $PRODUCT_OUT/root ]; then
	echo "No $PRODUCT_OUT/root found! You need build it first"
	echo "make bootimage at android top dir"
	exit 1
fi

if [ ! -d $KERNEL_OUT ]; then
	echo "$KERNEL_OUT no found! Build it..."
	mkdir $KERNEL_OUT
fi

if [ ! -f $PRODUCT_OUT/root/init ]; then
	echo "No $PRODUCT_OUT/root/init found! You need build it first"
	echo "make bootimage at android top dir"
	exit 1
fi

if [ ! -f $KERNEL_CONFIG ]; then
	make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE $KERNEL_DEFCONFIG -j4
fi

make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE modules

cp $WIFI_OUT/realtek/drivers/8192cu/rtl8xxx_CU/8192cu.ko $TARGET_OUT/lib/

make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE uImage -j8
make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE ${PROJECT_DT}.dtd -j8
make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE ${PROJECT_DT}.dtb -j12

cd $PRODUCT_OUT/root
find .| cpio -o -H newc | gzip -9 > ../ramdisk.img
cd -
out/host/linux-x86/bin/mkbootimg  --kernel $KERNEL_OUT/arch/arm/boot/uImage  --ramdisk $PRODUCT_OUT/ramdisk.img --second $KERNEL_OUT/arch/arm/boot/dts/amlogic/${PROJECT_DT}.dtb --output $PRODUCT_OUT/boot.img

echo "Build $PRODUCT_OUT/boot.img Done"
exit 0
fi

############################## recoveryimage ####################################
if [ $1 = recoveryimage ]; then

if [ ! -f out/host/linux-x86/bin/mkbootimg ]; then
	echo "No out/host/linux-x86/bin/mkbootimg found! You need build it first"
	echo "make recoveryimage at android top dir"
exit 1
fi
 
if [ ! -d $PRODUCT_OUT/recovery/root ]; then
	echo "No $PRODUCT_OUT/recovery/root found! You need build it first"
	echo "make recoveryimage at android top dir"
exit 1
fi

if [ ! -d $KERNEL_OUT ]; then
	echo "$KERNEL_OUT no found! Build it..."
	mkdir $KERNEL_OUT
fi

if [ ! -f $KERNEL_CONFIG ]; then
	make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE $KERNEL_DEFCONFIG -j4
fi

make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE BUILD_URECOVERY=true uImage -j8
make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE ${PROJECT_DT}.dtd -j8
make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE ${PROJECT_DT}.dtb -j12
mkdir -p $PRODUCT_OUT/recovery/root/boot


cd $PRODUCT_OUT/recovery/root
find .| cpio -o -H newc | gzip -9 > ../../ramdisk-recovery.img
cd -
out/host/linux-x86/bin/mkbootimg  --kernel $KERNEL_OUT/arch/arm/boot/uImage  --ramdisk $PRODUCT_OUT/ramdisk-recovery.img --second $KERNEL_OUT/arch/arm/boot/dts/amlogic/${PROJECT_DT}.dtb --output $PRODUCT_OUT/recovery.img

echo "Build $PRODUCT_OUT/recovery.img Done"
exit 0
fi

############################## menuconfig ####################################
if [ $1 = menuconfig ]; then
	if [ ! -f $KERNEL_CONFIG ]; then
		make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE $KERNEL_DEFCONFIG
	fi
	make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE menuconfig

	exit 0
fi

############################## saveconfig ####################################
if [ $1 = saveconfig -o $1 = savedefconfig ]; then
	if [ ! -f $KERNEL_CONFIG ]; then
		echo " $KERNEL_CONFIG is not found"
		make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE $KERNEL_DEFCONFIG
	fi
	make -C $KERNET_ROOTDIR O=../$KERNEL_OUT ARCH=arm CROSS_COMPILE=$PREFIX_CROSS_COMPILE savedefconfig

	echo "config saved to $KERNEL_OUT/defconfig"
	exit 0
fi

echo "Error: unrecognized  argument"
usage
