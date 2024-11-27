# 帮助信息

```powershell
PS C:\Users\Administrator> vmrun --help
Invalid argument: --help
vmrun version 1.17.0 build-14665864

Usage: vmrun [AUTHENTICATION-FLAGS] COMMAND [PARAMETERS]



AUTHENTICATION-FLAGS
--------------------
These must appear before the command and any command parameters.

   -T <hostType> (ws|fusion||player)
   -vp <password for encrypted virtual machine>
   -gu <userName in guest OS>
   -gp <password in guest OS>



POWER COMMANDS           PARAMETERS           DESCRIPTION
--------------           ----------           -----------
start                    Path to vmx file     Start a VM or Team
                         [gui|nogui]

stop                     Path to vmx file     Stop a VM or Team
                         [hard|soft]

reset                    Path to vmx file     Reset a VM or Team
                         [hard|soft]

suspend                  Path to vmx file     Suspend a VM or Team
                         [hard|soft]

pause                    Path to vmx file     Pause a VM

unpause                  Path to vmx file     Unpause a VM



SNAPSHOT COMMANDS        PARAMETERS           DESCRIPTION
-----------------        ----------           -----------
listSnapshots            Path to vmx file     List all snapshots in a VM
                         [showTree]

snapshot                 Path to vmx file     Create a snapshot of a VM
                         Snapshot name

deleteSnapshot           Path to vmx file     Remove a snapshot from a VM
                         Snapshot name
                         [andDeleteChildren]

revertToSnapshot         Path to vmx file     Set VM state to a snapshot
                         Snapshot name



GUEST OS COMMANDS        PARAMETERS           DESCRIPTION
-----------------        ----------           -----------
runProgramInGuest        Path to vmx file     Run a program in Guest OS
                         [-noWait]
                         [-activeWindow]
                         [-interactive]
                         Complete-Path-To-Program
                         [Program arguments]

fileExistsInGuest        Path to vmx file     Check if a file exists in Guest OS
                         Path to file in guest

directoryExistsInGuest   Path to vmx file     Check if a directory exists in Guest OS
                         Path to directory in guest

setSharedFolderState     Path to vmx file     Modify a Host-Guest shared folder
                         Share name
                         Host path
                         writable | readonly

addSharedFolder          Path to vmx file     Add a Host-Guest shared folder
                         Share name
                         New host path

removeSharedFolder       Path to vmx file     Remove a Host-Guest shared folder
                         Share name

enableSharedFolders      Path to vmx file     Enable shared folders in Guest
                         [runtime]

disableSharedFolders     Path to vmx file     Disable shared folders in Guest
                         [runtime]

listProcessesInGuest     Path to vmx file     List running processes in Guest OS

killProcessInGuest       Path to vmx file     Kill a process in Guest OS
                         process id

runScriptInGuest         Path to vmx file     Run a script in Guest OS
                         [-noWait]
                         [-activeWindow]
                         [-interactive]
                         Interpreter path
                         Script text

deleteFileInGuest        Path to vmx file     Delete a file in Guest OS
                         Path in guest

createDirectoryInGuest   Path to vmx file     Create a directory in Guest OS
                         Directory path in guest

deleteDirectoryInGuest   Path to vmx file     Delete a directory in Guest OS
                         Directory path in guest

CreateTempfileInGuest    Path to vmx file     Create a temporary file in Guest OS

listDirectoryInGuest     Path to vmx file     List a directory in Guest OS
                         Directory path in guest

CopyFileFromHostToGuest  Path to vmx file     Copy a file from host OS to guest OS
                         Path on host
                         Path in guest

CopyFileFromGuestToHost  Path to vmx file     Copy a file from guest OS to host OS
                         Path in guest
                         Path on host

renameFileInGuest        Path to vmx file     Rename a file in Guest OS
                         Original name
                         New name

typeKeystrokesInGuest    Path to vmx file     Type Keystrokes in Guest OS
                         keystroke string

connectNamedDevice       Path to vmx file     Connect the named device in the Guest OS
                         device name

disconnectNamedDevice    Path to vmx file     Disconnect the named device in the Guest OS
                         device name

captureScreen            Path to vmx file     Capture the screen of the VM to a local file
                         Path on host

writeVariable            Path to vmx file     Write a variable in the VM state
                         [runtimeConfig|guestEnv|guestVar]
                         variable name
                         variable value

readVariable             Path to vmx file     Read a variable in the VM state
                         [runtimeConfig|guestEnv|guestVar]
                         variable name

getGuestIPAddress        Path to vmx file     Gets the IP address of the guest
                         [-wait]



GENERAL COMMANDS         PARAMETERS           DESCRIPTION
----------------         ----------           -----------
list                                          List all running VMs

upgradevm                Path to vmx file     Upgrade VM file format, virtual hw

installTools             Path to vmx file     Install Tools in Guest

checkToolsState          Path to vmx file     Check the current Tools state

deleteVM                 Path to vmx file     Delete a VM

clone                    Path to vmx file     Create a copy of the VM
                         Path to destination vmx file
                         full|linked
                         [-snapshot=Snapshot Name]
                         [-cloneName=Name]



Template VM COMMANDS     PARAMETERS           DESCRIPTION
---------------------    ----------           -----------
downloadPhotonVM         Path for new VM      Download Photon VM





Examples:


Starting a virtual machine with Workstation on a Windows host
   vmrun -T ws start "c:\my VMs\myVM.vmx"


Running a program in a virtual machine with Workstation on a Windows host with Windows guest
   vmrun -T ws -gu guestUser -gp guestPassword runProgramInGuest "c:\my VMs\myVM.vmx" "c:\Program Files\myProgram.exe"


Creating a snapshot of a virtual machine with Workstation on a Windows host
   vmrun -T ws snapshot "c:\my VMs\myVM.vmx" mySnapshot


Reverting to a snapshot with Workstation on a Windows host
   vmrun -T ws revertToSnapshot "c:\my VMs\myVM.vmx" mySnapshot


Deleting a snapshot with Workstation on a Windows host
   vmrun -T ws deleteSnapshot "c:\my VMs\myVM.vmx" mySnapshot


Enabling Shared Folders with Workstation on a Windows host
   vmrun -T ws enableSharedFolders "c:\my VMs\myVM.vmx"
```

