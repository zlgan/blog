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