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

[root@otuslinux]/home/vagrant# blkid
/dev/sdc: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="337cfa08-cf31-5adb-3447-bf61dda92fdc" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sda1: UUID="8e4622c4-1066-4ea8-ab6c-9a19f626755c" TYPE="xfs"
/dev/sdf: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="0b75c403-8206-a21a-70ca-942124d9ebac" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sde: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="1fcfb5db-a917-98c1-cab8-891e41544f01" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sdd: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="4fa98b3a-955f-14cd-3eb5-a55c1c557c05" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/md0: PTTYPE="gpt"
/dev/sdb: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="270b756e-9f75-62ea-a704-ef9aefcdd31b" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/md0p1: UUID="ca0f92a8-81c1-4dbb-8a4d-ecbcc0fb487b" TYPE="ext4" PARTLABEL="primary" PARTUUID="bfd973e9-4678-4ad0-88de-08e754ff786a"
```

### Схема разметки после переноса на RAID

```bash
[root@otuslinux]/tmp# lsblk
NAME      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda         8:0    0   40G  0 disk
└─sda1      8:1    0   40G  0 part
  └─md1     9:1    0   40G  0 raid1 /
sdb         8:16   0   40G  0 disk
└─sdb1      8:17   0   40G  0 part
  └─md1     9:1    0   40G  0 raid1 /
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
sdg         8:96   0  250M  0 disk
└─md0       9:0    0  992M  0 raid5
  └─md0p1 259:0    0  988M  0 md    /raid

[root@otuslinux]/tmp# blkid
/dev/sdd: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="337cfa08-cf31-5adb-3447-bf61dda92fdc" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sdg: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="0b75c403-8206-a21a-70ca-942124d9ebac" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sde: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="4fa98b3a-955f-14cd-3eb5-a55c1c557c05" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sdf: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="1fcfb5db-a917-98c1-cab8-891e41544f01" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sdc: UUID="1da41ac6-a707-b27a-1070-d136a71068f3" UUID_SUB="270b756e-9f75-62ea-a704-ef9aefcdd31b" LABEL="otuslinux:0" TYPE="linux_raid_member"
/dev/sda1: UUID="ee560c6e-96f1-84d6-69ab-3a44eba6e2e6" UUID_SUB="02176fa9-5272-928d-b58b-2a3bbfe311cd" LABEL="otuslinux:1" TYPE="linux_raid_member"
/dev/sdb1: UUID="ee560c6e-96f1-84d6-69ab-3a44eba6e2e6" UUID_SUB="bc4651a5-28ad-b439-17c5-03498b0e4ba2" LABEL="otuslinux:1" TYPE="linux_raid_member"
/dev/md0: PTTYPE="gpt"
/dev/md0p1: UUID="ca0f92a8-81c1-4dbb-8a4d-ecbcc0fb487b" TYPE="ext4" PARTLABEL="primary" PARTUUID="bfd973e9-4678-4ad0-88de-08e754ff786a"
/dev/md1: UUID="ca52d758-1b54-4f5c-88ee-d206304756c3" TYPE="xfs"
```

### Результат

```bash
[root@otuslinux]/home/vagrant# mount | grep md1
/dev/md1 on / type xfs (rw,relatime,attr2,inode64,noquota)

[root@otuslinux]/home/vagrant# mdadm -D /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Mon Feb 11 22:43:27 2019
        Raid Level : raid1
        Array Size : 41908224 (39.97 GiB 42.91 GB)
     Used Dev Size : 41908224 (39.97 GiB 42.91 GB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Mon Feb 11 23:45:09 2019
             State : clean
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : otuslinux:1  (local to host otuslinux)
              UUID : ee560c6e:96f184d6:69ab3a44:eba6e2e6
            Events : 151

    Number   Major   Minor   RaidDevice State
       2       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1
```
