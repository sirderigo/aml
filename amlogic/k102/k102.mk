# Copyright (C) 2011 Amlogic Inc
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
# This file is the build configuration for a full Android
# build for MX reference board. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit from those products. Most specific first.
$(call inherit-product-if-exists, vendor/google/products/gms.mk)
$(call inherit-product, device/amlogic/common/mid_amlogic.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk

# Discard inherited values and use our own instead.
PRODUCT_NAME := k102
PRODUCT_MANUFACTURER := MID
PRODUCT_DEVICE := k102
PRODUCT_MODEL := k102
PRODUCT_CHARACTERISTICS := tablet


TARGET_SUPPORT_USB_BURNING_V2 := true
ifeq ($(TARGET_SUPPORT_USB_BURNING_V2),true)
TARGET_USB_BURNING_V2_DEPEND_MODULES := img-package
#BOARD_USERDATAIMAGE_PARTITION_SIZE := 12884901888
#BOARD_CACHEIMAGE_PARTITION_SIZE := 367001600
#BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
endif

#framebuffer use 3 buffers
TARGET_USE_TRIPLE_FB_BUFFERS := true
#########################################################################
#
#                                                Audio
#
#########################################################################

#possible options: 1 tiny 2 legacy
BOARD_ALSA_AUDIO := tiny
BOARD_AUDIO_CODEC := rt5616

ifneq ($(strip $(wildcard $(LOCAL_PATH)/mixer_paths.xml)),)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/mixer_paths.xml:system/etc/mixer_paths.xml
endif

include device/amlogic/common/audio.mk

ifeq ($(BOARD_ALSA_AUDIO),legacy)
PRODUCT_PROPERTY_OVERRIDES += \
    alsa.mixer.capture.master=Digital \
    alsa.mixer.capture.headset=Digital \
    alsa.mixer.capture.earpiece=Digital
endif

#########################################################################
#
#                                                USB
#
#########################################################################

BOARD_USES_USB_PM := true
	
#########################################################################
#
#                                                WiFi
#
#########################################################################

#WIFI_MODULE := AP6441
#WIFI_AP6xxx_MODULE := AP6441
#NFC_MODULE := AP6441

WIFI_MODULE := bcm40183
WIFI_AP6xxx_MODULE := AP6330

include device/amlogic/common/wifi.mk
#include device/amlogic/common/nfc.mk


# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
PRODUCT_DEFAULT_WIFI_CHANNELS := 11


#########################################################################
#
#                                                Bluetooth
#
#########################################################################
BOARD_HAVE_BLUETOOTH := true
BLUETOOTH_MODULE := AP6330

include device/amlogic/common/bluetooth.mk

#########################################################################
#
#                                                GPS
#
#########################################################################

GPS_MODULE :=
include device/amlogic/common/gps.mk

#########################################################################
#
#                                                Camera
#
#########################################################################
BOARD_HAVE_FRONT_CAM :=true
BOARD_HAVE_BACK_CAM :=true
IS_CAM_NONBLOCK := true
BOARD_HAVE_HW_JPEGENC := true

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml
#	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml
	
PRODUCT_PROPERTY_OVERRIDES += \
	hw.cameras=2

# Camera Orientation
PRODUCT_PROPERTY_OVERRIDES += \
	ro.camera.orientation.front=90 \
	ro.camera.orientation.back=90



# uncomment features file copy if board have some sensor
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml
#	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
#	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
#	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
#	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \


#########################################################################
#
#                                                Init.rc
#
#########################################################################

PRODUCT_COPY_FILES += \
	device/amlogic/common/init/tablet/init.amlogic.rc:root/init.amlogic.rc \
	$(LOCAL_PATH)/init.amlogic.usb.rc:root/init.amlogic.usb.rc \
	$(LOCAL_PATH)/init.amlogic.board.rc:root/init.amlogic.board.rc \
	device/amlogic/common/init/tablet/ueventd.amlogic.rc:root/ueventd.amlogic.rc


#########################################################################
#
#                                                languages
#
#########################################################################

# For all locales, $(call inherit-product, build/target/product/languages_full.mk)
PRODUCT_LOCALES := en_US fr_FR it_IT es_ES de_DE nl_NL cs_CZ pl_PL ja_JP zh_TW zh_CN ru_RU \
   ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG ca_ES en_GB fi_FI hi_IN \
   hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA vi_VN tl_PH ar_EG fa_IR \
   th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN


#########################################################################
#
#                                                Software features
#
#########################################################################

BUILD_WITH_AMLOGIC_PLAYER := true
BUILD_WITH_APP_OPTIMIZATION := true
BUILD_WITH_WIDEVINE_DRM := true
BUILD_WITH_EREADER := true 
# facelock enable, board should has front camera
BUILD_WITH_FACE_UNLOCK := true

include device/amlogic/common/software.mk

#########################################################################
#
#                                                Misc
#
#########################################################################


# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072


PRODUCT_PACKAGES += \
	lights.amlogic \
	FileBrowser \
	AppInstaller \
	VideoPlayer \
	SubTitle \
	HdmiSwitch \
	fw_env \
	PromptUser

# Device specific system feature description
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	$(LOCAL_PATH)/Third_party_apk_camera.xml:system/etc/Third_party_apk_camera.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml


# This only for m3
# Battery icons shown from uboot
#PRODUCT_COPY_FILES += \
#	device/amlogic/common/res/battery/0.rot270.bmp:system/resource/battery_pic/0.bmp \
#	device/amlogic/common/res/battery/1.rot270.bmp:system/resource/battery_pic/1.bmp \
#	device/amlogic/common/res/battery/2.rot270.bmp:system/resource/battery_pic/2.bmp \
#	device/amlogic/common/res/battery/3.rot270.bmp:system/resource/battery_pic/3.bmp \
#	device/amlogic/common/res/battery/4.rot270.bmp:system/resource/battery_pic/4.bmp \
#	device/amlogic/common/res/battery/power_low.rot270.bmp:system/resource/battery_pic/power_low.bmp


PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/alarm_blacklist.txt:/system/etc/alarm_blacklist.txt \
	$(LOCAL_PATH)/alarm_whitelist.txt:/system/etc/alarm_whitelist.txt \
	$(LOCAL_PATH)/sensor_access.txt:/system/etc/sensor_access.txt \
	$(LOCAL_PATH)/ds1-default.xml:/system/etc/ds1-default.xml
#	$(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip \

#touch firmware	
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/touch/gsl3680b_k102.cfg:system/etc/touch/gsl3680b_k102.cfg \
	$(LOCAL_PATH)/touch/gsl3680b_k102.fw:system/etc/touch/gsl3680b_k102.fw

CAM_CONFIG_FILES := ar0543_skt ov5647_cw0767 ov5647_k100		
		
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/u-boot.bin:u-boot.bin
#low memory killer
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/lowmemorykiller.txt:/system/etc/lowmemorykiller.txt

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/../common/res/logo/robot.768x1024.rot180.rle:root/initlogo.rle.bak \
	$(LOCAL_PATH)/../common/res/logo/robot.768x1024.rot180_firstinit.rle:root/firstinitlogo.rle
	
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/zram_mount.sh:/system/bin/zram_mount.sh
# inherit from the non-open-source side, if present
$(call inherit-product-if-exists, vendor/amlogic/k102/device-vendor.mk)
