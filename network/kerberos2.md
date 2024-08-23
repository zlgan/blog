# setup

## KDC

### create domain user for service

```
#1.create user
dev\mongouser
#2.set Delegation
```

### Add SPN for mongod

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
### 生成密钥表

```powershell
ktpass -princ HTTP/my-mss-server.my-company.com@MYDOMAIN.COM -mapuser my-mss-deployment@MYDOMAIN.COM -pass password -ptype KRB5_NT_PRINCIPAL -crypto ALL -out my-mss-deployment.keytab
```

## mongod

### 将 Kerberos 主体添加到 MongoDB。

```json
use admin
db.createUser(
  {
    user: "mongoAdmin",
    pwd: "0000abc!",
    roles: [
      { role: "userAdminAnyDatabase", db: "admin" },
      { role: "readWriteAnyDatabase", db: "admin" }
    ]
  }
)
```
```json
use $external
db.createUser(
   {
     user: "mongouser@DEV.HK",
     roles: [ { role: "read", db: "test" } ]
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

## client
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



# Trouble shot

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

https://learn.microsoft.com/th-th/sql/linux/sql-server-linux-ad-auth-understanding?view=sql-server-2017
