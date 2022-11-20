---
title: K8s集群搭建
date: 10/07/2021 23:56:40
tags: 
categories: K8s
---
https://www.bilibili.com/video/BV1rK411w7Gk?from=search&seid=17390140867179785275&spm_id_from=333.337.0.0

https://www.cnblogs.com/xuweiweiwoaini/p/13884112.html

安装Docker https://docs.docker.com/engine/install/centos/

阿里云：https://developer.aliyun.com/article/110806

### 安装Docker

```

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum clean all && yum makecache
#解决CentOS 8 中安装 Docker 出现和 Podman 冲突的问题
	dnf -y remove podman
	yum -y erase podman buildah
yum -y install docker-ce
```

### Docker 国内镜像加速

https://www.cnblogs.com/nhdlb/p/12567154.html



### 安装时间同步

https://blog.csdn.net/weixin_45717886/article/details/116995015

### 从阿里云K8s镜像中安装

```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet
```

### 启动K8s

```bash
#重置，多次init前执行
kubeadm reset

#初始化
 kubeadm init --apiserver-advertise-address=192.168.8.11 --image-repository registry.aliyuncs.com/google_containers --kubernetes-version=1.22.2 --service-cidr=10.96.0.0/12 --pod-network-cidr=10.244.0.0/16
 #初始化成功的日志
Your Kubernetes control-plane has initialized successfully!
To start using your cluster, you need to run the following as a regular user:
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
Alternatively, if you are the root user, you can run:
export KUBECONFIG=/etc/kubernetes/admin.conf
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
https://kubernetes.io/docs/concepts/cluster-administration/addons/
Then you can join any number of worker nodes by running the following on each as root:
kubeadm join 192.168.8.11:6443 --token d31stw.40yrif56jeu3lm0g \
--discovery-token-ca-cert-hash sha256:d7882099c8c008d40e8f31491c048f6aab2a564e5656bd3f9012ce389e88e635 
```

### 加入集群

```BASH
# 将Master节点配置拷贝node节点
scp /etc/kubernetes/admin.conf root@node16:/etc/kubernetes/admin.conf
export KUBECONFIG=/etc/kubernetes/admin.conf

#应用网络配置
kubectl apply -f kube-flannel.yml


#Erro1
kubectl apply -f kube-flannel.yml
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```





### 日志查看

```bash
journalctl -xefu kubelet
```





### 参考

https://www.cnblogs.com/caoxb/p/11243472.html

https://www.cnblogs.com/xuweiweiwoaini/p/13884112.html



https://www.cnblogs.com/2021-sue-888/p/14767120.html

