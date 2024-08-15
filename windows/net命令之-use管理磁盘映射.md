---
title: net命令之--use管理磁盘映射
date: 2021-03-06 15:20:56
tags: 
categories: Windows
---

### net use 命令解释

> NET USE 将计算机连接到共享资源或将计算机与共享资源断开连接。使用时如果没有选项，它会列出计算机的连接

#### 任务：

将远程资源映射为本地磁盘

1. 查看远程共享目录

   ```powershell
   PS D:\workspace> net view \\192.168.86.203
   在 \\192.168.86.203 的共享资源
   
   共享名      类型  使用为  注释
   -------------------------------------------------------------------------------
   testShare   Disk
   testShare2  Disk
   ```

2. 查看本地的磁盘映射

    ```powershell
    PS C:\Users\leozlgan> net use
    New connections will be remembered.
    Status       Local     Remote                    Network
    ----------------------------------------------------------------------------
    OK           M:        \\10.194.103.149\share    Microsoft Windows Network
    OK           N:        \\10.194.103.149\software Microsoft Windows Network
    ```


3. 删除本地的磁盘映射

    ```powershell
    PS C:\Users\leozlgan> net use n:  /delete #n是盘符
    n: was deleted successfully.
    ```

2. 使用net use映射为本地磁盘

   ```powershell
    PS C:\Users\leozlgan> net use n: \\10.194.103.149\software
    The command completed successfully.
   ```
