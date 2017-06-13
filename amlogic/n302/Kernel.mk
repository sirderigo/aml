#Android makefile to build kernel as a part of Android Build

#ifeq (0,1)

# for 1G DDR board, replace u-boot-1G.bin to u-boot.bin
KERNEL_DEVICETREE := mesong9bb_n302

KERNEL_DEFCONFIG := mesong9bb_defconfig
KERNET_ROOTDIR :=  common
KERNEL_COMPILE := arm-linux-gnueabihf-
PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-

KERNEL_DTD_PATH := arch/arm/boot/dts/amlogic

ifeq ($(OUT_DIR), $(TOPDIR)out)
KERNEL_OUT := $(ANDROID_BUILD_TOP)/$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
WIFI_OUT  := $(ANDROID_BUILD_TOP)/$(TARGET_OUT_INTERMEDIATES)/hardware/wifi
MALI_OUT := $(ANDROID_BUILD_TOP)/$(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/mali
else
KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
WIFI_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/wifi
MALI_OUT := $(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/mali
endif

KERNEL_CONFIG := $(KERNEL_OUT)/.config
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
BOARD_MKBOOTIMG_ARGS := --second $(KERNEL_OUT)/$(KERNEL_DTD_PATH)/$(KERNEL_DEVICETREE).dtb

define cp-kernel-modules
mkdir -p $(PRODUCT_OUT)/root/boot
mkdir -p $(TARGET_OUT)/lib

#mali & ump
#cp $(MALI_OUT)/mali.ko $(PRODUCT_OUT)/root/boot/

#wifi
#cp $(WIFI_OUT)/realtek/drivers/8192cu/rtl8xxx_CU/8192cu.ko $(TARGET_OUT)/lib/
#cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU/8188eu.ko $(TARGET_OUT)/lib/

$(THERMAL_KO):
$(MAKE) -C $(shell pwd)/$(PRODUCT_OUT)/obj/KERNEL_OBJ M=$(shell pwd)/hardware/amlogic/thermal/ ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) modules
cp $(shell pwd)/hardware/amlogic/thermal/aml_thermal.ko $(PRODUCT_OUT)/root/boot/ 


cp $(KERNET_ROOTDIR)/$(KERNEL_DTD_PATH)/$(KERNEL_DEVICETREE).dtd $(PRODUCT_OUT)/meson_target.dtd
cp $(KERNEL_OUT)/arch/arm/boot/meson.dtd $(PRODUCT_OUT)/meson.dtd
cp $(KERNEL_OUT)/$(KERNEL_DTD_PATH)/$(KERNEL_DEVICETREE).dtb $(PRODUCT_OUT)/meson.dtb
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEFCONFIG)


$(TARGET_PREBUILT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	@echo " make uImage" 
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) uImage
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) modules
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEVICETREE).dtd
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEVICETREE).dtb
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) dtd
	$(cp-kernel-modules)

kerneltags: $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) tags

kernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) menuconfig
	     
savekernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) savedefconfig
	cp $(KERNEL_OUT)/defconfig $(KERNET_ROOTDIR)/customer/configs/$(KERNEL_DEFCONFIG)

#endif
