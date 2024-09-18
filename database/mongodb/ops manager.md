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
mkdir -p opsmanager/{data,log,conf}
```

1.3 设置目录权限

```bash
chmod -R 777 opsmanager
```

1.4  在宿主机/var/opsmanager/appdb/node{1,2,3}/conf 下新建配置文件mongod.conf

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
  replSetName: rsapp

#sharding:

## Enterprise-Only Options:

#auditLog:

```

1.5 挂载并启动容器

```bash
#运行容器
docker run --name mongodb_app -p 27001:27017 -d -v /var/opsmanager/appdb/node1/data:/data/data -v /var/opsmanager/appdb/node1/log/:/data/log/ -v /var/opsmanager/appdb/node1/conf/:/data/conf/ --ulimit nofile=64000:64000 mongodb/mongodb-enterprise-server:7.0.6-ubuntu2204 --config /data/conf/mongod.conf

docker run --name mongodb_app2 -p 27002:27017 -d -v /var/opsmanager/appdb/node2/data:/data/data -v /var/opsmanager/appdb/node2/log/:/data/log/ -v /var/opsmanager/appdb/node2/conf/:/data/conf/ --ulimit nofile=64000:64000 mongodb/mongodb-enterprise-server:7.0.6-ubuntu2204 --config /data/conf/mongod.conf

docker run --name mongodb_app3 -p 27003:27017 -d -v /var/opsmanager/appdb/node3/data:/data/data -v /var/opsmanager/appdb/node3/log/:/data/log/ -v /var/opsmanager/appdb/node3/conf/:/data/conf/ --ulimit nofile=64000:64000 mongodb/mongodb-enterprise-server:7.0.6-ubuntu2204 --config /data/conf/mongod.conf


```

```yaml
#docker-compose.yaml方式部署
services:
  mongodb_app4:
    image: mongodb/mongodb-enterprise-server:latest
    container_name: mongodb_app4
	restart: always
	networks:
	  - mongo-app-cluster
    ports:
      - "27004:27017"
    volumes:
      - /var/opsmanager/appdb/node4/data:/data/data
      - /var/opsmanager/appdb/node4/log:/data/log
      - /var/opsmanager/appdb/node4/conf:/data/conf
    ulimits:
      nofile:
        soft: 64000
        hard: 64000
    command: "--config /data/conf/mongod.conf"
networks:
  mongo-app-cluster:
    external: true	
```



1.6 初始化副本集

```bash
rs.initiate({_id:"rsapp",members:[{_id:0,host:"192.168.8.21:27001"},{_id:1,host:"192.168.8.21:27002"},{_id:2,host:"192.168.8.21:27003"}]})
```

1.7 修改副本集配置

```bash
#保存配置到变量
cf=rs.conf()
#查看成员1配置
cf.members[0]
cf.members[0].host="10.194.191.124:27001"
rs.reconfig(cf)
#添加成员
rs.add("<ip>:<port>")
#删除成员
rs.remove("<ip>:<port>")

```


##  2. 安装ops manager

2.1 安装rpm

```bash
sudo rpm -ivh /tmp/mongodb-mms-7.0.3.500.20240305T1921Z.x86_64.rpm
# -i：表示安装（install）RPM包。
# -v：表示在安装过程中显示详细信息（verbose），包括正在安装的文件列表和进度。
# -h：表示在安装过程中显示哈希标记（hash marks），以显示安装进度。
```

2.2 修改配置：

```bash
/opt/mongodb/mms/conf/conf-mms.properties

mongo.mongoUri=mongodb://127.0.0.1:27001,127.0.0.1:27002,127.0.0.1:27003/?replicaSet=rsapp&maxPoolSize=150&retryWrites=false&retryReads=false&uuidRepresentation=standard
```

 

2.3查看服务启动情况：

```bash
systemctl status mongodb-mms
#systemctl start  mongodb-mms

#如果服务没有启动可以手工启动服务
/opt/mongodb/mms/bin/mongodb-mms start

#查看日志：
  Invalid config: Attempting to import cluster process as standalone  

#查看配置
```

## 3.在http://<host>:8080注册第一个用户

```
mongoadmin / 0000abc!

```



## 4.配置ops manager

#### 设置Web 服务器

#### 设置电子邮件服务器





## 5.从ops manager页面下载并安装Agent
- Monitoring Agent
- Backup Agent ，默认处于休眠状态，知道主动启动
- Agent需要与mongodb 进程在同一个账户下运行
## 6.将部署导入监控


#Q&A
- 防火墙服务mpssvc无法停止
`reg add hklm\system\currentcontrolset\services\mpssvc /t reg_dword /v start /d 4 /f reg add hklm\system\currentcontrolset\services\mpssvc /t reg_dword /v start /d 4 /f `
# ref
- 安装流程：https://www.cnblogs.com/generalli2019/p/13471246.html

