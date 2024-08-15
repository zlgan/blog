---
title: powershell命令之--get-aduser管理域用户
date: 2021-03-06 19:33:45
tags: 
categories: Powershell
---

### 查询所有域用户

```powershell
PS C:\Users\Administrator> Get-ADUser -Filter *


DistinguishedName : CN=Administrator,CN=Users,DC=topdm,DC=com
Enabled           : True
GivenName         :
Name              : Administrator
ObjectClass       : user
ObjectGUID        : 2be00a71-3a3a-44e5-b55b-b66edc2432ba
SamAccountName    : Administrator
SID               : S-1-5-21-24746217-1637656304-1526929586-500
Surname           :
UserPrincipalName :

DistinguishedName : CN=Guest,CN=Users,DC=topdm,DC=com
Enabled           : False
GivenName         :
Name              : Guest
ObjectClass       : user
ObjectGUID        : 08637438-3cfe-49f3-b477-603268aa4793
SamAccountName    : Guest
SID               : S-1-5-21-24746217-1637656304-1526929586-501
Surname           :
UserPrincipalName :

```

### 查询指定域用户

```powershell
PS C:\Users\Administrator> Get-ADUser -Identity user1

DistinguishedName : CN=user1,CN=Users,DC=topdm,DC=com
Enabled           : True
GivenName         :
Name              : user1
ObjectClass       : user
ObjectGUID        : e6a96bd2-69fc-4687-97ad-dcd07cc199ad
SamAccountName    : user1
SID               : S-1-5-21-24746217-1637656304-1526929586-1106
Surname           : user1
UserPrincipalName : user1@topdm.com

```