---
title: Powershell基础命令
date: 2021-02-19 23:31:06
tags: 
categories: Powershell
---


### 1.使用帮助系统
~~~powershell
​	get-help / man
 -full# 显示完整帮助
 ​-examples# 显示实例
~~~

### 2.元信息管理

~~~powershell

- $psversiontable #查看ps版本信息

-  get-command #获取所有powershell命令

- get-alias  #查看命令别名

- get-alias -def get-command# 根据完整名查别名

PS C:\Users\leozlgan> Get-Alias -Definition Get-Content

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           cat -> Get-Content
Alias           gc -> Get-Content
Alias           type -> Get-Content

-  get-psprovider  #查看PS的提供程序

- get-verb# 查询ps支持的所有谓词

- get-psprovider  #查看PS的提供程序

-  get-psdrive# 查询ps的驱动器

  ​	Registry--注册表
  ​	Alias--别名
  ​	Environmet -环境变量
  ​	FileSystem--文件系统
  ​	Function-
  ​	Variable--本地变量
  ​	Certificate--证书
  ​	WSMan

- show-command <command name>#  通过UI界面输入参数

- Update-Help# 更新帮助系统文件

-# 命令用法

  *# 谓词+名词+参数名+参数值
  *# 使用位置参数可以省略参数名，直接输入参数值
  *# 参数名称可以不用输入完整，只要能与其他参数区别开来即可
  
- get-memeber（gm）获取对象属性

- where-object (?)

  *# 示例： ls |?{$_.name -eq "music"}
  
- $host.ui.RawUI.WindowTitle="修改窗口标题"

- get-history# 显示命令历史

  ```powershell
  PS F:\> h
    Id CommandLine
    -- -----------
     1 cd E:\Study\Java\MavenTest\maven01
     2 e:
     3 ls
     4 f:
  #r# 执行历史列表中的指定记录  
  PS F:\> r 3
  ls
#      目录: F:\
  Mode                 LastWriteTime         Length Name
  ----                 -------------         ------ ----
  d-----         2020/9/26     11:43                Baby
  d-----         2021/7/31      8:05                backup
  d-----          2021/8/5     21:50                BaiduNetdiskDownload  
  ```
```
  

#### 模块管理

*  env:psmodulepath     #查看路径    
* $env:psmodulepath.split（'；'）| ls     #查看所有模块     
* get-command -module <模块名称>     #查看模块提供的命令    

环境变量
	* ls env:# 显示所有环境变量
	* $env:path# 显示指定的环境变量path
	* $var1="test"申明赋值变量
	* $var1# 显示变量
	*# 使用.net方法设置永久生效的环境变量：

#### 特殊变量

PowerShell的特殊变量由系统自动创建。用户自定义的变量名称应该不和特殊变量相同。
    $^ ：前一命令行的第一个标记
    $$ ：前一命令行的最后一个标记
    $_ ：表示表示当前循环的迭代变量。
   $PSItem:# 同上
    $? ：前一命令执行状态，成功（Ture）# 或者# 失败（False）
    $Args ：为脚本或者函数指定的参数
    $Error ：错误发生时，错误对象存储于变量 $Error# 中
    $Foreach ：引用foreach循环中的枚举器
    $Home ：用户的主目录
    $Host ：引用宿主 POWERSHELL# 语言的应用程序
    $Input ：通过管道传递给脚本的对象的枚举器
    $LastExitCode ：上一程序或脚本的退出代码
    $Matches ：# 使用 –match# 运算符找到的匹配项的哈希表
    $PSHome ：Windows PowerShell# 的安装位置
    $profile ：标准配置文件（可能不存在）
    $StackTrace ： Windows PowerShell# 捕获的上一异常


#### 计算机管理

-# 关机 : stop-computer

-# 注销当前登录用户 cmd /c logoff

-# 查询已登录用户

  ```
#  运算符
  ```

  

