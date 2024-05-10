# 阿里云注册域名

1. 进入 云解析DNS

   https://dns.console.aliyun.com/?spm=5176.12818093_-1363046575.console-base.ddns.3be916d0xHGnSs#/dns/domainList

2. ![image-20240413210027785](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240413210027785.png)

# docker中运行ddns-go

```bash
#拉取镜像
docker pull  jeessy/ddns-go

#启动容器运行，默认端口：9876
docker run -d --name ddns-go --restart=always --net=host -v /opt/ddns-go:/root jeessy/ddns-go
```



# 配置ddns-go

![image-20240413205133770](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240413205133770.png)