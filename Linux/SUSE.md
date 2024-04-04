# 网络接口配置

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

  ## 命令行查看网络配置信息
  ip addr show  #显示网络接口信息
  ip route show  #显示路由表信息
  ip link show  #显示网络接口信息
  ip neighbor show  #显示ARP/NDISC表信息
  ip maddr show  #显示组播地址表信息
  ip monitor  #实时监控网络接口信息
  ip netstat  #显示网络连接信息


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
SuSEfirewall2 status #查看防火墙设置
SuSEfirewall2 start #启用防火墙
SuSEfirewall2 stop #禁用防火墙
SuSEfirewall2 restart #重启防火墙
SuSefirewall2 show #查看防火墙规则
SuSEfirewall2 status #查看防火墙状态

修改防火墙配置规则：/etc/sysconfig/SuSEfirewall2 

# 端口查看 ss（Socket Statistics）
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

# netstat
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


# 用户管理：
  sudo id 显示当前登录用户
  sudo passwd 修改密码



# zypper的用法：


# YaST的用法
