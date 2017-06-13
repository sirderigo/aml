LOCAL_PATH := $(my-dir)

#########################################
include $(CLEAR_VARS)

LOCAL_PREBUILT_LIBS := libfacelock_jni.so

LOCAL_MODULE_TAGS := optional

include $(BUILD_MULTI_PREBUILT) 
