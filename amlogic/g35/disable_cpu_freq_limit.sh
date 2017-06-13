#!/system/bin/sh

sleep 2
echo "disable cpu freq limit..."
echo 0 > /sys/class/freq_limit/limit

#setprop cpu.freq.service true

