---
title: Dapper一对多
date: 2021-12-09 23:03:18
tags:
categories: Dapper
---

### 1.创建表

```sql
create table Orders
(
	orderId varchar(20),
	orderName varchar(20)
)

create table OrderDetails
(
	orderId varchar(20),
	detailsName varchar(20)
)


insert into Orders 
select '1','a' union
select '2','b'

insert into OrderDetails
select '1','a1' union 
select '1','a2' union 
select '1','a3' union 
select '2','b1' union 
select '2','b2'

```

### 2.查询

```c#
 public class Orders
 {
     public string OrderId { get; set; }
     public string OrderName { get; set; }
     public ICollection<OrderDetails> details { get; set; }
 }

 public class OrderDetails
 {
     public string OrderId { get; set; }
     public string DetailsName { get; set; }
 }


public static void Test1()
 {
     string connectionString = "server=.;Initial Catalog=mydatabase;Integrated Security=True;TrustServerCertificate=True";
     using (IDbConnection connection = new SqlConnection(connectionString))
     {
         var orderDictionary = new Dictionary<string, Orders>();
         string cmd = "select a.*,b.* from orders a inner join orderdetails b on a.orderid=b.orderid";
         var data = connection.Query<Orders, OrderDetails, Orders>(cmd, (order, details) =>
         {
             Orders orderEntry;
             if (!orderDictionary.TryGetValue(order.OrderId, out orderEntry))
             {
                 orderEntry = order;
                 orderEntry.details = new List<OrderDetails>();
                 orderDictionary.Add(orderEntry.OrderId, orderEntry);
             }

             orderEntry.details.Add(details);
             return orderEntry;
	//splitOn是orderid，运行时，会从查询结果所有字段列表的最后一个字段开始进行匹配，一直到找到orderid这个字段（大小写忽略），找到的第一个orderid字段匹配TSecond
         }, splitOn: "orderid").Distinct();
     }
 }
```

# 部署Docker的Demo

下面是一个 .NET Core Web API 的示例代码，它将返回一个简单的 "Hello World" 字符串：

```csharp
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("[controller]")]
public class HelloWorldController : ControllerBase
{
    [HttpGet]
    public string Get()
    {
        return "Hello World!";
    }
}
```

接下来，您可以编写一个 Dockerfile，以在 Docker 容器中运行该 Web API 项目。以下是一个示例 Dockerfile：

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# 将 .csproj 文件复制到 /app 目录中
COPY *.csproj ./

# 运行 dotnet restore 命令
RUN dotnet restore

# 将所有文件复制到 /app 目录中
COPY . .

# 构建项目
RUN dotnet publish -c Release -o out

# 使用 .NET 运行时作为基础镜像
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "WebApiDemo.dll"]
```

请注意，上面的 Dockerfile 文件将在基于 .NET Core 5.0 的 Docker 容器中运行。如果您需要使用其他版本的 .NET Core，请相应地更改 Dockerfile 文件。

接下来，您需要使用以下步骤生成 Docker 镜像：

1. 在项目的根目录中打开终端或命令提示符。

2. 使用以下命令构建 Docker 镜像：

```
docker build -t webapidemo .
```

请注意，上面的命令将根据当前目录中的 Dockerfile 文件生成名为 "webapidemo" 的 Docker 镜像。

3. 使用以下命令运行 Docker 容器：

```
docker run -d -p 8080:80 --name webapidemo webapidemo
```

请注意，上面的命令将在名为 "webapidemo" 的容器中运行名为 "webapidemo" 的 Docker 镜像，并将容器的端口映射到主机的端口 8080 上。

最后，您需要将该 Docker 容器部署到 CentOS 服务器上。以下是一个示例命令，用于将 Docker 容器从本地主机迁移到远程 CentOS 服务器：

1. 将 Docker 镜像保存为 tar 文件：

```
docker save webapidemo > webapidemo.tar
```

2. 将 tar 文件复制到 CentOS 服务器上：

```
scp webapidemo.tar user@centos-server:/path/to/destination
```

请注意，上面的命令将 tar 文件复制到名为 "centos-server" 的远程 CentOS 服务器上，并将其保存到目标路径下。

3. 在 CentOS 服务器上加载 Docker 镜像：

```
docker load < webapidemo.tar
```

请注意，上面的命令将从 tar 文件中加载 Docker 镜像。

4. 在 CentOS 服务器上运行 Docker 容器：

```
docker run -d -p 8080:80 --name webapidemo webapidemo
```

请注意，上面的命令将在名为 "webapidemo" 的容器中运行名为 "webapidemo" 的 Docker 镜像，并将容器的端口映射到主机的端口 8080 上。

完成上述步骤后，您的 .NET Core Web API 项目应该已经成功地部署到 CentOS 服务器上了。

