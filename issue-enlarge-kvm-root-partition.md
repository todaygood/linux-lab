# 虚拟机直接扩容根分区


1. 将vm node01 停掉，扩容qcow2文件

```
[root@cnsz332563 images]# virsh destroy node01
Domain node01 destroyed

You have mail in /var/spool/mail/root
[root@cnsz332563 images]# ls
bak  CentOS-7-2003-03.qcow2  centos7-kernel-ml.qcow2  node02.qcow2  node03.qcow2
[root@cnsz332563 images]# qemu-img resize CentOS-7-2003-03.qcow2  100G
Image resized.
[root@cnsz332563 images]# virsh start node01
Domain node01 started
```


2. 进入VM，扩容块设备，扩容文件系统



```
[root@node01 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        3.9G     0  3.9G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G   17M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/vda1       8.0G  2.0G  6.1G  25% /
tmpfs           787M     0  787M   0% /run/user/0
[root@node01 ~]# fdisk /dev/vda
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk /dev/vda: 107.4 GB, 107374182400 bytes, 209715200 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000940fd

   Device Boot      Start         End      Blocks   Id  System
/dev/vda1   *        2048    16777215     8387584   83  Linux

Command (m for help): d
Selected partition 1
Partition 1 is deleted

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-209715199, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-209715199, default 209715199):
Using default value 209715199
Partition 1 of type Linux and of size 100 GiB is set

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
[root@node01 ~]# partprobe
[root@node01 ~]# fdisk -l /dev/vda1

Disk /dev/vda1: 107.4 GB, 107373133824 bytes, 209713152 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

[root@node01 ~]# xfs_growfs  /
meta-data=/dev/vda1              isize=512    agcount=4, agsize=524224 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=2096896, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 2096896 to 26214144
[root@node01 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        3.9G     0  3.9G   0% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G   17M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/vda1       100G  2.0G   99G   2% /
tmpfs           787M     0  787M   0% /run/user/0
[root@node01 ~]#
```
