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

#Support moduels:
#                bcm40183
#                bcm40181
#                rtl8192cu
#                rtl8188eu
#                rt5370
#                rt8189es
#                rt8723bs
#								 mt7601
#								 mt5931

PRODUCT_PACKAGES += wpa_supplicant.conf
PRODUCT_PACKAGES += hostapd_wps

PRODUCT_COPY_FILES += \
	device/amlogic/common/tools/wififix.sh:system/bin/wififix.sh
	
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

PRODUCT_PROPERTY_OVERRIDES += \
	ro.carrier=wifi-only


################################################################################## 8189es
ifeq ($(WIFI_MODULE),rtl8189es)

WIFI_DRIVER := 8189es
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8189es.ko
WIFI_DRIVER_MODULE_NAME := 8189es
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"
WIFI_FIRMWARE_LOADER :=""
WIFI_DRIVER_FW_PATH_STA :=""
WIFI_DRIVER_FW_PATH_AP  :=""
WIFI_DRIVER_FW_PATH_P2P :=""
WIFI_DRIVER_FW_PATH_PARAM :=""

BOARD_WLAN_DEVICE := rtl8189es
WIFI_DRIVER_FW_PATH_PARAM   := ""

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
CONFIG_DRIVER_WEXT :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl

PRODUCT_COPY_FILES += \
	hardware/amlogic/wifi/rtl8189es/config/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
	hardware/amlogic/wifi/rtl8189es/config/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/8189es.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/8189es.ko:system/lib/8189es.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

endif

################################################################################## 8723bs
ifeq ($(WIFI_MODULE),rtl8723bs)

WIFI_DRIVER := 8723bs
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8723bs.ko
WIFI_DRIVER_MODULE_NAME := 8723bs
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"
WIFI_FIRMWARE_LOADER :=""
WIFI_DRIVER_FW_PATH_STA :=""
WIFI_DRIVER_FW_PATH_AP  :=""
WIFI_DRIVER_FW_PATH_P2P :=""
WIFI_DRIVER_FW_PATH_PARAM :=""

BOARD_WLAN_DEVICE := rtl8723bs
WIFI_DRIVER_FW_PATH_PARAM   := ""

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
CONFIG_DRIVER_WEXT :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl

PRODUCT_COPY_FILES += \
	hardware/amlogic/wifi/rtl8189es/config/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
	hardware/amlogic/wifi/rtl8189es/config/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/8723bs.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/8723bs.ko:system/lib/8723bs.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

endif
################################################################################## bcm40183
ifeq ($(WIFI_MODULE),bcm40183)

WIFI_DRIVER := bcm40183
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/40183/fw_bcm40183b2.bin nvram_path=/etc/wifi/40183/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/40183/fw_bcm40183b2.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/40183/fw_bcm40183b2_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/40183/fw_bcm40183b2_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd

PRODUCT_PACKAGES += \
	40183/nvram.txt \
	40183/fw_bcm40183b2.bin \
	40183/fw_bcm40183b2_apsta.bin \
	40183/fw_bcm40183b2_p2p.bin \
	wl \
	dhd

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

endif

################################################################################## bcm40181
ifeq ($(WIFI_MODULE),bcm40181)
WIFI_DRIVER := bcm40181
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/40181/fw_bcm40181a2.bin nvram_path=/etc/wifi/40181/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/40181/fw_bcm40181a2.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/40181/fw_bcm40181a2_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/40181/fw_bcm40181a2_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd

PRODUCT_PACKAGES += \
	40181/nvram.txt \
	40181/fw_bcm40181a0.bin \
	40181/fw_bcm40181a0_apsta.bin \
	40181/fw_bcm40181a2.bin \
	40181/fw_bcm40181a2_apsta.bin \
	40181/fw_bcm40181a2_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## AP62x2
ifeq ($(WIFI_MODULE),AP62x2)
WIFI_DRIVER := AP62x2
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/62x2/fw_bcm43241b4_ag.bin nvram_path=/etc/wifi/62x2/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/62x2/fw_bcm43241b4_ag.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/62x2/fw_bcm43241b4_ag_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/62x2/fw_bcm43241b4_ag_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd

PRODUCT_PACKAGES += \
	62x2/nvram.txt \
	62x2/fw_bcm43241b4_ag.bin \
	62x2/fw_bcm43241b4_ag_apsta.bin \
	62x2/fw_bcm43241b4_ag_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## AP6335
