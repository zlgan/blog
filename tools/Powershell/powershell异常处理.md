---
title: powershell异常处理
date: 2021-12-2 23:17:14
tags: 
categories: Powershell
---

```powershell
$PSDefaultParameterValues.Clear()
$PSDefaultParameterValues.Add("*:ErrorAction","Stop")
#或者 $ErrorActionPreference='stop'
Trap [System.Exception]
{
    $Error[0] >> d:\err.txt
    Write-Host $Error[0]
    break
 }
function test()
{
    Get-Content -Path y:
    Write-Host "done in test"
}
Get-Content -Path z:
Write-Host "done"
test
```



