# servers:

| ip             | hostname        | roles         | domain | platform            | account                     |
| -------------- | --------------- | ------------- | ------ | ------------------- | --------------------------- |
| 10.194.168.196 | EWIN2WW311-DIT3 | AD-DC,DNS,KDC | dev.hk | windows server 2019 | dev\administrator 0000abc!! |
| 10.194.168.197 | MBSINFOAS11-DIT | Mongod        | dev.hk | windows server 2019 |                             |
| 10.194.168.198 | EWIN2INFOAS01-D | Client        | dev.hk | windows server 2019 |                             |

# setup

## KDC

### create domain user for service

```powershell
[10.194.168.196]: PS C:\> Get-ADUser mongouser
DistinguishedName : CN=mongouser,CN=Users,DC=dev,DC=hk
Enabled           : True
GivenName         : mongouser
Name              : mongouser
ObjectClass       : user
ObjectGUID        : c1d9cfa5-01e0-4b71-841b-a4d931989d18
SamAccountName    : mongouser
SID               : S-1-5-21-217758136-131099017-4145448323-1106
Surname           :
UserPrincipalName : mongouser@dev.hk
```

### Add SPN for mongod

> 1.同一个节点多个端口运行的服务只需要注册一次

```powershell
#删除注册
setspn.exe -D Mongodb/MBSINFOAS11-DIT.dev.hk dev\mongouser
#创建SPN，并关联登录账号
setspn.exe -S Mongodb/MBSINFOAS11-DIT.dev.hk dev\mongouser
#查询SPN
[10.194.168.196]: PS C:\> setspn -l mongouser
Registered ServicePrincipalNames for CN=mongouser,CN=Users,DC=dev,DC=hk:
        Mongodb/MBSINFOAS11-DIT.dev.hk
```
### 生成密钥表keytab

```powershell
ktpass -princ HTTP/my-mss-server.my-company.com@MYDOMAIN.COM -mapuser my-mss-deployment@MYDOMAIN.COM -pass password -ptype KRB5_NT_PRINCIPAL -crypto ALL -out my-mss-deployment.keytab
```

## mongod

### 将 Kerberos 主体添加到 MongoDB。

```json
use admin
use admin
db.createUser(
  {
    user: "mongoAdmin",
    pwd: "0000abc!",
    roles: [
      { role: "userAdminAnyDatabase", db: "admin" },
      { role: "readWriteAnyDatabase", db: "admin" },
      { role: "root", db: "admin" }
    ]
  }
)
```
```json
use $external
db.createUser(
   {
     user: "mongouser@DEV.HK",
     roles: [ { role: "root", db: "admin" } ]
   }
)
```

### 开启Kerberos认证

```yaml
security:
   authorization: enabled
setParameter:
   authenticationMechanisms: GSSAPI
```

### 以mongouser@DEV.HK身份运行服务

```
 mongod.exe --config "F:\mongodb\Node1\cfg\mongod.cfg"  --install --serviceName mongodb27018 --serviceDisplayName mongodb27018 --serviceUser 'mongouser@dev.hk' --servicePassword '0000abc!'
```

###  on container

```shell

docker run \
-e KRB5_KTNAME=/data/conf/mongokerb1.keytab \
--hostname mongokerb1.dev.hk \
--name mongodb_kerberos1 \
-p 28101:27017 -d \
-v /var/mongodb/kerberos/node1/data:/data/data \
-v /var/mongodb/kerberos/node1/log/:/data/log/ \
-v /var/mongodb/kerberos/node1/conf/:/data/conf/ \
--ulimit nofile=64000:64000 \
mongodb/mongodb-enterprise-server-krb5client  --config /data/conf/mongod.conf



#export keytab
ktpass -princ mongodb/mongokerb1.dev.hk@DEV.HK -mapuser mongouser@DEV.HK -pass 0000abc! -ptype KRB5_NT_PRINCIPAL -crypto ALL -out mongokerb1.keytab

#show keytab
klist -k mongokerb1.keytab
Keytab name: FILE:mongokerb1.keytab
KVNO Principal
---- --------------------------------------------------------------------------
   3 mongodb/mongokerb1.dev.hk@DEV.HK
   3 mongodb/mongokerb1.dev.hk@DEV.HK
   3 mongodb/mongokerb1.dev.hk@DEV.HK
   3 mongodb/mongokerb1.dev.hk@DEV.HK
   3 mongodb/mongokerb1.dev.hk@DEV.HK
   
   
```

