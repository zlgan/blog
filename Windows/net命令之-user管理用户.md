---
title: net命令之-user管理用户
date: 2022-06-12 16:20:56
tags: 
categories: Windows
---

### net use 命令解释

NET USE 将计算机连接到共享资源或将计算机与共享资源断开连接。使用时如果没有选项，它会列出计算机的连接：

```powershell
--查看系统用户
net user 
--删除用户
net user dblogin1 /delete  
--添加用户
net user dblogin1 dblogin1 /add 
--修改密码
net user dblogin1 dblogin1  
--查看计算机是的用户组
net localgroup
--将用户加入组
net localgroup administrators dblogin1
```

