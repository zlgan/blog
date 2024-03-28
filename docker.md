# 常用命令
## 1.docker exec
```bash
 docker exec -it 545ed62d3abf /bin/bash
#是用于在一个正在运行的容器中执行命令
# docker exec：用于在容器中执行命令的Docker命令。
# -it：选项用于分配一个伪终端（pseudo-TTY）并保持标准输入（stdin）打开，以便我们可以与容器进行交互。
# 545ed62d3abf：这是容器的ID或名称，用于指定要执行命令的容器。
# /bin/bash：要在容器中执行的命令，这里是启动一个交互式的bash Shell。
```

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