#### validate environment

```shell
bash-5.1# mongokerberos --client --username mongod
Resolving kerberos environment...
[OK] Kerberos environment resolved without errors.

Verifying DNS resolution works with Kerberos service at mongokerb1.dev.hk...
[OK] DNS test successful.

Getting MIT Kerberos KRB5 environment variables...
        * KRB5CCNAME: not set.
        * KRB5_CLIENT_KTNAME: not set.
        * KRB5_CONFIG: not set.
        * KRB5_KTNAME: /data/conf/mongokerb1.keytab
        * KRB5_TRACE: not set.
[OK]

Verifying existence of KRB5 client keytab FILE:/var/kerberos/krb5/user/0/client.keytab...
[INFO] KRB5 Client keytab does not exist.
        * Users without a client keytab need to kinit in order to obtain TGTs.

Checking principal(s) in KRB5 keytab...
[FAIL] Neither client keytab nor credentials cache contains entry with user principal name for specified --user mongod   
```



#### krb5.conf

```
# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
    default = FILE:/var/log/krb5libs.log
    kdc = FILE:/var/log/krb5kdc.log
    admin_server = FILE:/var/log/kadmind.log

[libdefaults]
    dns_lookup_realm = false
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    rdns = false
    pkinit_anchors = FILE:/etc/pki/tls/certs/ca-bundle.crt
    spake_preauth_groups = edwards25519
    dns_canonicalize_hostname = fallback
    qualify_shortname = ""
    default_realm = DEV.HK
    default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 DEV.HK = {
     kdc = EWIN2WW311-DIT3.dev.hk
     admin_server = EWIN2WW311-DIT3.dev.hk
 }

[domain_realm]
 .dev.hk = DEV.HK
 dev.hk = DEV.HK
```



## client

### connection string

```
mongodb://mongouser%40DEV.HK@MBSINFOAS11-DIT.dev.hk:27017/?authMechanism=GSSAPI&authSource=%24external
```

### Kerberos ticket manage

```powershell
#list all ticket
klist

#delete 
 PS C:\Windows\system32> klist purge
Current LogonId is 0:0x4bbb00
        Deleting all tickets:
        Ticket(s) purged!
#获取服务的票据
PS C:\Users\mongouser\Desktop> klist get mongodb/MBSINFOAS11-DIT.dev.hk
Current LogonId is 0:0x591258a
A ticket to mongodb/MBSINFOAS11-DIT.dev.hk has been retrieved successfully.
Cached Tickets: (2)
#0>     Client: mongouser @ DEV.HK
        Server: krbtgt/DEV.HK @ DEV.HK
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
        Ticket Flags 0x40e10000 -> forwardable renewable initial pre_authent name_canonicalize
        Start Time: 8/23/2024 16:07:32 (local)
        End Time:   8/24/2024 2:07:32 (local)
        Renew Time: 8/30/2024 15:14:24 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0x1 -> PRIMARY
        Kdc Called: ewin2ww311-dit3.dev.hk
#1>     Client: mongouser @ DEV.HK
        Server: mongodb/MBSINFOAS11-DIT.dev.hk @ DEV.HK
        KerbTicket Encryption Type: RSADSI RC4-HMAC(NT)
        Ticket Flags 0x40a50000 -> forwardable renewable pre_authent ok_as_delegate name_canonicalize
        Start Time: 8/23/2024 16:07:32 (local)
        End Time:   8/24/2024 2:07:32 (local)
        Renew Time: 8/30/2024 15:14:24 (local)
        Session Key Type: RSADSI RC4-HMAC(NT)
        Cache Flags: 0
        Kdc Called: ewin2ww311-dit3.dev.hk
```



## check list

- firewall 

  Server Manager-->Local Server-->Windows defender firewall

- time sync for all nodes

# Troubleshot

## Was not able to acquire principal id from Cyrus SASL

