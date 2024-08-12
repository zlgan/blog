---
title: Java基础
date: 2021-06-26 07:02:58
tags:
categories: Java
---

### JDK，JRE，JVM

![image-20210626070601182](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210626070601182.png)

### 环境搭建

1. 安装JDK

``` powershell
#下载安装JDK

#配置Java相关的环境变量
PS D:\workspace> ls env: | ?{$_.value -like "*java*" } |Format-Table

Name                           Value
----                           -----
CLASSPATH                      .;C:\Program Files\Java\jdk-13.0.1\lib;C:\Program Files\Java\jdk-13.0.1\lib\tools.jar
JAVA_HOME                      C:\Program Files\Java\jdk-13.0.1
JRE_HOME                       C:\Program Files\Java\jdk-13.0.1\bin\jre
Path                          %Java_HOME%\bin;%JRE_HOME%\bin

#查看Java版本信息
PS D:\workspace> java -version
java version "13.0.1" 2019-10-15
Java(TM) SE Runtime Environment (build 13.0.1+9)
Java HotSpot(TM) 64-Bit Server VM (build 13.0.1+9, mixed mode, sharing)
```

2.  JDK目录解析

```powershell
PS D:\workspace> cd $env:JAVA_HOME
PS C:\Program Files\Java\jdk-13.0.1> ls | select mode, Name

Mode   Name
----   ----
d----- bin # 可执行程序 如JavaC编译器等
d----- conf
d----- include # 放置JDK引用的C，c++等头文件
d----- jmods 
d----- legal
d----- lib # java的库文件
-a---- COPYRIGHT
-a---- release
```

### Hello，World

1. 用记事本编写源代码

```java
public class Hello
{
	public static void main(String[] args)
	{
		System.out.print("hello,world");
	}
}
```

2. 编译并执行

```powershell
#编译源文件，编译之后产生Hello.Class文件
E:\Study\Java\Code>javac Hello.java
#执行文件class文件，不带扩展名，否则出错
E:\Study\Java\Code>java Hello
hello,world
E:\Study\Java\Code>
```

3.注意

- 文件名和类型名词必须一致，首字母大写
- Java大小写敏感，类的名称大写字母开头，属性小写字母开头的驼峰表示，方法名小写字母开头

### Java程序运行机制

![image-20210626081816888](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210626081816888.png)

Java程序首先编译成字节码文件，然后在JVM中被解释执行

### 集成开发工具IDEA

