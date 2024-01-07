---
title: dotnet命令行
date: 4/16/2022 15:21:56
tags: 
categories: DotNet
---

### 解决方案和项目管理

```bash
#创建项目和解决方案
dotnet new sln -n mysolution 
dotnet new console -o app
dotnet new classlib -o mylib1
dotnet new xunit -o unitTest1

#项目之间添加引用关系
#添加单个
PS E:\workspace\Project\DotNet\CSharp\myApp> dotnet add  .\app\app.csproj  reference .\mylib1\mylib1.csproj
已将引用“..\mylib1\mylib1.csproj”添加到项目
#一次添加多个
PS E:\workspace\Project\DotNet\CSharp\myApp> dotnet add .\unitTest1\unitTest1.csproj reference .\app\app.csproj .\mylib1\mylib1.csproj
已将引用“..\app\app.csproj”添加到项目。
已将引用“..\mylib1\mylib1.csproj”添加到项目。

#将项目添加到解决方案
E:\workspace\Project\DotNet\CSharp\myApp> dotnet sln add .\app\app.csproj .\mylib1\mylib1.csproj .\unitTest1\unitTest1.csproj
已将项目“app\app.csproj”添加到解决方案中。
已将项目“mylib1\mylib1.csproj”添加到解决方案中。
已将项目“unitTest1\unitTest1.csproj”添加到解决方案中。
PS E:\workspace\Project\DotNet\CSharp\myApp> dotnet sln list
项目
--
app\app.csproj
mylib1\mylib1.csproj
unitTest1\unitTest1.csproj
PS E:\workspace\Project\DotNet\CSharp\myApp> 

#查看当前解决方案引用的项目
PS E:\workspace\Project\DotNet\CSharp\myApp> dotnet sln list
项目
--
app\app.csproj
mylib1\mylib1.csproj
unitTest1\unitTest1.csproj
PS E:\workspace\Project\DotNet\CSharp\myApp>

#删除解决
```

### Nuget 包管理

```bash
#列出项目项目或者解决方案的包引用
dotnet list package 
#将Newtonsoft.Json NuGet 包添加(或者更新)到项目：
dotnet add package Newtonsoft.json
#要添加 12.0.1 版的 Newtonsoft.Json 包，请使用以下命令
dotnet add package Newtonsoft.Json --version 12.0.1
#从项目文件中移除包引用
dotnet remove package Newtonsoft.Json
```





创建项目指定SDK

dotnet new console --framework 'netcoreapp3.1'

dotnet new console --framework 'net6.0'





<Project Sdk="Microsoft.NET.Sdk.Web">  构建aspnet 应用需要引入的nuget包集合

<Project Sdk="Microsoft.NET.Sdk">构建dotnet 应用需要引入的nuget包集合

<TargetFramework>netcoreapp3.1</TargetFramework> 目标SDK





dotnet dev-certs https --check
A valid certificate was found: 9B6FDE7F6F882A5217586058A3735DDB6B25C008 - CN=localhost - Valid from 2024-01-06 17:08:04Z to 2025-01-05 17:08:04Z - IsHttpsDevelopmentCertificate: true - IsExportable: true
Run the command with both --check and --trust options to ensure that the certificate is not only valid but also trusted.
