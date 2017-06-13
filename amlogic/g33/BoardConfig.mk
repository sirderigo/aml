# Copyright (C) 2010 Amlogic Inc
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

# config.mk
#
# Product-specific compile-time definitions.
#

##################################################### CPU
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a9

##################################################### release package
TARGET_BOOTLOADER_BOARD_NAME := g33
TARGET_BOARD_PLATFORM := meson6
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_SIMULATOR := false

TARGET_NO_KERNEL := false
include device/amlogic/$(TARGET_PRODUCT)/Kernel.mk
TARGET_AMLOGIC_BOOTLOADER := $(PRODUCT_OUT)/u-boot.bin
# TARGET_AMLOGIC_AML_LOGO := device/amlogic/common/res/logo/a9.1024x768.bmp
TARGET_AMLOGIC_LOGO := $(PRODUCT_OUT)/res-package.img
TARGET_AMLOGIC_RES_PACKAGE := device/amlogic/g33/res_pack
TARGET_BUILD_WIPE_USERDATA := false
TARGET_RECOVERY_ROTATE := 270
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_FLASH_BLOCK_SIZE := 2048


USE_OPENGL_RENDERER := true

#GPU
USING_MALI450:=false
USING_ION:=true

#SENSOR
BOARD_SENSOR_AMLOGIC:=true
BOARD_SENSOR_KIONIX_61G:=false
#PRODUCT_EXTRA_RECOVERY_KEYS := ../common/releasekey.x509.pem

include device/amlogic/common/sepolicy.mk
