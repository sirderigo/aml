#!/system/bin/sh

OUTPUTMODE=$(cat /sys/class/display/mode)

case $OUTPUTMODE in

    4k2k30hz)
        busybox echo 4k2k30hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale

    ;;  

    4k2k60hz420)
        busybox echo 4k2k60hz420 > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k50hz420)
        busybox echo 4k2k50hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k60hz)
        busybox echo 4k2k60hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k50hz)
        busybox echo 4k2k50hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k5g)
        busybox echo 4k2k5g > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;
    4k2k5g420)
        busybox echo 4k2k5g > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale
        busybox echo 2 > /sys/class/graphics/fb0/freescale_mode
        busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        busybox echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;
    1080p60hz)
        busybox echo 1080p60hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale

    ;;

    1080p50hz)
        busybox echo 1080p50hz > /sys/class/display/mode

        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale

    ;;    
    *)
        busybox echo "Error: Un-supported display mode"
        busybox echo "       Default to 1080p"

        busybox echo 1080p > /sys/class/display/mode
        #busybox fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #busybox fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        busybox echo 0 > /sys/class/graphics/fb0/free_scale

esac

