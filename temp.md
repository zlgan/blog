--EDA
https://aws.amazon.com/cn/what-is/eda/
https://solace.com/what-is-event-driven-architecture/
https://www.redhat.com/en/topics/integration/what-is-an-event-mesh

--设置变量风格
https://dotnetthoughts.net/customize-create-and-initialize-field/

Sync call Async
https://www.cnblogs.com/yuanshuo/p/13807557.html
haha
xixi
hehe
1111

https://docs.github.com/zh


# develop app
- https://32a3058a.isolation.zscaler.com/profile/9160b3a5-1571-41d2-a091-3762f83cdc25/zia-session/?controls_id = d90c6343-5842-4bb5-a982-43a9ae951f9f&region = sin&tenant = 29ce959a9fd0&user = a2119ee0529d2dc4e2c92f29946a5d04f381ba599e9de9ea28d1df7d7e22c2ea&original_url = https%3A%2F%2Fkotlin.liying-cn.net%2Fdocs%2Freference_zh%2Fcross-platform-frameworks.html&key = sh-1&hmac = ff7c821687a31f68eedf608e4f89847b5b09a3c08c23dc3169365e4bc62e9168
- alipay, wechat pay api intergress
- app+ wechat tiny app
- https://flutter.cn/docs
- http://chuquan.me/2018/08/26/graphics-rending-principle-gpu/
- 
# recent topic
- xunit test host
- azure notification hub
- OAuth 2.0
- review dotnet core 6-8 new features
# google fcm migration
- https://firebase.google.com/docs/cloud-messaging/migrate-v1?hl = zh-cn
- https://learn.microsoft.com/zh-cn/azure/notification-hubs/notification-hubs-gcm-to-fcm#migration-steps

# tiny tools
- drawio
    - draw flow chat : https://app.diagrams.net/?splash = 0&ui = sketch
    - https://www.drawio.com/doc/


# 20231201
刷新视图：
EXEC sp_refreshview 'vw_mc_user_achievement';

- 阿里技术专家详解 DDD 系列文章整理成 PDF 文件
    - 使用特性来对数据格式做基本校验
    - DDD 中如何进行业务规则的校验
    - 什么是代码遵循了 DRY 原则和单一性原则
# 20231204
宏观架构比如 SOA 架构、微服务架构，应用内部的架构设计，如 DDD
什么是数据库分片：https://aws.amazon.com/cn/what-is/database-sharding/
列出项目中所有的 nuget 包：dotnet list package 
DDD 中各个层次对象的：各个层次对象之间使用 AutoMapper 转换
- UI：DTO
- Domain：Entity，ValueObject
- DB：DataObject（DO）
Auto mapper 文档: https://docs.automapper.org/en/latest/Getting-started.html
DDD 设计心得：
- 识别系统当中的所有 Entity 和 VO
- 当一个业务逻辑设计多个 Enity 和 VO 的协作和交互，需要使用 Domain Servie 来实现
- Entity、VO 和 Domain Service 封装所有的业务逻辑
- 依赖外部系统的功能时，使用防腐层 ACL, 一般使用适配器来协调内外接口的不一致的情况。
- Entity 状态的初始化：
   - 对于 Entity 生命周期开始的时候应该初始化，并且不会发生变化的状态应该是用构造函数初始化
   - 对于其他情况应该是用 Set 函数初始化（例如 status 状态的更新）
- Domain service VS Application
  - 领域服务（Domain Service）：如果该业务逻辑属于领域的核心业务，与实体的状态和行为紧密相关，而且不适合放在单个实体内部，可以将其放到领域服务中。领域服务负责处理领域内的复杂业务逻辑，跨越多个实体和值对象，确保领域的一致性和完整性。
  - 应用层（Application Layer）：如果该业务逻辑不属于领域的核心业务，而是属于应用程序的协调和处理部分，可以将其放到应用层中。应用层负责接收用户输入，协调领域对象的调用，处理业务流程，并将结果返回给表示层。它通常与用户界面或外部系统交互，并处理一些应用层的特定逻辑。
  - 一个 Application 接口代表的是一个业务用例
# 20231205
修改远程仓库

