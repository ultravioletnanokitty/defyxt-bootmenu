#! /bin/bash

adb wait-for-device
adb shell rm /data/local/tmp/*
adb push res/97bootmenu /data/local/tmp/97bootmenu
adb push res/battery_charger /data/local/tmp/battery_charger
adb push res/battery_charger.bin /data/local/tmp/battery_charger.bin
adb push res/bootmenu /data/local/tmp/bootmenu
adb push res/busybox /data/local/tmp/busybox
adb push res/install.sh /data/local/tmp/install.sh
adb push res/install-recovery.sh /data/local/tmp/install-recovery.sh
adb push res/sysinit /data/local/tmp/sysinit
adb push res/vpnclientpm /data/local/tmp/vpnclientpm
adb shell "chmod 777 /data/local/tmp/install.sh"
adb shell "su -c /data/local/tmp/install.sh"
