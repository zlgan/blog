



1. 创建用户主体：

   > 主体属于名为 *Realm* 的管理单位。对于每个 Realm，“Kerberos 密钥分发中心”(KDC) 都会维护该 Realm 主体和主体关联的“秘钥”数据库

   在AD中创建一个用户账户 reportingapp@EXAMPLE.NET

2. 创建服务主体

   为集群中所有节点创建SPN（ Service Principal Name）服务主体名，并关联到指定账户

>   setspn.exe -S <service>/<fully qualified domain name>@<KERBEROS REALM>

   ```powershell
   #删除注册
   setspn.exe -D mongodb38017/winServer02.top.com top\mongouser
   #创建SPN，并关联登录账号
   setspn.exe -S mongodb38017/winServer02.top.com top\mongouser
   #查询SPN
   PS C:\Users\Administrator\Desktop> setspn -l mongouser
   Registered ServicePrincipalNames 用于 CN=mongouser,CN=Users,DC=top,DC=com:
           mongodb/winServer02.top.com
           mongodb/winServer02.top.com:38017
   ```

3. 将 Kerberos 用户主体添加到 MongoDB

```powershell

use $external
db.createUser(
   {
     user: "mongouser@top.com",
     roles: [ { role: "root", db: "records" } ]
   }
)
```

4. 生成keytab密钥表文件（linux平台的服务需要）

   ```powershell
   ktpass -princ nfs/fss-mt-ad-1.fss-ad.com@FSS-AD.COM -mapuser FSS-AD\fss-mt-ad-1 -crypto AES256-SHA1 +rndpass -ptype KRB5_NT_SRV_HST  -out fss-mt-ad-1.keytab
   # -princ nfs/fss-mt-ad-1.fss-ad.com@FSS-AD.COM：指定要为其生成 keytab 文件的主体名称（Principal Name）。在这个示例中，主体名称是 nfs/fss-mt-ad-1.fss-ad.com@FSS-AD.COM
   # -mapuser FSS-AD\fss-mt-ad-1：将指定的用户（User）映射到 Kerberos 主体。在这里，用户 FSS-AD\fss-mt-ad-1 被映射到主体 nfs/fss-mt-ad-1.fss-ad.com@FSS-AD.COM
   # -crypto AES256-SHA1：指定要使用的加密类型。在这里，使用 AES256-SHA1 算法进行加密
   # +rndpass：生成一个随机密码，并将其与 keytab 文件一起输出。这样可以确保 keytab 文件中包含一个安全的随机密码
   # -ptype KRB5_NT_SRV_HST：指定主体类型。在这里，主体类型为 KRB5_NT_SRV_HST（Kerberos 服务主体）
   # -out fss-mt-ad-1.keytab：指定生成的 keytab 文件的输出路径和文件名。在这里，生成的 keytab 文件将保存为 fss-mt-ad-1.keytab
   ```

5. 连接测试：

   ```
   PS C:\Users\mongouser\Desktop> mongosh.exe --host  winServer02.top.com --port 38017 --authenticationMechanism=GSSAPI --authenticationDatabase='$external' --username  'top\mongouser'
   ```

   

# tools 

- setspn 

  > 为 MongoDB Windows 服务分配服务主体名称
  >
  > https://web.mit.edu/kerberos/krb5-latest/doc/

- **ktpass** 

  > 工具为服务主体名称 (SPN) 生成 Kerberos 密钥表文件

- mongokerberos.exe 

  > 用于根据正在运行的 Kerberos 部署测试 MongoDB 的 Kerberos 和 GSSAPI[配置选项](https://www.mongodb.com/zh-cn/docs/manual/reference/configuration-options/#std-label-security.sasl.options)

# ref

https://seevae.github.io/2020/09/12/%E8%AF%A6%E8%A7%A3kerberos%E8%AE%A4%E8%AF%81%E6%B5%81%E7%A8%8B/