[IDEA官网](https://www.jetbrains.com)

### Java语言基础

#### 1. 标识符

1. Java 大小写敏感
2. 变量命名規則：[A-za-z_$].*
3. 变量不能使用关键字命名

Java数据类型：

- 基本类型

  ![image-20210627064650642](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210627064650642.png)

  ![image-20210626163233878](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210626163233878.png)

- 引用类型

```
类，接口，数组
```

#### 2. 变量命名规范

- 成员变量，方法名，局部变量首字母小写+驼峰原则
- 常量：变量名大写字母+下划线连接
- 类名称：首字母大写+驼峰原则



### Java与C#语法差异

#### 数据类型

1. 可空类型：C#的数据类型关键字加？int?,实际对应的是Nullable<int>;Java表示空不可以使用关键字，只能使用数据类型关键字对应的类型表示null

```c#
//C#
  Nullable<int> a1=null;
  int? a2=null;
//Java
int? a1=null //编译不通过
Integer a1=null; //OK
```

2. 常量

~~~c#
private const int mAXAGE=10;//C#
private final int MAX_AGE =144;//Java
~~~

3.字符串比较

```java
//对于引用类型来说==操作符是比较引用，equals 是值的比较
		String s1=new String("aaa");
        String s2=new String("aaa");
        System.out.println(s1==s2);//false
        System.out.println(s1.equals(s2));//true
```



#### 命名空间

1. 组织类型的名空间：C# 使用 ==namespace==，Java使用==package==；
2. 当前文档导入命名空间 C# 使用==using== <namespace name>，Java使用==import== <package name>
3. Java一个Class文件最多只能有一个public的类型，且Class类型必须与文件名相同

```c#
//C#
using System;
namespace namespace1
｛
 ｝
//Java
Pacakge <PackageName> //当前类型所在的包名 
import <packageName>.* // 引入其他包名称，支持通配符,通配符代表所有的类

```

#### 属性

1. C#有Property的概念，可以通过get，set访问；Java必须先定义变量，然后写getXXX，setXXX方法

```c#
//C#
namespace Hello.World
{
    public class Person
    {
        public int Age { get; set; }
    }
}

//Java
package hello.world;
public class Person {    
    private int age;
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
}
```

#### Foreach语法

~~~c#
foreach (var str in args) {} //c#

for(String str : args){} //Java 中并没有foreach关键字，这种写法相当于foreach
~~~

#### Lambda 表达式

1. 为了“模拟”函数指针的功能，在C#中使用委托，在Java中使用函数式接口

2. 函数式接口其实就是一个接口，它看起来具有表示“方法签名”的功能，但是很丑陋。

   委托看起来更像“方法签名”，也很优雅，但不要被迷惑，其实它也是一个类

3. lambda表达式的写法略微不同，C#中是() => {}，Java中是() -> {}

4. 一定要明白不仅普通数据可以当作参数传递，代码片段（就是逻辑）也可以当作参数传递。

   这个思想就是核心，至于写法和用法就是围绕着核心的变化而已

```java
public class HelloWorld {
    public static void main(String[] args) {
        Mathoperation mathoperation=(int a,int b)->a+b;
        System.out.println(mathoperation.operation(1,2)); //3
    }
}
interface Mathoperation{
    int operation(int a,int b);
}

```

#### 继承和多态

1. 继承父类C#使用 subClass：superClass，java使用 subClass ==extends== superClass
2. 复写父类的方法，C#要求父类方法有==virtual== 关键字，Java默认都是虚方法
3. C#在方法定义中使用override关键字复写，Java使用注解==@Override==，也可以省略这个注解

```java
package Base;
public class Inherit {
    public static void main(String[] args) {
        new Teacher().sayHello(); //hello i'am a teacher
    }
}

class Person {
    public void sayHello(){
        System.out.println("hello i'am a person");
    }
}

class Teacher extends Person{
    @Override //可以不要，默认覆盖父类同名方法
    public void sayHello(){
        System.out.println("hello i'am a teacher");
    }
}

```



### 注释文档

1. 编写文档注释

```java
package Base;

//注释可以写在类上，也可以卸载方法上

/**
 * @author leo
 * @version 1.0
 */
public class Doc {
    String name;
    /**
     *
     * @param name
     * @return string
     * @throws Exception
     * @author leo
     */
    public String test(String name) throws Exception{
        return  name;
    }
}

```

2. 命令行中生成文档 ==javadoc==命令

~~~cmd
E:\Study\Java\JavaSE\Module1\src\Base>javadoc -encoding utf-8 -charset utf-8 Doc.java
Loading source file Doc.java...
Constructing Javadoc information...
Standard Doclet version 13.0.1
Building tree for all the packages and classes...
Generating .\Base\Doc.html...
Doc.java:12: warning: no description for @param
     * @param name
       ^
Doc.java:14: warning: no description for @throws
     * @throws Exception
       ^
Generating .\Base\package-summary.html...
Generating .\Base\package-tree.html...
Generating .\constant-values.html...
Building index for all the packages and classes...
Generating .\overview-tree.html...
Generating .\deprecated-list.html...
Generating .\index-all.html...
Building index for all classes...
Generating .\allclasses-index.html...
Generating .\allpackages-index.html...
Generating .\index.html...
Generating .\help-doc.html...
2 warnings

~~~

### 编译与运行



### 参考资料

> 阿里巴巴开发手册
>
> [Java官方文档](https://www.oracle.com/cn/technical-resources/)

