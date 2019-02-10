# Процесс переноса установленной системы на RAID

## Схема разметки до манипуляций

```bash
[root@otuslinux]~# lsblk
NAME      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda         8:0    0   40G  0 disk  
└─sda1      8:1    0   40G  0 part  /
sdb         8:16   0  250M  0 disk  
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid
sdc         8:32   0  250M  0 disk  
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid
sdd         8:48   0  250M  0 disk  
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid
sde         8:64   0  250M  0 disk  
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid
sdf         8:80   0  250M  0 disk  
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid
```
