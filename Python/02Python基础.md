---
title: Python基础
date: 2021-06-27 07:36:18
tags:
categories: Python
---

### 01_HelloPython

```python
def Hello():
    return "hello python."
print(Hello())
```
### 02_字符串处理
```python
s1="test1"
s2="test2"
print(s1+s2) #字符串拼接
print(s1,s2) #拼接，以空格分隔

msg="hello,Wrold"
print(msg.title()) #首字母大写，其余小写 Hello,Wrold
print(msg.upper()) 
print(msg.lower())

#转义字符
msg2="Hello\nWrold" # 换行输出 \n表示换行
msg3=r"Hello\nWrold" # r表示不转义，原样输出

#删除空白字符
stripTest=" Hello World "
stripTest.lstrip() #删除左边空白
stripTest.rstrip() #删除右边空白
stripTest.strip() #删除左右空白


```
### 03_数字运算
```python
a=5
b=3

print(a**b) #125 乘方5的3次方 
print(a//b) #1 取整数部分，没有四舍五入 

a=0.1
b=0.2

print(a+b)
print(a-b)
print(a*b)
print(a**b)
print(a/b)
print(a//b)
```
### 04_列表
```python
frout=["apple","paire","blanan"]

#遍历数组
print("begin")
for item in frout:
    print("\t",item)
print("end.")


#新增元素
frout.append("测试")
#删除元素
frout.remove("apple")
#排序
frout.sort()

#遍历数组--带索引
print("begin")
for i,item in  enumerate(frout):
    print("\t",i,item)
print("end.")


#统计
myList=[1,4,9,3,2,0]
print(max(myList)) #9
print(sum(myList)) #19
print(min(myList)) #0

#切片 myList[<from>:<to>:<step length>]
#获取从列表索引from 开始到to-1的元素集合，from默认为0，to的默认值为索引最大值
#<step length> 默认为1，可以不写
print(myList[0:3]) #1,4,9
print(myList[:3]) #同上
print(myList[2:4]) #9,3
print(myList[2:3]) #9
print(myList[2:]) #9,3,2,0
#-1表示最大索引-1的位置
print(myList[2:-1]) #9,3,2
print(myList[2:2]) #[] 非法的切片
print(myList[2:1]) #[] 非法的切片

#带有三个参数的切片
print(myList[1:5:2]) #[4, 3]
print(myList[1::3]) #[4, 2]

mySlice=myList[2:5]
#改变切片的内容，不影响原列表
mySlice.append("20")
print(myList) #[1, 4, 9, 3, 2, 0]
print(mySlice) #[9, 3, 2, '20']


```
### 05_Range
```python
myRange=range(5)
#该函数生成的是一个range对象
print(myRange) #range(0, 5)
myList=list(myRange) #[0, 1, 2, 3, 4]

#range对象转列表
print(list(myRange))

#生成指定起始值，和指定步长的range对象
myRange2=range(1,11,2)
print(list(myRange2)) #[1, 3, 5, 7, 9]

#range对象的遍历，同列表
for item in myRange2:
    print(item)

#range的统计信息
print("test",myRange2[1:3])
```
### 06_IF语句
```python
if 1==1:
    print(True)

if 1==1 and 2==2 :
    print(True)

if 1==2 or 3==3:
    print(True)

point=30
if point>40:
    print("good")
elif point>30:
    print("normal")
elif point>20:
    print("normal")
else:
    print("bad")
```
### 07_字典
```python
db_config={
    "ip":"127.0.0.1",
    "port":80,
    "uid":"admin",
    "pwd":123456
}

print(db_config)

#新增字典项目
db_config["timeout"]=30
print(db_config)

#修改字典项目
db_config["timeout"]=60
print(db_config)

#删除字典项目
del db_config["timeout"]
print(db_config)

#遍历字典元素
for key,value in db_config.items():
    print(key,"=",value)

#遍历字典Key
for key in db_config.keys():
    print(key,"is",db_config[key])

#遍历value db_config.values()



```
### 08_函数
```python
#定义函数
def hello1():
    print("hello python")

#调用函数
hello1()

#定义个带默认值的函数，可以不传递该参数
def hello2(name="testname"):
    print("hello",name)

hello2("leo")
hello2()

#定义个参数不确定的函数，num相当于一个列表
def add(*num):
    result=0
    for item in num:
        result+=item
    return result

print(add(1,2,3,4)) #10
print(add(1,2,3,4,5,6,7,8,9)) #45

#定义一个项目不确定的字典参数(关键字参数)
def sendEmail(**data):
    for key,val in data.items():
        print(key,"=",val)

sendEmail(title="testTitle",to="aaa",cc="cclist")
```
### 09_自定义模块
```python
#引入外部模块，模块名就是文件名
import Func
print(Func.add(3,5))
#引入外部模块，并定义别名
import Func as myFunc
print(myFunc.add(3,5))
```
### 10_定义一个类
```python
#定义一个类
class Player():
    #类的构造函数
    def __init__(self,name,age):
        super().__init__()
        self.name=name
        self.age=age
    def sayHello(self):
        print("Hello,my name is ",self.name,"and my age is ",self.age)
    def intro(self):
        print("I'am a player")

#实例化一个对象
player1= Player("tom",30)
player1.sayHello()


#类的继承
class nbaPlayer(Player):
    def __init__(self, name, age):
        #在构造函数中给父类的构造函数传递参数
        super().__init__(name, age)
        self.category="nba"
    def intro(self):
        print("I'am a ",self.category,"player")

kobe= nbaPlayer("kobe",40)
kobe.sayHello()
kobe.intro()
```
### 11_引用外部模块和外部类
```python
#core是模块名称,后面的列表是该模块中定义的类
from core import nbaPlayer
kobe=nbaPlayer("kobe",39)
kobe.intro()
kobe.sayHello()
```
### 12_读写文件
```python
  
#定义文件路径
filepath ="files/test.txt"
#以写模式打开文件，并指定文件句柄
with open(filepath,"w", encoding= "utf-8") as myFile:
    myFile.write("hello\n")
    myFile.write("python\n")
    myFile.write("world\n")
with open(filepath,'r',encoding="utf-8") as myFile:
    print(myFile.read())
```
### 13_错误处理
```python
try:
    10/0
except ZeroDivisionError  as zdr:
    print("error")
else:
    print("ok")
finally:
    print("end")
print("---------------------")
try:
    10/10
except ZeroDivisionError  as zdr:
    print("error")
else:
    print("ok")
finally:
    print("end")    
```
### core
```python
#定义一个类
class Player():
    #类的构造函数
    def __init__(self,name,age):
        super().__init__()
        self.name=name
        self.age=age
    def sayHello(self):
        print("Hello,my name is ",self.name,"and my age is ",self.age)
    def intro(self):
        print("I'am a player")

#实例化一个对象
# player1= Player("tom",30)
# player1.sayHello()


#类的继承
class nbaPlayer(Player):
    def __init__(self, name, age):
        #在构造函数中给父类的构造函数传递参数
        super().__init__(name, age)
        self.category="nba"
    def intro(self):
        print("I'am a ",self.category,"player")
```
### Func
```python
def add(x,y):
    return x+y
```
