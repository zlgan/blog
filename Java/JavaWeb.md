---
title: JavaWeb
date: 2021-06-27 07:36:18
tags:
categories: Java
---

### Tomcat

1. 从[官网](http://tomcat.apache.org)下载，解压即可

2. 目录结构

```bash
PS D:\Program Files\Tomcat\apache-tomcat-10.0.7> ls|select Mode,Name

Mode   Name
----   ----
d----- bin #关闭启动服务器的脚本和工具
d----- conf #服务器配置信息
d----- lib #引用的jar包
d----- logs
d----- temp
d----- webapps # 存放网站文件
d----- work
-a---- BUILDING.txt 
-a---- CONTRIBUTING.md
-a---- LICENSE
-a---- NOTICE
-a---- README.md
-a---- RELEASE-NOTES
-a---- RUNNING.txt

```

3. Tomcat自带的实例代码

![image-20210628220442123](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210628220442123.png)

### Maven

#### 1.作用

- 项目架构管理, 使用约定的规则来组织Java项目结构
- Jar的依赖管理
- 项目生命周期管理工具（編譯，測試，打包，安裝，推送到倉庫）

#### 2.下载地址

[Maven下载地址列表](https://archive.apache.org/dist/maven/maven-3/)

#### 3.配置Maven环境变量

```powershell
PS D:\workspace> ls env: |where value -Like *maven*

Name                           Value
----                           -----
M2_HOME                        D:\Program Files\apache-maven-3.6.1\bin
MAVEN_HOME                     D:\Program Files\apache-maven-3.6.1
#將MAVEN_HOME\bin加入到Path环境变量
path2                          C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\Syste...


# 测试Maven是否安装配置成功
PS D:\workspace> mvn -version
Apache Maven 3.6.1 (d66c9c0b3152b2e69ee9bac180bb8fcc8e6af555; 2019-04-05T03:00:29+08:00)
Maven home: D:\Program Files\apache-maven-3.6.1\bin\..
Java version: 1.8.0_291, vendor: Oracle Corporation, runtime: C:\Program Files\Java\jdk1.8.0_291\jre
Default locale: zh_SG, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
PS D:\workspace>
```

#### 4.设置阿里云的镜像仓库

1. 打开: %Maven_Home%\conf\setting.xml
2. 加入阿里云镜像

``` xml
	 <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>central</mirrorOf>
     <name>阿里云公共仓库</name>
     <url>https://maven.aliyun.com/repository/central</url>
    </mirror>
```

3.设置本地仓库

``` xml
<localRepository>D:\Program Files\maven-repo</localRepository>
```



#### 5.IDEA中使用Maven

![image-20210704184914160](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210704184914160.png)

![image-20210704185328625](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210704185328625.png)

```powershell
#Maven 控制台的输出
[IO] --- maven-archetype-plugin:3.2.0:generate (default-cli) @ standalone-pom ---
[INFO] Generating project in Batch mode
[WARNING] No archetype found in remote catalog. Defaulting to internal catalog
[INFO] Archetype repository not defined. Using the one from [org.apache.maven.archetypes:maven-archetype-webapp:1.0] found in catalog internal
Downloading from aliyunmaven: https://maven.aliyun.com/nexus/content/groups/public/org/apache/maven/archetypes/maven-archetype-webapp/maven-metadata.xml
Downloaded from aliyunmaven: https://maven.aliyun.com/nexus/content/groups/public/org/apache/maven/archetypes/maven-archetype-webapp/maven-metadata.xml (557 B at 746 B/s)
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Archetype: maven-archetype-webapp:RELEASE
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: groupId, Value: org.example
[INFO] Parameter: artifactId, Value: untitled1
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] Parameter: package, Value: org.example
[INFO] Parameter: packageInPathFormat, Value: org/example
[INFO] Parameter: package, Value: org.example
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] Parameter: groupId, Value: org.example
[INFO] Parameter: artifactId, Value: untitled1
[INFO] Project created from Archetype in dir: C:\Users\Administrator\AppData\Local\Temp\archetypetmp\untitled1
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.034 s
[INFO] Finished at: 2021-07-04T18:56:28+08:00
[INFO] ------------------------------------------------------------------------

Process finished with exit code 0
```



``` powershell
#使用Maven创建的Java项目的默认目录结构
PS E:\Study\Java\MavenTest\untitled1> tree  /f
卷 Work 的文件夹 PATH 列表
卷序列号为 0AC3-0CE6
E:.
│  pom.xml
│
├─.idea
│      .gitignore
│      compiler.xml
│      jarRepositories.xml
│      misc.xml
│      workspace.xml
│
└─src
    └─main
        └─webapp
            │  index.jsp
            │
            └─WEB-INF
                    web.xml
                    
# 本地仓库默认下载的Jar包

PS D:\Program Files\maven-repo> ls
    目录: D:\Program Files\maven-repo
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----       28/6/2021  下午 11:38                antlr
d-----       28/6/2021  下午 11:38                asm
d-----       28/6/2021  下午 11:39                avalon-framework
d-----       28/6/2021  下午 11:38                backport-util-concurrent
d-----       28/6/2021  下午 11:37                classworlds
d-----       28/6/2021  下午 11:40                com
d-----       28/6/2021  下午 11:39                commons-beanutils
d-----       28/6/2021  下午 11:39                commons-chain
d-----       28/6/2021  下午 11:38                commons-cli
d-----       28/6/2021  下午 11:37                commons-codec
d-----       28/6/2021  下午 11:37                commons-collections
d-----       28/6/2021  下午 11:39                commons-digester
d-----       28/6/2021  下午 11:37                commons-io
d-----       28/6/2021  下午 11:37                commons-lang
d-----       28/6/2021  下午 11:39                commons-logging
d-----       28/6/2021  下午 11:39                commons-validator
d-----       28/6/2021  下午 11:39                dom4j
d-----       28/6/2021  下午 11:39                javax
d-----       28/6/2021  下午 11:37                junit
d-----       28/6/2021  下午 11:38                log4j
d-----       28/6/2021  下午 11:39                logkit
d-----       29/6/2021  下午 11:15                net
d-----       28/6/2021  下午 11:40                org
d-----       28/6/2021  下午 11:39                oro
d-----       28/6/2021  下午 11:39                sslext
d-----       28/6/2021  下午 11:39                xerces
d-----       28/6/2021  下午 11:39                xml-apis
d-----       28/6/2021  下午 11:40                xmlpull
d-----       28/6/2021  下午 11:40                xpp3

#查看Log4j的包结构
PS D:\Program Files\maven-repo\log4j> tree /f
卷 Apps 的文件夹 PATH 列表
卷序列号为 8C52-7680
D:.
└─log4j
    └─1.2.12
            log4j-1.2.12.jar
            log4j-1.2.12.jar.sha1
            log4j-1.2.12.pom
            log4j-1.2.12.pom.sha1
            _remote.repositories

```

Maven的基本配置

![image-20210704191036143](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210704191036143.png)

### Servlet

