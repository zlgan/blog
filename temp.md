English
streamline
Mutations
hesitate
upcoming 
concern 
Sorry got urgent matter to handle, rescheduling this call to Friday afternoon instead
Please refer the architecture diagram as below.
Please feel free to expand this invitation to relevant parties, like cloud PaaS team and solace team.
I don't think half an hour is enough, but let's get in touch and decide what to do next.
Would you mind helping arrange a follow up to continue the conversation
I want to make sure the server team's questions are fully answered/clarified before they start setting up the server environment on December 1, 2022
Please find the action items below, I think it would make sense to schedule another checkpoint call next week.
While we wait for Andy's response, could you please also elaborate on the concerns you raised on the call yesterday so that Andy is aware of it and incorporates it into the solution design?
Can I assume the following information is for future testing of ultra-low level arrangements?


Acceptance Criteria
what's the point

with barely a prompt, Barbara talked on
Admin user could input tagline and message in both Chi and Eng for each template
as-is
there is a hints message to encourage user to create post
User did not save and accidently kill app 

================================================================
git log --after="2014-02-12T16:36:00-07:00" --author=leozlgan
========================================================================
todo
k8s
app dynamic
MQ
cometChat

=======================================================================
填写工时：
https://timesheet.gientech.com/#/Account/MyIndex.aspx
员工自助
https://hub.gientech.com/?q=page-staffself


https://www.cometchat.com/docs/react-native-chat-sdk/key-concepts


apikey:
527bbf72afa3d8176d40dd7d72d7d9419a0df2bd
authkey:
235d06e68480b43a5c7983a2558b0c2ab0611f1e



--------db full-----------
USE AdventureWorks2022;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE AdventureWorks2022
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (AdventureWorks2022_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE AdventureWorks2022
SET RECOVERY FULL;
GO


--EDA
https://aws.amazon.com/cn/what-is/eda/
https://solace.com/what-is-event-driven-architecture/
https://www.redhat.com/en/topics/integration/what-is-an-event-mesh

--设置变量风格
https://dotnetthoughts.net/customize-create-and-initialize-field/


Sync call Async
https://www.cnblogs.com/yuanshuo/p/13807557.html
haha
xixi
hehe
1111

https://docs.github.com/zh


要查询当前数据库中未提交的事务，你可以使用以下SQL查询：

```sql
SELECT
    r.session_id,
    r.transaction_id,
    r.database_id,
    t.name AS 'Transaction Name',
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.percent_complete,
    r.estimated_completion_time,
    r.cpu_time,
    r.total_elapsed_time
FROM sys.dm_exec_requests r
INNER JOIN sys.dm_tran_session_transactions t
ON r.session_id = t.session_id;
```

这个查询会返回当前数据库中正在执行的事务的相关信息，包括事务ID、数据库ID、事务状态等等。你可以根据需要进一步筛选未提交的事务。

# develop app
- https://32a3058a.isolation.zscaler.com/profile/9160b3a5-1571-41d2-a091-3762f83cdc25/zia-session/?controls_id=d90c6343-5842-4bb5-a982-43a9ae951f9f&region=sin&tenant=29ce959a9fd0&user=a2119ee0529d2dc4e2c92f29946a5d04f381ba599e9de9ea28d1df7d7e22c2ea&original_url=https%3A%2F%2Fkotlin.liying-cn.net%2Fdocs%2Freference_zh%2Fcross-platform-frameworks.html&key=sh-1&hmac=ff7c821687a31f68eedf608e4f89847b5b09a3c08c23dc3169365e4bc62e9168
- alipay,wechat pay api intergress
- app+ wechat tiny app
- https://flutter.cn/docs
- http://chuquan.me/2018/08/26/graphics-rending-principle-gpu/
- 
# recent topic
- xunit test host
- azure notification hub
- OAuth 2.0
- review dotnet core 6-8 new features
# google fcm migration
- https://firebase.google.com/docs/cloud-messaging/migrate-v1?hl=zh-cn
- https://learn.microsoft.com/zh-cn/azure/notification-hubs/notification-hubs-gcm-to-fcm#migration-steps

# tiny tools
- drawio
    - draw flow chat : https://app.diagrams.net/?splash=0&ui=sketch
    - https://www.drawio.com/doc/
 
## shell folders 
https://ss64.com/nt/shell.html
```powershell
shell:startup #是一個特殊的 Shell 文件夾路徑，它指向當前用戶的啟動文件夾
shell:desktop：#打開用戶桌面文件夾，其中包含用戶的桌面快捷方式和文件。
shell:documents：#打開用戶的文檔文件夾，其中包含用戶的文檔文件。
shell:downloads：#打開用戶的下載文件夾，其中包含用戶下載的文件。
shell:favorites：#打開用戶的收藏夾，其中包含用戶的收藏夾快捷方式。
shell:history：#打開用戶的歷史文件夾，其中包含用戶的瀏覽歷史記錄。
shell:recent：#打開用戶的最近文件夾，其中包含最近訪問的文件的快捷方式。
shell:sendto：#打開用戶的發送到文件夾，其中包含用於快速發送文件的目標快捷方式。
shell:startmenu：#打開開始菜單文件夾，其中包含開始菜單的快捷方式和文件夾。
shell:programs：#打開用戶的程序文件夾，其中包含用戶的安裝的程序和快捷方式。
shell:system：#打開系統文件夾，其中包含操作系統的系統文件和資源。

在powershell打开上述文件夹,example:
explorer shell:startup
```
# 20231130
- cmd 命令 where的用法
- 
# 20231201
刷新视图：
EXEC sp_refreshview 'vw_mc_user_achievement';

- 阿里技术专家详解 DDD 系列文章整理成PDF文件
    - 使用特性来对数据格式做基本校验
    - DDD中如何进行业务规则的校验
    - 什么是代码遵循了 DRY 原则和单一性原则
# 20231204
宏观架构比如SOA架构、微服务架构，应用内部的架构设计，如DDD
什么是数据库分片：https://aws.amazon.com/cn/what-is/database-sharding/
列出项目中所有的nuget包：dotnet list package 
DDD中各个层次对象的：各个层次对象之间使用AutoMapper转换
- UI：DTO
- Domain：Entity，ValueObject
- DB：DataObject（DO）
Auto mapper 文档:https://docs.automapper.org/en/latest/Getting-started.html
DDD设计心得：
- 识别系统当中的所有Entity和VO
- 当一个业务逻辑设计多个Enity和VO的协作和交互，需要使用Domain Servie来实现
- Entity、VO和Domain Service封装所有的业务逻辑
- 依赖外部系统的功能时，使用防腐层ACL,一般使用适配器来协调内外接口的不一致的情况。
- Entity状态的初始化：
   - 对于Entity生命周期开始的时候应该初始化，并且不会发生变化的状态应该是用构造函数初始化
   - 对于其他情况应该是用Set函数初始化（例如status状态的更新）
