#ifneq ($(TARGET_AMLOGIC_KERNEL),)

# for 1G DDR board, replace u-boot-1G.bin to u-boot.bin
KERNEL_DEVICETREE := meson8m2_n101_512M
#ifeq ($(K101_DDR_SIZE),k101_1G_ddr)
#    KERNEL_DEVICETREE := meson8_k101_1G
#endif
#ifeq ($(K101_DDR_SIZE),k101_512M_ddr)
#    KERNEL_DEVICETREE := meson8_k101_512M
#endif
KERNEL_DEFCONFIG := meson8m2_defconfig
KERNET_ROOTDIR :=  common
KERNEL_COMPILE := arm-linux-gnueabihf-
PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
WIFI_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/wifi
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
BOARD_MKBOOTIMG_ARGS := --second $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtb

define cp-kernel-modules
mkdir -p $(PRODUCT_OUT)/root/boot
mkdir -p $(TARGET_OUT)/lib
if [ -f $(KERNET_ROOTDIR)/drivers/amlogic/ump/Kbuild ]; then \
	-cp $(KERNEL_OUT)/drivers/amlogic/ump/ump.ko $(PRODUCT_OUT)/root/boot/ ;\
	cp $(KERNEL_OUT)/drivers/amlogic/mali/mali.ko $(PRODUCT_OUT)/root/boot/ ;\
else \
	-cp $(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/ump/ump.ko $(PRODUCT_OUT)/root/boot/ ;\
	cp $(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/mali/mali.ko $(PRODUCT_OUT)/root/boot/ ;\
fi

cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU/8188eu.ko $(TARGET_OUT)/lib/
#cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU_MP/8188eu_mp.ko $(TARGET_OUT)/lib/
cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtd $(PRODUCT_OUT)/meson_target.dtd
cp $(KERNEL_OUT)/arch/arm/boot/meson.dtd $(PRODUCT_OUT)/meson.dtd
cp $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtb $(PRODUCT_OUT)/meson.dtb
$(THERMAL_KO):
	$(MAKE) -C $(shell pwd)/$(PRODUCT_OUT)/obj/KERNEL_OBJ M=$(shell pwd)/hardware/amlogic/thermal/ ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) modules
cp $(shell pwd)/hardware/amlogic/thermal/aml_thermal.ko $(TARGET_OUT)/lib/
cp $(KERNEL_OUT)/../hardware/amlogic/nand/amlnf/aml_nftl_dev.ko $(PRODUCT_OUT)/root/boot/
cp $(KERNEL_OUT)/../hardware/amlogic/pmu/aml_pmu_dev.ko $(TARGET_OUT)/lib/
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEFCONFIG)


$(TARGET_PREBUILT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	@echo " make uImage" 
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) uImage
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) modules
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEVICETREE).dtd
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEVICETREE).dtb
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
