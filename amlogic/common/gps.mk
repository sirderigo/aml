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


# Disable GPS by default
PRODUCT_PROPERTY_OVERRIDES += \
	gps.enable=false

PRODUCT_COPY_FILES += \
	device/amlogic/common/config/gps.conf:system/etc/gps.conf

################################################################################## xxx
ifeq ($(GPS_MODULE),xxx)

PRODUCT_PROPERTY_OVERRIDES += \
	gps.enable=true

PRODUCT_PACKAGES += \
	gps.amlogic

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml


endif

ifeq ($(GPS_MODULE), AP6476)
PRODUCT_PROPERTY_OVERRIDES += \
	gps.enable=true

PRODUCT_COPY_FILES += \
    	device/amlogic/common/bplus/gps.default.so:system/lib/hw/gps.default.so \
	device/amlogic/common/bplus/glgps:system/bin/glgps \
	device/amlogic/common/bplus/gpsconfig.xml:system/etc/gpsconfig.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml
endif
