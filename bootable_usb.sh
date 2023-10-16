#/bin/bash
# v0.2

USB=/dev/sdb
ISO=~/Downloads/ubuntu2310.iso

## check if mounted usb
if findmnt $USB? >/dev/null; then
    echo "Desmontando particiones en $USB"
    sudo umount $USB*
else
    echo "No se encontraron particiones montadas en $USB"
fi

### clean and format
#sudo umount /dev/sdb
sudo dd if=/dev/zero of=$USB bs=1M count=10
sudo parted $USB mklabel gpt
sudo parted -s -a optimal $USB mkpart primary fat32 2048s 100%
sleep 2
sudo mkfs.vfat -F 32 -n "BOOTUSB" /dev/sdb1
sudo partprobe $USB

# optional, faster but can be harmful to the usb in the long run 
#sudo dd if=$ISO of=$USB bs=8M status=progress oflag=direct

# copy iso files & make usb bootable
sudo dd if=$ISO of=$USB bs=4M status=progress && sync

