#!/bin/bash

mdconf_path="/etc/mdadm.conf"
raid_drives=$(lsblk -dpno NAME | grep -v "$(ls /dev/sd*[0-9] | head -c 8)")

mdadm --zero-superblock --force $(echo "$raid_drives")
mdadm --create --verbose /dev/md0 -l5 -n5 $(echo "$raid_drives")
echo "DEVICE partitions" > $mdconf_path && mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> $mdconf_path
parted -s /dev/md0 mklabel gpt
parted -s /dev/md0 mkpart primary ext4 0% 100%
mkfs.ext4 /dev/md0p1
