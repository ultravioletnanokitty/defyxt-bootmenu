#! /system/bin/sh

# remount /system
chmod 777 /data/local/tmp/busybox
/data/local/tmp/busybox mount -o remount,rw /system

# install busybox
/data/local/tmp/busybox cp /data/local/tmp/busybox /system/bin/busybox
chmod 755 /system/bin/busybox
ln -s /system/bin/busybox /system/bin/cp

# copy over bootmenu
rm -r /system/bootmenu
cp -r /data/local/tmp/bootmenu /system/bootmenu
chmod 755 /system/bootmenu/binary/*
chmod 755 /system/bootmenu/script/*

# copy binaries
mv /system/bin/battery_charger /system/bin/battery_charger.bin
cp /data/local/tmp/battery_charger /system/bin/battery_charger
chmod 755 /system/bin/battery_charger
cp /data/local/tmp/sysinit /system/bin/sysinit
chmod 755 /system/bin/sysinit
cp /data/local/tmp/vpnclientpm /system/bin/vpnclientpm
chmod 755 /system/bin/vpnclientpm

# add busybox run-parts support
cp /data/local/tmp/install-recovery.sh /system/etc/install-recovery.sh
chmod 755 /system/etc/install-recovery.sh

# add bootmenu initscript
mkdir /system/etc/init.d
cp /data/local/tmp/97bootmenu /system/etc/init.d/97bootmenu
chmod 755 system/etc/init.d/*

sync
reboot
