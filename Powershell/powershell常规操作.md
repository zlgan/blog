---
title: powershell常规操作
date: 2021-07-09 22:21:07
tags:
categories: Powershell
---

### 1、命令管理

```powershell
#输入多行命令,只需要在命令后面加上重音符号 `
PS C:\Users\Administrator> ping `
>> -n 3 `
>> www.baidu.com
Pinging www.a.shifen.com [183.232.231.174] with 32 bytes of data:
Reply from 183.232.231.174: bytes=32 time=11ms TTL=57
Reply from 183.232.231.174: bytes=32 time=12ms TTL=57
Reply from 183.232.231.174: bytes=32 time=11ms TTL=57
```

```powershell
get-command #查看所有命令
rename-item #重命名
invoke-item # 
get-alias gc #根据别名查全名 
Get-Alias -Definition Get-Command #根据全名查别名
Get-help get-command #查看帮助
Get-help get-command -example #查看帮助带示例
```

```powershell
Get-Member 获得对象信息
PS E:\workspace\myBlog\source\_posts\Regex> ls *.md | Get-Member
   TypeName: System.IO.FileInfo
Name                      MemberType     Definition
----                      ----------     ----------
LinkType                  CodeProperty   System.String LinkType{get=GetLinkType;}
Mode                      CodeProperty   System.String Mode{get=Mode;}
ModeWithoutHardLink       CodeProperty   System.String ModeWithoutHardLink{get=ModeWithoutHardLink;}
Target                    CodeProperty   System.String Target{get=GetTarget;}
```

```powershell
Sort-Object 排序
PS D:\temp> ls *.txt | Sort-Object LastWriteTime    
    Directory: D:\temp
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            2022/7/9    12:43              3 b.txt
-a---            2022/7/9    12:43              3 a.txt
-a---            2022/7/9    12:43              3 c.txt
```

```powershell
select-object(select) 投影
PS D:\temp> ls a.txt | select name,basename,fullname
Name  BaseName FullName
----  -------- --------
a.txt a        D:\temp\a.txt
```
```powershell
where-object(where,?) 过滤
PS D:\temp> Get-Service *svc | ?{$_.status -eq "stopped"} #查找已停止的名称svc结尾的服务
```

### 2、文件操作
```powershell
#判断文件或者路径是否存在
Test-Path 
#寻找磁盘上的大文件
ls -file -Recurse | ?{$_.length -ge 1mb}|select fullname
#批量删除当前目录以及子目录下所有md文件
PS D:\workspace\myBlog\source> ls -Recurse *.md | rm		
#多个文件内容合并
get-content *.md | set-content new.md
#批量修改文件名
 ls *.txt | Rename-Item -NewName {'000'+$_.Name}

#查找包含与不包含的文本
Select-String -Path .\test -Pattern 'err' | Select-String -NotMatch -Pattern 'aaa'
```
### 3、计算机管理
```powershell
#查看计算机基本信息
PS C:\Users\Administrator> systeminfo
Host Name:                 LEOCOMPUTER
OS Name:                   Microsoft Windows 10 专业版
OS Version:                10.0.19045 N/A Build 19045
OS Manufacturer:           Microsoft Corporation
OS Configuration:          Standalone Workstation
OS Build Type:             Multiprocessor Free

#列出计算机管理的class名称
Get-WmiObject  -list win32*

#查看BIOS信息
PS C:\WINDOWS\system32> r 11
Get-WmiObject  Win32_BIOS
SMBIOSBIOSVersion : 1205
Manufacturer      : American Megatrends Inc.
Name              : BIOS Date: 05/11/18 00:32:49 Ver: 05.0000C
SerialNumber      : System Serial Number
Version           : ALASKA - 1072009

#查找磁盘相关的命令
 Get-WmiObject -List win32*disk* 
#查看磁盘使用情况
 Get-WmiObject Win32_LogicalDisk
```

