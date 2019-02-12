#!/bin/bash

clear
printf "\nall devices\n\n\n" && lsblk
echo "mdstat: $(mdadm -D /dev/md0)"
echo "mounted partition: $(mount | grep /raid)"
