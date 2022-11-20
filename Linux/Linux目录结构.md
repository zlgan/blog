---
title: Linux目录结构
date: 09/28/2021 22:35:48
tags: 
categories: Linux
---
```bash
├── bin -> usr/bin  #bin 是 Binaries (二进制文件) 的缩写, 这个目录存放着最经常使用的命令。
├── boot #这里存放的是启动 Linux 时使用的一些核心文件，包括一些连接文件以及镜像文件。
│   ├── efi
│   ├── grub2
│   └── loader
├── dev #dev 是 Device(设备) 的缩写, 该目录下存放的是 Linux 的外部设备，在 Linux 中访问设备的方式和访问文件的方式是相同的。
│   ├── block
│   ├── bsg
│   ├── bus
│   ├── char
│   ├── cl
│   ├── cpu
│   ├── disk
│   ├── dri
│   ├── fd -> /proc/self/fd
│   ├── hugepages
│   ├── input
│   ├── mapper
│   ├── mqueue
│   ├── net
│   ├── pts
│   ├── raw
│   ├── shm
│   ├── snd
│   └── vfio
├── etc #etc 是 Etcetera(等等) 的缩写,这个目录用来存放所有的系统管理所需要的配置文件和子目录
│   ├── alsa
│   ├── alternatives
│   ├── anaconda
│   ├── audit
│   ├── authselect
│   ├── avahi
│   ├── bash_completion.d
│   ├── binfmt.d
│   ├── bluetooth
│   ├── brltty
│   ├── chkconfig.d
│   ├── chromium
│   ├── cifs-utils
│   ├── cni
│   ├── cockpit
│   ├── containers
│   ├── cron.d
│   ├── cron.daily
│   ├── cron.hourly
│   ├── cron.monthly
│   ├── cron.weekly
│   ├── crypto-policies
│   ├── cups
│   ├── cupshelpers
│   ├── dbus-1
│   ├── dconf
│   ├── default
│   ├── depmod.d
│   ├── dhcp
│   ├── dnf
│   ├── dnsmasq.d
│   ├── dracut.conf.d
│   ├── egl
│   ├── exports.d
│   ├── firefox
│   ├── firewalld
│   ├── flatpak
│   ├── fonts
│   ├── fwupd
│   ├── gconf
│   ├── gcrypt
│   ├── gdm
│   ├── geoclue
│   ├── glvnd
│   ├── gnupg
│   ├── groff
│   ├── grub.d
│   ├── gss
│   ├── gssproxy
│   ├── hp
│   ├── init.d -> rc.d/init.d
│   ├── initial-setup
│   ├── iproute2
│   ├── iscsi
│   ├── issue.d #查看Linux的发行版
│   ├── kdump
│   ├── kernel
│   ├── krb5.conf.d
│   ├── ld.so.conf.d
│   ├── libblockdev
│   ├── libibverbs.d
│   ├── libnl
│   ├── libpaper.d
│   ├── libreport
│   ├── libssh
│   ├── libvirt
│   ├── logrotate.d
│   ├── lsm
│   ├── lvm
│   ├── mcelog
│   ├── microcode_ctl
│   ├── modprobe.d
│   ├── modules-load.d
│   ├── motd.d
│   ├── multipath
│   ├── ndctl
│   ├── NetworkManager
│   ├── nftables
│   ├── nginx
│   ├── nvme
│   ├── oddjob
│   ├── oddjobd.conf.d
│   ├── openldap
│   ├── opt
│   ├── ostree
│   ├── PackageKit
│   ├── pam.d
│   ├── pipewire
│   ├── pkcs11
│   ├── pki
│   ├── plymouth
│   ├── pm
│   ├── polkit-1
│   ├── popt.d
│   ├── prelink.conf.d
│   ├── profile.d
│   ├── pulse
│   ├── qemu-ga
│   ├── qemu-kvm
│   ├── ras
│   ├── rc0.d -> rc.d/rc0.d
│   ├── rc1.d -> rc.d/rc1.d
│   ├── rc2.d -> rc.d/rc2.d
│   ├── rc3.d -> rc.d/rc3.d
│   ├── rc4.d -> rc.d/rc4.d
│   ├── rc5.d -> rc.d/rc5.d
│   ├── rc6.d -> rc.d/rc6.d
│   ├── rc.d
│   ├── rdma
│   ├── request-key.d
│   ├── rhsm
│   ├── rpm
│   ├── rsyslog.d
│   ├── rwtab.d
│   ├── samba
│   ├── sane.d
│   ├── sasl2
│   ├── security
│   ├── selinux
│   ├── setroubleshoot
│   ├── sgml
│   ├── skel
│   ├── smartmontools
│   ├── speech-dispatcher
│   ├── ssh
│   ├── ssl
│   ├── sssd
│   ├── sudoers.d
│   ├── sysconfig
│   ├── sysctl.d
│   ├── systemd
│   ├── terminfo
│   ├── tmpfiles.d
│   ├── tuned
│   ├── udev
│   ├── udisks2
│   ├── unbound
│   ├── UPower
│   ├── vmware-tools
│   ├── wpa_supplicant
│   ├── X11
│   ├── xdg
│   ├── xinetd.d
│   ├── xml
│   ├── yum
│   └── yum.repos.d
├── home #用户的主目录，在 Linux 中，每个用户都有一个自己的目录，一般该目录名是以用户的账号命名的
│   ├── node
│   ├── yagnmi
│   └── yangmi
#lib 是 Library(库) 的缩写这个目录里存放着系统最基本的动态连接共享库，其作用类似于 Windows 里的 DLL 文件。几乎所有的应用程序都需要用到这些共享库
├── lib -> usr/lib
├── lib64 -> usr/lib64
├── media #linux 系统会自动识别一些设备，例如U盘、光驱等等，当识别后，Linux 会把识别的设备挂载到这个目录下
├── mnt #系统提供该目录是为了让用户临时挂载别的文件系统的，我们可以将光驱挂载在 /mnt/ 上，然后进入该目录就可以查看光驱里的内容了
│   ├── cdroom
│   └── hgfs
├── opt #opt 是 optional(可选) 的缩写，这是给主机额外安装软件所摆放的目录

#proc 是 Processes(进程) 的缩写，/proc 是一种伪文件系统（也即虚拟文件系统），存储的是当前内核运行状态的一系列特殊文件，这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。
#这个目录的内容不在硬盘上而是在内存里，我们也可以直接修改里面的某些文件，比如可以通过下面的命令来屏蔽主机的ping命令，使别人无法ping你的机器：
├── proc
│   ├── 1
│   ├── 10
│   ├── 1005
│   ├── acpi
│   ├── asound
│   ├── bus
│   ├── driver
│   ├── fs
│   ├── irq
│   ├── mpt
│   ├── net -> self/net
│   ├── scsi
│   ├── self -> 62232
│   ├── sys
│   ├── sysvipc
│   ├── thread-self -> 62232/task/62232
│   └── tty
├── root #该目录为系统管理员，也称作超级权限者的用户主目录
│   ├── 公共
│   ├── 模板
│   ├── 视频
│   ├── 图片
│   ├── 文档
│   ├── 下载
│   ├── 音乐
│   ├── 桌面
│   ├── c
│   ├── frp
│   ├── httpd-2.4.46
│   └── test
├── run #是一个临时文件系统，存储系统启动以来的信息。当系统重启时，这个目录下的文件应该被删掉或清除
│   ├── avahi-daemon
│   ├── chrony
│   ├── cockpit
│   ├── console
│   ├── criu
│   ├── cryptsetup
│   ├── cups
│   ├── dbus
│   ├── faillock
│   ├── firewalld
│   ├── fsck
│   ├── gdm
│   ├── gnome-initial-setup
│   ├── initramfs
│   ├── libvirt
│   ├── lock
│   ├── log
│   ├── lsm
│   ├── lvm
│   ├── mdadm
│   ├── media
│   ├── motd.d
│   ├── mount
│   ├── NetworkManager
│   ├── plymouth
│   ├── podman
│   ├── radvd
│   ├── rhsm
│   ├── rpcbind
│   ├── samba
│   ├── sepermit
│   ├── setrans
│   ├── setroubleshoot
│   ├── spice-vdagentd
│   ├── sudo
│   ├── systemd
│   ├── tmpfiles.d
│   ├── tuned
│   ├── udev
│   ├── udisks2
│   ├── user
│   └── vmware
├── sbin -> usr/sbin #s 就是 Super User 的意思，是 Superuser Binaries (超级用户的二进制文件) 的缩写，这里存放的是系统管理员使用的系统管理程序
├── srv # 该目录存放一些服务启动之后需要提取的数据。
├── sys
│   ├── block
│   ├── bus
│   ├── class
│   ├── dev
│   ├── devices
│   ├── firmware
│   ├── fs
│   ├── hypervisor
│   ├── kernel
│   ├── module
│   └── power
├── tmp
│   ├── vmware-root_908-2688685236
│   └── vmware-root_911-4013199080

#usr 是 unix shared resources(共享资源) 的缩写，这是一个非常重要的目录，用户的很多应用程序和文件都放在这个目录下，类似于 windows 下的 program files 目录
├── usr 
│   ├── bin #系统用户使用的应用程序
│   ├── etc
│   ├── games
│   ├── include
│   ├── lib
│   ├── lib64
│   ├── libexec
│   ├── local
│   ├── sbin #超级用户使用的比较高级的管理程序和系统守护程序
│   ├── share
│   ├── src #内核源代码默认的放置目录
│   └── tmp -> ../var/tmp
└── var #var 是 variable(变量) 的缩写，这个目录中存放着在不断扩充着的东西，我们习惯将那些经常被修改的目录放在这个目录下。包括各种日志文件
    ├── account
    ├── adm
    ├── cache
    ├── crash
    ├── db
    ├── empty
    ├── ftp
    ├── games
    ├── gopher
    ├── kerberos
    ├── lib
    ├── local
    ├── lock -> ../run/lock
    ├── log
    ├── mail -> spool/mail
    ├── nis
    ├── opt
    ├── preserve
    ├── run -> ../run
    ├── spool
    ├── tmp
    └── yp

```

