#!/sbin/busybox ash

######## BootMenu Script
######## Execute [2nd-init] Menu

source /system/bootmenu/script/_config.sh

######## Main Script

mount -o remount,rw rootfs /
rm -f /*.rc
rm -f /*.sh

## Stop respawn
/mnt/bootmenu/binary/2nd-init 


killall servicemanager
killall orientationd
killall geomagneticd
killall accelerometerd
killall vold
killall debuggerd
killall mediaserver
killall dbus-daemon 
killall installd
killall keystore
killall qmuxd
killall netmgrd
killall port-bridge
killall rild

 
cp -f /system/bootmenu/2nd-init/* /
chmod 640 /*.rc
chmod 750 /init
rm -f /sbin/ueventd
ln -s /init /sbin/ueventd

killall ueventd

# original /tmp data symlink
#if [ -L /tmp.bak ]; then
#  rm /tmp.bak
#fi

#if [ -L /sdcard-ext ]; then
#    rm /sdcard-ext
#    mkdir -p /sd-ext
#fi

## unmount devices
sync
umount /acct
umount /dev/cpuctl
umount /dev/pts
umount /mnt/asec
umount /mnt/obb
umount /cache
umount /hidden/data
umount /hidden
umount /mnt/obb


#umount -l /system 2> /data/local/tmp/smt.txt
umount /system
#umount /data 

#mount /dev/block/mmcblk0p2 /data
#mount /dev/block/mmcblk0p3 /systemreboo


######## Cleanup

#rm -f /sbin/lsof

## busybox cleanup..
#if [ -f /sbin/busybox ]; then
#    for cmd in $(/sbin/busybox --list); do
#        [ -L "/sbin/$cmd" ] && rm "/sbin/$cmd"
#    done
#
#    rm -f /sbin/busybox
#fi

######## Let's go

/mnt/bootmenu/binary/2nd-init 
# kill bootmenu process
killall bootmenu
