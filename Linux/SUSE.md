1. 包管理工具 zypper
```bash
sudo zypper install <package> #安装软件包：

```
2. 系统管理工具：Yast

```bash
#查看端口占用情况
ss -tuln
lsof -i -P -n

#关闭防火墙
sudo systemctl stop firewalld
sudo systemctl disable firewalld

```

