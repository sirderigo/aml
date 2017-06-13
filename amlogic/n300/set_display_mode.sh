#!/system/bin/sh

case `getprop sys.fb.bits` in
    32) osd_bits=32
    ;;

    *) osd_bits=16
    ;;
esac

OUTPUTMODE=$(getprop ubootenv.var.outputmode)

case $OUTPUTMODE in

    4k2k30hz)
        echo 4k2k30hz > /sys/class/display/mode
        
        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale

    ;;  

    4k2k60hz420)
        echo 4k2k60hz420 > /sys/class/display/mode
        
        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k50hz420)
        echo 4k2k50hz > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k60hz)
        echo 4k2k60hz > /sys/class/display/mode
        
        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k50hz)
        echo 4k2k50hz > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    4k2k5g)
        echo 4k2k5g > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;
    4k2k5g420)
        echo 4k2k5g > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale
        echo 2 > /sys/class/graphics/fb0/freescale_mode
        echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
        echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    ;;

    1080p60hz)
        echo 1080p60hz > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale

    ;;   
 
    1080p50hz)
        echo 1080p50hz > /sys/class/display/mode

        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale

    ;;    
    

    *)
        echo "Error: Un-supported display mode"
        echo "       Default to 1080p60hz"

        echo 1080p > /sys/class/display/mode
        #fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 3240 32 -rgba 8/24,8/16,8/8,0/0
        #fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 8/24,8/16,8/8,8/0
        echo 0 > /sys/class/graphics/fb0/free_scale

esac

