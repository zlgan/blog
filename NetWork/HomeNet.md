---
title: 家庭网络拓扑
date: 2021-08-1 8:28:30
tags: 
categories: Network
---

### 网络现状及问题

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
