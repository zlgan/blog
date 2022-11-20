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

