#!/sbin/sh
busybox echo /dev/block/cache > /sys/devices/lm0/gadget/gadget-lun0/file
