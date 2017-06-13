
LOCAL_PATH := $(my-dir)
###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := EPG-S805-VER3.52.108-20141230-F_sign
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_PREBUILT)
###############################################################################
