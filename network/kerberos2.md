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
{"t":{"$date":"2024-08-22T17:27:29.635+08:00"},"s":"I",  "c":"NETWORK",  