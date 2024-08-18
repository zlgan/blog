# 查看安装的角色



```powershell
 Get-WindowsFeature |?{$_.installed -eq $true}
```

# AD 活动目录





```powershell
#查看域账户
PS C:\Users\Administrator\Desktop> get-aduser -Filter *

DistinguishedName : CN=Administrator,CN=Users,DC=top,DC=com
Enabled           : True
GivenName         :
Name              : Administrator
ObjectClass       : user
ObjectGUID        : 26299488-ff7b-4c88-8829-2c9543e2e1fb
SamAccountName    : Administrator
SID               : S-1-5-21-3522673559-2889240798-3553025543-500
Surname           :
UserPrincipalName :


#查看域中的计算机
PS C:\Users\Administrator\Desktop> Get-ADComputer -Filter *

DistinguishedName : CN=WINSERVER01,OU=Domain Controllers,DC=top,DC=com
DNSHostName       : winServer01.top.com
Enabled           : True
Name              : WINSERVER01
ObjectClass       : computer
ObjectGUID        : 40b52875-7ce6-4d59-8e36-b44fc438fed1
SamAccountName    : WINSERVER01$
SID               : S-1-5-21-3522673559-2889240798-3553025543-1000
UserPrincipalName :
```

# 修改计算机的SID





```
sysprep 是 Windows 自带的工具，用于准备系统部署，重置 SID。

打开命令提示符，导航到 C:\Windows\System32\Sysprep 目录。

运行以下命令：

cmd
复制代码
sysprep /generalize /oobe /shutdown
该命令会重置计算机的 SID，并关闭计算机。
```

