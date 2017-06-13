#!/system/bin/sh
#for recovery
old_state=1
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)
display_mode=$(cat /sys/class/display/mode)
old_state=$hpdstate

busybox echo 1 > /sys/class/graphics/fb0/blank
busybox echo 1 > /sys/class/graphics/fb1/blank

if [ $hpdstate -eq 1 ] ; then
    busybox echo 720p > /sys/class/display/mode
    busybox echo 40 25 1240 690 0 > /sys/class/ppmgr/ppscaler_rect

elif [ $hpdstate -eq 0 ] ; then
    busybox echo 576cvbs > /sys/class/display/mode	
    busybox echo 30 20 680 556 0 > /sys/class/ppmgr/ppscaler_rect
    
else
    busybox echo 720p > /sys/class/display/mode
    busybox echo 40 25 1240 690 0 > /sys/class/ppmgr/ppscaler_rect
   
fi

echo 0 0 1280 720 0 0 18 18 > /sys/class/display/axis
echo 0 > /sys/class/graphics/fb0/freescale_mode
echo 0 > /sys/class/graphics/fb1/freescale_mode
echo 0 0 1279 719 > /sys/class/graphics/fb0/free_scale_axis
busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale

busybox echo null > /sys/class/display2/mode
busybox echo 576cvbs > /sys/class/display2/mode 
busybox echo 1 > /sys/class/video2/screen_mode
busybox echo 0  > /sys/module/amvideo2/parameters/clone_frame_scale_width

busybox echo 0 > /sys/class/graphics/fb0/blank

#for checking is hdmi or cvbs 

while true ; do
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)

if [ $hpdstate != $old_state ] ; then
	old_state=$hpdstate
	if [ $hpdstate -eq 1 ] ; then
	    busybox echo 720p > /sys/class/display/mode
	    busybox echo 40 25 1240 690 0 > /sys/class/ppmgr/ppscaler_rect
	
	elif [ $hpdstate -eq 0 ] ; then
	    busybox echo 576cvbs > /sys/class/display/mode	
	    busybox echo 30 20 680 556 0 > /sys/class/ppmgr/ppscaler_rect
	    
	else
	    busybox echo 720p > /sys/class/display/mode
	    busybox echo 40 25 1240 690 0 > /sys/class/ppmgr/ppscaler_rect
	   
	fi
	
	echo 0 0 1280 720 0 0 18 18 > /sys/class/display/axis
	echo 0 > /sys/class/graphics/fb0/freescale_mode
	echo 0 > /sys/class/graphics/fb1/freescale_mode
	echo 0 0 1279 719 > /sys/class/graphics/fb0/free_scale_axis
	busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale

	busybox echo null > /sys/class/display2/mode
	busybox echo 576cvbs > /sys/class/display2/mode 
	busybox echo 1 > /sys/class/video2/screen_mode
	busybox echo 0  > /sys/module/amvideo2/parameters/clone_frame_scale_widthh
fi
                                            
done
