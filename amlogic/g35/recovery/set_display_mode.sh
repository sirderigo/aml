#!/system/bin/sh
#for recovery
display_mode=$(cat /sys/class/display/mode)

busybox echo 1 > /sys/class/graphics/fb0/blank
busybox echo 1 > /sys/class/graphics/fb1/blank

busybox echo 720p > /sys/class/display/mode
busybox echo 40 25 1240 690 0 > /sys/class/ppmgr/ppscaler_rect


echo 0 0 1280 720 0 0 18 18 > /sys/class/display/axis
echo 0 > /sys/class/graphics/fb0/freescale_mode
echo 0 > /sys/class/graphics/fb1/freescale_mode
echo 0 0 1279 719 > /sys/class/graphics/fb0/free_scale_axis
busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale


busybox echo 0 > /sys/class/graphics/fb0/blank

