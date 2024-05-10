# 1./etc/shells: valid login shells
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash



# history

history -w 将缓存中的命令写入  .bashhistory文件中

history -c 清空历史记录

!n 执行第n条命令

!!重复执行上一条命令

# 基本命令

## alias 别名

```bash
alias 别名=‘原命令’
alias #查看命令别名
/root/.bashrc #别名永久生效要保存到该文件中
```



## 环境变量 $PATH

```
suse01:~ # echo $PATH
/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:/bin
```

# 快捷键 

```
ctrl+c # 强制终止当前的命令
ctrl+L #清屏
ctrl+u #删除或者剪切光标之前的的命令
ctrl+k #删除或者剪切光标之后的命令
ctrl+y #粘贴ctrl+u或者ctrl+k剪切的命令
ctrl+d 对出当前终端
```

# 标准输入输出 

## 输出重定向

```bash
/dev/stdin  0  #标准输入--键盘
/dev/stdout 1  #标准输出 --显示器
/dev/stderr 2  #标准错误输出 --显示器

命令> 文件 #以覆盖的
命令>>文件
命令 2>文件 #错误命令

#将正确输出和错误输出一起保存
#方式1
命令 >> 文件 2>&1
#方式2
命令 &>> 文件 

/dev/null #linux中特殊文件，可以理解成垃圾箱
ls &> /dev/null #不想要任何输出

```



# 多命令顺序执行

- command1;command2
- command1&& command2 
- command1 ||command2

# 管道

# 通配符

- ？ 匹配任意一个字符
- \*  匹配0个或者任意多个字符
- [] 匹配括号中的任意一个字符
- [-] 范围
- [^0-9 ]匹配不在指定范围的字符



## 特殊符号

- ’‘ 单引号中的特殊符号都是作为普通字符处理 
- “ ” 双引号 ，里面的特殊符号有特殊含义
- `` 反引号扩起来的是系统命令
- $()同上



```
suse01:~ # name=sc 
suse01:~ # echo $name 
sc
suse01:~ # echo "$name" 
sc
suse01:~ # echo '$name'
$name
suse01:~ # echo '$(date)'
$(date)
suse01:~ # echo "$(date)"
Thu May  2 02:30:55 CST 2024


suse01:~ #  abc=`date`
suse01:~ # echo $abc
Thu May 2 02:29:37 CST 2024


[root@node11 ~]# echo "\n"
\n
[root@node11 ~]# echo -e "hello\nworld"
hello
world
```



# 变量

## 环境变量

```
set #查看所有的变量
export <变量名> #将变量加入环境变量
#环境变量可以在所有shell中可见，本地变量只在当前shell可见，在子shell不可见
```

pstree

## 位置参数

$n $0表示命令本身 $1表示第一个参数

$* 代表所有参数，作为一个整体

$@ 代表所以参数，作为一个数组

$# 参数的个数

## 预定义变量

$? 代表上一个语句的执行状态0表示成功，其他表示失败

\$$ 保存的最后一个PID

$! 保存的当前的PID

# read 命令

-s 隐藏输入

-t 延迟时间

-n 字符数，接收到指定的字符数之后就乎自动往下执行，不用等待回车



# 运算符

>在 Bash shell 中，`$(( ))` 是一个用于进行算术运算的结构。当你把表达式放在 `$(( ))` 中时，Shell 会计算这个表达式，并将结果替换到命令行或脚本中的对应位置。这是 Bash 提供的一种方便的算术扩展方式。

```bash
[root@node11 ~]# a=3
[root@node11 ~]# b=4
[root@node11 ~]# c=$a+$b
[root@node11 ~]# echo $c
3+4
[root@node11 ~]# c=$($a+$b)
bash: 3+4: 未找到命令...
[root@node11 ~]# c=$(($a+$b))
[root@node11 ~]# echo $c
7
```













