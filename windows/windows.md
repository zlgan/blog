# 查看windows版本
```powershell
winver
```

# 电源管理

```powershell
powercfg /hibernate on #启用休眠
powercfg /hibernate off #禁用休眠
```


# 账户管理

```powershell
#启用管理员账户
net user Administrator /active:yes

#启用/禁用密码要求
net user Administrator /passwordreq:yes

```

# 进程管理
```powershell
#1.Find the target process
PS C:\Users\administrator\Desktop> tasklist /fi "services eq mongo28017"

Image Name                     PID Session Name        Session#    Mem Usage
========================= ======== ================ =========== ============
mongod.exe                   16232 Services                   0    267,620 K

#2.Force kill the process 
PS C:\Users\administrator\Desktop> taskkill /F /PID 16232
SUCCESS: The process with PID 16232 has been terminated.
```
控制面板命令：

control 打开控制面板



![image-20240729214131909](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214131909.png)

sysdm.cpl 打开系统属性

![image-20240729214217727](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214217727.png)

ncpa.cpl 打开网络连接

![image-20240729214410741](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214410741.png)

firewall.cpl 打开防火墙

![image-20240729214500905](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214500905.png)

powercfg.cpl 打开电源管理

![image-20240729214634818](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214634818.png)

inetcpl.cpl  打开internet属性

![image-20240729214816458](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214816458.png)

appwiz.cpl 打开程序和功能

![image-20240729214929661](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20240729214929661.png)
