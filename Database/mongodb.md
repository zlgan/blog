### mongodb概念篇

www.mongodb.com

database>collection>document

1. mongodb 的前端

   1. mongo shell
   2. mongo compass

2. 引擎

   1. WiredTiger

      允许使用文档级别的锁

   ![image-20240126212410390](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126212410390.png)

   ![image-20240126212503440](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126212503440.png)

![image-20240126220902473](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126220902473.png)

![image-20240126222305971](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126222305971.png)



# 安装

```bash
#查看安装的组件
suse02:/etc # rpm -qa |grep mongo
mongodb-enterprise-database-tools-extra-7.0.12-1.suse15.x86_64
mongodb-mongosh-2.2.13-1.el8.x86_64
mongodb-database-tools-100.10.0-1.x86_64
mongodb-enterprise-server-7.0.12-1.suse15.x86_64
mongodb-enterprise-7.0.5-1.suse15.x86_64
mongodb-enterprise-mongos-7.0.12-1.suse15.x86_64
mongodb-enterprise-database-7.0.12-1.suse15.x86_64
mongodb-enterprise-tools-7.0.12-1.suse15.x86_64
mongodb-enterprise-cryptd-7.0.12-1.suse15.x86_64

#查看软件包信息和安装路径
suse02:/etc # rpm -qil mongodb-enterprise-server-7.0.12-1.suse15.x86_64
Name        : mongodb-enterprise-server
Version     : 7.0.12
Release     : 1.suse15
Architecture: x86_64
Install Date: Sat Jul 27 21:17:05 2024
Group       : Applications/Databases
Size        : 188180930
License     : Commercial
Signature   : RSA/SHA256, Sat Jun 29 04:05:52 2024, Key ID 160d26bb1785ba38
Source RPM  : mongodb-enterprise-database-7.0.12-1.suse15.src.rpm
Build Date  : Wed Jun 26 03:21:45 2024
Build Host  : ip-10-128-153-135.ec2.internal
Relocations : /usr /var /etc 
URL         : http://www.mongodb.org
Summary     : MongoDB database server (enterprise)
Description :
MongoDB is built for scalability, performance and high availability, scaling from single server deployments to large, complex multi-site architectures. By leveraging in-memory computing, MongoDB provides high performance for both reads and writes. MongoDB’s native replication and automated failover enable enterprise-grade reliability and operational flexibility.

MongoDB is an open-source database used by companies of all sizes, across all industries and for a wide variety of applications. It is an agile database that allows schemas to change quickly as applications evolve, while still providing the functionality developers expect from traditional databases, such as secondary indexes, a full query language and strict consistency.

MongoDB has a rich client ecosystem including hadoop integration, officially supported drivers for 10 programming languages and environments, as well as 40 drivers supported by the user community.

MongoDB features:
* JSON Data Model with Dynamic Schemas
* Auto-Sharding for Horizontal Scalability
* Built-In Replication for High Availability
* Rich Secondary Indexes, including geospatial
* TTL indexes
* Text Search
* Aggregation Framework & Native MapReduce

This package contains the MongoDB server software, default configuration files, and systemd service files.
Distribution: (none)
/etc/mongod.conf
/run/mongodb
/usr/bin/mongod
/usr/lib/systemd/system/mongod.service
/usr/share/doc/packages/mongodb-enterprise-server
/usr/share/doc/packages/mongodb-enterprise-server/LICENSE-Enterprise.txt
/usr/share/doc/packages/mongodb-enterprise-server/MPL-2
/usr/share/doc/packages/mongodb-enterprise-server/README
/usr/share/doc/packages/mongodb-enterprise-server/THIRD-PARTY-NOTICES
/usr/share/man/man1/mongod.1.gz
/usr/share/man/man5/mongodb-parameters.5.gz
/var/lib/mongo
/var/log/mongodb
/var/log/mongodb/mongod.log


```







迁移的问题：

1. 索引，视图，函数，存储过程
2. 数据库事务如何保证
3. 直接保存一对多的关系，存在大量冗余？



mogo优点：

1. 横向扩展能力
2. 直接存储文本，图片，视频，二进制文件？
3. 分片架构
4. 数据加载到内存的，定时保存到磁盘中，公式通过日志恢复同步失败的情况。

### 数据库操作

```bash
#删除数据库
> use mydatabase
switched to db mydatabase
> db.dropDatabase()
{ "ok" : 1 }

#停止mongodb
 use admin
 db.shutdownServer()
 

```



### 操作collection

#### 查询集合

```
> show collections
c1
myCollection
```

#### 创建集合 

1. 显示创建集合

   ```
   > db.createCollection("myCollection",{})
   { "ok" : 1 }
   ```

2. 隐式创建集合

   ```
   > db.c1.insert({"k":"v"})
   WriteResult({ "nInserted" : 1 })
   ```

### 用户角色管理

#### 查看角色

