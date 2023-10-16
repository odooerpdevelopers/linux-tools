#/bin/bash

USB=/dev/sdb
ISO=~/Downloads/ubuntu2310.iso

### clean and format
sudo dd if=/dev/zero of=$USB bs=1M count=10
sudo parted $USB mklabel gpt
sudo parted -a optimal $USB mkpart primary fat32 0% 100%
sudo umount /dev/sdb1
sudo mkfs.vfat -F 32 -n "BOOTUSB" /dev/sdb1

# copy iso files & make usb bootable
sudo dd if=$ISO of=$USB bs=4M status=progress && sync

