




## Ref 

https://access.redhat.com/solutions/1445073

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/sec-cpu_and_memory-use_case


https://huataihuang.gitbooks.io/cloud-atlas/os/linux/kernel/cgroups/rhel7/introduction.html


# use cgroup in rhel7 

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/resource_management_guide/chap-using_control_groups

rhel6文档中的方法已经过时。

通过libcgroup软件包提供的cgconfig工具可以挂载和处理控制器的层次结构，但不被systemd所支持（尤其是net-prio控制器）。绝对不要使用libcgroup工具来修改通过systemd所挂载的默认层次结构，因为这样会导致不可预知的错误。libcgroup软件包将在未来的Red Hat Enterprise Linux版本中移除。


systemd自动创建一个slice（片），scope（范围）和service（服务）单元来提供cgroup树的统一结构。使用systemctl命令，可以通过创建定制的slice来修改这个层次结构。并且，systemd为重要的内核资源控制器在/sys/fs/cgroup/目录下自动挂载层次结构。

参见 https://huataihuang.gitbooks.io/cloud-atlas/os/linux/kernel/cgroups/rhel7/introduction.html

service服务- 一个进程或者一组进程
scope 范围- 一组外部创建的进程

slice分片 - 使用unit层次化组织的组,slice不包含进程，它是由scope和service组成的层次结构，活跃的进程则包含在service和scope中。


systemd-cgls 命令可以清晰的显示出启动了哪些服务，每个服务启动了哪些进程/线程,系统有哪些虚拟机，哪些容器。

关于systemd和cgroup相关的东西，可以 man systemd.resource-control 查看文档。






