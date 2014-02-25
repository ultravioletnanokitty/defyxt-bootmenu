#!/sbin/sh

######## BootMenu Script
######## Execute [Normal] Boot


export PATH=/sbin:/system/xbin:/system/bin

######## Main Script

mount -o remount,rw /
mount -o remount,rw $PART_SYSTEM /system

######## Cleanup

## busybox applets cleanup..
for cmd in $(/sbin/busybox --list); do
  [ -L "/sbin/$cmd" ] && [ "$cmd" != "sh" ] && rm "/sbin/$cmd"
done

## reduce lcd backlight to save battery
echo 10 > /sys/class/leds/lcd-backlight/brightness

echo 0 > /sys/class/leds/button-backlight/brightness

start
