---
title: vmrun使用命令行管理vmware
date: 2021-03-07 16:07:16
tags: 
categories: Windows

---

### 查看运行中的虚拟机

```powershell
PS D:\workspace\myBlog> vmrun list
Total running VMs: 1
D:\Program Files (x86)\VMMachines\Windows 10 x64\Windows 10 x64.vmx
```

### 关闭虚拟机

```powershell
PS D:\workspace\myBlog> vmrun stop "D:\Program Files (x86)\VMMachines\Windows 10 x64\Windows 10 x64.vmx"
```

### 开启虚拟机

```
PS D:\workspace\myBlog> vmrun -t ws start "D:\Program Files (x86)\VMMachines\Windows 10 x64\Windows 10 x64.vmx" nogui
```

nogui  参数指定后台运行



# 网络配置

1. 检查vmware网络设置，默认情况下vmware会使用使用虚拟网卡vmnet0 连接到物理网卡，

   ![image-20210515105038837](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105038837.png)

   ![image-20210515105605423](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105605423.png)

   ![image-20210515105728646](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105728646.png)

   此处选择桥接到本地使用的物理网卡

2. 查看宿主机的网络设置，因为桥接模式相当于物理机和虚拟机连接到同一个交换机，所有ip必须为同一个网段，网关，dns是相同的

   ![image-20210515111126007](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515111126007.png)

3. 在虚拟机中设置网卡，注意使用root账号操作

   ![image-20210515112119289](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515112119289.png)

# Clone

hostnamectl

vim /etc/hostname

vim /etc/hosts

vim /etc/sysconfig/network/ifcfg-eth0
