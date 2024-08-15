---
title: 搜索条件设置
categroies: Tools
date: 2021年7月15日 00:25:24
---

### 文件名

- <Keywords> 文件名包含的字符
- case:<Keywords>区分大小写的关键字
- ！<KeyWords>文件名中不包含的关键字
- wholeword:<fileName>完全匹配文件名
- a|b 文件名包含a或者b
- regex:<expression> 使用正则表达式搜索

### 文件内容

- content:<keywords> 文件内容中包含制定的关键字
- size:1mb..2mb    1Mb<文件大小<2Mb
- dm:<startData>..<endDate> 修改日期范围

### 目录

- d:\ 搜索D盘及其子目录
- parent:d:搜索D盘（不包含子目录）