---
title: Maven项目开发流程
date: 2021-06-27 07:36:18
tags:
categories: Java
---



## Maven项目开发流程

### 1.Maven约定的项目结构

~~~powershell
>PS E:\Study\Java\MavenTest\maven01> tree /f

>│  pom.xml #管理项目依赖
>│
>├─src
>│  ├─main
>│  │  ├─java
>│  │  └─resources
>│  └─test
>│      ├─java
>│      └─resources
>└─target

~~~

### 2.编写代码以及测试类

~~~ java
//编写一个类
package com.leo;
public class Student{
    public void sayHello(){
        System.out.print("Hello Student"); 
    }
}

//编写测试代码
package com.leo.test;
import com.leo.Student;
import org.junit.Test; //导入junit依赖类
public class StudentTest{
    @Test
    public void myTest(){
        Student ss=new Student();
        ss.sayHello();
    }
}
~~~

```powershell
E:.
│  pom.xml
│
├─src
│  ├─main
│  │  ├─java
│  │  │  └─com
│  │  │      └─leo
│  │  │              Student.java
│  │  │
│  │  └─resources
│  └─test
│      ├─java
│      │  └─com
│      │      └─leo
│      │          └─test
│      │                  StudentTest.java
│      │
│      └─resources
```

### 3.编写Pom文件

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <!--设置Maven使用的版本号-->
    <modelVersion>4.0.0</modelVersion>
    <!--设置当前项目的gav坐标-->
    <groupId>com.leo</groupId>
    <artifactId>Maven01</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <dependencies>
        <!-- 引入junit依赖-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.11</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>    
~~~

### 4.编译 mvn compile

~~~powershell
PS E:\Study\Java\MavenTest\maven01> mvn compile
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< com.leo:Maven01 >---------------------------
[INFO] Building Maven01 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ Maven01 ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding GBK, i.e. build is platform dependent!
[INFO] Compiling 1 source file to E:\Study\Java\MavenTest\maven01\target\classes
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.163 s
[INFO] Finished at: 2021-07-07T23:19:37+08:00
[INFO] ------------------------------------------------------------------------
~~~

> 编译完成之后，项目根目录下增加==targe==目录，生成了class文件。
>
> mvn clean命令用于删除该目录

```
└─target
    ├─classes
    │  └─com
    │      └─leo
    │              Student.class
    │
    ├─maven-status
    │  └─maven-compiler-plugin
    │      ├─compile
    │      │  └─default-compile
    │      │          createdFiles.lst
    │      │          inputFiles.lst
    │      │
    │      └─testCompile
    │          └─default-testCompile
    │                  createdFiles.lst
    │                  inputFiles.lst
```



### 5.测试  mvn test

> Maven 会自动扫描test目录下所有的TestCase 然后执行测试

```powershell
PS E:\Study\Java\MavenTest\maven01> mvn test
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< com.leo:Maven01 >---------------------------
[INFO] Building Maven01 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ Maven01 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ Maven01 ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding GBK, i.e. build is platform dependent!
[INFO] Compiling 1 source file to E:\Study\Java\MavenTest\maven01\target\test-classes
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ Maven01 ---
[INFO] Surefire report directory: E:\Study\Java\MavenTest\maven01\target\surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.leo.test.StudentTest
Hello StudentTests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.065 sec
Results :
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.082 s
[INFO] Finished at: 2021-07-07T23:20:36+08:00
[INFO] ------------------------------------------------------------------------
```

>测试之后target新增以下文件
>
>```powershell
>target
>    ├─surefire-reports  #测试报告
>    │      com.leo.test.StudentTest.txt
>    │      TEST-com.leo.test.StudentTest.xml
>    │
>    └─test-classes
>        └─com
>            └─leo
>                └─test
>                        StudentTest.class
>```

### 6.打包 mvn package

```powershell
PS E:\Study\Java\MavenTest\maven01> mvn package
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< com.leo:Maven01 >---------------------------
[INFO] Building Maven01 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ Maven01 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ Maven01 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ Maven01 ---
[INFO] Surefire report directory: E:\Study\Java\MavenTest\maven01\target\surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.leo.test.StudentTest
Hello StudentTests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.066 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ Maven01 ---
[INFO] Building jar: E:\Study\Java\MavenTest\maven01\target\Maven01-0.0.1-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.216 s
[INFO] Finished at: 2021-07-07T23:32:17+08:00
[INFO] ------------------------------------------------------------------------
```

> 打包之后Target目录新增内容：
>
>  Maven01-0.0.1-SNAPSHOT.jar
> │
> ├─maven-archiver
> │      pom.properties

### 7.安装 mvn install ，打jar包并安装到本地仓库

~~~powershell
PS E:\Study\Java\MavenTest\maven01> mvn install
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< com.leo:Maven01 >---------------------------
[INFO] Building Maven01 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ Maven01 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ Maven01 ---
[WARNING] Using platform encoding (GBK actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ Maven01 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ Maven01 ---
[INFO] Surefire report directory: E:\Study\Java\MavenTest\maven01\target\surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.leo.test.StudentTest
Hello StudentTests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.072 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ Maven01 ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ Maven01 ---
[INFO] Installing E:\Study\Java\MavenTest\maven01\target\Maven01-0.0.1-SNAPSHOT.jar to D:\Program Files\maven-repo\com\leo\Maven01\0.0.1-SNAPSHOT\Maven01-0.0.1-SNAPSHOT.jar

#此处可见jar包的安装位置：
[INFO] Installing E:\Study\Java\MavenTest\maven01\pom.xml to D:\Program Files\maven-repo\com\leo\Maven01\0.0.1-SNAPSHOT\Maven01-0.0.1-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.367 s
[INFO] Finished at: 2021-07-07T23:57:01+08:00
[INFO] ------------------------------------------------------------------------
~~~

>
>
>1. 查看本地仓库配置的位置
>
>~~~powershell
>PS D:\> select-string -Path $env:MAVEN_HOME\conf\settings.xml -Pattern "localrepository"
><localRepository>D:\Program Files\maven-repo</localRepository>
>~~~
>
>2. 查看安装到本地仓库的jar包
>
>``` powershell
>PS D:\Program Files\maven-repo\com> tree .\leo\Maven01\0.0.1-SNAPSHOT /f
>D:\PROGRAM FILES\MAVEN-REPO\COM\LEO\MAVEN01\0.0.1-SNAPSHOT
>    maven-metadata-local.xml
>    Maven01-0.0.1-SNAPSHOT.jar
>    Maven01-0.0.1-SNAPSHOT.pom
>    _remote.repositories
>```
>
>

### 8.引用生成的jar

> 将pom文件中的gav引用到其他项目即可

~~~xml
PS D:\Program Files\maven-repo\com\leo\Maven01\0.0.1-SNAPSHOT> more .\Maven01-0.0.1-SNAPSHOT.pom
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.leo</groupId>
    <artifactId>Maven01</artifactId>
    <version>0.0.1-SNAPSHOT</version>

    <dependencies>
        <!-- https://mvnrepository.com/artifact/junit/junit -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.11</version>
            <scope>test</scope>
        </dependency>

    </dependencies>
</project>
~~~