#Android makefile to build kernel as a part of Android Build

#ifeq (0,1)

KERNEL_DEFCONFIG := meson6tvd_defconfig
KERNET_ROOTDIR :=  common
KERNEL_COMPILE := arm-linux-gnueabihf-
PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
WIFI_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/wifi
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
BOARD_MKBOOTIMG_ARGS := --second $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/meson6tvd_ref.dtb

define cp-kernel-modules
mkdir -p $(PRODUCT_OUT)/root/boot
mkdir -p $(TARGET_OUT)/lib

#wifi
cp $(WIFI_OUT)/realtek/drivers/8192cu/rtl8xxx_CU/8192cu.ko $(TARGET_OUT)/lib/
#cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU/8188eu.ko $(TARGET_OUT)/lib/

cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/meson6tvd_ref.dtd $(PRODUCT_OUT)/meson_target.dtd
cp $(KERNEL_OUT)/arch/arm/boot/meson.dtd $(PRODUCT_OUT)/meson.dtd
cp $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/meson6tvd_ref.dtb $(PRODUCT_OUT)/meson.dtb
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEFCONFIG)


$(TARGET_PREBUILT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	@echo " make uImage" 
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) uImage
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) modules
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) meson6tvd_ref.dtd
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) meson6tvd_ref.dtb
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) dtd
	$(cp-kernel-modules)

kerneltags: $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) tags

kernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) menuconfig
	     
savekernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) savedefconfig
	cp $(KERNEL_OUT)/defconfig $(KERNET_ROOTDIR)/customer/configs/$(KERNEL_DEFCONFIG)

#endif
