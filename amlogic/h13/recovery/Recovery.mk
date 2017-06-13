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
# This file combines a set of device-specific recovery related configuration.
#

# if use amlogic recovery system or not
TARGET_USE_AMLOGIC_RECOVERY := true

#------------------------------------------------------------------------------------------------
#
# Macros defined in below like TARGET_RECOVERY_NO_### use to exclude some files from 
# uImage_recovery, for project which is sensitive with size of uImage_recovery, use them reduce it`s size
#
# No Adbd in uImage_recovery
TARGET_RECOVERY_NO_ADBD := false

# No mali in uImage_recovery
TARGET_RECOVERY_NO_MALI := true

# No busybox in uImage_recovery
TARGET_RECOVERY_NO_BUSYBOX := false

# No console in uImage_recovery
TARGET_RECOVERY_NO_SH := false

# No remote in uImage_recovery
# If you set to false, you need copy remotecfg and remote.conf to device/amlogic/xxx/recovery, and add
# service remotecontrol /sbin/remotecfg /etc/remote.conf
#    oneshot
# to init.rc, note that remotecfg must be compiled with static library
# TARGET_RECOVERY_NO_REMOTE := false

#-------------------------------------------------------------------------------------------------
#
# Macros defined in below use to custom recovery program
#
# if has media internal storge
TARGET_RECOVERY_HAS_MEDIA := false

# label for internal storge
TARGET_RECOVERY_MEDIA_LABEL := "\"aml-$(TARGET_BOOTLOADER_BOARD_NAME)\""

# if has efuse support
TARGET_RECOVERY_HAS_EFUSE := false

# if support toggle display or not
TARGET_RECOVERY_TOGGLE_DISPLAY := false

# Does the device support additional update package installation source?
# Set to true if ONLY sdcard update is supported, or false if additional source (e.g. udisk) is supported.
TARGET_RECOVERY_HAS_SDCARD_ONLY := false

# custom ui library like for recovery 
TARGET_RECOVERY_UI_LIB :=

# ui menu loop select
TARGET_RECOVERY_MENU_LOOP_SELECT :=  true