1. dotnet build runtime
2. 返回 task 不带 async?
3. Parallel.ForEach
4. order by guid()?
5. 字符串常量还是枚举？
6. ConfigurationProvider 里面是否可以使用注入 option ?
7. .GetAwaiter().GetResult();
8. 
# 20231213
设置 windodws 输入法快捷键参考： https://support.hp.com/hk-zh/document/c01349985
vscode 重构小技巧之代码包裹：
1. ctrl+. 打开建议菜单
2. 选择 surround with snippet（用片段包围）
ctrl+z 撤销
ctrl+y 反撤销（重做）
按鼠标中键，可以选择多列

git 删除未跟踪文件

# 删除 untracked files
git clean -f 
连 untracked 的目录也一起删掉
git clean -fd
连 gitignore 的 untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o 之类的文件用的）
git clean -xfd 
在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
git clean -nxfd
git clean -nf
git clean -nfd

重构：
https://code.visualstudio.com/docs/csharp/refactoring
1. F2  重命名
2. ctrl+.
   1. 将一段代码提取到方法
   2. 将一段代码包裹在语句中
   3. 将字符串提取到常量
   4. 调用异步方法自动加 await
   5. 选中属性生成构造函数
   6. 将属性添加到构造函数
   7. 添加缺少的引用
   8. 隐士类型与显示类型之间转换
   9. convert between for and foreach
    xunit 集成测试原理
       https://learn.microsoft.com/zh-cn/aspnet/core/test/integration-tests?view = aspnetcore-6.0

# 20231215

git tag -l " GamificationService*" --sort =-creatordate
OOD 设计原则：Liskov substitution principle
在讲 DDD 的解法前，我们先去看看一套游戏里最近比较火的架构设计，Entity-Component-System（ECS）是如何实现的。
Type Object 设计模式
code  --list-extensions 列出所有已安装的扩展

# 20231219
https://cli.github.com/manual/

# 20231225

1. drawio 快捷键 https://app.diagrams.net/shortcuts.svg

# 20231226

# CQRS 的四层架构
## presentation
  - dependency
    1. application
    2. domain
    3. infrastructure
  - code orgnazation
  - 职责
    1. 用户接口层负责向用户显示信息和解释用户指令。这里的用户可能是：用户、程序、自动化测试和批处理脚本等等
## application
  - dependecy
    1. domain
    2. infrastructure
  - code orgnaztion
    1. commands
    2. queries
    3. domainEventHandlers
  - 职责
    1. 协调多个聚合的服务和领域对象完成服务编排和组合，协作完成业务操作
    2. 行安全认证、权限校验、事务控制、发送或订阅领域事件
## domain
  - code orgnaztion

    2. seedwork
    4. AggregatesModel
    1. events
    5. exceptions
    6. services
  - 职责
  1. 现企业核心业务逻辑表达业务概念、业务状态和业务规则

## infrastructure
  - repositories

  - 职责
  1. 为其它各层提供通用的技术和基础服务

## ddd 实战课程
https://zq99299.github.io/note-book2/ddd/


https://www.bilibili.com/video/BV1k7411A7p6/

https://github.com/dotnet/extensions/releases


# 20240108
1. git revert 

git 查找两个分支的共同节点
https://blog.csdn.net/qq_20817327/article/details/117817160

# 20240129
https://www.qwertee.io/blog/postgresql-b-tree-index-explained-part-1/


# 20240325
1. 解决虚拟机账号问题 
2. 创建一个 SUSE 系统的虚拟机
3. Linux 目录的参考标准：https://www.pathname.com/fhs/pub/fhs-2.3.pdf
4. 配置 ssh 登录 nas
5. 利用 ChatGTP 重构知识体系
6. 搭建 DNS，活动目录 AD，域控制器
7. ladp 协议 ：https://www.openldap.org/doc/admin26/
8. Kerberos 认证：https://seevae.github.io/2020/09/12/%E8%AF%A6%E8%A7%A3kerberos%E8%AE%A4%E8%AF%81%E6%B5%81%E7%A8%8B/
9. 研究 LADP，Kerbers 身份认证
10. 部署 splunk 日志系统研究一下
11. https://docs.docker.com/
12. vmrun 从命令行控制虚拟机.
    https://docs.vmware.com/cn/VMware-Fusion/13/com.vmware.fusion.using.doc/GUID-FF306A59-080E-497E-857D-F45125927FB3.html
13. 研究鸿蒙 os 与安卓的差异
14. 学习 linux&bash

