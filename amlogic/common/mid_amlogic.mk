#
# Copyright (C) 2009 The Android Open Source Project
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

# This is a generic Amlogic product
# It includes the base Android platform.

PRODUCT_PACKAGES := \
    drmserver \
    libdrmframework \
    libdrmframework_jni \
    libfwdlockengine \
    PinyinIME \
    libWnnEngDic \
    libWnnJpnDic \
    libwnndict \
    Contacts \
    ContactsProvider \
    WAPPushManager

# Live Wallpapers
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers

# sensors
PRODUCT_PACKAGES += \
    libmplmpu \
    libmllite \
    libmlplatform
    
# multi-user permission
PRODUCT_PACKAGES += \
    libsystemwriteservice

# Additional settings used in all AOSP builds
PRODUCT_PROPERTY_OVERRIDES := \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.ringtone=Ring_Synth_04.ogg \
    ro.config.notification_sound=pixiedust.ogg

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := en_US

# needed for ASEC
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

PRODUCT_PACKAGES += \
    busybox \
    utility_busybox \
    ntfs-3g \
    mkntfs \
    ntfsfix \
    fsck.exfat mount.exfat

# Mali GPU OpenGL libraries
PRODUCT_PACKAGES += \
    libGLES_mali \
    egl.cfg \
    gralloc.amlogic \
    hwcomposer.amlogic

# Player
PRODUCT_PACKAGES += \
    amlogic.subtitle.xml \
    amlogic.libplayer.xml


# Amlogic RIL
PRODUCT_PACKAGES += \
	Phone       \
	usb_modeswitch \
	libaml-ril.so \
	init-pppd.sh \
	rild \
	ip-up \
	chat

#Camera & Sensors Hal
PRODUCT_PACKAGES += \
	camera.amlogic \
	sensors.amlogic

# YAFFS2 tools
#PRODUCT_PACKAGES += \
    mkyaffsimage2K.dat \
    mkyaffsimage4K.dat


# libemoji for Webkit
PRODUCT_PACKAGES += libemoji

#USB PM
PRODUCT_PACKAGES += \
    usbtestpm \
    usbpower

PRODUCT_COPY_FILES += \
    device/amlogic/common/tools/AmlHostsTool:system/bin/AmlHostsTool 

#possible options:1 mass_storage 2 mtp
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# USB
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml	

# Touch screen features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
    
#copy all possible idc to target
PRODUCT_COPY_FILES += \
    device/amlogic/common/idc/ft5x06.idc:system/usr/idc/ft5x06.idc \
    device/amlogic/common/idc/pixcir168.idc:system/usr/idc/pixcir168.idc \
    device/amlogic/common/idc/ssd253x-ts.idc:system/usr/idc/ssd253x-ts.idc \
    device/amlogic/common/idc/Vendor_222a_Product_0001.idc:system/usr/idc/Vendor_222a_Product_0001.idc \
    device/amlogic/common/idc/Vendor_dead_Product_beef.idc:system/usr/idc/Vendor_dead_Product_beef.idc \
    device/amlogic/common/idc/mg-capacitive.idc:system/usr/idc/mg-capacitive.idc

#cp kl file for adc keyboard
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/Vendor_0001_Product_0001.kl:/system/usr/keylayout/Vendor_0001_Product_0001.kl

#copy set_display_mode.sh
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/set_display_mode.sh:system/bin/set_display_mode.sh 

#copy lowmem_manage.sh
PRODUCT_COPY_FILES += \
	device/amlogic/common/lowmem_manage.sh:system/bin/lowmem_manage.sh

#copy lowmemorykiller.txt
ifeq ($(BUILD_WITH_LOWMEM_COMMON_CONFIG),true)
PRODUCT_COPY_FILES += \
	device/amlogic/common/config/lowmemorykiller_2G.txt:/system/etc/lowmemorykiller_2G.txt \
	device/amlogic/common/config/lowmemorykiller.txt:/system/etc/lowmemorykiller.txt \
	device/amlogic/common/config/lowmemorykiller_512M.txt:/system/etc/lowmemorykiller_512M.txt
endif

ifneq ($(wildcard frameworks/base/Android.mk),)
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif

ifneq ($(wildcard frameworks/base/Android.mk),)
# Overlay for device specific settings
DEVICE_PACKAGE_OVERLAYS := $(TARGET_PRODUCT_DIR)/overlay
endif


ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/mali.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/mali.ko:root/boot/mali.ko
endif

ifneq ($(wildcard $(TARGET_PRODUCT_DIR)/ump.ko),)
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/ump.ko:root/boot/ump.ko
endif

$(call inherit-product-if-exists, external/libusb/usbmodeswitch/CopyConfigs.mk)
$(call inherit-product-if-exists, hardware/amlogic/libril/config/Copy.mk)


# Get some sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

# Get a list of languages.
$(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)

# Get everything else from the parent package
#$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)
$(call inherit-product, device/amlogic/common/generic_no_telephony_amlogic.mk)

# Include BUILD_NUMBER if defined
$(call inherit-product, $(TARGET_PRODUCT_DIR)/version_id.mk)


DISPLAY_BUILD_NUMBER := true

# Overrides
PRODUCT_BRAND := MID
PRODUCT_DEVICE := Android Reference Device
PRODUCT_NAME := Android Reference Design
PRODUCT_CHARACTERISTICS := tablet
