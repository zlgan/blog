---
title: SqlServer权限管理
date: 2022-06-12 17:48:30
tags: 
categories: Database
---

# 登录

```sql
--删除并创建登录
DROP LOGIN [LEOCOMPUTER\dblogin1] 
CREATE LOGIN [LEOCOMPUTER\dblogin1] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
```

# 服务器角色

```sql
exec sp_addrolemember 'db_owner','LEOCOMPUTER\dblogin1'	
```

# 创建用户

```sql
--基于登录名创建数据库用户
DROP USER [LEOCOMPUTER\dblogin1]
CREATE USER [LEOCOMPUTER\dblogin1] FOR LOGIN [LEOCOMPUTER\dblogin1] WITH DEFAULT_SCHEMA=[dbo]
```

