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



