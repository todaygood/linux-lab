# networkManager介绍

​       通常的linux发行版对于网络的配置方法一般会同时支持network.service（即配置和使用/etc/sysconfig/network-scripts/下的配置文件来配置网络，对于ubuntu是/etc/network/interfaces等等）和NetworkManager.service（简称NM）。**默认情况下，这2个服务都有开启，而且功能上是平行的，可以通过任意一个来配置网络，正常的情况下通过NM来配置网络后它会自动把配置同步到network.service的配置中。**





nmcli修改connection name之后，会将connect name 写入到ifcfg-$ETH 文件里面去

```bash
nmcli> set connection.id bridge-network
nmcli> save persistent
Error: Failed to save 'bridge-network' (d3a182af-5e76-4835-b6c6-0e8db8b49d4e) connection: Could not read file '/etc/sysconfig/network-scripts/ifcfg-enp0s3': No such file or directory
nmcli> save persistent
Connection 'bridge-network' (d3a182af-5e76-4835-b6c6-0e8db8b49d4e) successfully updated.

```



```bash
[root@node4 network-scripts]# mv bak/ifcfg-enp0s3  .
[root@node4 network-scripts]#
[root@node4 network-scripts]# ls
bak           ifdown-bnep  ifdown-post    ifdown-TeamPort  ifup-eth   ifup-plusb   ifup-Team         network-functions
ifcfg-enp0s3  ifdown-eth   ifdown-ppp     ifdown-tunnel    ifup-ippp  ifup-post    ifup-TeamPort     network-functions-ipv6
ifcfg-enp0s8  ifdown-ippp  ifdown-routes  ifup             ifup-ipv6  ifup-ppp     ifup-tunnel
ifcfg-lo      ifdown-ipv6  ifdown-sit     ifup-aliases     ifup-isdn  ifup-routes  ifup-wireless
ifdown        ifdown-isdn  ifdown-Team    ifup-bnep        ifup-plip  ifup-sit     init.ipv6-global
[root@node4 network-scripts]# cat ifcfg-enp0s3
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=bridge-network
UUID=d3a182af-5e76-4835-b6c6-0e8db8b49d4e
DEVICE=enp0s3
ONBOOT=yes


```

##激活连接
nmcli connection up connection-name
nmcli device connect interface-name

##取消激活链接
nmcli connection down connection-name　　　　##这个操作当取消一个激活后，如果有其它连接会自动激活其它连接
nmcli device disconnect interface-name 　　　　##这个操作会取消接口上的激活，如果有其它连接也不会自动激活其它连接


nmcli connection add type ethernet con-name connection-name ifname interface-name ipv4.method manual ipv4.addresses address ipv4.gateway address



# nmcli操作无线网络和网卡

[root@Fedora ~]# nmcli device wifi  //tab之后有list和connect
connect  help     hotspot  list     rescan   
[root@Fedora ~]# nmcli device wifi list 再tab看到的不再重要了，回去
bssid     hwaddr    ifname    --rescan  
[root@Fedora ~]# nmcli device wifi list 
IN-USE  SSID     MODE   CHAN  RATE       SIGNAL  BARS  SECURITY 
        Honor 8  Infra  6     65 Mbit/s  100     ▂▄▆█  WPA2     
[root@Fedora ~]# nmcli device wifi connect //tab看到了我们想连接的热点
A4:71:74:00:11:43  Honor\ 8           
[root@Fedora ~]# nmcli device wifi connect Honor\ 8 //tab后
bssid         ifname        password      wep-key-type  
hidden        name          private       
＃连接网络要用到网卡的，ifname这个都认识吧
＃在输入ifname后再tab直接出wlp9s0，这是因为我的电脑就一个网卡      
[root@Fedora ~]# nmcli device wifi connect Honor\ 8 ifname wlp9s0 //还差个密码呢
bssid         ifname        password      wep-key-type  
hidden        name          private       
[root@Fedora ~]# nmcli device wifi connect Honor\ 8 ifname wlp9s0 password 12345678
Device 'wlp9s0' successfully activated with 'd31829c0-dfed-426f-be98-856892b589b4'.

＃这里的12345678是我手机热点的密码，不要搞错哦



# Issue



## nmcli 为何tab不出来命令提示

因为没有安装bash-completion rpm包

solution:  # yum -y install bash-completion,  重启bash



# Ref 



[nmcli命令详解(创建热点，连接wifi，管理连接等)](https://www.cnblogs.com/mind-water/p/12079647.html)

https://zhuanlan.zhihu.com/p/52731316

https://www.cnblogs.com/pipci/p/12570592.html

