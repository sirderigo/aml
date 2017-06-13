#ifneq ($(TARGET_AMLOGIC_KERNEL),)

KERNEL_DEFCONFIG := meson8b_defconfig
KERNET_ROOTDIR :=  common
KERNEL_COMPILE := arm-linux-gnueabihf-

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
WIFI_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/wifi
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
BOARD_MKBOOTIMG_ARGS := --second $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/meson8b_m102_1G.dtb
PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-

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


cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/meson8b_m102_1G.dtd $(PRODUCT_OUT)/meson_target.dtd
cp $(KERNEL_OUT)/arch/arm/boot/meson.dtd $(PRODUCT_OUT)/meson.dtd
cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU/8188eu.ko $(TARGET_OUT)/lib/
#cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU_MP/8188eu_mp.ko $(TARGET_OUT)/lib/
cp $(WIFI_OUT)/realtek/drivers/8189es/rtl8189ES/8189es.ko $(TARGET_OUT)/lib/
cp $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/meson8b_m102_1G.dtb $(PRODUCT_OUT)/meson.dtb
cp $(KERNEL_OUT)/../hardware/amlogic/nand/amlnf/aml_nftl_dev.ko $(PRODUCT_OUT)/root/boot/
cp $(KERNEL_OUT)/../hardware/amlogic/pmu/aml_pmu_dev.ko $(TARGET_OUT)/lib/
cp $(KERNEL_OUT)/../hardware/amlogic/touch/gsl_point_id.ko $(TARGET_OUT)/lib/
$(THERMAL_KO):
	$(MAKE) -C $(shell pwd)/$(PRODUCT_OUT)/obj/KERNEL_OBJ M=$(shell pwd)/hardware/amlogic/thermal/ ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) modules
cp $(shell pwd)/hardware/amlogic/thermal/aml_thermal.ko $(TARGET_OUT)/lib/
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) $(KERNEL_DEFCONFIG)


$(TARGET_PREBUILT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	@echo " make uImage" 
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) uImage
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) modules
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) meson8b_m102_1G.dtd
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_COMPILE) meson8b_m102_1G.dtb
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
