---
title: RPM包管理
date: 10/04/2021 16:58:42
tags: 
categories: Linux
---
###  查看yum全局配置

```bash
[root@node11 test]# cat /etc/yum.conf 
[main]
gpgcheck=1 #是否检查GPG(GNU Private Guard)，一种密钥方式签名
installonly_limit=3 #允许保留多少个内核包
clean_requirements_on_remove=True
best=True
skip_if_unavailable=False
```

### yum源配置

####  查看本机yum源

```bash
#通过配置文件查询 
[root@node11 test]# ll /etc/yum.repos.d/
总用量 48
-rw-r--r--. 1 root root  719 11月  9 2020 CentOS-Linux-AppStream.repo
-rw-r--r--. 1 root root  704 11月  9 2020 CentOS-Linux-BaseOS.repo
-rw-r--r--. 1 root root 1130 11月  9 2020 CentOS-Linux-ContinuousRelease.repo
-rw-r--r--. 1 root root  318 11月  9 2020 CentOS-Linux-Debuginfo.repo
-rw-r--r--. 1 root root  732 11月  9 2020 CentOS-Linux-Devel.repo
-rw-r--r--. 1 root root  704 11月  9 2020 CentOS-Linux-Extras.repo
-rw-r--r--. 1 root root  719 11月  9 2020 CentOS-Linux-FastTrack.repo
-rw-r--r--. 1 root root  740 11月  9 2020 CentOS-Linux-HighAvailability.repo
-rw-r--r--. 1 root root  693 11月  9 2020 CentOS-Linux-Media.repo
-rw-r--r--. 1 root root  706 11月  9 2020 CentOS-Linux-Plus.repo
-rw-r--r--. 1 root root  724 11月  9 2020 CentOS-Linux-PowerTools.repo
-rw-r--r--. 1 root root  898 11月  9 2020 CentOS-Linux-Sources.repo

#通过命令行查看
[root@node11 test]# yum repolist all
仓库标识                 仓库名称                                                     状态
appstream                CentOS Linux 8 - AppStream                                   启用
appstream-source         CentOS Linux 8 - AppStream - Source                          禁用
baseos                   CentOS Linux 8 - BaseOS                                      启用
baseos-source            CentOS Linux 8 - BaseOS - Source                             禁用
cr                       CentOS Linux 8 - ContinuousRelease                           禁用
debuginfo                CentOS Linux 8 - Debuginfo                                   禁用
devel                    CentOS Linux 8 - Devel WARNING! FOR BUILDROOT USE ONLY!      禁用
extras                   CentOS Linux 8 - Extras                                      启用
extras-source            CentOS Linux 8 - Extras - Source                             禁用
fasttrack                CentOS Linux 8 - FastTrack                                   禁用
ha                       CentOS Linux 8 - HighAvailability                            禁用
media-appstream          CentOS Linux 8 - Media - AppStream                           禁用
media-baseos             CentOS Linux 8 - Media - BaseOS                              禁用
plus                     CentOS Linux 8 - Plus                                        禁用
plus-source              CentOS Linux 8 - Plus - Source                               禁用
powertools               CentOS Linux 8 - PowerTools                                  禁用

#查看启用的yum源
[root@node11 test]# yum repolist enabled 
仓库标识                                   仓库名称
appstream                                  CentOS Linux 8 - AppStream
baseos                                     CentOS Linux 8 - BaseOS
extras                                     CentOS Linux 8 - Extras
```

#### yum源文件设置

```bash
[root@node11 test]# cat /etc/yum.repos.d/CentOS-Linux-BaseOS.repo 
# CentOS-Linux-BaseOS.repo
#
# The mirrorlist system uses the connecting IP address of the client and the
# update status of each mirror to pick current mirrors that are geographically
# close to the client.  You should use this for CentOS updates unless you are
# manually picking other mirrors.
#
# If the mirrorlist does not work for you, you can try the commented out
# baseurl line instead.

[baseos] 
name=CentOS Linux $releasever - BaseOS # 源名称
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=BaseOS&infra=$infra # 镜像地址
#baseurl=http://mirror.centos.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

```

### 更换阿里云的yum源

