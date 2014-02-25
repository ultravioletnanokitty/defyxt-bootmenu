#!/sbin/busybox ash

######## BootMenu Script
######## Execute [2nd-boot] Menu

source /system/bootmenu/script/_config.sh

######## Main Script


mount -o remount,rw rootfs /
rm -f /*.rc
rm -f /*.sh
cp -f /system/bootmenu/2nd-init/* /
chmod 640 /*.rc
chmod 750 /init
rm -f /sbin/ueventd
cp -f /system/bootmenu/binary/adbd /sbin/adbd
killall ueventd

rm /system/etc/init.d/97bootmenu

ADBD_RUNNING=`ps | grep adbd | grep -v grep`
if [ -z "$ADB_RUNNING" ]; then
    rm -f /tmp/usbd_current_state
fi

# original /tmp data symlink
if [ -L /tmp.bak ]; then
  rm /tmp.bak
fi

if [ -L /sdcard-ext ]; then
    rm /sdcard-ext
    mkdir -p /sd-ext
fi

## unmount devices
sync
umount /acct
umount /dev/cpuctl
umount /dev/pts
umount /mnt/asec
umount /mnt/obb
umount /cache
umount /data

######## Cleanup

rm -f /sbin/lsof

## busybox cleanup..
if [ -f /sbin/busybox ]; then
    for cmd in $(/sbin/busybox --list); do
        [ -L "/sbin/$cmd" ] && rm "/sbin/$cmd"
    done

    rm -f /sbin/busybox
fi

######## Let's go

/system/bootmenu/binary/2nd-init
