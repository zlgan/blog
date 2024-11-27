

# 系统信息查看

## 查看发行版信息
```bash
suse01:/ # cat /etc/os-release 
NAME="openSUSE Leap"
VERSION="15.5"
ID="opensuse-leap"
ID_LIKE="suse opensuse"
VERSION_ID="15.5"
PRETTY_NAME="openSUSE Leap 15.5"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:opensuse:leap:15.5"
BUG_REPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://www.opensuse.org/"
DOCUMENTATION_URL="https://en.opensuse.org/Portal:Leap"
LOGO="distributor-logo-Leap"
```
# 网络接口配置

```bash
  ip addr  #显示网络接口信息
  sudo ip addr add 192.168.0.11/24 dev eth0 #在eth0网卡上添加ip
  sudo ip delete add 192.168.0.11/24 dev eth0 #在eth0网卡上删除ip
  sudo ip link set dev eth0 up #开启网卡
  sudo ip link set dev eth0 down #关闭网卡
  sudo ip link set dev eth0 promisc on #开启网卡混杂模式
  sudo ip link set dev eth0 promisc off #关闭网卡混杂模式
  sudo ip link set dev eth0 mtu 1500 #设置网卡最大传输单元
  sudo ip link set dev eth0 txqueuelen 1000 #设置网卡发送队列长度
  sudo ip link set dev eth0 address 00:00:00:00:00:00 #设置网卡MAC地址
  sudo ip link set dev eth0 master br0 #将网卡eth0加入网桥br0
  sudo ip link set dev eth0 nomaster #将网卡eth0从网桥br0中移除
  sudo ip link set dev eth0 type vlan id 10 #将网卡eth0设置为VLAN模式，并设置VLAN ID为10  
```
  ## 命令行查看网络配置信息
  ```bash
  ip addr show  #显示网络接口信息
  ip route show  #显示路由表信息
  ip link show  #显示网络接口信息
  ip neighbor show  #显示ARP/NDISC表信息
  ip maddr show  #显示组播地址表信息
  ip monitor  #实时监控网络接口信息
  ip netstat  #显示网络连接信息
  ```

  ## 配置ip
  /etc/sysconfig/network/ifcfg-eth0

  ```bash
  IPADDR=192.168.1.11
  NETMASK=255.255.255.0
  ```
## 配置网关
/etc/sysconfig/network/routes
```bash
default 192.168.1.1 --
```
2. 系统管理工具：Yast

```bash
#查看端口占用情况
ss -tuln
lsof -i -P -n

#关闭防火墙
sudo systemctl stop firewalld
sudo systemctl disable firewalld

```

=======

## 配置DNS
/etc/resolv.conf
```bash
nameserver 8.8.8.8 
```


# OpenSUSE Linux 查看防火墙配置
```bash
SuSEfirewall2 status #查看防火墙设置
SuSEfirewall2 start #启用防火墙
SuSEfirewall2 stop #禁用防火墙
SuSEfirewall2 restart #重启防火墙
SuSefirewall2 show #查看防火墙规则
SuSEfirewall2 status #查看防火墙状态
```
修改防火墙配置规则：/etc/sysconfig/SuSEfirewall2 

# 端口查看 ss（Socket Statistics）/netstat
```bash
ss -t #TCP连接
ss -u #UDP链接
ss -l #监听状态
ss -a #所有状态
ss -n #ip地址和端口号以数字形式显示

显示所有具有特定本地或远程地址的连接：
ss dst 192.168.1.100
ss src 10.0.0.1
显示与指定进程ID相关联的连接：
ss -p pid 1234

netstat -a #显示所有端口
netstat -t #tcp端口 
netstat -u #显示所有UDP端口
netstat -l #仅显示监听端口
netstat -pl #显示所有端口和进程ID
netstat -r #显示路由表信息
netstat -s #显示网络统计信息
netstat -tunlp | grep 8080 #查看8080端口
netstat -tunlp 
netstat -anp | grep 8080 #查看8080端口  
```

# 用户管理：
  sudo id 显示当前登录用户
  sudo passwd 修改密码

# 软件包管理：

## zypper命令详解

```bash
zypper lr #列出源仓库列表
zypper clean #删除zypper下载的安装包缓存和安装包的元数据缓存
zypper refresh # 刷新zypper软件包缓存和元数据缓存
zypper update # 更新
zypper ps #命令用于显示在 SUSE 系统上当前正在运行的进程和与之相关的软件包信息
zypper info <package_name> #查看某个已安装软件包的详细信息
zypper list-updates #查询已安装的软件包中有哪些可以更新
sudo zypper install /path/to/package.rpm #安装已经下载rpm包
#查看已安装的软件包
DEVMSSUSESVR11:~ #zypper se --installed-only mongo
Reading installed packages...

S  | Name        | Summary             | Type
---+-------------+---------------------+--------
i+ | mongodb-mms | MongoDB Ops Manager | package

```

