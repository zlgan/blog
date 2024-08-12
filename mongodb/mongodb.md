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



ISODate的格式：

**日期扩展格式**: `YYYY-MM-DD`

**时间扩展格式**: `hh:mm:ss`

**日期和时间组合扩展格式**: `YYYY-MM-DDThh:mm:ss`

时区偏移

- UTC时间： 2024-08-09T06:34:56Z 
- 北京时间：2024-08-09T14:34:56+08:00





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





# Replica Set

## 集群状态信息rs.status()

```json
rs.status()
{
  set: 'rs0',
  date: ISODate('2024-08-10T13:48:38.657Z'),
  myState: 1,  //1主节点,2secondary节点
  term: Long('11'), //选举发生的次数
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,//选举主节点需要的节点数
  writeMajorityCount: 2, //写关注要等待多少节点完成才返回
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
    lastCommittedWallTime: ISODate('2024-08-10T13:48:35.601Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
    appliedOpTime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
    durableOpTime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
    lastAppliedWallTime: ISODate('2024-08-10T13:48:35.601Z'),
    lastDurableWallTime: ISODate('2024-08-10T13:48:35.601Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1723297715, i: 1 }),
    
 //与选举有关的状态：    
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-08-10T13:38:10.294Z'),
    electionTerm: Long('11'), //选举次数
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1723131324, i: 1 }), t: Long('10') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1723297057, i: 1 }), t: Long('10') },
    numVotesNeeded: 2,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'), //主节点多久没响应开始触发选举
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2024-08-10T13:38:15.448Z'),
    wMajorityWriteAvailabilityDate: ISODate('2024-08-10T13:38:15.526Z')
  },
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long('8'),
    lastVoteDate: ISODate('2024-08-08T06:30:52.998Z'),
    electionCandidateMemberId: 2,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1723098642, i: 1 }), t: Long('7') },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1723098642, i: 1 }), t: Long('7') },
    priorityAtElection: 1
  },
  members: [
    {
      _id: 0,
      name: 'suse02:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 313913,
      optime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
      optimeDate: ISODate('2024-08-10T13:48:35.000Z'),
      lastAppliedWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      lastDurableWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1723297090, i: 1 }),
      electionDate: ISODate('2024-08-10T13:38:10.000Z'),
      configVersion: 6,
      configTerm: 11,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'suse03:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 635,
      optime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
      optimeDurable: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
      optimeDate: ISODate('2024-08-10T13:48:35.000Z'),
      optimeDurableDate: ISODate('2024-08-10T13:48:35.000Z'),
      lastAppliedWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      lastDurableWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      lastHeartbeat: ISODate('2024-08-10T13:48:37.029Z'),
      lastHeartbeatRecv: ISODate('2024-08-10T13:48:37.743Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'suse02:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 6,
      configTerm: 11
    },
    {
      _id: 2,
      name: 'suse04:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 623,
      optime: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
      optimeDurable: { ts: Timestamp({ t: 1723297715, i: 1 }), t: Long('11') },
      optimeDate: ISODate('2024-08-10T13:48:35.000Z'),
      optimeDurableDate: ISODate('2024-08-10T13:48:35.000Z'),
      lastAppliedWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      lastDurableWallTime: ISODate('2024-08-10T13:48:35.601Z'),
      lastHeartbeat: ISODate('2024-08-10T13:48:37.110Z'),
      lastHeartbeatRecv: ISODate('2024-08-10T13:48:37.310Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'suse02:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 6,
      configTerm: 11
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1723297715, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1723297715, i: 1 })
}
Enterprise rs0 [direct: primary] test> 

```



## 修改配置

### 查看config

