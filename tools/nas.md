

# 系统信息

![image-20240420190257124](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240420190257124.png)

![image-20240420190433746](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240420190433746.png)

![image-20240420190455716](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240420190455716.png)

# 修改root密码

```
synouser --setpw root 密码
```

# CLI 命令行管理工具

- https://blog.miniasp.com/post/2022/10/04/Synology-NAS-CLI-Administrator-Guide





## synoservice 

### docker

```bash
 #查看docker的运行状态
root@Nas:/# synoservice --status | grep -i docker
service [pkgctl-Docker] status=[error]
	[pkgctl-Docker] is stop. 
```

# docker

## 配置文件

```bash
#docker 配置 
/var/packages/Docker/etc/dockerd.json


```

