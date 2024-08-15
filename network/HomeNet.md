---
title: 家庭网络拓扑
date: 2021-08-1 8:28:30
tags: 
categories: Network
---

# 家庭网络v1.0

由于装修的时候没有考虑网络规划，装修师傅根据个人经验，把房间和客厅分别拉了一根线到信息箱。中国移动的宽带师傅给我们家的网络连接是这样的

 ![image-20210801083504972](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801083504972.png)

这里面存在一些问题:

- 光猫本来设计的是光电信号转换的，这时候还要作为路由器负责内外网转换，效率不高，网络不稳定
- 本来办理的是移动300Mb套餐，光猫只有一个千兆口，其他都是百兆口，只有客厅的网络能跑满带宽，房间连接的百兆口，上网速度很不理想。

### 方案1

为了解决问题，考虑过如下这个方案，在光猫后面接一个千兆交换机，这样房间和客厅理论上都可以跑满300M带宽。但是没有解决上述的第一个问题，还是必要光猫拨号。为了达到更好的性能，放弃了这个方案。

![image-20210801084151953](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801084151953.png)

### 方案2

现在需要一台路由器拨号，而且还要能放入信息箱，再加上信息箱本身又被我家的一个柜子包裹，基本上不指望这个路由器的wifi信号，经过一番搜索，在京东上找到了一款这款有线的路由器，并且体积足够小。

![image-20210801085252168](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801085252168.png)

![image-20210801085318625](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801085318625.png)

这款路由器支带4个千兆LAN口，支持AC+Ap模式的组网。但是考虑到家里有几个路由器，没有买Ap面板，直接将路由器设置成AP模式，也就是将各个房间的路由器的LAN口连接有线路由器，然后修改LAN地址跟网关同一个网段。这样家里的所有设备都是在同一个局域网，方便共享文件。如是网络拓扑变成这样：客厅和房间的路由器wifi设置成相同的参数，经过测试发现手机可以在这两个区域实现漫游，但是不是无缝漫游不得而知。

![image-20210801084644488](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801084644488.png)

### 未来

上面的方案也有一些弊端，就是网关的工作负荷较大，在信息箱的散热也是要考虑的问题，这个没法解决。未来装修的时候可以考虑客厅到信息箱接入多根线，让拨号路由器放在客厅，然后通过另一个线接回信息箱，再经过交换机接入其他房间，这样做有两点好处：

- 交换机只负责房间的数据转发，负荷没那么大，散热问题可以大大缓解。
- 交换机也比路由器便宜。
- 将房间换成AP面板，实现真正的无缝漫游，并且时延很低。

![image-20210801090006538](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210801090006538.png)



# 家庭网络v2.0

![image-20240421072331047](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240421072331047.png)





常用dns：

120.196.165.24 

211.136.192.6



<Huawei > 用户视图

[Huawei] 系统视图

<Huawei>display current-configuration 

<Huawei>system-view 



#返回上一级视图

[Huawei]quit



[Huawei]interface e0/0/0



[Huawei]vlan 10

[Huawei-vlan10]display vlan

```
* : management-vlan
---------------------
The total number of vlans is : 2

VLAN ID Type         Status   MAC Learning Broadcast/Multicast/Unicast Property 
--------------------------------------------------------------------------------

1       common       enable   enable       forward   forward   forward default  
10      common       enable   enable       forward   forward   forward default
```



[Huawei]undo vlan 10



<Huawei>save 

```
<Huawei>save 
  The current configuration will be written to the device. 
  Are you sure to continue? (y/n)[n]:y
  It will take several minutes to save configuration file, please wait.......
  Configuration file had been saved successfully
  Note: The configuration file will take effect after being activated
<Huawei>
```



reboo 重启设备



重命名为net1

[Huawei]sysname net1

display this  #查看当前配置

undo ip add #删除ip配置



ip ？#显示ip命令的帮助

dir

```
<R3>dir 
Directory of flash:/

  Idx  Attr     Size(Byte)  Date        Time(LMT)  FileName 
    0  drw-              -  Apr 21 2024 09:26:04   dhcp
    1  -rw-        121,802  May 26 2014 09:20:58   portalpage.zip
    2  -rw-          2,263  Apr 21 2024 09:25:58   statemach.efs
    3  -rw-        828,482  May 26 2014 09:20:58   sslvpn.zip
    4  -rw-            352  Apr 21 2024 09:36:42   private-data.txt
    5  -rw-            592  Apr 21 2024 09:36:42   vrpcfg.zip

```





```
<R1>display ip routing-table 
Route Flags: R - relay, D - download to fib
------------------------------------------------------------------------------
Routing Tables: Public
         Destinations : 10       Routes : 10       

Destination/Mask    Proto   Pre  Cost      Flags NextHop         Interface

       20.1.1.0/24  Direct  0    0           D   20.1.1.1        GigabitEthernet
0/0/2
       20.1.1.1/32  Direct  0    0           D   127.0.0.1       GigabitEthernet
0/0/2
     20.1.1.255/32  Direct  0    0           D   127.0.0.1       GigabitEthernet
0/0/2
      127.0.0.0/8   Direct  0    0           D   127.0.0.1       InLoopBack0
      127.0.0.1/32  Direct  0    0           D   127.0.0.1       InLoopBack0
127.255.255.255/32  Direct  0    0           D   127.0.0.1       InLoopBack0
    192.168.0.0/24  Direct  0    0           D   192.168.0.1     GigabitEthernet
0/0/0
    192.168.0.1/32  Direct  0    0           D   127.0.0.1       GigabitEthernet
0/0/0
  192.168.0.255/32  Direct  0    0           D   127.0.0.1       GigabitEthernet
0/0/0
255.255.255.255/32  Direct  0    0           D   127.0.0.1       InLoopBack0

```





[R1]ip route-static 20.1.2.0 24 20.1.1.2  #配置静态路由







```
PC>ipconfig

Link local IPv6 address...........: fe80::5689:98ff:fe5b:2df1
IPv6 address......................: :: / 128
IPv6 gateway......................: ::
IPv4 address......................: 192.168.0.2
Subnet mask.......................: 255.255.255.0
Gateway...........................: 192.168.0.1
Physical address..................: 54-89-98-5B-2D-F1
DNS server........................:

PC>tracert 192.168.1.2

traceroute to 192.168.1.2, 8 hops max
(ICMP), press Ctrl+C to stop
 1  192.168.0.1   47 ms  31 ms  47 ms
 2  20.1.1.2   47 ms  47 ms  62 ms
 3  20.1.2.2   47 ms  63 ms  78 ms
 4  192.168.1.2   78 ms  94 ms  93 ms
```

