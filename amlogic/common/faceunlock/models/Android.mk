#
# Copyright (C) 2011 Google Inc.
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

LOCAL_PATH := $(call my-dir)

# ==== FaceLock models ========================

include $(CLEAR_VARS)

LOCAL_MODULE := detection/multi_pose_face_landmark_detectors.7/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================


include $(CLEAR_VARS)

LOCAL_MODULE := detection/multi_pose_face_landmark_detectors.7/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================
include $(CLEAR_VARS)

LOCAL_MODULE := detection/multi_pose_face_landmark_detectors.7/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-2/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================
include $(CLEAR_VARS)

LOCAL_MODULE := detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-r0-ri30.4a-v24/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================
include $(CLEAR_VARS)

LOCAL_MODULE := detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rn30-ri30.5-v24/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================
include $(CLEAR_VARS)

LOCAL_MODULE := detection/yaw_roll_face_detectors.6/head-y0-yi45-p0-pi45-rp30-ri30.5-v24/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# =============================================
include $(CLEAR_VARS)

LOCAL_MODULE := recognition/face.face.y0-y0-22-b-N/full_model.bin

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

# This will install the file in /system/vendor/pittpatt/models
LOCAL_MODULE_PATH := $(TARGET_OUT)/vendor/pittpatt/models
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

