![image-20240128181818374](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240128181818374.png)

 ![image-20240128182520410](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240128182520410.png)

![image-20240128182659475](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240128182659475.png)



# 安装部署
1.https://cloud.tencent.com/developer/article/1900495



# push
```bash
index=iosbs sourcetype=iosbs_txn_pushas  (source="*PersonalizationService*.log" OR  source="*\PushAgent*.log" OR source="*\PushSvc*.log")
|search "ERR]"

```

# gamification 
```bash
#All
index=iosbs gamification earliest=-3h

#AS
index=iosbs host="magameas*" earliest=-3h

#Web
index=iosbs host!="magameas*" earliest=-5h  (gamification or objectstorage)

#goalx
index=iosbs host="magameas*" earliest=-5h ">> HTTP" 

#IBURN
index=iosbs host="magameas*" earliest=-5h "AcceptMessageEvent" 

```


## other
```bash
index=iosbs  gamification earliest=-5h 
| head 100 
| tail 80
| rare 3 host
| top 10 host
| regex _raw= "in \d{3,}\.?\d* ms"
```


原始数据-->索引-->事件-->索引桶


# Splunk 命令
## spath 
> 从xml或者json中提取字段
```bash
#从data中提取字段
... | spath input=data path=fieldName
#提取字段并重命名
... | spath input=data path=fieldName output=newFieldName
#提取多个嵌套的字段
index=your_index | spath input=_raw path=event.user.name output=userName | spath input=_raw path=event.action output=userAction

```

## eval
```bash
#添加新字段
| eval author="leo"

#修改现有字段
| eval _raw=_raw+"newstring"
| eval price = price + 10
| eval total = price + tax

#条件计算
| eval status = if(age > 18, "adult", "minor")

```

## stats
> 用于聚合和统计数据，比如求和、平均值、计数等。

```bash
| stats count by StatusCode
```

## where 
```bash

|savedsearch gamification
| top StatusCode
| top limit=1 StatusCode



```

sourcetype=access_* status=200 action=purchase [search sourcetype=access_* status=200 action=purchase | top limit=1 clientip | table clientip] | stats count, distinct_count(productId), values(productId) by clientip



