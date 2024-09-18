













# 控制平面

- api server
- scheduler
- controller mgr
- etcd

# pod

- pause pod 

  > 第一个启动的容器,与其他容器共享：network,pid,ipc

- 一个典型 的pod

  1. kubelet：接受控制平面的命令

  2. pause container

  3. kube proxy

  4. ## container runtime



# CNI(容器网络接口)

> 是一个接口规范



# 资源

## 名称空间资源

### 工作负载

- Pod
- ReplicaSet
- Deployment

### 服务发现与负载均衡

- Service
- Ingress

### 配置与存储

- Volume
- CSI

## 集群资源

- Namespace
- node
- clusterRole
- ClusterRoleBinding

## 元数据资源

- HPA
- PodTemplate
- LImitRange

# temp

RH系列linux：

	- red hat linux：（企业版）
	- linux fedora：linux的桌面版
	- centos：社区版linux，从red hat 修改而来，后被红帽收购，已关闭
	- centos stream：（滚动版，red hat新功能的测试版）
	- rocky linux：免费版

