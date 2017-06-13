#!/system/bin/sh

case `getprop sys.fb.bits` in
    32) osd_bits=32
    ;;

    *) osd_bits=16
    ;;
esac
#if [ -e /dev/dvb0.frontend0 ]; then
#    DVB_EXIST=yes
#else
    DVB_EXIST=no
#fi
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)
if [ "$(getprop ro.platform.hdmionly)" = "true" ]; then
    if [ "$hpdstate" = "1" ]; then
        outputmode=$(getprop ubootenv.var.hdmimode)
        setprop ubootenv.var.outputmode $outputmode
    else
        outputmode=$(getprop ubootenv.var.cvbsmode)
        setprop ubootenv.var.outputmode $outputmode
    fi
else  
    outputmode=$(getprop ubootenv.var.outputmode)
fi
scalemode=$(getprop ro.platform.has.1080scale)
if [ "$(getprop ro.platform.has.cvbsmode)" = "true" ]; then
	cvbsmode=$(getprop ubootenv.var.cvbsmode)

	if [ "$outputmode" = "480i" -o "$outputmode" = "576i" ]; then
		echo null > /sys/class/display2/mode
	#if [ "$cvbsmode" = "480cvbs" ]; then
	elif [ "$cvbsmode" = "480cvbs" ]; then
		echo null > /sys/class/display2/mode
		echo 480cvbs > /sys/class/display2/mode 
		echo 1 > /sys/class/video2/screen_mode
	elif [ "$cvbsmode" = "576cvbs" ]; then
		echo null > /sys/class/display2/mode
		echo 576cvbs > /sys/class/display2/mode 
		echo 1 > /sys/class/video2/screen_mode
	else
		echo null > /sys/class/display2/mode
		echo 480cvbs > /sys/class/display2/mode 
		echo 1 > /sys/class/video2/screen_mode
		setprop ubootenv.var.cvbsmode 480cvbs
	fi

	if [ "$outputmode" = "1080p" -o "$outputmode" = "1080i" -o "$outputmode" = "1080p50hz" -o "$outputmode" = "1080i50hz" -o "$outputmode" = "4k2k24hz" -o "$outputmode" = "4k2k25hz" -o "$outputmode" = "4k2k30hz" -o "$outputmode" = "4k2ksmpte"] ; then
	    echo 960  > /sys/module/amvideo2/parameters/clone_frame_scale_width
	else
	    echo 0  > /sys/module/amvideo2/parameters/clone_frame_scale_width
	fi
fi
#if [ "$scalemode" = "2" ] ; then
    #if [ $DVB_EXIST = yes ]; then
        #echo 0 0 1280 720 0 0 1240 690 > /sys/class/display/axis
    #else
        #echo 0 0 1280 720 0 0 18 18 > /sys/class/display/axis
    #fi
    if [ "$outputmode" = "1080p" -o "$outputmode" = "1080i" -o "$outputmode" = "1080p50hz" -o "$outputmode" = "1080i50hz" -o "$outputmode" = "4k2k24hz" ] ; then
    	setprop ro.sf.lcd_density 240
    else
    	setprop ro.sf.lcd_density 160
    fi
    sleep 1
#fi
        
