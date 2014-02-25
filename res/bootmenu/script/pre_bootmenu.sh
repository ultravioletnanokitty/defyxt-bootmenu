#!/system/bootmenu/binary/busybox sh

######## BootMenu Script
######## Execute Pre BootMenu

export PATH=/sbin:/system/xbin:/system/bin

source /system/bootmenu/script/_config.sh
PART_CACHE=/dev/block/mtdblock10
FS_CACHE=yaffs2

######## Main Script

BB_STATIC="/system/bootmenu/binary/busybox"

BB="/sbin/busybox"

## reduce lcd backlight to save battery
echo 50 > /sys/class/leds/lcd-backlight/brightness

# these first commands are duplicated for broken systems
mount -o remount,rw rootfs /
$BB_STATIC mount -o remount,rw /

# we will use the static busybox
cp -f $BB_STATIC $BB
$BB_STATIC cp -f $BB_STATIC $BB

$BB_STATIC chmod 755 /sbin
$BB_STATIC chmod 755 $BB
$BB chown 0.0 $BB
$BB chmod 4755 $BB

write /sys/module/android/parameters/switch_port_enable 1

cp /system/bootmenu/binary/adbd /sbin/adbd.2
chmod 4755 /sbin/sh

chown 0.0 /sbin/adbd.2
chmod 4755 /sbin/adbd.2

/sbin/adbd.2 &
#/sbin/adbd &
write /sys/module/android/parameters/switch_port_enable 1

#umount /data
#umount /system

#mount /dev/block/mmcblk0p2 /data
#mount /dev/block/mmcblk0p3 /system


if [ -f /sbin/chmod ]; then
    # job already done...
    exit 0
fi

# busybox sym link..
for cmd in $($BB --list); do
    $BB ln -s /sbin/busybox /sbin/$cmd
done

$BB chmod +rx /sbin/*

## /default.prop replace..
cp -f /system/bootmenu/config/default.prop /default.prop

## mount cache
mkdir -p /cache

# mount cache for boot mode and recovery logs
if [ ! -d /cache/recovery ]; then
    mount -t $FS_CACHE -o nosuid,nodev,noatime,nodiratime,barrier=1 $PART_CACHE /cache
fi
 
mkdir -p /cache/bootmenu

mount -o remount,rw rootfs /
#mount -o remount,rw $PART_SYSTEM /system


mkdir /sys2

#cp -r /system/bootmenu /mnt
#umount -l /system
#sleep 1s
#cp -r /mnt/bootmenu /system

echo 1 > /sys/class/leds/button-backlight/brightness



exit 0