```json
Enterprise rs0 [direct: primary] test> rs.conf()
{
  _id: 'rs0',
  version: 6,
  term: 11,
  members: [
    {
      _id: 0,
      host: 'suse02:27017',
      arbiterOnly: false, //是否为仲裁节点
      buildIndexes: true,
      hidden: false, //是否为隐藏节点
      priority: 1, //该几点被选举成主节点的权重0：不被选举。
      tags: {}, // 标签
      secondaryDelaySecs: Long('0'),
      votes: 1 //0:不能参与投票，1：参与投票
    },
    {
      _id: 1,
      host: 'suse03:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'suse04:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
  writeConcernMajorityJournalDefault: true,
  settings: {
    chainingAllowed: true, //true:允许从其他second节点同步数据，false:只能从主节点同步数据
    heartbeatIntervalMillis: 2000, //2秒中发送一次心跳
    heartbeatTimeoutSecs: 10,
    electionTimeoutMillis: 10000, //节点等待主节点心跳响应超过多久触发重新选举
    catchUpTimeoutMillis: -1,
    catchUpTakeoverDelayMillis: 30000,
    getLastErrorModes: {},
    getLastErrorDefaults: { w: 1, wtimeout: 0 },
    replicaSetId: ObjectId('66a621526b571e56fecf292a')
  }
}

```



### 修改config

```json
cfg = rs.conf()
cfg.members[0].host = "mongo2.example.net"
rs.reconfig(cfg)
rs.reconfig(cfg,{force:true}) //强制使集群重新运行
```

https://www.thecodebuzz.com/mongodb-repository-implementation-unit-testing-net-core-example/

https://github.com/brunobritodev/MongoDB-RepositoryUoWPatterns

## oplog

### 测试代码

```python
from pymongo import MongoClient
import pprint
client=MongoClient('mongodb://suse02:27017,suse03:27017,suse04:27017?replicaSet=rs0')
db=client.demo
collection=db.player
collection.insert_one({"name":"qdn"})
```

### 查看oplog

```json
Enterprise rs0 [direct: secondary] test> use local
switched to db local
Enterprise rs0 [direct: secondary] local> db.oplog.rs.find({op:'i'}).sort({ts:-1}).limit(1)
[
  {
    lsid: {
      id: UUID('1bdd10d3-d207-4c99-8684-714e6c6b2d14'),
      uid: Binary.createFromBase64('47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=', 0)
    },
    txnNumber: Long('1'),
    op: 'i', //i=insert,u=update,d=delete,n=null不会引起数据变更
    ns: 'demo.player', //collection
    ui: UUID('02e6738a-3d10-42f9-97bd-c32141870490'),
    //具体操作的动作
    o: { _id: ObjectId('66b80d671c6c53c7510893f4'), name: 'qdn' },
    //更新操作中的查询条件
    o2: { _id: ObjectId('66b80d671c6c53c7510893f4') },
    stmtId: 0,
    ts: Timestamp({ t: 1723338087, i: 1 }),
    //term:表示副本集中的主节点的任期编号
    t: Long('12'),
    v: Long('2'),
    wall: ISODate('2024-08-11T01:01:27.715Z'),
    prevOpTime: { ts: Timestamp({ t: 0, i: 0 }), t: Long('-1') }
  }
]    
```

### 查看oplog的默认配置

```bash
Enterprise rs0 [direct: secondary] local> rs.printReplicationInfo()
actual oplog size
'1149.365234375 MB'
---
configured oplog size
'1149.365234375 MB'
---
log length start to end # oplog 中从第一个事件到最后一个事件的时间跨度
'1175303 secs (326.47 hrs)'
---
oplog first event time
'Sun Jul 28 2024 18:45:39 GMT+0800 (China Standard Time)'
---
oplog last event time
'Sun Aug 11 2024 09:14:02 GMT+0800 (China Standard Time)'
---
now
'Sun Aug 11 2024 17:14:10 GMT+0800 (China Standard Time)'
```



## failover

# Authorization

## sha1

```bash
#1.创建管理员用户
use admin
db.createUser({ user: "admin", pwd: "admin", roles: [{ role: "root", db: "admin" }] })

#2.创建keyfile
openssl rand -base64 756 > /etc/mongodb-keyfile

#3.编辑配置文件
vi /etc/mongod.conf
security:
    authorization: enabled
    keyFile: /etc/mongodb-keyfile

#4.设置keyfile的访问权限
chmod 400 /etc/mongodb-keyfile
chown mongod:mongod /etc/mongodb-keyfile 

#5.使用账号登录
mongosh -u "admin" -p "admin"
```

## kerberos