```
{"t":{"$date":"2024-08-22T17:27:29.635+08:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"10.194.168.198:62223","uuid":{"uuid":{"$uuid":"f356f1f7-72c2-49ff-bf1f-1c08868fd789"}},"connectionId":135,"connectionCount":1}}
{"t":{"$date":"2024-08-22T17:27:29.647+08:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn135","msg":"client metadata","attr":{"remote":"10.194.168.198:62223","client":"conn135","doc":{"application":{"name":"MongoDB Compass"},"driver":{"name":"nodejs","version":"6.3.0"},"platform":"Node.js v18.15.0, LE","os":{"name":"win32","architecture":"x64","version":"10.0.17763","type":"Windows_NT"}}}}
{"t":{"$date":"2024-08-22T17:27:29.664+08:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"10.194.168.198:62224","uuid":{"uuid":{"$uuid":"b1502f27-0bdc-4eca-a72a-4252103d6639"}},"connectionId":136,"connectionCount":2}}
{"t":{"$date":"2024-08-22T17:27:29.667+08:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn136","msg":"client metadata","attr":{"remote":"10.194.168.198:62224","client":"conn136","doc":{"application":{"name":"MongoDB Compass"},"driver":{"name":"nodejs","version":"6.3.0"},"platform":"Node.js v18.15.0, LE","os":{"name":"win32","architecture":"x64","version":"10.0.17763","type":"Windows_NT"}}}}
{"t":{"$date":"2024-08-22T17:27:29.690+08:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn135","msg":"Connection ended","attr":{"remote":"10.194.168.198:62223","uuid":{"uuid":{"$uuid":"f356f1f7-72c2-49ff-bf1f-1c08868fd789"}},"connectionId":135,"connectionCount":1}}
{"t":{"$date":"2024-08-22T17:27:29.705+08:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn136","msg":"Connection ended","attr":{"remote":"10.194.168.198:62224","uuid":{"uuid":{"$uuid":"b1502f27-0bdc-4eca-a72a-4252103d6639"}},"connectionId":136,"connectionCount":0}}
{"t":{"$date":"2024-08-22T17:27:29.705+08:00"},"s":"E",  "c":"ACCESS",   "id":24030,   "ctx":"conn136","msg":"Was not able to acquire principal id from Cyrus SASL","attr":{"result":-6}}
{"t":{"$date":"2024-08-22T17:27:29.705+08:00"},"s":"I",  "c":"ACCESS",   "id":5286307, "ctx":"conn136","msg":"Failed to authenticate","attr":{"client":"10.194.168.198:62224","isSpeculative":false,"isClusterMember":false,"mechanism":"GSSAPI","user":"","db":"$external","error":"AuthenticationAbandoned: Authentication session abandoned, client has likely disconnected","result":337,"metrics":{"conversation_duration":{"micros":36657,"summary":{"0":{"step":1,"duration_micros":468},"1":{"step":2,"duration_micros":270}}}},"extraInfo":{}}}
```



# Memo

## remote login

```
Enter-PSSession 10.194.168.196 -Authentication Negotiate
Enter-PSSession 10.194.168.197 -Authentication Negotiate
Enter-PSSession 10.194.168.198 -Authentication Negotiate
```

## enable kerberos event log

https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-kerberos-event-logging

## 域控制查询

```
 nltest /dsgetdc:dev.hk /force /kdc
 
 nltest: 这是一个用于测试和诊断网络连接和 Active Directory 功能的命令行工具。
/dsgetdc:contoso.com: 这个参数用于获取指定域（在此例中为 contoso.com）的域控制器（Domain Controller, DC）的信息。
/force: 这个选项强制命令立即查找域控制器，而不使用缓存结果。这意味着它将绕过任何已缓存的域控制器信息，确保获取最新的结果。
/kdc: 这个选项指示命令查找 Kerberos 域控制器。KDC 是处理 Kerberos 身份验证请求的服务。
```

## 容器中配置sqlserver kerberos 连接

https://learn.microsoft.com/zh-cn/sql/linux/sql-server-linux-ad-auth-understanding?view=sql-server-2017

https://documentation.suse.com/zh-cn/sles/15-SP2/html/SLES-all/cha-security-kerberos.html
