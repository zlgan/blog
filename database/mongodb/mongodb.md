# mongodb概念篇

   1. WiredTiger

      允许使用文档级别的锁

   ![image-20240126212410390](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126212410390.png)

   ![image-20240126212503440](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126212503440.png)

![image-20240126220902473](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126220902473.png)

![image-20240126222305971](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240126222305971.png)


# 安装信息

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



# 数据库管理

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
# 查看帮助（help命令）

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

## db.help()

```json
> db.help()
{
  "help": "Database Class",
  "docs": null,
  "attr": [
    {
      "name": "getMongo",
      "description": "Returns the current database connection"
    },
    {
      "name": "getName",
      "description": "Returns the name of the DB"
    },
    {
      "name": "getCollectionNames",
      "description": "Returns an array containing the names of all collections in the current database."
    },
    {
      "name": "getCollectionInfos",
      "description": "Returns an array of documents with collection information, i.e. collection name and options, for the current database."
    },
    {
      "name": "runCommand",
      "description": "Runs an arbitrary command on the database."
    },
    {
      "name": "adminCommand",
      "description": "Runs an arbitrary command against the admin database."
    },
    {
      "name": "aggregate",
      "description": "Runs a specified admin/diagnostic pipeline which does not require an underlying collection."
    },
    {
      "name": "getSiblingDB",
      "description": "Returns another database without modifying the db variable in the shell environment."
    },
    {
      "name": "getCollection",
      "description": "Returns a collection or a view object that is functionally equivalent to using the db.<collectionName>."
    },
    {
      "name": "dropDatabase",
      "description": "Removes the current database, deleting the associated data files."
    },
    {
      "name": "createUser",
      "description": "Creates a new user for the database on which the method is run. db.createUser() returns a duplicate user error if the user already exists on the database."
    },
    {
      "name": "updateUser",
      "description": "Updates the user’s profile on the database on which you run the method. An update to a field completely replaces the previous field’s values. This includes updates to the user’s roles array."
    },
    {
      "name": "changeUserPassword",
      "description": "Updates a user’s password. Run the method in the database where the user is defined, i.e. the database you created the user."
    },
    {
      "name": "logout",
      "description": "Ends the current authentication session. This function has no effect if the current session is not authenticated."
    },
    {
      "name": "dropUser",
      "description": "Removes the user from the current database."
    },
    {
      "name": "dropAllUsers",
      "description": "Removes all users from the current database."
    },
    {
      "name": "auth",
      "description": "Allows a user to authenticate to the database from within the shell."
    },
    {
      "name": "grantRolesToUser",
      "description": "Grants additional roles to a user."
    },
    {
      "name": "revokeRolesFromUser",
      "description": "Removes a one or more roles from a user on the current database."
    },
    {
      "name": "getUser",
      "description": "Returns user information for a specified user. Run this method on the user’s database. The user must exist on the database on which the method runs."
    },
    {
      "name": "getUsers",
      "description": "Returns information for all the users in the database."
    },
    {
      "name": "createCollection",
      "description": "Create new collection"
    },
    {
      "name": "createEncryptedCollection",
      "description": "Creates a new collection with a list of encrypted fields each with unique and auto-created data encryption keys (DEKs). This is a utility function that internally utilises ClientEnryption.createEncryptedCollection."
    },
    {
      "name": "createView",
      "description": "Create new view"
    },
    {
      "name": "createRole",
      "description": "Creates a new role."
    },
    {
      "name": "updateRole",
      "description": "Updates the role’s profile on the database on which you run the method. An update to a field completely replaces the previous field’s values."
    },
    {
      "name": "dropRole",
      "description": "Removes the role from the current database."
    },
    {
      "name": "dropAllRoles",
      "description": "Removes all roles from the current database."
    },
    {
      "name": "grantRolesToRole",
      "description": "Grants additional roles to a role."
    },
    {
      "name": "revokeRolesFromRole",
      "description": "Removes a one or more roles from a role on the current database."
    },
    {
      "name": "grantPrivilegesToRole",
      "description": "Grants additional privileges to a role."
    },
    {
      "name": "revokePrivilegesFromRole",
      "description": "Removes a one or more privileges from a role on the current database."
    },
    {
      "name": "getRole",
      "description": "Returns role information for a specified role. Run this method on the role’s database. The role must exist on the database on which the method runs."
    },
    {
      "name": "getRoles",
      "description": "Returns information for all the roles in the database."
    },
    {
      "name": "currentOp",
      "description": "Runs an aggregation using $currentOp operator. Returns a document that contains information on in-progress operations for the database instance. For further information, see $currentOp."
    },
    {
      "name": "killOp",
      "description": "Calls the killOp command. Terminates an operation as specified by the operation ID. To find operations and their corresponding IDs, see $currentOp or db.currentOp()."
    },
    {
      "name": "shutdownServer",
      "description": "Calls the shutdown command. Shuts down the current mongod or mongos process cleanly and safely. You must issue the db.shutdownServer() operation against the admin database."
    },
    {
      "name": "fsyncLock",
      "description": "Calls the fsync command. Forces the mongod to flush all pending write operations to disk and locks the entire mongod instance to prevent additional writes until the user releases the lock with a corresponding db.fsyncUnlock() command."
    },
    {
      "name": "fsyncUnlock",
      "description": "Calls the fsyncUnlock command. Reduces the lock taken by db.fsyncLock() on a mongod instance by 1."
    },
    {
      "name": "version",
      "description": "returns the db version. uses the buildinfo command"
    },
    {
      "name": "serverBits",
      "description": "returns the db serverBits. uses the buildInfo command"
    },
    {
      "name": "isMaster",
      "description": "Calls the isMaster command"
    },
    {
      "name": "hello",
      "description": "Calls the hello command"
    },
    {
      "name": "serverBuildInfo",
      "description": "returns the db serverBuildInfo. uses the buildInfo command"
    },
    {
      "name": "serverStatus",
      "description": "returns the server stats. uses the serverStatus command"
    },
    {
      "name": "stats",
      "description": "returns the db stats. uses the dbStats command"
    },
    {
      "name": "hostInfo",
      "description": "Calls the hostInfo command"
    },
    {
      "name": "serverCmdLineOpts",
      "description": "returns the db serverCmdLineOpts. uses the getCmdLineOpts command"
    },
    {
      "name": "rotateCertificates",
      "description": "Calls the rotateCertificates command"
    },
    {
      "name": "printCollectionStats",
      "description": "Prints the collection.stats for each collection in the db."
    },
    {
      "name": "getProfilingStatus",
      "description": "returns the db getProfilingStatus. uses the profile command"
    },
    {
      "name": "setProfilingLevel",
      "description": "returns the db setProfilingLevel. uses the profile command"
    },
    {
      "name": "setLogLevel",
      "description": "returns the db setLogLevel. uses the setParameter command"
    },
    {
      "name": "getLogComponents",
      "description": "returns the db getLogComponents. uses the getParameter command"
    },
    {
      "name": "cloneDatabase",
      "description": "deprecated, non-functional"
    },
    {
      "name": "cloneCollection",
      "description": "deprecated, non-functional"
    },
    {
      "name": "copyDatabase",
      "description": "deprecated, non-functional"
    },
    {
      "name": "commandHelp",
      "description": "returns the db commandHelp. uses the passed in command with help: true"
    },
    {
      "name": "listCommands",
      "description": "Calls the listCommands command"
    },
    {
      "name": "getLastErrorObj",
      "description": "Calls the getLastError command"
    },
    {
      "name": "getLastError",
      "description": "Calls the getLastError command"
    },
    {
      "name": "printShardingStatus",
      "description": "Calls sh.status(verbose)"
    },
    {
      "name": "printSecondaryReplicationInfo",
      "description": "Prints secondary replicaset information"
    },
    {
      "name": "getReplicationInfo",
      "description": "Returns replication information"
    },
    {
      "name": "printReplicationInfo",
      "description": "Formats sh.getReplicationInfo"
    },
    {
      "name": "printSlaveReplicationInfo",
      "description": "DEPRECATED. Use db.printSecondaryReplicationInfo"
    },
    {
      "name": "setSecondaryOk",
      "description": "This method is deprecated. Use db.getMongo().setReadPref() instead"
    },
    {
      "name": "watch",
      "description": "Opens a change stream cursor on the database"
    },
    {
      "name": "sql",
      "description": "(Experimental) Runs a SQL query against Atlas Data Lake. Note: this is an experimental feature that may be subject to change in future releases."
    },
    {
      "name": "checkMetadataConsistency",
      "description": "Returns a cursor with information about metadata inconsistencies"
    }
  ]
}
```


