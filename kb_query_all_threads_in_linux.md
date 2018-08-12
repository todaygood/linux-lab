#  How to query all threads in linux os? 

## ps -T -p <pid>

```bash
[root@cloud-sz-kolla-b13-01 a]# ps -T -p 91797
   PID   SPID TTY          TIME CMD
 91797  91797 ?        04:41:45 qemu-kvm
 91797  91804 ?        01:13:15 qemu-kvm
 91797  91805 ?        00:16:50 qemu-kvm
 91797  91806 ?        00:21:13 qemu-kvm
 91797  91807 ?        00:33:00 qemu-kvm
 91797  91808 ?        00:38:52 qemu-kvm
 91797  91810 ?        00:00:00 qemu-kvm
```

ps -eLf 是显示系统中所有的线程。

## pstree -p <pid>
```bash
[root@cloud-sz-kolla-b13-01 a]# pstree -p  |grep qemu 
           |-qemu-kvm(11961)-+-{qemu-kvm}(11967)
           |                 |-{qemu-kvm}(11969)
           |                 |-{qemu-kvm}(11970)
           |                 |-{qemu-kvm}(11971)
           |                 |-{qemu-kvm}(11972)
           |                 |-{qemu-kvm}(11973)
           |                 `-{qemu-kvm}(11975)
           |-qemu-kvm(13044)-+-{qemu-kvm}(13050)
           |                 |-{qemu-kvm}(13051)
           |                 |-{qemu-kvm}(13052)
           |                 |-{qemu-kvm}(13053)
           |                 |-{qemu-kvm}(13054)
           |                 |-{qemu-kvm}(13056)
           |                 |-{qemu-kvm}(97054)
           |                 |-{qemu-kvm}(97058)
           |                 |-{qemu-kvm}(39533)
           |                 |-{qemu-kvm}(39535)
           |                 |-{qemu-kvm}(39538)
           |                 |-{qemu-kvm}(39548)
           |                 |-{qemu-kvm}(39554)
 ```
 
 ## top -H 
 top 命令按H键可以查看，另外top -H -p <pid> 可以显示该pid下的thread 的运行情况。
 ```bash
 [root@cloud-sz-kolla-b13-01 a]# top -H -p 91797
top - 09:16:28 up 78 days, 15:09,  9 users,  load average: 1.63, 1.70, 1.78
Threads:   7 total,   0 running,   7 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.0 us,  0.7 sy,  0.0 ni, 98.2 id,  0.1 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 52695571+total,  7267936 free, 13117033+used, 38851744+buff/cache
KiB Swap:  5242876 total,  2412028 free,  2830848 used. 39233788+avail Mem 

   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                             
 91797 107       20   0 10.731g 1.505g  10372 S  1.0  0.3 281:54.69 qemu-kvm                                            
 91804 107       20   0 10.731g 1.505g  10372 S  0.3  0.3  73:17.90 qemu-kvm                                            
 91808 107       20   0 10.731g 1.505g  10372 S  0.3  0.3  38:53.56 qemu-kvm                                            
 91805 107       20   0 10.731g 1.505g  10372 S  0.0  0.3  16:51.25 qemu-kvm                                            
 91806 107       20   0 10.731g 1.505g  10372 S  0.0  0.3  21:13.81 qemu-kvm                                            
 91807 107       20   0 10.731g 1.505g  10372 S  0.0  0.3  33:02.08 qemu-kvm                                            
 91810 107       20   0 10.731g 1.505g  10372 S  0.0  0.3   0:00.84 qemu-kvm      
 ```
 ## htop 
 htop 可能功能很强大，但在我的thinkpad ssh终端下FX键不起作用。
 
 # Ref

http://ask.xmodulo.com/view-threads-process-linux.html          

