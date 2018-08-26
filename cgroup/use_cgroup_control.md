# CGroup控制cpu,memory,blkio 

　　 
## CPU

 echo 50000 > /cgroup/cpu/foo/cpu.cfs_quota_us  #将cpu.cfs_quota_us设为50000，相对于cpu.cfs_period_us的100000是50%
 
 
 
 可以限定进程可以使用哪些 cpu 核心。cpuset 子系统就是处理进程可以使用的 cpu 核心和内存节点，以及其他一些相关配置。这部分的很多配置都和 NUMA 有关。其中 cpuset.cpus、cpuset.mems 就是用来限制进程可以使用的 cpu 核心和内存节点的。这两个参数中 cpu 核心、内存节点都用 id 表示，之间用 “,” 分隔。比如 0,1,2 。也可以用 “-” 表示范围，如 0-3 。两者可以结合起来用。如“0-2,6,7”。在添加进程前，cpuset.cpus、cpuset.mems 必须同时设置，而且必须是兼容的，否则会出错。例如

# echo 0 >/sys/fs/cgroup/cpuset/foo/cpuset.cpus
# echo 0 >/sys/fs/cgroup/cpuset/foo/cpuset.mems
这样， /foo 中的进程只能使用 cpu0 和内存节点0。用

# cat /proc/<pid>/status|grep '_allowed_list'


cpu.shares

它也是用来限制 cpu 使用的。但是与 cpu.cfs_quota_us、cpu.cfs_period_us 有挺大区别。cpu.shares 不是限制进程能使用的绝对的 cpu 时间，而是控制各个组之间的配额。比如

/cpu/cpu.shares : 1024
/cpu/foo/cpu.shares : 2048
那么当两个组中的进程都满负荷运行时，/foo 中的进程所能占用的 cpu 就是 / 中的进程的两倍。如果再建一个 /foo/bar 的 cpu.shares 也是 1024，且也有满负荷运行的进程，那 /、/foo、/foo/bar 的 cpu 占用比就是 1:2:1 。前面说的是各自都跑满的情况。如果其他控制组中的进程闲着，那某一个组的进程完全可以用满全部 cpu。可见通常情况下，这种方式在保证公平的情况下能更充分利用资源。



在 cpu 子系统中，cpu.stat 就是用前面那种方法做的资源限制的统计了。nr_periods、nr_throttled 就是总共经过的周期，和其中受限制的周期。throttled_time 就是总共被控制组掐掉的 cpu 使用时间。

## blkio 


blkio.throttle.read_bps_device   读速度 
blkio.throttle.write_bps_device  写速度

#8:0对应主设备号和副设备号，可以通过ls -l /dev/sda查看
echo '8:0   1048576' > /cgroup/blkio/foo/blkio.throttle.read_bps_device



## Memory 

cgroups oom kill进程

mkdir -p /cgroup/memory/foo
echo 1048576 >  /cgroup/memory/foo/memory.limit_in_bytes   #分配1MB的内存给这个控制组
echo 30215 > /cgroup/memory/foo/tasks 




## Ref 
https://www.cnblogs.com/yanghuahui/p/3751826.html







