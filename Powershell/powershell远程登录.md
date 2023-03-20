---
title: powershell远程登录
date: 2021-03-07 13:37:14
tags: 
categories: Powershell
---

### 前提

所有命令在管理员账户下运行

### 远程计算机（192.168.86.201）

1. 开启远程管理

   ```powershell
   Enable-PSRemoting -Force
   ```

   该服务开启了WinRM服务，监听5985（http）5986（https）端口，并且设置好了防火墙规则

2. 将客户端加入信任列表

   ```powershell
     winrm set winrm/config/client '@{TrustedHosts="192.168.1.100"}'
   ```
 ```powershell
     winrm get winrm/config/client 

    Client
        NetworkDelayms = 5000
        URLPrefix = wsman
        AllowUnencrypted = false
        Auth
            Basic = true
            Digest = true
            Kerberos = true
            Negotiate = true
            Certificate = true
            CredSSP = false
        DefaultPorts
            HTTP = 5985
            HTTPS = 5986
        TrustedHosts = deviv3,dev2svc,dev2db,dev5,dev6,dev7
   ```

3. 重启服务并测试

   ```powershell
     Restart-Service winrm
     Get-Service winrm
   ```

   

### 客户端（192.168.1.100)

1. 将开启远程管理服务，同上

2. 远程服务器加入信任列表，多个IP用逗号分开

3. 测试服务器是否准备好接受远程连接

   ```
   Test-WSMan 服务器IP
   ```

   

### 远程连接

```powershell
 Enter-PSSession -ComputerName 192.168.86.203 -Credential topdm\administrator	
 exit //断开连接 
```

### 提示

1. 如果出现连接问题，可以先关闭防火墙试试