## rs.help()

```json
{
  "help": "Replica Set Class",
  "docs": "https://docs.mongodb.com/manual/reference/method/js-replication/",
  "attr": [
    {
      "name": "initiate",
      "description": "Initiates the replica set."
    },
    {
      "name": "config",
      "description": "Returns a document that contains the current replica set configuration."
    },
    {
      "name": "conf",
      "description": "Calls replSetConfig"
    },
    {
      "name": "reconfig",
      "description": "Reconfigures an existing replica set, overwriting the existing replica set configuration."
    },
    {
      "name": "reconfigForPSASet",
      "description": "Reconfigures an existing replica set, overwriting the existing replica set configuration, if the reconfiguration is a transition from a Primary-Arbiter to a Primary-Secondary-Arbiter set."
    },
    {
      "name": "status",
      "description": "Calls replSetGetStatus"
    },
    {
      "name": "isMaster",
      "description": "Calls isMaster"
    },
    {
      "name": "hello",
      "description": "Calls hello"
    },
    {
      "name": "printSecondaryReplicationInfo",
      "description": "Calls db.printSecondaryReplicationInfo"
    },
    {
      "name": "printSlaveReplicationInfo",
      "description": "DEPRECATED. Use rs.printSecondaryReplicationInfo"
    },
    {
      "name": "printReplicationInfo",
      "description": "Calls db.printReplicationInfo"
    },
    {
      "name": "add",
      "description": "Adds replica set member to replica set."
    },
    {
      "name": "addArb",
      "description": "Calls rs.add with arbiterOnly=true"
    },
    {
      "name": "remove",
      "description": "Removes a replica set member."
    },
    {
      "name": "freeze",
      "description": "Prevents the current member from seeking election as primary for a period of time. Uses the replSetFreeze command"
    },
    {
      "name": "stepDown",
      "description": "Causes the current primary to become a secondary which forces an election. If no stepDownSecs is provided, uses 60 seconds. Uses the replSetStepDown command"
    },
    {
      "name": "syncFrom",
      "description": "Sets the member that this replica set member will sync from, overriding the default sync target selection logic."
    },
    {
      "name": "secondaryOk",
      "description": "This method is deprecated. Use db.getMongo().setReadPref() instead"
    }
  ]
}
```

### collections.help()

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