停止 windows 防火墙服务 mpssvc
https://learn.microsoft.com/en-us/answers/questions/64486/disable-windows-firewall-on-2k19?page = 2#answers


## zypper 的使用 
```bash
zypper lr #列出源仓库列表
zypper clean #删除zypper下载的安装包缓存和安装包的元数据缓存
zypper refresh # 刷新zypper软件包缓存和元数据缓存
zypper update # 更新
zypper ps #命令用于显示在 SUSE 系统上当前正在运行的进程和与之相关的软件包信息
zypper info <package_name> #查看某个已安装软件包的详细信息
zypper list-updates #查询已安装的软件包中有哪些可以更新
sudo zypper install /path/to/package.rpm #安装已经下载rpm包
```

linux 系统信息查询：
https://cloud.tencent.com/developer/article/1926086



```bash
#开放防火墙端口
firewall-cmd --query-port=80/tcp（查看端口是否开放）
firewall-cmd --zone=public --add-port=80/tcp --permanent（设置80端口开放出来）
firewall-cmd --reload （重启防火墙，就可以使用了）
```

```bash

docker login -u leozlgan (gzl@10010312)
docker tag getting-started leozlgan/mytest:latest 
docker push leozlgan/mytest:latest

```
```bash

docker volume create to-do
docker volume ls 
docker volume inspect <volume-name> #view volume details

docker inspect <container_name> #view container details
```


```bash

docker network create todo-app
docker network inspect todo-app

docker run -d \
    --network todo-app --network-alias mysql \
    -v todo-mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=todos \
    mysql:8.0

docker exec -it <mysql-container-id> mysql -u root -p    
mysql> SHOW DATABASES;
mysql> exit

```

1. 安装 Docker Desktop 并尝试使用 k8s
2. linux 磁盘挂载研究？









# ldap

## openLDAP





# dns 服务器

## dnsmasq





# nginx 配置负载均衡

## OAuth 2.0

## OpenID Connect (OIDC)



IdentityServer4 



```



```


![aa..excalidraw](E:\workspace\blog\assets\aa..excalidraw.svg)
https://blog.csdn.net/qq_41813208/article/details/122310785
https://seevae.github.io/2020/09/12/%E8%AF%A6%E8%A7%A3kerberos%E8%AE%A4%E8%AF%81%E6%B5%81%E7%A8%8B/


nslookup 命令学习


PS E:\workspace > net config workstation
Computer name                       aaa
Full Computer name                   bb
User name                            aa


https://blog.csdn.net/qq_36279445/article/details/110647055


# 查看系统中所有模块
 $env: PSModulePath -split ";" |ls
Get-Module 是一个 PowerShell 命令，用于列出当前会话中已加载的所有模块









获取当前时间戳

[System.DateTimeOffset]::UtcNow.ToUnixTimeSeconds()





- openstack （Iaas 的框架)
- kubernetes（Paas的框架）



liveness : 存活检测，如果检测不通过则重启pod

readiness：就绪探针，对于未就绪的pod，防止service将流量导入到该pod

# 20241127
- meeting
https://events.mongodb.com/sparklingsoireehkjc

- vs2022 profile
https://learn.microsoft.com/zh-cn/visualstudio/profiling/instrumentation?view=vs-2022&wt.mc_id=visualstudio_inproduct_aka_vs17instrumentationtool







本地认证

NTLMHash(password)== sam

工作组计算机认证

NTLMV2 Challenge/Reponse

- 协议版本协商 NTLMv1 or  NTMLv2
- client 发送用户名到server
- server
  -  NTLM Hash(Challenge)=challenge1 
  - 发送challenge到clent
- client 使用密码生成NTLM Hash并且计算challenge的哈希，然后返回给server
- server 对比challenge1与client的响应，如果相同则通过，否则不通过

域计算机认证

![image-20241214135109898](E:\workspace\blog\assets\image-20241214135109898.png)

![image-20241214135232297](E:\workspace\blog\assets\image-20241214135232297.png)

 

![image-20241214135431704](E:\workspace\blog\assets\image-20241214135431704.png)

![image-20241214141407695](E:\workspace\blog\assets\image-20241214141407695.png)

![image-20241214141454765](E:\workspace\blog\assets\image-20241214141454765.png)




https://www.noi.cn/upload/resources/file/2023/03/15/1fa58eac9c412e01ce3c89c761058a43.pdf

https://hkoi.org/zh/cspjs-past-problems/


















