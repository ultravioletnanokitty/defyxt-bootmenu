#!/sbin/sh

######## BootMenu Script
######## Execute [ADB Daemon] Menu

source /system/bootmenu/script/_config.sh

/system/bin/write /sys/module/android/parameters/switch_port_enable 1
/sbin/adbd &
/system/bin/write /sys/module/android/parameters/switch_port_enable 1

exit

######## Main Script
sleep 5

for i in $(seq 1 10)
do
    TMP=$(mount | grep /tmp)
    if [ -z "$TMP" ]
    then
        break
    fi
    umount -l /tmp
    sleep 1
done

mkdir -p /tmp
chown system.shell /tmp
chmod 0777 /tmp

# custom adbd (allow always root)
cp -f /system/bootmenu/binary/adbd /sbin/adbd.root
chown 0.0 /sbin/adbd.root
chmod 4755 /sbin/adbd.root

echo usb_mode_charge_adb > /tmp/usbd_current_state

# busybox ash history
mkdir -p /cache/bootmenu
export HISTFILE=/cache/bootmenu/.ash_history
export HISTFILESIZE=256

busybox kill $(busybox ps | busybox grep adbd)
echo msc_adb > /dev/usb_device_mode
touch /tmp/recovery.log
sync
/sbin/adbd.root &
/sbin/adbd &

exit