```bash
#1.查看操作系统的发行版本
[root@node11 ~]# cat /etc/redhat-release 
CentOS Linux release 8.3.2011

#2.在阿里云的镜像服务器下载对应的Repo文件 http://mirrors.aliyun.com/repo/

[root@node11 ~]# wget http://mirrors.aliyun.com/repo/Centos-8.repo
--2021-10-01 11:18:34--  http://mirrors.aliyun.com/repo/Centos-8.repo
正在解析主机 mirrors.aliyun.com (mirrors.aliyun.com)... 36.159.55.219, 117.187.22.240, 117.187.22.244, ...
正在连接 mirrors.aliyun.com (mirrors.aliyun.com)|36.159.55.219|:80... 已连接。
已发出 HTTP 请求，正在等待回应... 200 OK
长度：2595 (2.5K) [application/octet-stream]
正在保存至: “Centos-8.repo”

#3.备份Base源
[root@node11 ~]# mv /etc/yum.repos.d/CentOS-Linux-BaseOS.repo  /etc/yum.repos.d/CentOS-Linux-BaseOS.repo.bak

#4.用阿里云的源替换Base源的文件
[root@node11 ~]# mv Centos-8.repo /etc/yum.repos.d/CentOS-Linux-BaseOS.repo

#5.清理本地缓存（rpm包的元数据信息）
[root@node11 ~]# yum clean all 

#6.重建缓存
[root@node11 ~]# yum makecache 
```



### 查询rpm包信息

```bash
#显示基本信息
[root@node11 test]# yum list nginx
上次元数据过期检查：0:36:37 前，执行于 2021年10月01日 星期五 09时22分09秒。
已安装的软件包
nginx.x86_64                    1:1.14.1-9.module_el8.0.0+184+e34fea82  @appstream 

#显示详细信息
[root@node11 test]# yum info nginx 
上次元数据过期检查：0:36:53 前，执行于 2021年10月01日 星期五 09时22分09秒。
已安装的软件包
名称         : nginx
时期         : 1
版本         : 1.14.1
发布         : 9.module_el8.0.0+184+e34fea82
架构         : x86_64
大小         : 1.7 M
源           : nginx-1.14.1-9.module_el8.0.0+184+e34fea82.src.rpm
仓库         : @System
来自仓库     : appstream
概况         : A high performance web server and reverse proxy server
URL          : http://nginx.org/
协议         : BSD
描述         : Nginx is a web server and a reverse proxy server for HTTP, SMTP, POP3 and
             : IMAP protocols, with a strong focus on high concurrency, performance and low
             : memory usage.
```

### 安装rpm包

```bash
#安装Redis -y 静默安装
[root@node11 ~]# yum -y install redis  
#查找安装路径信息
[root@node11 ~]# rpm -ql redis 
/etc/logrotate.d/redis
/etc/redis-sentinel.conf
/etc/redis.conf
/etc/systemd/system/redis-sentinel.service.d
/etc/systemd/system/redis-sentinel.service.d/limit.conf
/etc/systemd/system/redis.service.d
/etc/systemd/system/redis.service.d/limit.conf
/usr/bin/redis-benchmark
/usr/bin/redis-check-aof
/usr/bin/redis-check-rdb
/usr/bin/redis-cli
/usr/bin/redis-sentinel
/usr/bin/redis-server
/usr/lib/.build-id
/usr/lib/.build-id/50
/usr/lib/.build-id/50/faa29d15513db4515d3ac62c86fac3b940abc2
/usr/lib/.build-id/59
/usr/lib/.build-id/59/c0804d7145f96ebdc7a61ee95631a619928910
/usr/lib/.build-id/a4
/usr/lib/.build-id/a4/795de9232bc97eac0fe26c8fef616d6268e10d
/usr/lib/systemd/system/redis-sentinel.service
/usr/lib/systemd/system/redis.service
/usr/lib64/redis
/usr/lib64/redis/modules
/usr/libexec/redis-shutdown
/usr/share/licenses/redis
/usr/share/licenses/redis/COPYING
/usr/share/licenses/redis/COPYING-hiredis
/usr/share/licenses/redis/COPYING-jemalloc
/usr/share/licenses/redis/COPYRIGHT-lua
/usr/share/man/man1/redis-benchmark.1.gz
/usr/share/man/man1/redis-check-aof.1.gz
/usr/share/man/man1/redis-check-rdb.1.gz
/usr/share/man/man1/redis-cli.1.gz
/usr/share/man/man1/redis-sentinel.1.gz
/usr/share/man/man1/redis-server.1.gz
/usr/share/man/man5/redis-sentinel.conf.5.gz
/usr/share/man/man5/redis.conf.5.gz
/var/lib/redis
/var/log/redis
/var/run/redis

#列出资源库中特定的可以安装或更新以及已经安装的rpm包
yum list

#列出资源库中所有可以更新的rpm包
yum list updates

#列出已经安装的所有的rpm包
yum list installed

```


