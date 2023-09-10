# 安装

以下是在 CentOS 7 虚拟机上安装 Minikube 的详细步骤：

1. 安装虚拟化软件。Minikube 使用虚拟化来创建 Kubernetes 集群，因此您需要在 CentOS 7 虚拟机上安装虚拟化软件。这里以 VirtualBox 为例进行说明。您可以使用以下命令来安装 VirtualBox：

   ```
   sudo yum install -y wget
   wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
   sudo yum update
   sudo yum install -y VirtualBox-6.1
   ```

2. 安装 kubectl。kubectl 是 Kubernetes 的命令行工具，用于管理 Kubernetes 集群。您可以使用以下命令在 CentOS 上安装 kubectl：

   ```
   sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
   sudo chmod +x ./kubectl
   sudo mv ./kubectl /usr/local/bin/kubectl
   ```

3. 安装 Docker。Minikube 需要 Docker 来管理容器。您可以使用以下命令在 CentOS 上安装 Docker：

   ```
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   sudo yum install -y docker-ce docker-ce-cli containerd.io
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

4. 安装 Minikube。您可以使用以下命令在 CentOS 上安装 Minikube：

   ```
   curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
   sudo install minikube-linux-amd64 /usr/local/bin/minikube
   ```

5. 启动 Minikube。使用以下命令启动 Minikube：

   ```
   minikube start --vm-driver=virtualbox
   ```

   注意，`--vm-driver` 参数指定了虚拟化平台，这里选择 VirtualBox。如果您使用的是其他虚拟化平台，请相应调整参数。

6. 验证 Minikube 是否安装成功。您可以使用以下命令检查 Minikube 是否运行正常：

   ```
   kubectl get nodes
   ```

   如果 Minikube 运行正常，您应该可以看到一个节点已经运行。

完成上述步骤后，您可以使用 kubectl 命令管理 Kubernetes 集群。例如，使用 `kubectl create deployment` 和 `kubectl expose` 命令创建和公开一个应用程序。

# 部署一个应用

# 常用命令

##  kubectl 

### kubectl get 

> 用于获取 Kubernetes 资源的信息

1. 查看pod

```bash
[root@node12 docker]# kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
hellodocker-7d94f9cb68-dwgkx   1/1     Running   0          6h23m
```

2. 查看服务

```bash
[root@node12 docker]# kubectl get services
NAME          TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
hellodocker   LoadBalancer   10.103.107.31   10.103.107.31   80:30905/TCP   6h19m
kubernetes    ClusterIP      10.96.0.1       <none>          443/TCP        15h

```

3. 查看服务的url

```bash
[root@node12 docker]# minikube service hellodocker --url
http://192.168.59.100:30905
```

4. 要查看 Minikube 的日志

```bash
minikube logs
```

### kubectl describe

> kubectl describe` 是 Kubernetes 命令行工具 `kubectl` 的一个命令，用于获取 Kubernetes 资源的详细信息

1. 获取 Pod 的详细信息：

   ```
   kubectl describe pod <pod-name>
   ```

   该命令将显示指定名称的 Pod 的详细信息，包括 Pod 的状态、容器信息、事件等。

2. 获取 Service 的详细信息：

   ```
   kubectl describe service <service-name>
   ```

   该命令将显示指定名称的 Service 的详细信息，包括 Service 的类型、IP 地址、端口信息等。

3. 获取 Node 的详细信息：

   ```
   kubectl describe node <node-name>
   ```

   该命令将显示指定名称的 Node 的详细信息，包括 Node 的状态、资源使用情况等。

4. 获取 Deployment 的详细信息：

   ```
   kubectl describe deployment <deployment-name>
   ```

   该命令将显示指定名称的 Deployment 的详细信息，包括 Deployment 的副本数、容器信息等。

5. 获取 Namespace 的详细信息：

   ```
   kubectl describe namespace <namespace-name>
   ```

   该命令将显示指定名称的 Namespace 的详细信息，包括 Namespace 中的资源信息等。

6. 获取 ConfigMap 的详细信息：

   ```
   kubectl describe configmap <configmap-name>
   ```

   该命令将显示指定名称的 ConfigMap 的详细信息，包括 ConfigMap 的键值对信息等。