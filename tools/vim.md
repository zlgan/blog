# 命令模式

## 设置行号

:set nu

## 搜索

/ +<keyword>

?+<keyword>











# normal

## 按单词移动

### w 将光标移动到下一个单词的开头

### b 将光标移动到上一个单词的开头

### e 将光标移动到下一个单词的末尾

### E 将光标移动到上一个单词的末尾



## 按行移动

### gg 到文件的首行 

### G 到文件的尾行

### 5G 跳转到第5行

### $ 跳转到当前行尾

### 0 条状到当前行为

### 到屏幕中间M

### kjhl 上下左右移动

gg 行首
G 行尾
dd 删除当前行
10dd 删除第10行
ctrl+u 向上翻页
ctrl+d 向下翻页

```
:set nu  设置行号
```

```
i "insert" 在光标开始之前输入
I 在本行的开头开始输入
a "append"
o 下方插入
O 上方插入

s删除当前光标字符，然后开始输入
S删除当前行，然后重新输入

```



# insert模式

# command 模式 

```
:w 保存当前文件
:q 退出
:q! 放弃当前更改，然后退出 
:wq 保存当前修改，然后退出
```

# 搜索

/pattern 设置搜素的内容，然后回车

nN 快速重复/查找

# 替换

```text
:{作用范围}s/{目标字符}/{替换的字符}/{替换标志}


作用范围：
	% 表示整个文档
	1,10 表示第 1 行到第 10 行之间进行替换
	
	例如 :1,10s/old_string/new_string/g 表示在第 1 行到第 10 行之间进行替换
	例如 :%s/old_string/new_string/g 表示在第 1 行到第 10 行之间进行替换
	
替换标志:	
	g 表示全局替换（每行所有匹配项），如果不加 g，则只替换每行第一个匹配项
	i 忽略大小写，I区分大小写
	c 逐个确认

```
