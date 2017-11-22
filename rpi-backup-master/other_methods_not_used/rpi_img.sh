#!/bin/sh
echo "123456"|sudo -S dd if=/dev/zero of=raspberrypi.img bs=1MB count=8000
echo "123456" | sudo -S  parted raspberrypi.img --script -- mklabel msdos
echo "123456" | sudo -S  parted raspberrypi.img --script -- mkpart primary fat32 1 64M
echo "123456" | sudo -S  parted raspberrypi.img --script -- mkpart primary ext4 64M -1

loopdevice=`sudo losetup -f --show raspberrypi.img`
device=`sudo kpartx -va $loopdevice | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1`
device="/dev/mapper/${device}"
partBoot="${device}p1"
partRoot="${device}p2"
echo "123456" | sudo -S  mkfs.vfat $partBoot
echo "123456" | sudo -S  mkfs.ext4 $partRoot
sudo mkdir /media/usb1
echo "123456" | sudo -S  mount -t vfat $partBoot /media/usb1
echo "123456" | sudo -S  cp -rfp /boot/* /media/usb1
echo "123456" | sudo -S  umount /media/usb1
sudo mkdir /media/usb2
echo "123456" | sudo -S  mount -t ext4 $partRoot /media/usb2
cd /media/usb2
echo "123456" | sudo -S  dump -0uaf - / | sudo   restore -rf -
cd
echo "123456" | sudo -S  umount /media/usb2
echo "123456" | sudo -S  kpartx -d $loopdevice
echo "123456" | sudo -S  losetup -d $loopdevice
