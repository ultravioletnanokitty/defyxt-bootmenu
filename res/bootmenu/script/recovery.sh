#!/sbin/sh

######## BootMenu Script
######## Execute [Custom Recovery] Menu

source /mnt/bootmenu/script/_config.sh

######## Main Script

BB_STATIC="/cache/busybox"

## /tmp folder can be a link to /data/tmp, bad thing !
umount -l /tmp
rm /tmp
mkdir -p /tmp
mkdir -p /res

rm -f /etc
mkdir /etc

rm -f /sdcard
mkdir /sdcard

chmod 755 /sbin
chmod 755 /res

cp -r -f $BM_ROOTDIR/recovery/res/* /res/
cp -p -f $BM_ROOTDIR/recovery/sbin/* /sbin/

 
cp -f /sbin/busybox /cache/busybox
chmod +rx /cache/busybox 

cd /sbin

$BB_STATIC rm -R busybox
$BB_STATIC ln -s recovery edify
$BB_STATIC ln -s recovery dedupe
$BB_STATIC ln -s recovery setprop
$BB_STATIC ln -s recovery dump_image
$BB_STATIC ln -s recovery erase_image
$BB_STATIC ln -s recovery flash_image
$BB_STATIC ln -s recovery mkyaffs2image
$BB_STATIC ln -s recovery unyaffs
$BB_STATIC ln -s recovery nandroid
$BB_STATIC ln -s recovery volume
$BB_STATIC ln -s recovery reboot
$BB_STATIC ln -s recovery minizip
$BB_STATIC ln -s recovery busybox


$BB_STATIC chmod +rx /sbin/*

if [ ! -e /etc/recovery.fstab ]; then
    cp $BM_ROOTDIR/recovery/recovery.fstab /etc/recovery.fstab
fi

$BB_STATIC mkdir -p /cache/recovery
$BB_STATIC touch /cache/recovery/command
$BB_STATIC touch /cache/recovery/log
$BB_STATIC touch /cache/recovery/last_log
$BB_STATIC touch /tmp/recovery.log

## Unmount partitions and kill remaining processes
$BB_STATIC umount /system
$BB_STATIC umount /data

usleep 50000

/sbin/recovery
$BB_STATIC fuser -mk /system
$BB_STATIC fuser -mk /data 

exit
