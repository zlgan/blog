# 常用命令

## 2.docker run 
```bash
docker run -i -t -d -p 8080:80  nginx /bin/bash
# docker run：运行一个新的容器。
# -d：以守护进程（后台）模式运行容器
# -p 8080:80：将宿主机的端口8080映射到容器的端口80。这意味着在宿主机上访问8080端口时，请求将被转发到容器的80端口
# -i：表示将容器的标准输入（stdin）与当前终端（宿主机）绑定，以便在容器内部进行交互。
# -t：为容器分配一个伪终端（pseudo-tty），以便在容器内部使用类似终端的Shell。
# nginx：指定要使用的镜像名称，这里使用的是nginx镜像。
# /bin/bash：在容器内部运行的命令，即启动一个Bash Shell
```



# docker

## docker info 显示docker系统级信息

```bash
[root@node11 ~]# docker info 
Client: Docker Engine - Community
 Version:    26.0.1 #客户端的版本
 Context:    default
 Debug Mode: false
 Plugins: #安装的插件
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.13.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.26.1
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

#服务器的信息
Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 26.0.1
 Storage Driver: overlay2
  Backing Filesystem: xfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: e377cd56a71523140ca6ae87e30244719194a521
 runc version: v1.1.12-0-g51d5e94
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
 Kernel Version: 4.18.0-240.el8.x86_64
 Operating System: CentOS Linux 8
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 781.9MiB
 Name: node11
 ID: d7bfc004-3814-4509-9972-f0883ee64099
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

# docker image

## docker images 

## docker pull

## docker save

## docker load

## docker build 

# docker container

## docker ps 

## docker run

## docker inspect

## docker exec
```bash
 docker exec -it 545ed62d3abf /bin/bash
#是用于在一个正在运行的容器中执行命令
# docker exec：用于在容器中执行命令的Docker命令。
# -it： -i 表示容器的标准输入保持开放，-t 分配一个伪终端。这两个一起使用可以让你与运行的容器进行交互。
# 545ed62d3abf：这是容器的ID或名称，用于指定要执行命令的容器。
# /bin/bash：要在容器中执行的命令，这里是启动一个交互式的bash Shell。
```

## docker logs <container>

## docker compose

## compose.yaml

# Dockerfile

```bash
#查看容器
docker ps #运行中的容器
docker container ls  #运行中的容器
docker container ls -a #所有容器
#启动与停止容器
docker stop -t 10 db57e08154fb
docker start  db57e08154fb
#修改容器名称
docker rename mongodb mongodb_app
```

# docker  network   

![image-20240420215917485](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240420215917485.png)

```bash
ip -json address show dev <interface> |jq .

#创建网络bridge模式 
docker network create -d bridge <bridge-name>
docker network ls
docker network inspect <bridge-name>

```


# docker compse 
1. 安装：https://docs.docker.com/engine/install/sles/#set-up-the-repository
2. 阿里云加速:https://help.aliyun.com/zh/acr/user-guide/accelerate-the-pulls-of-docker-official-images
3. https://docs.docker.com/compose/gettingstarted/

#删除网络
``` powershell
docker network rm <bridge-name>
```
# docker volume
# docker compose

# 部署Docker的Demo

下面是一个 .NET Core Web API 的示例代码，它将返回一个简单的 "Hello World" 字符串：

```csharp
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("[controller]")]
public class HelloWorldController : ControllerBase
{
    [HttpGet]
    public string Get()
    {
        return "Hello World!";
    }
}
```

接下来，您可以编写一个 Dockerfile，以在 Docker 容器中运行该 Web API 项目。以下是一个示例 Dockerfile：

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# 将 .csproj 文件复制到 /app 目录中
COPY *.csproj ./

# 运行 dotnet restore 命令
RUN dotnet restore

# 将所有文件复制到 /app 目录中
COPY . .

# 构建项目
RUN dotnet publish -c Release -o out

# 使用 .NET 运行时作为基础镜像
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "WebApiDemo.dll"]
```

请注意，上面的 Dockerfile 文件将在基于 .NET Core 5.0 的 Docker 容器中运行。如果您需要使用其他版本的 .NET Core，请相应地更改 Dockerfile 文件。

接下来，您需要使用以下步骤生成 Docker 镜像：

1. 在项目的根目录中打开终端或命令提示符。

2. 使用以下命令构建 Docker 镜像：

```
docker build -t webapidemo .
```

请注意，上面的命令将根据当前目录中的 Dockerfile 文件生成名为 "webapidemo" 的 Docker 镜像。

3. 使用以下命令运行 Docker 容器：

```
docker run -d -p 8080:80 --name webapidemo webapidemo
```

请注意，上面的命令将在名为 "webapidemo" 的容器中运行名为 "webapidemo" 的 Docker 镜像，并将容器的端口映射到主机的端口 8080 上。

最后，您需要将该 Docker 容器部署到 CentOS 服务器上。以下是一个示例命令，用于将 Docker 容器从本地主机迁移到远程 CentOS 服务器：

1. 将 Docker 镜像保存为 tar 文件：

```
docker save webapidemo > webapidemo.tar
```

2. 将 tar 文件复制到 CentOS 服务器上：

```
scp webapidemo.tar user@centos-server:/path/to/destination
```

请注意，上面的命令将 tar 文件复制到名为 "centos-server" 的远程 CentOS 服务器上，并将其保存到目标路径下。

3. 在 CentOS 服务器上加载 Docker 镜像：

```
docker load < webapidemo.tar
```

请注意，上面的命令将从 tar 文件中加载 Docker 镜像。

4. 在 CentOS 服务器上运行 Docker 容器：

```
docker run -d -p 8080:80 --name webapidemo webapidemo
```

请注意，上面的命令将在名为 "webapidemo" 的容器中运行名为 "webapidemo" 的 Docker 镜像，并将容器的端口映射到主机的端口 8080 上。

完成上述步骤后，您的 .NET Core Web API 项目应该已经成功地部署到 CentOS 服务器上了。
