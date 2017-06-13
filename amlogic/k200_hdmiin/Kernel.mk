#ifneq ($(TARGET_AMLOGIC_KERNEL),)


# for 1G DDR board, replace u-boot-1G.bin to u-boot.bin
KERNEL_DEVICETREE := meson8_k200a_1G_hdmiin

ifeq ($(BOARD_REVISION),a_2G)
    KERNEL_DEVICETREE := meson8_k200a_2G_hdmiin
endif
ifeq ($(BOARD_REVISION),b)
    KERNEL_DEVICETREE := meson8_k200b_1G_emmc_sdio_hdmiin meson8_k200b_1G_emmc_sdhc_hdmiin meson8_k200b_2G_emmc_sdhc_hdmiin meson8_k200b_2G_emmc_sdio_hdmiin meson8m2_n200_1G_hdmiin meson8m2_n200_2G_hdmiin
else
ifeq ($(BOARD_REVISION),b_2G)
    KERNEL_DEVICETREE := meson8_k200b_2G_emmc_sdhc_hdmiin meson8_k200b_2G_emmc_sdio_hdmiin
endif
endif

ifeq ($(TARGET_USE_SECUREOS),true)
KERNEL_DEFCONFIG := meson8_tee_defconfig
else
KERNEL_DEFCONFIG := meson8_defconfig
endif

KERNET_ROOTDIR :=  common
KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
INSTALLED_DTIMAGE_TARGET := $(PRODUCT_OUT)/dt.img
BOARD_MKBOOTIMG_ARGS := --second $(INSTALLED_DTIMAGE_TARGET)
TARGET_AMLOGIC_INT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage
TARGET_AMLOGIC_INT_RECOVERY_KERNEL := $(KERNEL_OUT)/arch/arm/boot/uImage_recovery
DTBTOOL := device/amlogic/common/dtbTool
WORD_NUMBER := $(words $(KERNEL_DEVICETREE))
define build-dtimage-target
    #$(call pretty,"Target dt image: $(INSTALLED_DTIMAGE_TARGET)")
    @echo " Target dt image: $(INSTALLED_DTIMAGE_TARGET)"
    $(hide) $(DTBTOOL) -o $(INSTALLED_DTIMAGE_TARGET) -p $(KERNEL_OUT)/scripts/dtc/ $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/
    $(hide) chmod a+r $@
endef
ifeq ($(WORD_NUMBER),1)
BOARD_MKBOOTIMG_ARGS := --second $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtb
define cp-dtbs
    @echo " only one dtb"
    cp $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtb $(PRODUCT_OUT)/meson.dtb
    cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtd $(PRODUCT_OUT)/meson_target.dtd
endef
else
define cp-dtbs
@echo " multi dtbs"
$(foreach dtd_file,$(KERNEL_DEVICETREE), \
    cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/$(dtd_file).dtd $(PRODUCT_OUT)/; \
    )
$(build-dtimage-target)
endef
define update-aml_upgrade-conf
@echo " update-aml_upgrade_conf for multi-dtd"
@sed -i "/meson.*\.dtd/d" $(PACKAGE_CONFIG_FILE)
@sed -i "s/meson.*\.dtb/dt.img/" $(PACKAGE_CONFIG_FILE)
$(hide) $(foreach dtd_file,$(KERNEL_DEVICETREE), \
	sed -i "0,/aml_sdc_burn\.ini/ s/file=\"aml_sdc_burn\.ini\".*/&\n&/" $(PACKAGE_CONFIG_FILE); \
	sed -i "0,/aml_sdc_burn\.ini/ s/ini\"/dtd\"/g" $(PACKAGE_CONFIG_FILE); \
	sed -i "0,/aml_sdc_burn\.dtd/ s/aml_sdc_burn/$(dtd_file)/g" $(PACKAGE_CONFIG_FILE); \
	)
endef 
endif
MALI_OUT := $(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/mali
UMP_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/arm/gpu/ump
WIFI_OUT  := $(TARGET_OUT_INTERMEDIATES)/hardware/wifi

PREFIX_CROSS_COMPILE=arm-linux-gnueabihf-
#arm-none-linux-gnueabi-

define cp-modules
mkdir -p $(PRODUCT_OUT)/root/boot
mkdir -p $(TARGET_OUT)/lib

#cp $(UMP_OUT)/ump.ko $(PRODUCT_OUT)/root/boot/
cp $(MALI_OUT)/mali.ko $(PRODUCT_OUT)/root/boot/
#cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU_MP/8188eu_mp.ko $(TARGET_OUT)/lib/
if [ "$(BOARD_REVISION)" == "b" -o "$(BOARD_REVISION)" == "b_2G" ]; then \
    cp $(WIFI_OUT)/broadcom/drivers/ap6xxx/broadcm_40181/dhd.ko $(TARGET_OUT)/lib/ ;\
else \
    cp $(WIFI_OUT)/realtek/drivers/8188eu/rtl8xxx_EU/8188eu.ko $(TARGET_OUT)/lib/ ;\
fi
#cp $(KERNET_ROOTDIR)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtd $(PRODUCT_OUT)/meson_target.dtd
#cp $(WIFI_OUT)/realtek/drivers/8811au/rtl8811AU/8821au.ko $(TARGET_OUT)/lib/
cp $(KERNEL_OUT)/arch/arm/boot/meson.dtd $(PRODUCT_OUT)/meson.dtd
#cp $(KERNEL_OUT)/arch/arm/boot/dts/amlogic/$(KERNEL_DEVICETREE).dtb $(PRODUCT_OUT)/meson.dtb
$(cp-dtbs)
$(THERMAL_KO):
	$(MAKE) -C $(shell pwd)/$(PRODUCT_OUT)/obj/KERNEL_OBJ M=$(shell pwd)/hardware/amlogic/thermal/ ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) modules
cp $(shell pwd)/hardware/amlogic/thermal/aml_thermal.ko $(TARGET_OUT)/lib/
cp $(KERNEL_OUT)/../hardware/amlogic/pmu/aml_pmu_dev.ko $(TARGET_OUT)/lib/
if [ "$(BOARD_REVISION)" == "a" -o "$(BOARD_REVISION)" == "a_2G" ]; then \
    cp $(KERNEL_OUT)/../hardware/amlogic/nand/amlnf/aml_nftl_dev.ko $(PRODUCT_OUT)/root/boot/ ;\
fi
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(KERNEL_DEFCONFIG)


$(TARGET_PREBUILT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	@echo " make uImage" 
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) uImage
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) modules
ifeq ($(WORD_NUMBER),1)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(KERNEL_DEVICETREE).dtd
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(KERNEL_DEVICETREE).dtb
else
	$(foreach dtd_file,$(KERNEL_DEVICETREE), \
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(dtd_file).dtd; \
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(dtd_file).dtb; \
        )
endif
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) dtd
	$(cp-modules)

kerneltags: $(KERNEL_OUT)
	$(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) tags

kernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) menuconfig

savekernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C $(KERNET_ROOTDIR) O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) savedefconfig
	cp $(KERNEL_OUT)/defconfig $(KERNET_ROOTDIR)/customer/configs/$(KERNEL_DEFCONFIG)


#endif
