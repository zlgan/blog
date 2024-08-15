





1. ![image-20240127140734744](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240127140734744.png)

   出现这个警告需要执行以下脚本在源数据库上打开cdc（变更数据捕获）

```sql
USE MigrationTest
GO
IF (N'MigrationTest') NOT in (SELECT name FROM sys.databases WHERE is_cdc_enabled = 1)
EXEC sys.sp_cdc_enable_db;
GO
```





## 