nolock 不加锁（可以读到未提交的修改，脏读）
readpast(查询时跳过被锁定的记录)
updlock 更新锁，把查询到的记录加锁，其他事物无法修改，等到后续要修改的时候锁会升级为排它锁
rowlock 强制使用行级锁
holdlock 加共享锁，直到事物结束才释放
xlock意思是直接对表加排他锁

updlock与共享锁兼容


对于堆表无法使用行级锁

锁的资源类型：
KEY：索引键
RID：数据行 （文件编号：分页编号：Slot编号）
PAG：分页编号
TAB：表
FILE：数据库文件
·DB：数据库
IDX：索引行

锁的类型：
共享锁s
排他锁x
更新锁u
意向锁I

一条语句执行
begin tran
select * From lock1 with(updlock,rowlock) where c2=1
sp_lock
59	1	1716201164	1	PAG	1:376                           	IU	GRANT
59	1	1716201164	1	KEY	(8194443284a0)                  	U	GRANT
59	1	1716201164	0	TAB	                                	IX	GRANT


查看数据库的隔离级别
DBCC Useroptions

# 开启事务READ_COMMITTED_SNAPSHOT 隔离级别
ALTER DATABASE DemoDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE DemoDB SET ALLOW_SNAPSHOT_ISOLATION ON
ALTER DATABASE DemoDB SET READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE DemoDB SET MULTI_USER