# 启动vmware相关服务

```powershell
PS C:\Users\Administrator> Start-Service VMware* -PassThru

Status   Name               DisplayName
------   ----               -----------
Running  VMware NAT Service VMware NAT Service
Running  VMwareHostd        VMware Workstation Server
```

# vmrun命令行工具

## 查看运行中的虚拟机

```powershell
PS D:\workspace\myBlog> vmrun list
Total running VMs: 1
D:\Program Files (x86)\VMMachines\Windows 10 x64\Windows 10 x64.vmx
```

## 关闭虚拟机

```powershell
PS D:\workspace\myBlog> vmrun stop "D:\Program Files (x86)\VMMachines\Windows 10 x64\Windows 10 x64.vmx"
```

## 开启虚拟机

```powershell
vmrun -T ws start $env:vm_suse01 nogui
```

nogui  参数指定后台运行





# 网络配置

1. 检查vmware网络设置，默认情况下vmware会使用使用虚拟网卡vmnet0 连接到物理网卡，

   ![image-20210515105038837](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105038837.png)

   ![image-20210515105605423](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105605423.png)

   ![image-20210515105728646](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515105728646.png)

   此处选择桥接到本地使用的物理网卡

2. 查看宿主机的网络设置，因为桥接模式相当于物理机和虚拟机连接到同一个交换机，所有ip必须为同一个网段，网关，dns是相同的

   ![image-20210515111126007](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515111126007.png)

3. 在虚拟机中设置网卡，注意使用root账号操作

   ![image-20210515112119289](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20210515112119289.png)

# Clone

hostnamectl

vim /etc/hostname

vim /etc/hosts

vim /etc/sysconfig/network/ifcfg-eth0
