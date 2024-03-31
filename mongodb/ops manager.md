## 1. 安装 ops manager app db

1.1 docker中安装mongodb企业版

https://www.mongodb.com/docs/manual/tutorial/install-mongodb-enterprise-with-docker/

```bash
#获取最新的镜像
docker pull mongodb/mongodb-enterprise-server:latest
```

1.2 挂载数据文件和配置文件

```bash
#宿主机/ops目录下新建目录
mkdir -p mongodb/{data,log,conf}
```

1.3 设置目录权限

```bash
chmod -R 777 mongodb
```

1.4  在宿主机/opt/mongodb/conf下新建配置文件mongod.conf

```yaml
# mongod.conf
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /data/data/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path:  /data/log/mongodb.log

# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0

#processManagement:

#security:
  #authorization: enabled
  #keyFile:  C:\Program Files\MongoDB\Server\7.0\bin\mongo.keyFile
  
#operationProfiling:

replication:
  replSetName: rs01

#sharding:

## Enterprise-Only Options:

#auditLog:

```

1.5 挂载并启动容器

```bash
#运行容器
docker run --name mongodb_app01 --net mongo-app-cluster  -p 27001:27017 -d -v /opt/mongodb/rsApp/node1/data:/data/data -v /opt/mongodb/rsApp/node1/log/:/data/log/ -v /opt/mongodb/rsApp/node1/conf/:/data/conf/ mongodb/mongodb-enterprise-server:latest --config /data/conf/mongod.conf


docker run --name mongodb_app02 --net mongo-app-cluster  -p 27002:27017 -d -v /opt/mongodb/rsApp/node2/data:/data/data -v /opt/mongodb/rsApp/node2/log/:/data/log/ -v /opt/mongodb/rsApp/node2/conf/:/data/conf/ mongodb/mongodb-enterprise-server:latest --config /data/conf/mongod.conf


docker run --name mongodb_app03 --net mongo-app-cluster  -p 27003:27017 -d -v /opt/mongodb/rsApp/node3/data:/data/data -v /opt/mongodb/rsApp/node3/log/:/data/log/ -v /opt/mongodb/rsApp/node3/conf/:/data/conf/ mongodb/mongodb-enterprise-server:latest --config /data/conf/mongod.conf

```

1.6 初始化副本集

```
rs.initiate({_id:"rsapp",members:[{_id:0,host:"192.168.8.21:27001"},{_id:1,host:"192.168.8.22:27002"},{_id:2,host:"192.168.8.23:27003"}]})
```



##  2. 安装ops manager

2.1 安装rpm

```bash
sudo rpm -ivh /tmp/mongodb-mms-7.0.3.500.20240305T1921Z.x86_64.rpm
```

2.2 修改配置：

```
/opt/mongodb/mms/conf/conf-mms.properties

mongo.mongoUri=mongodb://127.0.0.1:27001,127.0.0.1:27002,127.0.0.1:27003/?replicaSet=rsapp&maxPoolSize=150&retryWrites=false&retryReads=false&uuidRepresentation=standard
```

 

2.3查看服务启动情况：

```bash
systemctl status mongodb-mms
#systemctl start  mongodb-mms

#查看日志：
cat /opt/mongodb/mms/logs/mms0.log

#查看配置
cat /opt/mongodb/mms/conf/mms.conf
#手工启动服务
/opt/mongodb/mms/bin/mongodb-mms start

```



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

