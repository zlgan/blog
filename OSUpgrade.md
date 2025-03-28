# uefi、bios设置
1. 关闭UEFI的安全启动选项		
# windows启动盘制作
# debian启动盘制作
# 磁盘分区
1. 4k对齐
2. 
## 分区明细
| 分区用途      | 大小   | 文件系统  | 挂载点 | 备注                                                         |
| ------------- | ------ | --------- | -------- | ------------------------------------------------------------ |
| EFI 系统分区  | 1GB  | FAT32     | /boot/efi   | ​必须首位，存放 UEFI 引导文件，Windows 和 Debian 共用|
| Windows 系统盘 | 300GB  | NTFS      |    |系统文件和软件                           |
| 共享存储分区  | 200GB  | exFAT     | /mnt/share   | 跨系统共享文件（需在 Debian 安装 exfat-fuse 和 exfat-utils 包） |
| Debian boot  | 2GB    | ext4      | /boot | 系统内核文件                                         |
| Debian swap  | 16GB    | sda2-vg01-swap     ext4 | [SWAP]| 交换分区                                         |
| Debian root  | 200GB  | sda2-vg01-root      ext4| / |                                        |
| Debian home  | 100GB    | sda2-vg01-home      ext4|  |                                         |

# windows设置

1. windows 的电源管理中关闭快速启动			