ifeq ($(WIFI_MODULE),AP6335)
WIFI_DRIVER := AP6335
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/6335/fw_bcm4339a0_ag.bin nvram_path=/etc/wifi/6335/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/6335/fw_bcm4339a0_ag.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/6335/fw_bcm4339a0_ag_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/6335/fw_bcm4339a0_ag_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	6335/nvram.txt    \
	6335/fw_bcm4339a0_ag.bin \
	6335/fw_bcm4339a0_ag_apsta.bin \
	6335/fw_bcm4339a0_ag_p2p.bin \
  6335/nvram_ap6335e.txt   \
  6335/fw_bcm4339a0e_ag.bin \
  6335/fw_bcm4339a0e_ag_apsta.bin \
  6335/fw_bcm4339a0e_ag_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## AP6441
ifeq ($(WIFI_MODULE),AP6441)
WIFI_DRIVER := AP6441
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/6441/fw_bcm43341b0_ag.bin nvram_path=/etc/wifi/6441/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/6441/fw_bcm43341b0_ag.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/6441/fw_bcm43341b0_ag_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/6441/fw_bcm43341b0_ag_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	6441/nvram.txt    \
	6441/fw_bcm43341b0_ag.bin \
	6441/fw_bcm43341b0_ag_apsta.bin \
	6441/fw_bcm43341b0_ag_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif

################################################################################## AP6234
ifeq ($(WIFI_MODULE),AP6234)
WIFI_DRIVER := AP6234
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/6234/fw_bcm43341b0_ag.bin nvram_path=/etc/wifi/6234/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/6234/fw_bcm43341b0_ag.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/6234/fw_bcm43341b0_ag_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/6234/fw_bcm43341b0_ag_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	6234/nvram.txt    \
	6234/fw_bcm43341b0_ag.bin \
	6234/fw_bcm43341b0_ag_apsta.bin \
	6234/fw_bcm43341b0_ag_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif

################################################################################## AP6212
ifeq ($(WIFI_MODULE),AP6212)
WIFI_DRIVER := AP6212
WIFI_DRIVER_MODULE_PATH := /system/lib/dhd.ko
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_ARG  := "firmware_path=/etc/wifi/6212/fw_bcm43438a0.bin nvram_path=/etc/wifi/6212/nvram.txt"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/6212/fw_bcm43341b0_ag.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/6212/fw_bcm43341b0_ag_apsta.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/6212/fw_bcm43341b0_ag_p2p.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	6212/nvram.txt    \
	6212/fw_bcm43438a0.bin \
	6212/fw_bcm43438a0_apsta.bin \
	6212/fw_bcm43438a0_p2p.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/dhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dhd.ko:system/lib/dhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif


################################################################################## bcm43341
ifeq ($(WIFI_MODULE),bcm43341)
WIFI_DRIVER := bcm43341
WIFI_DRIVER_MODULE_PATH := /system/lib/bcmdhd.ko
WIFI_DRIVER_MODULE_NAME := bcmdhd
WIFI_DRIVER_MODULE_ARG  := "iface_name=wlan0 firmware_path=/etc/wifi/fw_bcmdhd_43341.bin nvram_path=/etc/wifi/nvram_43341.bin"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/fw_bcmdhd_43341.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/fw_bcmdhd_43341.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/fw_bcmdhd_43341.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	nvram_43341.bin   \
    fw_bcmdhd_43341.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/bcmdhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/bcmdhd.ko:system/lib/bcmdhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## bcm43241
ifeq ($(WIFI_MODULE),bcm43241)
WIFI_DRIVER := bcm43241
WIFI_DRIVER_MODULE_PATH := /system/lib/bcmdhd.ko
WIFI_DRIVER_MODULE_NAME := bcmdhd
WIFI_DRIVER_MODULE_ARG  := "iface_name=wlan0 firmware_path=/etc/wifi/fw_bcmdhd_43241.bin nvram_path=/etc/wifi/nvram_43241.bin"
WIFI_DRIVER_FW_PATH_STA :=/etc/wifi/fw_bcmdhd_43241.bin
WIFI_DRIVER_FW_PATH_AP  :=/etc/wifi/fw_bcmdhd_43241.bin
WIFI_DRIVER_FW_PATH_P2P :=/etc/wifi/fw_bcmdhd_43241.bin

BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
PRODUCT_PACKAGES += \
	nvram_43241.bin   \
    fw_bcmdhd_43241.bin \
	wl \
	dhd 

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/bcmdhd.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/bcmdhd.ko:system/lib/bcmdhd.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8192cu
ifeq ($(WIFI_MODULE),rtl8192cu)

WIFI_DRIVER             := rtl8192cu
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8192cu.ko
WIFI_DRIVER_MODULE_NAME := 8192cu
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8192cu

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8188eu
ifeq ($(WIFI_MODULE),rtl8188eu)

PRODUCT_COPY_FILESWIFI_DRIVER             := rtl8188eu
WIFI_DRIVER             := rtl8188eu
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8188eu.ko
WIFI_DRIVER_MODULE_NAME := 8188eu

WIFI_DRIVER_FW_PATH_STA          := none
WIFI_DRIVER_MODULE_ARG           := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8189es

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8192du
ifeq ($(WIFI_MODULE),rtl8192du)

WIFI_DRIVER             := rtl8192du
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8192du.ko
WIFI_DRIVER_MODULE_NAME := 8192du
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8192du

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8192eu
ifeq ($(WIFI_MODULE),rtl8192eu)

WIFI_DRIVER             := rtl8192eu
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8192eu.ko
WIFI_DRIVER_MODULE_NAME := 8192eu
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8192eu

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8723au
ifeq ($(WIFI_MODULE),rtl8723au)

WIFI_DRIVER             := rtl8723au
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8723au.ko
WIFI_DRIVER_MODULE_NAME := 8723au
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8723au

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8723bu
ifeq ($(WIFI_MODULE),rtl8723bu)

WIFI_DRIVER             := rtl8723bu
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8723bu.ko
WIFI_DRIVER_MODULE_NAME := 8723bu
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8723bu

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8811au,rtl8821au
ifeq ($(WIFI_MODULE),rtl88x1au)

WIFI_DRIVER             := rtl88x1au
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8821au.ko
WIFI_DRIVER_MODULE_NAME := 8821au
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl88x1au

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rtl8812au
ifeq ($(WIFI_MODULE),rtl8812au)

WIFI_DRIVER             := rtl8812au
BOARD_WIFI_VENDOR       := realtek
WIFI_DRIVER_MODULE_PATH := /system/lib/8812au.ko
WIFI_DRIVER_MODULE_NAME := 8812au
WIFI_DRIVER_FW_PATH_STA := none
WIFI_DRIVER_MODULE_ARG  := "ifname=wlan0 if2name=p2p0"

WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
CONFIG_DRIVER_WEXT               :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nl80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nl80211

BOARD_WLAN_DEVICE := rtl8812au

WIFI_FIRMWARE_LOADER      := ""
WIFI_DRIVER_FW_PATH_STA   := ""
WIFI_DRIVER_FW_PATH_AP    := ""
WIFI_DRIVER_FW_PATH_P2P   := ""
WIFI_DRIVER_FW_PATH_PARAM := ""

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf
		
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## rt5370
ifeq ($(WIFI_MODULE),rt5370)

WIFI_DRIVER             := rt5370
WIFI_DRIVER_MODULE_PATH := /system/lib/rt5370sta.ko
WIFI_DRIVER_MODULE_NAME := rt5370sta

WIFI_DRIVER_FW_PATH_STA := none
WPA_SUPPLICANT_VERSION  := VER_0_8_X

CONFIG_DRIVER_WEXT                :=y
BOARD_WPA_SUPPLICANT_PRIVATE_LIB  := lib_driver_cmd_nl80211
BOARD_WPA_SUPPLICANT_DRIVER       := NL80211

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/rt5370sta.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/rt5370sta.ko:system/lib/rt5370sta.ko
endif

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif

################################################################################## mt7601u
ifeq ($(WIFI_MODULE),mt7601u)

WIFI_DRIVER             := mt7601u
WIFI_DRIVER_MODULE_PATH := /system/lib/mt7601Usta.ko
WIFI_DRIVER_MODULE_NAME := mt7601Usta

WPA_SUPPLICANT_VERSION  := VER_0_8_X
CONFIG_DRIVER_WEXT                :=y
BOARD_WPA_SUPPLICANT_DRIVER       := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB  := lib_driver_cmd_mtk

