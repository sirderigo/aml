LOCAL_PATH := $(call my-dir)
ifeq (n300, $(TARGET_BOOTLOADER_BOARD_NAME))
$(warning cp  append to $(ANDROID_PRODUCT_OUT)/system/)
$(shell cd $(LOCAL_PATH) && mkdir -p $(ANDROID_PRODUCT_OUT)/system && cp -rf system/* $(ANDROID_PRODUCT_OUT)/system > /dev/null)
else
$(warning  dont't include $(call my-dir)/Android.mk )
endif