```bash
> use admin
switched to db admin
> db.system.roles.find()
{ "_id" : "admin.readWriteCustom", "role" : "readWriteCustom", "db" : "admin", "privileges" : [ { "resource" : { "db" : "mydatabase", "collection" : "" }, "actions" : [ "find", "insert", "remove", "update" ] } ], "roles" : [ ] }
>
```

```bash
> show roles
{
        "role" : "__system",
        "db" : "admin",
        "isBuiltin" : true,
        "roles" : [ ],
        "inheritedRoles" : [ ]
}
{
        "role" : "clusterMonitor",
        "db" : "admin",
        "isBuiltin" : true,
        "roles" : [ ],
        "inheritedRoles" : [ ]
}
```



#### 删除角色

```

```

 

### 副本集搭建

### 分片集群



### 疑问

1. 每个文档保存完整树状信息，是否存在冗余？
2. 

### mongo shell 帮助



#### 查看所有的帮助（help命令）

```
> help
        db.help()                    help on db methods
        db.mycoll.help()             help on collection methods
        sh.help()                    sharding helpers
        rs.help()                    replica set helpers
        help admin                   administrative help
        help connect                 connecting to a db help
        help keys                    key shortcuts
        help misc                    misc things to know
        help mr                      mapreduce

        show dbs                     show database names
        show collections             show collections in current database
        show users                   show users in current database
        show profile                 show most recent system.profile entries with time >= 1ms
        show logs                    show the accessible logger names
        show log [name]              prints out the last segment of log in memory, 'global' is default
        use <db_name>                set current database
        db.mycoll.find()             list objects in collection mycoll
        db.mycoll.find( { a : 1 } )  list objects in mycoll where a == 1
        it                           result of the last line evaluated; use to further iterate
        DBQuery.shellBatchSize = x   set default number of items to display on shell
        exit                         quit the mongo shell
```

#### db的帮助

```powershell
> db.help()
DB methods:
        db.adminCommand(nameOrDocument) - switches to 'admin' db, and runs command [just calls db.runCommand(...)]
        db.aggregate([pipeline], {options}) - performs a collectionless aggregation on this database; returns a cursor
        db.auth(username, password)
        db.commandHelp(name) returns the help for the command
        db.createUser(userDocument)
        db.createView(name, viewOn, [{$operator: {...}}, ...], {viewOptions})
        db.currentOp() displays currently executing operations in the db
        db.dropDatabase(writeConcern)
        db.dropUser(username)
        db.eval() - deprecated
        db.fsyncLock() flush data to disk and lock server for backups
        db.fsyncUnlock() unlocks server following a db.fsyncLock()
        db.getCollection(cname) same as db['cname'] or db.cname
        db.getCollectionInfos([filter]) - returns a list that contains the names and options of the db's collections
        db.getCollectionNames()
        db.getLastError() - just returns the err msg string
        db.getLastErrorObj() - return full status object
        db.getLogComponents()
        db.getMongo() get the server connection object
        db.getMongo().setSecondaryOk() allow queries on a replication secondary server
        db.getName()
        db.getProfilingLevel() - deprecated
        db.getProfilingStatus() - returns if profiling is on and slow threshold
        db.getReplicationInfo()
        db.getSiblingDB(name) get the db at the same server as this one
        db.getWriteConcern() - returns the write concern used for any operations on this db, inherited from server object if set
        db.hostInfo() get details about the server's host
        db.isMaster() check replica primary status
        db.hello() check replica primary status
        db.killOp(opid) kills the current operation in the db
        db.listCommands() lists all the db commands
        db.loadServerScripts() loads all the scripts in db.system.js
        db.logout()
        db.printCollectionStats()
        db.printReplicationInfo()
        db.printShardingStatus()
        db.printSecondaryReplicationInfo()
        db.rotateCertificates(message) - rotates certificates, CRLs, and CA files and logs an optional message
        db.runCommand(cmdObj) run a database command.  if cmdObj is a string, turns it into {cmdObj: 1}
        db.serverStatus()
        db.setLogLevel(level,<component>)
        db.setProfilingLevel(level,slowms) 0=off 1=slow 2=all
        db.setVerboseShell(flag) display extra information in shell output
        db.setWriteConcern(<write concern doc>) - sets the write concern for writes to the db
        db.shutdownServer()
        db.stats()
        db.unsetWriteConcern(<write concern doc>) - unsets the write concern for writes to the db
        db.version() current version of the server
        db.watch() - opens a change stream cursor for a database to report on all  changes to its non-system collections.
```

#### collections的帮助

