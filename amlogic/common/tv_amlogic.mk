#
# Copyright (C) 2007 The Android Open Source Project
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
    remotecfg \
    OpenWnn \
    libWnnEngDic \
    libWnnJpnDic \
    libwnndict \
    Contacts \
    ContactsProvider \
    WAPPushManager \
    Discovery.apk \
    IpRemote.apk \
    RemoteIME \
    DLNA \
    OTAUpgrade \
    RC_Server \
    libasound \
    alsalib-alsaconf \
    alsalib-pcmdefaultconf \
    alsalib-cardsaliasesconf \
    libamstreaming \
    bootplayer	\
    libTVaudio	\
    imageserver

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


# NativeImagePlayer
PRODUCT_PACKAGES += \
    NativeImagePlayer
    
# ATV
PRODUCT_PACKAGES += \
	tv \
	tvserver \
	libtv \
	libtvbinder \
	libtv_jni \
	libzvbi \
	libntsc_decode \
	libtinyxml \
	libkeycode_set_jni \
	libsrs.so \
	libhpeq.so

# DTV
PRODUCT_PACKAGES += \
	libam_adp \
	libam_mw \
	libam_ver

# TV UI
PRODUCT_PACKAGES += \
	TvPlayer \
	TVService

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
    

#Camera & Sensors Hal
PRODUCT_PACKAGES += \
	camera.amlogic

#	sensors.amlogic

# remote control
#PRODUCT_PACKAGES += \
    remote_control

# YAFFS2 tools
#PRODUCT_PACKAGES += \
    mkyaffsimage2K.dat \
    mkyaffsimage4K.dat

#PRODUCT_PACKAGES += \
    usbtestpm \
    usbpower \
    usbtestpm_mx \
    usbtestpm_mx_iddq \
    usbpower_mx_iddq

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

#init*.rc	
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init/tv/init.amlogic.rc:root/init.amlogic.rc \
	$(LOCAL_PATH)/init/tv/ueventd.amlogic.rc:root/ueventd.amlogic.rc \
	$(TARGET_PRODUCT_DIR)/init.amlogic.usb.rc:root/init.amlogic.usb.rc \
	$(TARGET_PRODUCT_DIR)/init.amlogic.board.rc:root/init.amlogic.board.rc
	
#input tv config files
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/tvconfig.conf:system/etc/tvconfig.conf \
	$(TARGET_PRODUCT_DIR)/tv_default.cfg:system/etc/tv_default.cfg \
	$(TARGET_PRODUCT_DIR)/tv_default.xml:system/etc/tv_default.xml \
	$(TARGET_PRODUCT_DIR)/tv_setting_config.cfg:system/etc/tv_setting_config.cfg \
	$(TARGET_PRODUCT_DIR)/param/pq.db:system/etc/pq.db \
	$(TARGET_PRODUCT_DIR)/tvcp.sh:system/bin/tvcp.sh
	
#tv dec bin
PRODUCT_COPY_FILES += $(TARGET_PRODUCT_DIR)/dec:system/bin/dec

#remote config
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/remote.conf:/system/etc/remote.conf \
	$(TARGET_PRODUCT_DIR)/remote_mouse.conf:/system/etc/remote_mouse.conf

# USB
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

#copy all possible idc to target
PRODUCT_COPY_FILES += \
    device/amlogic/common/idc/ft5x06.idc:system/usr/idc/ft5x06.idc \
    device/amlogic/common/idc/pixcir168.idc:system/usr/idc/pixcir168.idc \
    device/amlogic/common/idc/ssd253x-ts.idc:system/usr/idc/ssd253x-ts.idc \
    device/amlogic/common/idc/Vendor_222a_Product_0001.idc:system/usr/idc/Vendor_222a_Product_0001.idc \
    device/amlogic/common/idc/Vendor_dead_Product_beef.idc:system/usr/idc/Vendor_dead_Product_beef.idc

#cp kl file for adc keyboard
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/Vendor_0001_Product_0001.kl:/system/usr/keylayout/Vendor_0001_Product_0001.kl

#copy set_display_mode.sh
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/set_display_mode.sh:system/bin/set_display_mode.sh

#copy zram_mount.sh
PRODUCT_COPY_FILES += \
	$(TARGET_PRODUCT_DIR)/zram_mount.sh:system/bin/zram_mount.sh 
	
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


# Get some sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

# Get everything else from the parent package
#$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)
$(call inherit-product, device/amlogic/common/generic_no_telephony_amlogic.mk)

# Include BUILD_NUMBER if defined
$(call inherit-product, $(TARGET_PRODUCT_DIR)/version_id.mk)

DISPLAY_BUILD_NUMBER := true

# Overrides
PRODUCT_BRAND := TV
PRODUCT_DEVICE := Android Reference Device
PRODUCT_NAME := Android Reference Design
PRODUCT_MANUFACTURER := TV
PRODUCT_CHARACTERISTICS := TV

# Override the PRODUCT_BOOT_JARS set in core_minimal.mk
PRODUCT_BOOT_JARS := core:conscrypt:okhttp:core-junit:bouncycastle:ext:framework:framework2:telephony-common:voip-common:mms-common:android.policy:services:apache-xml:webviewchromium:tv