```shell
zypper addrepo -f http://mirrors.aliyun.com/opensuse/distribution/leap/15.5/repo/oss/ openSUSE-15.5-Oss 
zypper addrepo -f http://mirrors.aliyun.com/opensuse/update/leap/15.5/oss openSUSE-15.5-Update-Oss
zypper addrepo -f https://mirrors.aliyun.com/opensuse/distribution/openSUSE-current/repo/non-oss/ ali-opensuse-current-dist-non-oss
zypper addrepo -f https://mirrors.aliyun.com/opensuse/distribution/openSUSE-current/repo/oss/ ali-opensuse-current-dist-oss 



sudo zypper mr -d repo-oss
sudo zypper mr -d repo-non-oss
sudo zypper mr -d repo-update
sudo zypper mr -d repo-update-non-oss

```





## rpm管理

-`q`: query（查询），用于查询软件包。
-`a`: all（所有），用于查询所有已安装的软件包。
-`l`: list（列出），用于列出指定软件包安装的所有文件

**`-i`**: info（信息），用于显示软件包的详细信息

```bash
#查询已安装的软件包
suse02:/etc # rpm -qa | grep mongodb
mongodb-enterprise-database-tools-extra-7.0.12-1.suse15.x86_64
mongodb-mongosh-2.2.13-1.el8.x86_64
mongodb-database-tools-100.10.0-1.x86_64
mongodb-enterprise-server-7.0.12-1.suse15.x86_64
mongodb-enterprise-7.0.5-1.suse15.x86_64
mongodb-enterprise-mongos-7.0.12-1.suse15.x86_64
mongodb-enterprise-database-7.0.12-1.suse15.x86_64
mongodb-enterprise-tools-7.0.12-1.suse15.x86_64
mongodb-enterprise-cryptd-7.0.12-1.suse15.x86_64

#查询某个软件包的文件路径
suse02:/etc # rpm -qli mongodb-mongosh-2.2.13-1.el8.x86_64
Name        : mongodb-mongosh
Version     : 2.2.13
Release     : 1.el8
Architecture: x86_64
Install Date: Sat Jul 27 21:17:20 2024
Group       : Development/Tools
Size        : 260781970
License     : ASL 2.0 and Proprietary
Signature   : RSA/SHA256, Thu Jul 25 23:01:41 2024, Key ID 160d26bb1785ba38
Source RPM  : mongodb-mongosh-2.2.13-1.el8.src.rpm
Build Date  : Thu Jul 25 00:46:32 2024
Build Host  : ip-10-128-186-1.ec2.internal
Relocations : (not relocatable)
URL         : https://github.com/mongodb-js/mongosh
Summary     : MongoDB Shell CLI REPL Package
Description :
MongoDB Shell CLI REPL Package
Distribution: (none)
/usr/bin/mongosh
/usr/lib64/mongosh_crypt_v1.so
/usr/share/doc/mongodb-mongosh
/usr/share/doc/mongodb-mongosh/.sbom.json
/usr/share/doc/mongodb-mongosh/README
/usr/share/doc/mongodb-mongosh/THIRD_PARTY_NOTICES
/usr/share/licenses/mongodb-mongosh
/usr/share/licenses/mongodb-mongosh/LICENSE-crypt-library
/usr/share/licenses/mongodb-mongosh/LICENSE-mongosh
/usr/share/man/man1/mongosh.1.gz

```

# 应用

## 通过nfs挂载远程仓库

### 服务器配置

```bash
#安装 NFS 服务端
zypper install nfs-kernel-server
systemctl start nfsserver
systemctl enable nfsserver

#配置共享目录
#编辑文件 /etc/exports，写入
/data/repo  *(ro,sync,no_subtree_check)

#重新加载 NFS 配置
exportfs -r

#要共享的文件拷贝到 /data/repo 目录

```

### 客户端配置

```bash
#安装nfs客户端
zypper install nfs-client

# 创建一个挂载点并挂载
mkdir -p /mnt/repo
mount suse02:/srv/repo /mnt/repo

# 将本地目录添加到zypper仓库
zypper ar file:///mnt/repo local_repo
zypper ref

# 从制定仓库安装
zypper install --from local_repo zsh
```



