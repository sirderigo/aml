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

############ if outputmode is cvbs ,and HDMI is plugged,we need clear the logo.
hpdstate=$(cat /sys/class/amhdmitx/amhdmitx0/hpd_state)
current_mode=$(cat /sys/class/display/mode)
if [ "$(getprop ro.platform.hdmionly)" = "true" ]; then
    if [ "$hpdstate" = "1" ]; then
        if [ "$current_mode" = "480cvbs" -o "$current_mode" = "576cvbs" ]; then
            echo 1 > /sys/class/graphics/fb0/blank
            echo 1 > /sys/class/graphics/fb1/blank
            echo 0 > /sys/class/graphics/fb1/free_scale
        fi
        outputmode=$(getprop ubootenv.var.hdmimode)
        setprop ubootenv.var.outputmode $outputmode
    else
        outputmode=$(getprop ubootenv.var.cvbsmode)
        setprop ubootenv.var.outputmode $outputmode
    fi
else  
    outputmode=$(getprop ubootenv.var.outputmode)
fi

############ if the tv don't support current outputmode,then switch to best outputmode
bestmode=0
support_flag=1
if [ "$hpdstate" = "1" ]; then

    while read line
    do
        if [ "$outputmode" = "$line" ]; then
            support_flag=1
            break;
        else
            support_flag=0
        fi

        ######## if no edid, don't change ouputmode
        echo "$line" | busybox grep -q 'null'
        if [ $? -eq 0 ] ; then
            support_flag=0
            break;
        fi        
        echo "$line" | busybox grep -q '*'
        if [ $? -eq 0 ]
        then
            bestmode=${line/'*'}
            if [ "$outputmode" = "$bestmode" ]; then
                support_flag=1
                break
            fi
        fi
    done < /sys/class/amhdmitx/amhdmitx0/disp_cap 

    if [ "$support_flag" = "0" ]; then
        if [ "$bestmode" != "0" ]; then
            echo 1 > /sys/class/graphics/fb0/blank
            echo 1 > /sys/class/graphics/fb1/blank
            echo 0 > /sys/class/graphics/fb1/free_scale
            outputmode=$bestmode
        else 
            bestmode=$(getprop ro.platform.best_outputmode)
            if [ "$bestmode" = "" ] ; then
                outputmode=720p
            else
                outputmode=$bestmode
            fi
        fi
        setprop ubootenv.var.outputmode $outputmode
        setprop ubootenv.var.hdmimode $outputmode
    fi

else
    if [ "$outputmode" != "480cvbs" -a "$outputmode" != "576cvbs" ] ; then
        outputmode=576cvbs
        setprop ubootenv.var.outputmode $outputmode
        setprop ubootenv.var.cvbsmode $outputmode
    fi
fi

setprop ro.sf.lcd_density 240

        
function getAxis()
{
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
    
    1080p24hz)
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
}

getAxis
echo $outputmode > /sys/class/display/mode


#echo $outputx $outputy $(($outputwidth + $outputx + $outputx)) $(($outputheight + $outputy + $outputy)) $outputx $outputy 18 18 > /sys/class/display/axis
echo 1 > /sys/class/graphics/fb0/freescale_mode
echo 1 > /sys/class/graphics/fb1/freescale_mode
echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
echo $outputx $outputy $(($outputwidth + $outputx - 1)) $(($outputheight + $outputy - 1)) > /sys/class/video/axis
echo $outputx $outputy $(($outputwidth + $outputx - 1)) $(($outputheight + $outputy - 1)) > /sys/class/graphics/fb0/window_axis
echo 0 > /sys/class/graphics/fb0/blank



                                                                                                                                  
if [ "$(getprop ubootenv.var.digitaudiooutput)" = "SPDIF passthrough" ] ; then
    echo 1 > /sys/class/audiodsp/digital_raw
elif [ "$(getprop ubootenv.var.digitaudiooutput)" = "HDMI passthrough" ] ; then  
    echo 2 > /sys/class/audiodsp/digital_raw
else
    echo 0 > /sys/class/audiodsp/digital_raw
fi

#echo 0 > /sys/class/graphics/fb1/blank
#echo 1 > /sys/class/graphics/fb1/blank
#fbset -fb /dev/graphics/fb1 -g 32 32 32 32 $osd_bits
#echo 1 > /sys/class/graphics/fb1/blank
#sleep 8
#echo m 0x1d26 '0x10b1' > /sys/class/display/wr_reg
