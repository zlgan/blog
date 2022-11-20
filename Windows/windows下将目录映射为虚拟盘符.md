---
title: windows下将目录映射为虚拟盘符
date: 2021-02-18 00:27:24
tags: 
categories: Windows
---

### subst

```powershell
PS D:\workspace\test> g:
Set-Location : 找不到驱动器。名为“G”的驱动器不存在。

PS D:\workspace\test> subst /?
将路径与驱动器号关联。
SUBST [drive1: [drive2:]path]
SUBST drive1: /D
  drive1:        指定要分配路径的虚拟驱动器。
  [drive2:]path  指定物理驱动器和要分配给虚拟驱动器的路径。
  /D             删除被替换的
(虚拟)驱动器。

不带参数键入 SUBST，以显示当前虚拟驱动器的列表。
```

- 将D:\workspace\test 映射到G盘

  ```powershell
  PS D:\workspace\test> subst g: .
  PS D:\workspace\test> g:
  PS G:\>
  ```

- 删除虚拟盘符G

  ```powershell
  PS G:\> subst g: /d
  PS G:\> g:
  Set-Location : 找不到驱动器。名为“G”的驱动器不存在。
  ```

  