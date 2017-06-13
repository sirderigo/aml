#!/system/bin/sh

case `getprop sys.fb.bits` in
    32) osd_bits=32
    ;;

    *) osd_bits=16
    ;;
esac

case $1 in 

    lvds1080p)
        fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 2160 32 -rgba 5/11,6/5,5/0,0/0
        fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 5/11,6/5,5/0,0/0
    ;;  

    lvds1080p50hz)
        fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 2160 32 -rgba 5/11,6/5,5/0,0/0
        fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 5/11,6/5,5/0,0/0
    ;;    

    *)
        echo "Error: Un-supported display mode lvds1080p"
        echo "       Default to lvds1080p"
        fbset -fb /dev/graphics/fb0 -g 1920 1080 1920 2160 32 -rgba 5/11,6/5,5/0,0/0
        fbset -fb /dev/graphics/fb1 -g 64 64 64 64 32 -rgba 5/11,6/5,5/0,0/0

esac
