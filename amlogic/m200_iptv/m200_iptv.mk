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
$(call inherit-product, device/amlogic/common/mbx_amlogic.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Replace definitions used by tablet in mid_amlogic.mk above
# Overrides
PRODUCT_BRAND := MBX
PRODUCT_DEVICE := Android Reference Device
PRODUCT_NAME := Android Reference Design
PRODUCT_CHARACTERISTICS := mbx

include frameworks/native/build/mbox-1024-dalvik-heap.mk

# Discard inherited values and use our own instead.
PRODUCT_NAME := m200_iptv
PRODUCT_MANUFACTURER := MBX
PRODUCT_DEVICE := m200_iptv
PRODUCT_MODEL := m200_iptv
# PRODUCT_CHARACTERISTICS := tablet,nosdcard

# for China mobile version
CHINA_MOBILE_ENABLE := true
TARGET_SUPPORT_USB_BURNING_V2 := true
ifeq ($(TARGET_SUPPORT_USB_BURNING_V2),true)
TARGET_USB_BURNING_V2_DEPEND_MODULES := img-package
#BOARD_USERDATAIMAGE_PARTITION_SIZE := 12884901888
#BOARD_CACHEIMAGE_PARTITION_SIZE := 367001600
#BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
endif

ifeq ($(CHINA_MOBILE_ENABLE), true)
 TARGET_BUILD_WIPE_CACHE := true
 DISABLE_BUILD_UTC_CHECK := true
 LIVEPLAY_SEEK := true
 DEFENV_IN_FACTORY_RESET := true
 USB_BURN := true
 CHINA_MOBILE_PPPOE := true
 CUSTOMER_SERIALNO_MAC := true
endif

# for security boot
#TARGET_USE_SECURITY_MODE :=true

#framebuffer use 3 buffers
TARGET_USE_TRIPLE_FB_BUFFERS := true

BOARD_USES_AML_SENSOR_HAL := true

#########################################################################
#
#                                                Audio
#
#########################################################################

#possible options: 1 tiny 2 legacy
BOARD_ALSA_AUDIO := tiny
BOARD_AUDIO_CODEC := amlpmu3
BOARD_USE_USB_AUDIO := true

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

WIFI_MODULE := AP6335
include device/amlogic/common/wifi.mk

# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
PRODUCT_DEFAULT_WIFI_CHANNELS := 11

#########################################################################
#
#                                                Bluetooth
#
#########################################################################

BOARD_HAVE_BLUETOOTH := true
BLUETOOTH_MODULE := AP6335
include device/amlogic/common/bluetooth.mk

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml

#########################################################################
#
#                                                GPS
#
#########################################################################

GPS_MODULE :=
include device/amlogic/common/gps.mk



#########################################################################
#
#                                                Init.rc
#
#########################################################################

PRODUCT_COPY_FILES += \
	device/amlogic/common/init/mbx/init.amlogic.rc:root/init.amlogic.rc \
	$(LOCAL_PATH)/init.amlogic.usb.rc:root/init.amlogic.usb.rc \
	device/amlogic/common/init/mbx/ueventd.amlogic.rc:root/ueventd.amlogic.rc

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.amlogic.board.rc:root/init.amlogic.board.rc

#########################################################################
#
#                                                languages
#
#########################################################################

# For all locales, $(call inherit-product, build/target/product/languages_full.mk)
ifeq ($(strip $(CHINA_MOBILE_ENABLE)),true)
PRODUCT_LOCALES := zh_CN en_US fr_FR it_IT es_ES de_DE nl_NL cs_CZ pl_PL ja_JP zh_TW ru_RU \
   ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG ca_ES en_GB fi_FI hi_IN \
   hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA vi_VN tl_PH ar_EG fa_IR \
   th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN
else
PRODUCT_LOCALES := en_US fr_FR it_IT es_ES de_DE nl_NL cs_CZ pl_PL ja_JP zh_TW zh_CN ru_RU \
   ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG ca_ES en_GB fi_FI hi_IN \
   hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA vi_VN tl_PH ar_EG fa_IR \
   th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN
endif


#########################################################################
#
#                                                Software features
#
#########################################################################

BUILD_WITH_AMLOGIC_PLAYER := true
BUILD_WITH_APP_OPTIMIZATION := true
BUILD_WITH_WIDEVINE_DRM := true
#BUILD_WITH_PLAYREADY_DRM := true
BUILD_WITH_EREADER := true 
BUILD_WITH_MIRACAST := true
#BUILD_WITH_XIAOCONG := true
BUILD_WITH_THIRDPART_APK := true
BUILD_WITH_BOOT_PLAYER:= true
BUILD_AMVIDEO_CAPTURE_TEST:=false
ifeq ($(wildcard vendor/google/products/gms.mk),)
# facelock enable, board should have front camera
BUILD_WITH_FACE_UNLOCK := true
endif

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

ifeq ($(strip $(CHINA_MOBILE_ENABLE)),true)
EPG_ENABLE := true

PRODUCT_PACKAGES += \
	FileBrowser \
	VideoPlayer \
	SubTitle \
	Samba \
	smbd\
	libsmbbase \
	libsmbmnt \
	RemoteIME \
	remotecfg \
	DLNA \
	OTAUpgrade \
	RC_Server \
	AmlMiracast \
	Discovery.apk \
	IpRemote.apk \
	PromptUser \
	libasound \
	alsalib-alsaconf \
	alsalib-pcmdefaultconf \
	alsalib-cardsaliasesconf \
	libamstreaming \
	bootplayer

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/ChinaMobile_apks/ChinaMobileOttItv_sign.apk:system/app/ChinaMobileOttItv_sign.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/libupnpdevice.so:system/lib/libupnpdevice.so \
  $(LOCAL_PATH)/ChinaMobile_apks/SHCMCC_Downloader.apk:system/app/SHCMCC_Downloader.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/shcmcc_installer.apk:system/app/shcmcc_installer.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/libmacaddress.so:system/lib/libmacaddress.so \
  $(LOCAL_PATH)/ChinaMobile_apks/SWControlServer_chinamobile.apk:system/app/SWControlServer_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWGuide_chinamobile.apk:system/app/SWGuide_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWIME2.apk:system/app/SWIME2.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWLogin_chinamobile.apk:system/app/SWLogin_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWLauncher_chinamobile.apk:system/app/SWLauncher_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWPlayer.apk:system/app/SWPlayer.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWLocalPlayer.apk:system/app/SWLocalPlayer.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWNetworkInfo_chinamobile.apk:system/app/SWNetworkInfo_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWSettings_chinamobile.apk:system/app/SWSettings_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWUpgrade_chinamobile.apk:system/app/SWUpgrade_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWUpgrade_usb.apk:system/app/SWUpgrade_usb.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWOTT_chinamobile.apk:system/app/SWOTT_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWXmpp_chinamobile.apk:system/app/SWXmpp_chinamobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/Bestv_Inside.apk:system/app/Bestv_Inside.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/icntv-shmobile.apk:system/app/icntv-shmobile.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SHCMCC_Diagnostic_sign.apk:system/app/SHCMCC_Diagnostic_sign.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SWControlServer_wimo.apk:system/app/SWControlServer_wimo.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/libtxcore.so:system/lib/libtxcore.so \
  $(LOCAL_PATH)/ChinaMobile_apks/SHCMCC_DeviceManger.apk:system/app/SHCMCC_DeviceManger.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SHCMCC_SANPING.apk:system/app/SHCMCC_SANPING.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/SHCMCC_wimo.apk:system/app/SHCMCC_wimo.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/com_joysee_stb_tv_1_3_2_3_jiangsu.apk:system/app/com_joysee_stb_tv_1_3_2_3_jiangsu.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/GalaxyITV_ShuMaShiXun_3.5.12.apk:system/app/GalaxyITV_ShuMaShiXun_3.5.12.apk \
  $(LOCAL_PATH)/ChinaMobile_apks/Launcher2.apk:system/app/Launcher2.apk 
  	
else

PRODUCT_PACKAGES += \
	FileBrowser \
	AppInstaller \
	VideoPlayer \
	SubTitle \
	Samba \
	smbd\
	libsmbbase \
	libsmbmnt \
	RemoteIME \
	remotecfg \
	DLNA \
	OTAUpgrade \
	RC_Server \
	AmlMiracast \
	MediaBoxLauncher \
	MboxSetting	\
	Discovery.apk \
	IpRemote.apk \
	PromptUser \
	libasound \
	alsalib-alsaconf \
	alsalib-pcmdefaultconf \
	alsalib-cardsaliasesconf \
	libamstreaming \
	bootplayer

BUILD_WITH_PPPOE := true
endif

ifeq ($(CHINA_MOBILE_ENABLE),true)
ifeq ($(BUILD_WITH_PPPOE),true)
PRODUCT_PACKAGES += \
    libpppoejni \
    pppoe_wrapper \
    pppoe \
    amlogic.pppoe \
    amlogic.pppoe.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.platform.has.pppoe=true
endif
else
ifeq ($(BUILD_WITH_PPPOE),true)
PRODUCT_PACKAGES += \
    PPPoE \
    libpppoejni \
    pppoe_wrapper \
    pppoe \
    amlogic.pppoe \
    amlogic.pppoe.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.platform.has.pppoe=true
endif
endif

ifeq ($(CHINA_MOBILE_PPPOE),true)
PRODUCT_PACKAGES += \
    libcbpppoejni
endif


# Device specific system feature description
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	$(LOCAL_PATH)/Third_party_apk_camera.xml:system/etc/Third_party_apk_camera.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml

ifeq ($(strip $(CHINA_MOBILE_ENABLE)),true)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/alarm_blacklist.txt:/system/etc/alarm_blacklist.txt \
	$(LOCAL_PATH)/alarm_whitelist.txt:/system/etc/alarm_whitelist.txt \
	$(LOCAL_PATH)/remote_chinamobile.conf:system/etc/remote.conf \
	$(LOCAL_PATH)/default_shortcut.cfg:system/etc/default_shortcut.cfg 
else
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/alarm_blacklist.txt:/system/etc/alarm_blacklist.txt \
	$(LOCAL_PATH)/alarm_whitelist.txt:/system/etc/alarm_whitelist.txt \
	$(LOCAL_PATH)/remote.conf:system/etc/remote.conf \
	$(LOCAL_PATH)/default_shortcut.cfg:system/etc/default_shortcut.cfg 
endif

PRODUCT_COPY_FILES += \
	device/amlogic/common/res/screen_saver/dlna.jpg:system/media/screensaver/images/dlna.jpg \
	device/amlogic/common/res/screen_saver/miracast.jpg:system/media/screensaver/images/miracast.jpg \
	device/amlogic/common/res/screen_saver/phone_remote.jpg:system/media/screensaver/images/phone_remote.jpg

    ifeq ($(TARGET_USE_SECURITY_MODE),true)
      PRODUCT_COPY_FILES += \
        $(TARGET_PRODUCT_DIR)/u-boot-usb.bin.aml:$(PRODUCT_OUT)/u-boot-usb.bin.aml \
        $(TARGET_PRODUCT_DIR)/ddr_init.bin:$(PRODUCT_OUT)/DDR_ENC.USB \
        $(TARGET_PRODUCT_DIR)/u-boot.bin.aml:$(PRODUCT_OUT)/u-boot.bin.aml \
        $(TARGET_PRODUCT_DIR)/u-boot.bin.aml:$(PRODUCT_OUT)/u-boot.bin
    else
      PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/u-boot.bin:u-boot.bin
    endif

#low memory killer
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/lowmemorykiller.txt:/system/etc/lowmemorykiller.txt

# App optimization
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/liboptimization.so:system/lib/liboptimization.so \
	$(LOCAL_PATH)/config:system/etc/config  \
	$(LOCAL_PATH)/wifi/config.txt:system/etc/wifi/config.txt \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf
	
# bootanimation and bootvideo
ifeq ($(strip $(CHINA_MOBILE_ENABLE)),true)
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/bootanimation_chinamobile.zip:system/media/bootanimation.zip \
  $(LOCAL_PATH)/mbox.mp4:system/etc/bootvideo 
else
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip \
  $(LOCAL_PATH)/mbox.mp4:system/etc/bootvideo
endif
# inherit from the non-open-source side, if present
$(call inherit-product-if-exists, vendor/amlogic/m200_iptv/device-vendor.mk)
