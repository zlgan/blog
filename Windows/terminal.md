# 快捷键

ctrl+shift+p 打开命令窗口

## 窗口类

1. 分割窗口 Alt+shift+（加号/减号）
2. 在窗格之间切换：Alt+方向键
3. 调整窗格大小： Alt+shift+方向键
4. 关闭当前窗格：ctrl+shift+w
5. 新建终端窗口: ctrl+shift+N

# 配置terminal

## 设置透明背景

1. 打开terminal 的json配置

   terminal>设置>打开json文件，添加一下设置

```json
"profiles": 
{
    "defaults": 
    {
        "elevate": true,
        //设置透明度100：不透明
        "opacity": 60,
        //设置亚克力效果
        "useAcrylic": true
    }
 }
```



## 使用psReadLine模块



1. 打开profile文件

```
PS C:\Users\Administrator> $profile
C:\Users\Administrator\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
PS C:\Users\Administrator> code $profile
```

2. 编辑此文件设置快捷键

```

Remove-PSReadLineKeyHandler -Key "Ctrl+LeftArrow"
Remove-PSReadLineKeyHandler -Key "Ctrl+Backspace"

Set-PSReadLineKeyHandler -Key "Ctrl+/" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+." -Function BackwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+Shift+h" -Function BackwardKillWord
```

https://www.cnblogs.com/cralor/p/17648531.html

