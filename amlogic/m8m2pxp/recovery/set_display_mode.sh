#!/system/bin/sh

old_state=1
outputmode=$(cat /sys/class/display/mode)
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)
old_state=$hpdstate
if [ "$hpdstate" = "1" ]; then
	if [ "$outputmode" = "480cvbs" -o "$outputmode" = "576cvbs" ] ; then
    outputmode=1080p
  fi
else
	if [ "$outputmode" != "480cvbs" -a "$outputmode" != "576cvbs" ] ; then
    outputmode=480cvbs
  fi
fi

echo $outputmode > /sys/class/display/mode

busybox echo 0 > /sys/class/ppmgr/ppscaler
busybox echo 0 > /sys/class/graphics/fb0/free_scale
busybox echo 1 > /sys/class/graphics/fb0/freescale_mode
busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis

case $outputmode in 

    480*)
    busybox echo 30 20 689 459 > /sys/class/graphics/fb0/window_axis 
    ;;
    
    576*)
    busybox echo 30 20 689 555 > /sys/class/graphics/fb0/window_axis 
    ;; 

    720*)
    busybox echo 40 30 1239 689 > /sys/class/graphics/fb0/window_axis 
    ;; 

    1080*)
    busybox echo 60 40 1859 1039 > /sys/class/graphics/fb0/window_axis 
    ;; 

    4k2k*)
    busybox echo 120 80 3719 2079 > /sys/class/graphics/fb0/window_axis 
   ;;
 
    *)
#    outputmode=1080p
    echo 1080p > /sys/class/display/mode    
    busybox echo 60 40 1859 1039 > /sys/class/graphics/fb0/window_axis 

esac

busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale


#for checking is hdmi or cvbs 
while true ; do
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)
if [ $hpdstate != $old_state ] ; then
	old_state=$hpdstate
	if [ "$hpdstate" = "1" ]; then
		if [ "$outputmode" = "480cvbs" -o "$outputmode" = "576cvbs" ] ; then
			outputmode=1080p
		fi
	else
		if [ "$outputmode" != "480cvbs" -a "$outputmode" != "576cvbs" ] ; then
			outputmode=480cvbs
		fi
	fi
	echo $outputmode > /sys/class/display/mode
	busybox echo 0 > /sys/class/ppmgr/ppscaler
	busybox echo 0 > /sys/class/graphics/fb0/free_scale
	busybox echo 1 > /sys/class/graphics/fb0/freescale_mode
	busybox echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis

	case $outputmode in 

		480*)
		busybox echo 30 20 689 459 > /sys/class/graphics/fb0/window_axis 
		;;
    
		576*)
		busybox echo 30 20 689 555 > /sys/class/graphics/fb0/window_axis 
		;; 

		720*)
		busybox echo 40 30 1239 689 > /sys/class/graphics/fb0/window_axis 
		;; 

		1080*)
		busybox echo 60 40 1859 1039 > /sys/class/graphics/fb0/window_axis 
		;; 

		4k2k*)
		busybox echo 120 80 3719 2079 > /sys/class/graphics/fb0/window_axis 
		;;
 
		*)
		#outputmode=1080p
		echo 1080p > /sys/class/display/mode    
		busybox echo 60 40 1859 1039 > /sys/class/graphics/fb0/window_axis 

	esac
busybox echo 0x10001 > /sys/class/graphics/fb0/free_scale
fi
                                            
sleep 5

done