```bash
> db.collections.help()
DBCollection help
        db.collections.find().help() - show DBCursor help
        db.collections.bulkWrite( operations, <optional params> ) - bulk execute write operations, optional parameters are: w, wtimeout, j
        db.collections.count( query = {}, <optional params> ) - count the number of documents that matches the query, optional parameters are: limit, skip, hint, maxTimeMS
        db.collections.countDocuments( query = {}, <optional params> ) - count the number of documents that matches the query, optional parameters are: limit, skip, hint, maxTimeMS
        db.collections.estimatedDocumentCount( <optional params> ) - estimate the document count using collection metadata, optional parameters are: maxTimeMS
        db.collections.convertToCapped(maxBytes) - calls {convertToCapped:'collections', size:maxBytes}} command
        db.collections.createIndex(keypattern[,options])
        db.collections.createIndexes([keypatterns], <options>)
        db.collections.dataSize()
        db.collections.deleteOne( filter, <optional params> ) - delete first matching document, optional parameters are: w, wtimeout, j
        db.collections.deleteMany( filter, <optional params> ) - delete all matching documents, optional parameters are: w, wtimeout, j
        db.collections.distinct( key, query, <optional params> ) - e.g. db.collections.distinct( 'x' ), optional parameters are: maxTimeMS
        db.collections.drop() drop the collection
        db.collections.dropIndex(index) - e.g. db.collections.dropIndex( "indexName" ) or db.collections.dropIndex( { "indexKey" : 1 } )
        db.collections.hideIndex(index) - e.g. db.collections.hideIndex( "indexName" ) or db.collections.hideIndex( { "indexKey" : 1 } )
        db.collections.unhideIndex(index) - e.g. db.collections.unhideIndex( "indexName" ) or db.collections.unhideIndex( { "indexKey" : 1 } )
        db.collections.dropIndexes()
        db.collections.explain().help() - show explain help
        db.collections.reIndex()
        db.collections.find([query],[fields]) - query is an optional query filter. fields is optional set of fields to return.
                                                      e.g. db.collections.find( {x:77} , {name:1, x:1} )
        db.collections.find(...).count()
        db.collections.find(...).limit(n)
        db.collections.find(...).skip(n)
        db.collections.find(...).sort(...)
        db.collections.findOne([query], [fields], [options], [readConcern])
        db.collections.findOneAndDelete( filter, <optional params> ) - delete first matching document, optional parameters are: projection, sort, maxTimeMS
        db.collections.findOneAndReplace( filter, replacement, <optional params> ) - replace first matching document, optional parameters are: projection, sort, maxTimeMS, upsert, returnNewDocument
        db.collections.findOneAndUpdate( filter, <update object or pipeline>, <optional params> ) - update first matching document, optional parameters are: projection, sort, maxTimeMS, upsert, returnNewDocument
        db.collections.getDB() get DB object associated with collection
        db.collections.getPlanCache() get query plan cache associated with collection
        db.collections.getIndexes()
        db.collections.insert(obj)
        db.collections.insertOne( obj, <optional params> ) - insert a document, optional parameters are: w, wtimeout, j
        db.collections.insertMany( [objects], <optional params> ) - insert multiple documents, optional parameters are: w, wtimeout, j
        db.collections.mapReduce( mapFunction , reduceFunction , <optional params> )
        db.collections.aggregate( [pipeline], <optional params> ) - performs an aggregation on a collection; returns a cursor
        db.collections.remove(query)
        db.collections.replaceOne( filter, replacement, <optional params> ) - replace the first matching document, optional parameters are: upsert, w, wtimeout, j
        db.collections.renameCollection( newName , <dropTarget> ) renames the collection.
        db.collections.runCommand( name , <options> ) runs a db command with the given name where the first param is the collection name
        db.collections.save(obj)
        db.collections.stats({scale: N, indexDetails: true/false, indexDetailsKey: <index key>, indexDetailsName: <index name>})
        db.collections.storageSize() - includes free space allocated to this collection
        db.collections.totalIndexSize() - size in bytes of all the indexes
        db.collections.totalSize() - storage allocated for all data and indexes
        db.collections.update( query, <update object or pipeline>[, upsert_bool, multi_bool] ) - instead of two flags, you can pass an object with fields: upsert, multi, hint, let
        db.collections.updateOne( filter, <update object or pipeline>, <optional params> ) - update the first matching document, optional parameters are: upsert, w, wtimeout, j, hint, let
        db.collections.updateMany( filter, <update object or pipeline>, <optional params> ) - update all matching documents, optional parameters are: upsert, w, wtimeout, j, hint, let
        db.collections.validate( <full> ) - SLOW
        db.collections.getShardVersion() - only for use with sharding
        db.collections.getShardDistribution() - prints statistics about data distribution in the cluster
        db.collections.getSplitKeysForChunks( <maxChunkSize> ) - calculates split points over all chunks and returns splitter function
        db.collections.getWriteConcern() - returns the write concern used for any operations on this collection, inherited from server/db if set
        db.collections.setWriteConcern( <write concern doc> ) - sets the write concern for writes to the collection
        db.collections.unsetWriteConcern( <write concern doc> ) - unsets the write concern for writes to the collection
        db.collections.latencyStats() - display operation latency histograms for this collection
```





# 副本集操作

## 修改副本集配置

```
cfg = rs.conf()
cfg.members[0].host = "mongo2.example.net"
rs.reconfig(cfg)
```

https://www.thecodebuzz.com/mongodb-repository-implementation-unit-testing-net-core-example/

https://github.com/brunobritodev/MongoDB-RepositoryUoWPatterns

