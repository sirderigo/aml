#
# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#Support modules:
#   bcm40183, AP6210, AP6476, AP6330, AP62x2,AP6335,mt5931 & mt6622

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
PRODUCT_PACKAGES += Bluetooth \
    bt_vendor.conf \
    bt_stack.conf \
    bt_did.conf \
    auto_pair_devlist.conf \
    libbt-hci \
    bluetooth.default \
    audio.a2dp.default \
    libbt-client-api \
    com.broadcom.bt \
    com.broadcom.bt.xml

PRODUCT_COPY_FILES += \
    hardware/amlogic/libbt/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    hardware/amlogic/libbt/data/blacklist.conf:system/etc/bluetooth/blacklist.conf

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/bluetooth),)
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(TARGET_PRODUCT_DIR)/bluetooth
endif

endif

################################################################################## bcm40183
ifeq ($(BLUETOOTH_MODULE),bcm40183)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += device/amlogic/common/tools/BCM40183B2_26M.hcd:system/etc/bluetooth/BCM4330.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

ifeq ($(BLUETOOTH_USE_BPLUS), true)
ifeq ($(BCM_BLUETOOTH_LPM_ENABLE), true)
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_lpm.conf:system/etc/bluetooth/bt_vendor.conf
else
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf
endif
endif
endif
################################################################################## AP6210
ifeq ($(BLUETOOTH_MODULE),AP6210)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6210/BT/bcm20710a1.hcd:system/etc/bluetooth/BCM20702.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

ifeq ($(BLUETOOTH_USE_BPLUS), true)
ifeq ($(BCM_BLUETOOTH_LPM_ENABLE), true)
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_AP6210_lpm.conf:system/etc/bluetooth/bt_vendor.conf
else
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_AP6210.conf:system/etc/bluetooth/bt_vendor.conf
endif
endif
endif
################################################################################## AP6476
ifeq ($(BLUETOOTH_MODULE),AP6476)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6476/GPS/bcm2076b1.hcd:system/etc/bluetooth/BCM2076.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

ifeq ($(BLUETOOTH_USE_BPLUS), true)
ifeq ($(BCM_BLUETOOTH_LPM_ENABLE), true)
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_AP6476_lpm.conf:system/etc/bluetooth/bt_vendor.conf
else
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_AP6476.conf:system/etc/bluetooth/bt_vendor.conf
endif
endif
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_stack.conf:system/etc/bluetooth/bt_stack.conf
endif
################################################################################## AP6330
ifeq ($(BLUETOOTH_MODULE),AP6330)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6330/BT/bcm40183b2.hcd:system/etc/bluetooth/BCM4330.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

ifeq ($(BLUETOOTH_USE_BPLUS), true)
ifeq ($(BCM_BLUETOOTH_LPM_ENABLE), true)
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor_lpm.conf:system/etc/bluetooth/bt_vendor.conf
else
    PRODUCT_COPY_FILES += device/amlogic/common/bplus/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf
endif
endif
endif

ifeq ($(BLUETOOTH_USE_BPLUS), true)
# BPlus
PRODUCT_COPY_FILES += \
    device/amlogic/common/bplus/bplus.default.so:system/lib/hw/bplus.default.so

PRODUCT_COPY_FILES += \
    device/amlogic/common/bplus/iop_bt.db:system/etc/bluetooth/iop_bt.db \
    device/amlogic/common/bplus/bt_did.conf:system/etc/bluetooth/bt_did.conf 

PRODUCT_PACKAGES += libbt_cust \
    leexplorer
endif

################################################################################## AP62x2
ifeq ($(BLUETOOTH_MODULE),AP62x2)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/62x2/BT/bcm43241b4.hcd:system/etc/bluetooth/bcm43241b4.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif
################################################################################## AP6335
ifeq ($(BLUETOOTH_MODULE),AP6335)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/6335/BT/bcm4335c0.hcd:system/etc/bluetooth/bcm4335c0.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif
################################################################################## AP6441
ifeq ($(BLUETOOTH_MODULE),AP6441)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/6441/BT/bcm43341b0.hcd:system/etc/bluetooth/bcm43341b0.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif
################################################################################## AP6234
ifeq ($(BLUETOOTH_MODULE),AP6234)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/6234/BT/bcm43341b0.hcd:system/etc/bluetooth/bcm43341b0.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif
################################################################################## AP6212
ifeq ($(BLUETOOTH_MODULE),AP6212)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/6212/BT/bcm43438a0.hcd:system/etc/bluetooth/bcm43438a0.hcd

PRODUCT_PACKAGES += libbt-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
endif

################################################################################## bcm43341
ifeq ($(BLUETOOTH_MODULE),bcm43341)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_usi/config/43341/BCM43341B0_002.001.014.0018.0000_USI_WM-BAN-BM-13_CL15_TESTONLY.hcd:system/etc/bluetooth/bcm43341b0.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif

################################################################################## bcm43241
ifeq ($(BLUETOOTH_MODULE),bcm43241)

BOARD_HAVE_BLUETOOTH_BCM := true

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_usi/config/43241/BCM4324B3_USI_WM-BAN-BM-10.hcd:system/etc/bluetooth/bcm4324b3.hcd

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += libbt-vendor

endif

################################################################################## mt6622
ifeq ($(BLUETOOTH_MODULE),mt6622)
BOARD_HAVE_BLUETOOTH_MTK := true
PRODUCT_PACKAGES += libbluetooth_mtk \
MTK_MT6622_E2_Patch.nb0	
ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/bluetooth),)
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(TARGET_PRODUCT_DIR)/bluetooth
endif
endif
################################################################################## rtl8723as-vau
ifeq ($(BLUETOOTH_MODULE),rtl8723au)

BOARD_HAVE_BLUETOOTH_RTK := true

#Realtek add start
$(call inherit-product, hardware/realtek/bluetooth/firmware/rtlbtfw_cfg.mk )
#realtek add end

PRODUCT_PACKAGES += libbt-vendor

PRODUCT_COPY_FILES += \
    device/amlogic/common/tools/rtk_bt_driver.sh:system/bin/rtk_bt_driver.sh

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
endif
################################################################################## rtl8723bs,rtl8761
#ifeq ($(BLUETOOTH_MODULE),rtl8723bs)
ifneq ($(filter rtl8761 rtl8723bs, $(BLUETOOTH_MODULE)),)

#Realtek add start
BOARD_HAVE_BLUETOOTH_RTK := true
BLUETOOTH_HCI_USE_RTK_H5 := true

#Realtek add start
$(call inherit-product, hardware/realtek/bluetooth/firmware/rtlbtfw_cfg.mk )
#realtek add end
PRODUCT_PACKAGES += libbt-vendor

#Realtek add start
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
#realtek add end
endif

################################################################################## RTL8723BU
ifeq ($(BLUETOOTH_MODULE),rtl8723bu)

BOARD_HAVE_BLUETOOTH_RTK := true

$(call inherit-product, hardware/realtek/bluetooth/firmware/rtl8723b/device-rtl.mk)

PRODUCT_COPY_FILES += \
    device/amlogic/common/tools/rtk_bt_driver.sh:system/bin/rtk_bt_driver.sh

PRODUCT_COPY_FILES += \
         frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
         frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
endif
