---
title: windwos terminal快捷键
date: 2021-02-20 18:39:17
tags:
categories: Windows
---

### 快捷键

- 复制 Ctrl+Shift+C
- 黏贴 Ctrl+Shift+V
- 新建默认终端 Ctrl+Shift+T
- 新建指定终端的窗口Ctrl+Shift+1,2,3
- 关闭窗口Ctrl+Shift+W
- 调整窗口大小 Ctrl+win+up/down （通用）

### 配置Git Bash 终端

打开Settings->list下面增加节点

```json
{
    "closeOnExit": true, // 关闭的时候退出命令终端
    "colorScheme": "Campbell", // 样式配置
    "commandline": "D:\\Program Files\\Git\\bin\\bash.exe", // git-bash的命令行所在位置
    "cursorColor": "#FFFFFF", // 光标颜色
    "cursorShape": "bar", // 光标形状
    "fontFace": "YaHei Consolas Hybrid", // 字体配置，选择你电脑上已安装的字体
    "fontSize": 14, // 终端字体大小
    "guid": "{1c4de342-38b7-51cf-b940-2309a097f589}", // 唯一的标识，改成和其他的已有终端不一样
    "historySize": 9001, // 终端窗口记忆大小
    "icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico", // git的图标
    "name": "git-bash", // 标签栏的标题显示
    "padding": "0, 0, 0, 0", // 边距
    "snapOnInput": true,
    "startingDirectory": "%USERPROFILE%", // gitbash 启动的位置（默认在C盘的用户里面的就是 ~ ）
    "useAcrylic": false // 是否开启透明度
  }
```