print outputmode = $outputmode
case $outputmode in 
    4k2k24hz)
    scaleenable=true
    scaledir=up
    if [ "$(getprop ubootenv.var.4k2k24hz_x)" = "" ] ; then
            outputx=0
        else outputx=$(getprop ubootenv.var.4k2k24hz_x)
        fi
        if [ "$(getprop ubootenv.var.4k2k24hz_y)" = "" ] ; then
            outputy=0
        else outputy=$(getprop ubootenv.var.4k2k24hz_y)
        fi
        if [ "$(getprop ubootenv.var.4k2k24hz_width)" = "" ] ; then
            outputwidth=3840
        else outputwidth=$(getprop ubootenv.var.4k2k24hz_width)
        fi
        if [ "$(getprop ubootenv.var.4k2k24hz_height)" = "" ] ; then
            outputheight=2160
        else outputheight=$(getprop ubootenv.var.4k2k24hz_height)
    fi
    ;;    
    4k2k25hz)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.4k2k25hz_x)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.4k2k25hz_x)
        fi
        if [ "$(getprop ubootenv.var.4k2k25hz_y)" = "" ] ; then
            outputy=0
        else outputy=$(getprop ubootenv.var.4k2k25hz_y)
        fi
        if [ "$(getprop ubootenv.var.4k2k25hz_width)" = "" ] ; then
            outputwidth=3840
        else outputwidth=$(getprop ubootenv.var.4k2k25hz_width)
        fi
        if [ "$(getprop ubootenv.var.4k2k25hz_height)" = "" ] ; then
            outputheight=2160
        else outputheight=$(getprop ubootenv.var.4k2k25hz_height)
    fi
        ;;    
    4k2k30hz)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.4k2k30hz_x)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.4k2k30hz_x)
        fi
        if [ "$(getprop ubootenv.var.4k2k30hz_y)" = "" ] ; then
            outputy=0
        else outputy=$(getprop ubootenv.var.4k2k30hz_y)
        fi
        if [ "$(getprop ubootenv.var.4k2k30hz_width)" = "" ] ; then
            outputwidth=3840
        else outputwidth=$(getprop ubootenv.var.4k2k30hz_width)
        fi
        if [ "$(getprop ubootenv.var.4k2k30hz_height)" = "" ] ; then
            outputheight=2160
        else outputheight=$(getprop ubootenv.var.4k2k30hz_height)
    fi  
    ;;
    4k2ksmpte)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.4k2ksmpte_x)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.4k2ksmpte_x)
        fi
        if [ "$(getprop ubootenv.var.4k2ksmpte_y)" = "" ] ; then
            outputy=0
        else outputy=$(getprop ubootenv.var.4k2ksmpte_y)
        fi
        if [ "$(getprop ubootenv.var.4k2ksmpte_width)" = "" ] ; then
            outputwidth=4096
        else outputwidth=$(getprop ubootenv.var.4k2ksmpte_width)
        fi
        if [ "$(getprop ubootenv.var.4k2ksmpte_height)" = "" ] ; then
            outputheight=2160
        else outputheight=$(getprop ubootenv.var.4k2ksmpte_height)
    fi  
    ;;
    480p)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.480poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.480poutputx)
        fi
        if [ "$(getprop ubootenv.var.480poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.480poutputy)
        fi
        if [ "$(getprop ubootenv.var.480poutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.480poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.480poutputheight)" = "" ] ; then 
            outputheight=480
        else outputheight=$(getprop ubootenv.var.480poutputheight)
    fi
       
    ;;
    
    480i)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.480ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.480ioutputx)
        fi
        if [ "$(getprop ubootenv.var.480ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.480ioutputy)
        fi
        if [ "$(getprop ubootenv.var.480ioutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.480ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.480ioutputheight)" = "" ] ; then 
            outputheight=480
        else outputheight=$(getprop ubootenv.var.480ioutputheight)    
     fi  
    ;; 
    480cvbs)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.480ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.480ioutputx)
        fi
        if [ "$(getprop ubootenv.var.480ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.480ioutputy)
        fi
        if [ "$(getprop ubootenv.var.480ioutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.480ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.480ioutputheight)" = "" ] ; then 
            outputheight=480
        else outputheight=$(getprop ubootenv.var.480ioutputheight)    
     fi  
    ;; 
       
    576p)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.576poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.576poutputx)
        fi
        if [ "$(getprop ubootenv.var.576poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.576poutputy)
        fi
        if [ "$(getprop ubootenv.var.576poutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.576poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.576poutputheight)" = "" ] ; then 
            outputheight=576
        else outputheight=$(getprop ubootenv.var.576poutputheight)    
     fi      
       
    ;;    
    
    576i)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.576ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.576ioutputx)
        fi
        if [ "$(getprop ubootenv.var.576ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.576ioutputy)
        fi
        if [ "$(getprop ubootenv.var.576ioutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.576ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.576ioutputheight)" = "" ] ; then 
            outputheight=576
        else outputheight=$(getprop ubootenv.var.576ioutputheight)    
     fi          
       
    ;;        
    576cvbs)
    scaleenable=true
    scaledir=down
    if [ "$(getprop ubootenv.var.576ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.576ioutputx)
        fi
        if [ "$(getprop ubootenv.var.576ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.576ioutputy)
        fi
        if [ "$(getprop ubootenv.var.576ioutputwidth)" = "" ] ; then 
            outputwidth=720
        else outputwidth=$(getprop ubootenv.var.576ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.576ioutputheight)" = "" ] ; then 
            outputheight=576
        else outputheight=$(getprop ubootenv.var.576ioutputheight)    
     fi          
       
    ;;     
    720p)
    scaleenable=false
    scaledir=down
    if [ "$(getprop ubootenv.var.720poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.720poutputx)
        fi
        if [ "$(getprop ubootenv.var.720poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.720poutputy)
        fi
        if [ "$(getprop ubootenv.var.720poutputwidth)" = "" ] ; then 
            outputwidth=1280
        else outputwidth=$(getprop ubootenv.var.720poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.720poutputheight)" = "" ] ; then 
            outputheight=720
        else outputheight=$(getprop ubootenv.var.720poutputheight)    
     fi          
        
    ;;

    1080p)
    scaleenable=false
    scaledir=up
    if [ "$(getprop ubootenv.var.1080poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.1080poutputx)
        fi
        if [ "$(getprop ubootenv.var.1080poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.1080poutputy)
        fi
        if [ "$(getprop ubootenv.var.1080poutputwidth)" = "" ] ; then 
            outputwidth=1920
        else outputwidth=$(getprop ubootenv.var.1080poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.1080poutputheight)" = "" ] ; then 
            outputheight=1080
        else outputheight=$(getprop ubootenv.var.1080poutputheight)    
     fi                 
    ;;

    1080i)
    scaleenable=false
    scaledir=up
     if [ "$(getprop ubootenv.var.1080ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.1080ioutputx)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.1080ioutputy)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputwidth)" = "" ] ; then 
            outputwidth=1920
        else outputwidth=$(getprop ubootenv.var.1080ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputheight)" = "" ] ; then 
            outputheight=1080
        else outputheight=$(getprop ubootenv.var.1080ioutputheight)    
     fi                       
    ;;   
    1080i50hz)
    scaleenable=false
    scaledir=up
     if [ "$(getprop ubootenv.var.1080ioutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.1080ioutputx)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.1080ioutputy)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputwidth)" = "" ] ; then 
            outputwidth=1920
        else outputwidth=$(getprop ubootenv.var.1080ioutputwidth)
        fi
        if [ "$(getprop ubootenv.var.1080ioutputheight)" = "" ] ; then 
            outputheight=1080
        else outputheight=$(getprop ubootenv.var.1080ioutputheight)    
     fi                           
       
    ;;   
   
    1080p50hz)
    scaleenable=false
    scaledir=up
    if [ "$(getprop ubootenv.var.1080poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.1080poutputx)
        fi
        if [ "$(getprop ubootenv.var.1080poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.1080poutputy)
        fi
        if [ "$(getprop ubootenv.var.1080poutputwidth)" = "" ] ; then 
            outputwidth=1920
        else outputwidth=$(getprop ubootenv.var.1080poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.1080poutputheight)" = "" ] ; then 
            outputheight=1080
        else outputheight=$(getprop ubootenv.var.1080poutputheight)    
     fi                     
    
       ;; 
    720p50hz)
    scaleenable=false
    scaledir=down
    if [ "$(getprop ubootenv.var.720poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.720poutputx)
        fi
        if [ "$(getprop ubootenv.var.720poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.720poutputy)
        fi
        if [ "$(getprop ubootenv.var.720poutputwidth)" = "" ] ; then 
            outputwidth=1280
        else outputwidth=$(getprop ubootenv.var.720poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.720poutputheight)" = "" ] ; then 
            outputheight=720
        else outputheight=$(getprop ubootenv.var.720poutputheight)    
     fi          
    ;;   
    *)
    outputmode=1080p
    scaleenable=false
    scaledir=up
    if [ "$(getprop ubootenv.var.1080poutputx)" = "" ] ; then 
            outputx=0
        else outputx=$(getprop ubootenv.var.1080poutputx)
        fi
        if [ "$(getprop ubootenv.var.1080poutputy)" = "" ] ; then 
            outputy=0
        else outputy=$(getprop ubootenv.var.1080poutputy)
        fi
        if [ "$(getprop ubootenv.var.1080poutputwidth)" = "" ] ; then 
            outputwidth=1920
        else outputwidth=$(getprop ubootenv.var.1080poutputwidth)
        fi
        if [ "$(getprop ubootenv.var.1080poutputheight)" = "" ] ; then 
            outputheight=1080
        else outputheight=$(getprop ubootenv.var.1080poutputheight)    
     fi              
 
esac
if [ "$outputmode" = "480i" -o "$outputmode" = "576i" ]; then
  if [ "$(getprop ro.platform.has.cvbsmode)" = "true" ] ; then
    if [ "$outputmode" = "480i" ];then
      echo 480cvbs > /sys/class/display/mode
      echo null > /sys/class/display2/mode
    else
      echo 576cvbs > /sys/class/display/mode 
      echo null > /sys/class/display2/mode
    fi  
  else
    echo $outputmode > /sys/class/display/mode
  fi  
else  
    echo $outputmode > /sys/class/display/mode                                                                                                                                      
fi
if [ "$(getprop ro.platform.has.realoutputmode)" != "true" ] ; then
  busybox echo $outputx $outputy $(($outputwidth + $outputx - 1)) $(($outputheight + $outputy - 1)) 0 > /sys/class/ppmgr/ppscaler_rect                     
  echo 1 > /sys/class/graphics/fb0/free_scale                                                                                                                                      
  echo 1 > /sys/class/graphics/fb1/free_scale  
else
  if [ "$scaledir" = "down" ]; then
    echo 0 0 1280 720 $outputx $outputy 18 18 > /sys/class/display/axis
  else
    echo 0 0 1920 1080 $outputx $outputy 18 18 > /sys/class/display/axis
  fi
  echo $outputx $outputy $(($outputwidth + $outputx - 1)) $(($outputheight + $outputy - 1)) > /sys/class/video/axis
fi  
                                                                                                                                  
if [ "$(getprop ubootenv.var.digitaudiooutput)" = "SPDIF passthrough" ] ; then
    echo 1 > /sys/class/audiodsp/digital_raw
elif [ "$(getprop ubootenv.var.digitaudiooutput)" = "HDMI passthrough" ] ; then  
    echo 2 > /sys/class/audiodsp/digital_raw
else
    echo 0 > /sys/class/audiodsp/digital_raw
fi

echo 0 > /sys/class/graphics/fb1/blank
echo 1 > /sys/class/graphics/fb1/blank
fbset -fb /dev/graphics/fb1 -g 32 32 32 32 $osd_bits
echo 1 > /sys/class/graphics/fb1/blank
#sleep 8
#echo m 0x1d26 '0x10b1' > /sys/class/display/wr_reg
