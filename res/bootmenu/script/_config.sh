######## BootMenu Script Env
######## common variables for scripts

export PATH=/sbin:/system/xbin:/system/bin

PART_SYSTEM=/dev/block/mtdblock9
PART_CACHE=/dev/block/mtdblock10
PART_DATA=/dev/block/mtdblock11

FS_SYSTEM=yaffs2
FS_CACHE=yaffs2
FS_DATA=yaffs2

BM_ROOTDIR=/mnt/bootmenu

BOARD_UMS_LUNFILE=/sys/devices/platform/usb_mass_storage/lun0/file

