--判断表是否存在
drop table if exists aaa
create table aaa(sname varchar(20) not null,age int not null default(100))
go
--判断视图是否存在
drop view if exists vw_aaa
go
create view vw_aaa as
select * from aaa
go
--判断主键是否存在
if object_id('dbo.pk_aaa_sname','PK') is not null
--删除主键
alter table aaa drop constraint pk_aaa_sname
--添加主键
alter table aaa add constraint pk_aaa_sname primary key clustered (sname ,age)

--默认值约束
if object_id('dbo.df_aaa_age','D') is not null
alter table aaa drop constraint df_aaa_age 
alter table aaa add constraint df_aaa_age default((100)) for age

--判断索引是否存在
if exists(select 1 From sys.indexes where name='idx_aaa_a' and object_id=object_id('aaa','U'))
drop index idx_aaa_a on aaa
create index idx_aaa_a on aaa (sname)

if exists(select 1 From sys.indexes where name='idx_aaa_b' and object_id=object_id('aaa','U'))
drop index idx_aaa_b on aaa
create index idx_aaa_b on aaa (age)



