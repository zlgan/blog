---
title: net命令之-user管理用户
date: 2022-06-12 16:20:56
tags: 
categories: Windows
---

### net use 命令解释
>NET USE用户管理计算机上面的用户

#### local user
```powershell
#查看系统用户
net user 
#查看指定用户
net user <username>
#添加用户
net user username1 password1 /add 
#修改密码
net user username1 password2
#删除用户
net user username1 /delete  
#查看计算机是的用户组
net localgroup
#将用户加入组
net localgroup administrators username1 
```
```powershell 
#设置密码永不过期，需要使用powershell cmdlet命令
Set-LocalUser -Name username1 -PasswordNeverExpires $true
```

#### domain user 
```powershell
#查看域账户的详细信息
net user leozlgan /DOMAIN  
#修改密码
net user leozlgan newpassword /DOMAIN  
```