PRODUCT_COPY_FILES += device/amlogic/$(TARGET_PRODUCT)/MT7601EEPROM.bin:system/bin/MT7601EEPROM.bin
PRODUCT_COPY_FILES += device/amlogic/$(TARGET_PRODUCT)/RT2870STA.dat:system/etc/Wireless/RT2870STA/RT2870STA.dat

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif
################################################################################## mt5931
ifeq ($(WIFI_MODULE),mt5931)

MTK_WLAN_SUPPORT				:= true
WIFI_DRIVER             := mt5931
WIFI_DRIVER_MODULE_PATH := /system/lib/wlan.ko
WIFI_DRIVER_MODULE_NAME := wlan
P2P_SUPPLICANT_VERSION  := VER_0_8_X_MTK
BOARD_P2P_SUPPLICANT_DRIVER       := NL80211

 PRODUCT_PACKAGES += \
      p2p_supplicant.conf	

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/wlan.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/wlan.ko:system/lib/wlan.ko
endif    

PRODUCT_COPY_FILES += hardware/amlogic/wifi/mt5931/WIFI_RAM_CODE:system/etc/firmware/WIFI_RAM_CODE

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml
	
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0
	
endif

################################################################################## AP6xxx
ifeq ($(WIFI_AP6xxx_MODULE),AP6181)

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6181/Wi-Fi/fw_bcm40181a2.bin:system/etc/wifi/40181/fw_bcm40181a2.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6181/Wi-Fi/fw_bcm40181a2_apsta.bin:system/etc/wifi/40181/fw_bcm40181a2_apsta.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6181/Wi-Fi/fw_bcm40181a2_p2p.bin:system/etc/wifi/40181/fw_bcm40181a2_p2p.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6181/Wi-Fi/nvram_ap6181.txt:system/etc/wifi/40181/nvram.txt

endif

ifeq ($(WIFI_AP6xxx_MODULE),AP6210)

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6210/Wi-Fi/fw_bcm40181a2.bin:system/etc/wifi/40181/fw_bcm40181a2.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6210/Wi-Fi/fw_bcm40181a2_apsta.bin:system/etc/wifi/40181/fw_bcm40181a2_apsta.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6210/Wi-Fi/fw_bcm40181a2_p2p.bin:system/etc/wifi/40181/fw_bcm40181a2_p2p.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6210/Wi-Fi/nvram_ap6210.txt:system/etc/wifi/40181/nvram.txt

endif

ifeq ($(WIFI_AP6xxx_MODULE),AP6476)

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6476/Wi-Fi/fw_bcm40181a2.bin:system/etc/wifi/40181/fw_bcm40181a2.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6476/Wi-Fi/fw_bcm40181a2_apsta.bin:system/etc/wifi/40181/fw_bcm40181a2_apsta.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6476/Wi-Fi/fw_bcm40181a2_p2p.bin:system/etc/wifi/40181/fw_bcm40181a2_p2p.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6476/Wi-Fi/nvram_ap6476.txt:system/etc/wifi/40181/nvram.txt

endif

ifeq ($(WIFI_AP6xxx_MODULE),AP6493)

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6493/Wi-Fi/fw_bcm40183b2.bin:system/etc/wifi/40183/fw_bcm40183b2.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6493/Wi-Fi/fw_bcm40183b2_apsta.bin:system/etc/wifi/40183/fw_bcm40183b2_apsta.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6493/Wi-Fi/fw_bcm40183b2_p2p.bin:system/etc/wifi/40183/fw_bcm40183b2_p2p.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6493/Wi-Fi/nvram_ap6493.txt:system/etc/wifi/40183/nvram.txt

endif

ifeq ($(WIFI_AP6xxx_MODULE),AP6330)

PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6330/Wi-Fi/fw_bcm40183b2.bin:system/etc/wifi/40183/fw_bcm40183b2.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6330/Wi-Fi/fw_bcm40183b2_apsta.bin:system/etc/wifi/40183/fw_bcm40183b2_apsta.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6330/Wi-Fi/fw_bcm40183b2_p2p.bin:system/etc/wifi/40183/fw_bcm40183b2_p2p.bin
PRODUCT_COPY_FILES += hardware/amlogic/wifi/bcm_ampak/config/AP6330/Wi-Fi/nvram_ap6330.txt:system/etc/wifi/40183/nvram.txt

endif