```bash
#查看安装的组件
suse02:/etc # rpm -qa |grep mongo
mongodb-enterprise-database-tools-extra-7.0.12-1.suse15.x86_64
mongodb-mongosh-2.2.13-1.el8.x86_64
mongodb-database-tools-100.10.0-1.x86_64
mongodb-enterprise-server-7.0.12-1.suse15.x86_64
mongodb-enterprise-7.0.5-1.suse15.x86_64
mongodb-enterprise-mongos-7.0.12-1.suse15.x86_64
mongodb-enterprise-database-7.0.12-1.suse15.x86_64
mongodb-enterprise-tools-7.0.12-1.suse15.x86_64
mongodb-enterprise-cryptd-7.0.12-1.suse15.x86_64

#查看软件包信息和安装路径
suse02:/etc # rpm -qil mongodb-enterprise-server-7.0.12-1.suse15.x86_64
Name        : mongodb-enterprise-server
Version     : 7.0.12
Release     : 1.suse15
Architecture: x86_64
Install Date: Sat Jul 27 21:17:05 2024
Group       : Applications/Databases
Size        : 188180930
License     : Commercial
Signature   : RSA/SHA256, Sat Jun 29 04:05:52 2024, Key ID 160d26bb1785ba38
Source RPM  : mongodb-enterprise-database-7.0.12-1.suse15.src.rpm
Build Date  : Wed Jun 26 03:21:45 2024
Build Host  : ip-10-128-153-135.ec2.internal
Relocations : /usr /var /etc 
URL         : http://www.mongodb.org
Summary     : MongoDB database server (enterprise)
Description :
MongoDB is built for scalability, performance and high availability, scaling from single server deployments to large, complex multi-site architectures. By leveraging in-memory computing, MongoDB provides high performance for both reads and writes. MongoDB’s native replication and automated failover enable enterprise-grade reliability and operational flexibility.

MongoDB is an open-source database used by companies of all sizes, across all industries and for a wide variety of applications. It is an agile database that allows schemas to change quickly as applications evolve, while still providing the functionality developers expect from traditional databases, such as secondary indexes, a full query language and strict consistency.

MongoDB has a rich client ecosystem including hadoop integration, officially supported drivers for 10 programming languages and environments, as well as 40 drivers supported by the user community.

MongoDB features:
* JSON Data Model with Dynamic Schemas
* Auto-Sharding for Horizontal Scalability
* Built-In Replication for High Availability
* Rich Secondary Indexes, including geospatial
* TTL indexes
* Text Search
* Aggregation Framework & Native MapReduce

This package contains the MongoDB server software, default configuration files, and systemd service files.
Distribution: (none)
/etc/mongod.conf
/run/mongodb
/usr/bin/mongod
/usr/lib/systemd/system/mongod.service
/usr/share/doc/packages/mongodb-enterprise-server
/usr/share/doc/packages/mongodb-enterprise-server/LICENSE-Enterprise.txt
/usr/share/doc/packages/mongodb-enterprise-server/MPL-2
/usr/share/doc/packages/mongodb-enterprise-server/README
/usr/share/doc/packages/mongodb-enterprise-server/THIRD-PARTY-NOTICES
/usr/share/man/man1/mongod.1.gz
/usr/share/man/man5/mongodb-parameters.5.gz
/var/lib/mongo
/var/log/mongodb
/var/log/mongodb/mongod.log


```

