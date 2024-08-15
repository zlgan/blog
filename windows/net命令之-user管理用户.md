---
title: net命令之-user管理用户
date: 2022-06-12 16:20:56
tags: 
categories: Windows
---

### net use 命令解释
>NET USE用户管理计算机上面的用户

NET USER 命令是用来管理计算机用户

```powershell
#查看系统用户
net user 
#查看指定用户的详细信息
net user <username>
#删除用户
net user dblogin1 /delete  
#添加用户
net user dblogin1 dblogin1 /add 
#修改密码
net user dblogin1 dblogin1  
#查看计算机的用户组
net localgroup
#将用户加入组
net localgroup administrators dblogin1
```

