| 资源            | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| RID             | 用于锁定堆中的单个行的行标识符。                             |
| KEY             | 索引中用于保护可序列化事务中的键范围的行锁。                 |
| PAGE            | 数据库中的 8 KB 页，例如数据页或索引页。                     |
| EXTENT          | 一组连续的八页，例如数据页或索引页。                         |
| HoBT            | 堆或 B 树。 用于保护没有聚集索引的表中的 B 树（索引）或堆数据页的锁。 |
| TABLE           | 包括所有数据和索引的整个表。                                 |
| FILE            | 数据库文件。                                                 |
| APPLICATION     | 应用程序专用的资源。                                         |
| METADATA        | 元数据锁。                                                   |
| ALLOCATION_UNIT | 分配单元。                                                   |
| DATABASE        | 整个数据库。                                                 |

# 锁的提示符hint

## nolock

> nolock 不加锁（可以读到未提交的修改，脏读）

## readpast

>readpast(查询时跳过被锁定的记录)

## updlock

>updlock 更新锁，把查询到的记录加锁，其他事物无法修改，等到后续要修改的时候锁会升级为排它锁。默认情况下select使用的是S锁，查询语句结束立即释放锁，而不是等到事务结束才释放，加UPDLOCK会使得锁定延迟到事务提交

```sql
BEGIN TRANSACTION;
SELECT * FROM myTable WITH (UPDLOCK)WHERE name = 'John';
UPDATE myTable  SET name ='aa' WHERE name = 'John';
-- 执行到第2行时候锁的情况：
-- RID  U
-- PAGE IU
-- OBJECT IX

-- 执行到第3行时候锁的情况：
-- RID  X
-- PAGE IX
-- OBJECT IX
```

## holdlock

>加共享锁，直到事物结束才释放

## rowlock

> 强行使用行级锁

## paglock

> 强行使用页锁

## tablock

> 强行使用表锁



[死锁指南 - SQL Server | Microsoft Learn](https://learn.microsoft.com/zh-cn/sql/relational-databases/sql-server-deadlocks-guide?view=sql-server-ver16)
