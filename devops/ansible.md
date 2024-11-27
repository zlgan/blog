# 其他



Prometheus 普罗米修斯 --系统监控

容器：podman，docker

配置管理：ansible，saltstack（需要代理）

日志：elk，splunk

cmdb 配置管理数据库？



三个关键模块

1. Paramiko
2. PyYAML
3. Jinja2（模板语言）

# 安装

https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

## 版本

```shell
root@ubuntu01:~# ansible --version 
ansible [core 2.16.10]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.3 (main, Jul 31 2024, 17:43:48) [GCC 13.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```

## 帮助

```shell
root@ubuntu01:~# ansible --help
usage: ansible [-h] [--version] [-v] [-b] [--become-method BECOME_METHOD] [--become-user BECOME_USER]
               [-K | --become-password-file BECOME_PASSWORD_FILE] [-i INVENTORY] [--list-hosts] [-l SUBSET]
               [-P POLL_INTERVAL] [-B SECONDS] [-o] [-t TREE] [--private-key PRIVATE_KEY_FILE] [-u REMOTE_USER]
               [-c CONNECTION] [-T TIMEOUT] [--ssh-common-args SSH_COMMON_ARGS] [--sftp-extra-args SFTP_EXTRA_ARGS]
               [--scp-extra-args SCP_EXTRA_ARGS] [--ssh-extra-args SSH_EXTRA_ARGS]
               [-k | --connection-password-file CONNECTION_PASSWORD_FILE] [-C] [-D] [-e EXTRA_VARS]
               [--vault-id VAULT_IDS] [-J | --vault-password-file VAULT_PASSWORD_FILES] [-f FORKS] [-M MODULE_PATH]
               [--playbook-dir BASEDIR] [--task-timeout TASK_TIMEOUT] [-a MODULE_ARGS] [-m MODULE_NAME]
               pattern

Define and run a single task 'playbook' against a set of hosts

positional arguments:
  pattern               host pattern

options:
  --become-password-file BECOME_PASSWORD_FILE, --become-pass-file BECOME_PASSWORD_FILE
                        Become password file
  --connection-password-file CONNECTION_PASSWORD_FILE, --conn-pass-file CONNECTION_PASSWORD_FILE
                        Connection password file
  --list-hosts          outputs a list of matching hosts; does not execute anything else
  --playbook-dir BASEDIR
                        Since this tool does not use playbooks, use this as a substitute playbook directory. This
                        sets the relative path for many features including roles/ group_vars/ etc.
  --task-timeout TASK_TIMEOUT
                        set task timeout limit in seconds, must be positive integer.
  --vault-id VAULT_IDS  the vault identity to use. This argument may be specified multiple times.
  --vault-password-file VAULT_PASSWORD_FILES, --vault-pass-file VAULT_PASSWORD_FILES
                        vault password file
  --version             show program's version number, config file location, configured module search path, module
                        location, executable location and exit
  -B SECONDS, --background SECONDS
                        run asynchronously, failing after X seconds (default=N/A)
  -C, --check           don't make any changes; instead, try to predict some of the changes that may occur
  -D, --diff            when changing (small) files and templates, show the differences in those files; works great
                        with --check
  -J, --ask-vault-password, --ask-vault-pass
                        ask for vault password
  -K, --ask-become-pass
                        ask for privilege escalation password
  -M MODULE_PATH, --module-path MODULE_PATH
                        prepend colon-separated path(s) to module library (default={{ ANSIBLE_HOME ~
                        "/plugins/modules:/usr/share/ansible/plugins/modules" }}). This argument may be specified
                        multiple times.
  -P POLL_INTERVAL, --poll POLL_INTERVAL
                        set the poll interval if using -B (default=15)
  -a MODULE_ARGS, --args MODULE_ARGS
                        The action's options in space separated k=v format: -a 'opt1=val1 opt2=val2' or a json
                        string: -a '{"opt1": "val1", "opt2": "val2"}'
  -e EXTRA_VARS, --extra-vars EXTRA_VARS
                        set additional variables as key=value or YAML/JSON, if filename prepend with @. This
                        argument may be specified multiple times.
  -f FORKS, --forks FORKS
                        specify number of parallel processes to use (default=5)
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory INVENTORY, --inventory-file INVENTORY
                        specify inventory host path or comma separated host list. --inventory-file is deprecated.
                        This argument may be specified multiple times.
  -k, --ask-pass        ask for connection password
  -l SUBSET, --limit SUBSET
                        further limit selected hosts to an additional pattern
  -m MODULE_NAME, --module-name MODULE_NAME
                        Name of the action to execute (default=command)
  -o, --one-line        condense output
  -t TREE, --tree TREE  log output to this directory
  -v, --verbose         Causes Ansible to print more debug messages. Adding multiple -v will increase the verbosity,
                        the builtin plugins currently evaluate up to -vvvvvv. A reasonable level to start is -vvv,
                        connection debugging might require -vvvv. This argument may be specified multiple times.

Privilege Escalation Options:
  control how and which user you become as on target hosts

  --become-method BECOME_METHOD
                        privilege escalation method to use (default=sudo), use `ansible-doc -t become -l` to list
                        valid choices.
  --become-user BECOME_USER
                        run operations as this user (default=root)
  -b, --become          run operations with become (does not imply password prompting)

Connection Options:
  control as whom and how to connect to hosts

  --private-key PRIVATE_KEY_FILE, --key-file PRIVATE_KEY_FILE
                        use this file to authenticate the connection
  --scp-extra-args SCP_EXTRA_ARGS
                        specify extra arguments to pass to scp only (e.g. -l)
  --sftp-extra-args SFTP_EXTRA_ARGS
                        specify extra arguments to pass to sftp only (e.g. -f, -l)
  --ssh-common-args SSH_COMMON_ARGS
                        specify common arguments to pass to sftp/scp/ssh (e.g. ProxyCommand)
  --ssh-extra-args SSH_EXTRA_ARGS
                        specify extra arguments to pass to ssh only (e.g. -R)
  -T TIMEOUT, --timeout TIMEOUT
                        override the connection timeout in seconds (default depends on connection)
  -c CONNECTION, --connection CONNECTION
                        connection type to use (default=ssh)
  -u REMOTE_USER, --user REMOTE_USER
                        connect as this user (default=None)

Some actions do not make sense in Ad-Hoc (include, meta, etc)

```



```bash
root@ubuntu01:/# ansible --version
ansible [core 2.16.10]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.3 (main, Sep 11 2024, 14:17:37) [GCC 13.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```



# 管理远程节点

## 配置Python解释器

>ansibile会在管理的节点上查找python解释器：
>
>[WARNING]: Platform linux on host 192.168.8.32 is using the discovered Python interpreter at /usr/bin/python3.6, but future installation of another Python interpreter could change the meaning of that path. See
>https://docs.ansible.com/ansible-core/2.16/reference_appendices/interpreter_discovery.html for more information.

```ini
#/etc/ansible/ansible.cfg 
#添加如何配置，消除警告
#在被控制节点上自动选择python解释器
[defaults]
interpreter_python=auto_silent
```



## 配置主机列表 hosts 

```bash
root@ubuntu01:~# cat /etc/ansible/hosts 
# This is the default ansible 'hosts' file.
#
# It should live in /etc/ansible/hosts
#
#   - Comments begin with the '#' character
#   - Blank lines are ignored
#   - Groups of hosts are delimited by [header] elements
#   - You can enter hostnames or ip addresses
#   - A hostname/ip can be a member of multiple groups

# Ex 1: Ungrouped hosts, specify before any group headers:

## green.example.com
## blue.example.com
## 192.168.100.1
## 192.168.100.10

# Ex 2: A collection of hosts belonging to the 'webservers' group:

## [webservers]
## alpha.example.org
## beta.example.org
## 192.168.1.100
## 192.168.1.110

# If you have multiple hosts following a pattern, you can specify
# them like this:

## www[001:006].example.com

# You can also use ranges for multiple hosts: 

## db-[99:101]-node.example.com

# Ex 3: A collection of database servers in the 'dbservers' group:

## [dbservers]
##
## db01.intranet.mydomain.net
## db02.intranet.mydomain.net
## 10.25.1.56
## 10.25.1.57


# Ex4: Multiple hosts arranged into groups such as 'Debian' and 'openSUSE':

## [Debian]
## alpha.example.org
## beta.example.org

## [openSUSE]
## green.example.com
## blue.example.com
[apps]
192.168.8.32

[dbs]
192.168.8.33

```



```
ansible #执行单条命令
ansible-doc  # 查看帮助
ansible-playbook #执行playbook
```



## 设置ssh公钥免密登录

```shell
#生成公私要对
ssh-keygen -f ~/.ssh/id_rsa -P "" >/dev/null 2>&1
#copy 公钥到远程主机
ssh-copy-id -i <pub-key-path> "-o StrictHostKeyChecking=no" remoteuser@remotehost
```

## 与远程主机交互

### command 模块

```shell
#查看主机名
root@ubuntu01:~# ansible leo -m command -a 'hostname'
[WARNING]: Platform linux on host 192.168.8.32 is using the discovered Python interpreter at /usr/bin/python3.6, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.16/reference_appendices/interpreter_discovery.html for more information.
192.168.8.32 | CHANGED | rc=0 >>
suse02

#查看内核版本
root@ubuntu01:~# ansible leo -m command -a 'uname -a'
192.168.8.32 | CHANGED | rc=0 >>
Linux suse02 5.14.21-150500.53-default #1 SMP PREEMPT_DYNAMIC Wed May 10 07:56:26 UTC 2023 (b630043) x86_64 x86_64 x86_64 GNU/Linux


#查看远程主机的内存信息，默认-m command 省略
root@ubuntu01:~# ansible leo  -a "free -m" 
[WARNING]: Platform linux on host 192.168.8.32 is using the discovered Python interpreter at /usr/bin/python3.6, but
future installation of another Python interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-core/2.16/reference_appendices/interpreter_discovery.html for more information.
192.168.8.32 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3924         536        3032          16         592        3388
Swap:          2048           0        2048


#进入/opt目录并创建文件
root@ubuntu01:~# ansible leo -a "touch test.log chdir=/opt"
oot@ubuntu01:~# ansible leo -a "ls /opt"






```

### shell 模块

> 支持管道符，重定向，等复杂操作

```bash
root@ubuntu01:~# ansible leo -m shell -a  "ps -ef | grep ssh" 
192.168.8.32 | CHANGED | rc=0 >>
root      1374     1  0 06:55 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root     15309  1374  1 07:21 ?        00:00:00 sshd: root@pts/0
root     15499 15498  0 07:21 pts/0    00:00:00 /bin/sh -c ps -ef | grep ssh
root     15501 15499  0 07:21 pts/0    00:00:00 grep ssh


root@ubuntu01:~# ansible leo -m shell -a  "date >/tmp/test.log && cat /tmp/test.log" 
192.168.8.32 | CHANGED | rc=0 >>
Thu 12 Sep 2024 07:23:11 AM CST


#1.创建文件
#2.写入命令到指定的文件
#3.文件权限设置
#4.执行文件中的命令
root@ubuntu01:~# ansible leo -m shell -a  "rm -rf /tmp/001;mkdir /tmp/001/;echo 'hostname' >/tmp/001/test.sh;chmod +x /tmp/001/test.sh;/tmp/001/test.sh;" 
192.168.8.32 | CHANGED | rc=0 >>
suse02


```





## 查看帮助

 ansible-doc  --list 查看所有模块



```powershell

# ansible-doc  command  #查看帮助信息
root@ubuntu01:~# ansible-doc -s command  #查看简化的帮助



- name: Execute commands on targets
  command:
      argv:                  # Passes the command as a list rather than a string. Use `argv' to avoid quoting values
                             # that would otherwise be interpreted incorrectly (for
                             # example "user name"). Only the string (free form) or the
                             # list (argv) form can be provided, not both.  One or the
                             # other must be provided.
      chdir:                 # Change into this directory before running the command.
      cmd:                   # The command to run.
      creates:               # A filename or (since 2.0) glob pattern. If a matching file already exists, this step
                             # *will not* be run. This is checked before `removes' is
                             # checked.
      expand_argument_vars:   # Expands the arguments that are variables, for example `$HOME' will be expanded before
                             # being passed to the command to run. Set to `false' to
                             # disable expansion and treat the value as a literal
                             # argument.
      free_form:             # The command module takes a free form string as a command to run. There is no actual
                             # parameter named 'free form'.
      removes:               # A filename or (since 2.0) glob pattern. If a matching file exists, this step *will* be
                             # run. This is checked after `creates' is checked.
      stdin:                 # Set the stdin of the command directly to the specified value.
      stdin_add_newline:     # If set to `true', append a newline to stdin data.
      strip_empty_ends:      # Strip empty lines from the end of stdout/stderr in result.

```



# 配置

```bash
root@ubuntu01:~# cat /etc/ansible/ansible.cfg
# Since Ansible 2.12 (core):
# To generate an example config file (a "disabled" one with all default settings, commented out):
#               $ ansible-config init --disabled > ansible.cfg
#
# Also you can now have a more complete file by including existing plugins:
# ansible-config init --disabled -t all > ansible.cfg

# For previous versions of Ansible you can check for examples in the 'stable' branches of each version
# Note that this file was always incomplete  and lagging changes to configuration settings

# for example, for 2.9: https://github.com/ansible/ansible/blob/stable-2.9/examples/ansible.cfg
[defaults]
interpreter_python=auto_silent
module_name=shell #修改默认模块
log_path=/var/log/ansible.log #日志文件位置
```



# ansible 命令

```bash
# 列出主机清单 --list-hosts
root@ubuntu01:/# ansible "*" --list-hosts
  hosts (2):
    192.168.8.32
    192.168.8.33
    
# -vvv 控制输出的详细程度



```





# ansible 工具

## ansible-galaxy

## ansible-vault  加解密

## ansible-console  进入交互模式

```bash
root@all (2)[f:5]$ list
192.168.8.32
192.168.8.33
```



# 常用模块

## 修改默认模块

## ping

```bash
root@ubuntu01:/# ansible all  -m ping
192.168.8.33 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": false,
    "ping": "pong"
}
192.168.8.32 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": false,
    "ping": "pong"
}
```



## file 

```shell
#创建文件
root@ubuntu01:~# ansible all -m file -a  'path=/tmp/test.txt state=touch'
192.168.8.33 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": true,
    "dest": "/tmp/test.txt",
    "gid": 0,
    "group": "root",
    "mode": "0644",
    "owner": "root",
    "size": 0,
    "state": "file",
    "uid": 0
}
192.168.8.32 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": true,
    "dest": "/tmp/test.txt",
    "gid": 0,
    "group": "root",
    "mode": "0644",
    "owner": "root",
    "size": 0,
    "state": "file",
    "uid": 0
}

```

## copy

```bash
#将assible controller上的文件拷贝到目标节点
ansible leo -m copy -a 'src=/tmp/copytest.txt dest=/tmp/copytest.txt'
192.168.8.33 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": true,
    "checksum": "f95b96b4305fa8b945f08c9a5c2737ac34d76bf2",
    "dest": "/tmp/copytest.txt",
    "gid": 0,
    "group": "root",
    "md5sum": "9d487327496f2375e14dfba392337f96",
    "mode": "0644",
    "owner": "root",
    "size": 14,
    "src": "/root/.ansible/tmp/ansible-tmp-1726414951.667462-18358-239437729040879/source",
    "state": "file",
    "uid": 0
}
192.168.8.32 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.6"
    },
    "changed": true,
    "checksum": "f95b96b4305fa8b945f08c9a5c2737ac34d76bf2",
    "dest": "/tmp/copytest.txt",
    "gid": 0,
    "group": "root",
    "md5sum": "9d487327496f2375e14dfba392337f96",
    "mode": "0644",
    "owner": "root",
    "size": 14,
    "src": "/root/.ansible/tmp/ansible-tmp-1726414951.6746578-18357-87924817583296/source",
    "state": "file",
    "uid": 0
}

```



## Cron--计划任务

/var/spool/cron/root   这个目录的作用？

## zypper模块  

>安装软件

```bash
#install
ansible leo -m zypper -a 'name=nginx state=present'
#uninstall
ansible leo -m zypper -a 'name=nginx state=absent'

```



## service  

> 管理服务

## script 

脚本推送到被控制端执行

# playbook

## 核心元素

### hosts   

### tasks

### variables

### templates 

### handlers 

### tags 

##  asible-playbook

```BASH
ansible-playbook pintest.yml  
ansible-playbook pintest.yml  --limit 192.168.8.32
```

## ansible-galaxy 



## 范例 

### 测试1

```yaml
#pingTest.yml
---
- hosts: leo
  remote_user: root
  tasks:
    - name: ping_test
      ping:  
```

```bash
root@ubuntu01:~/playbooks# ansible-playbook pingTest.yml

PLAY [leo] ***********************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************
ok: [192.168.8.33]
ok: [192.168.8.32]

TASK [ping_test] *****************************************************************************************************
ok: [192.168.8.33]
ok: [192.168.8.32]

PLAY RECAP ***********************************************************************************************************
192.168.8.32               : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
192.168.8.33               : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

### 测试2

```YAML
---
# install nginx
- hosts: leo
  remote_user: root
  tasks:
    - name: add group nginx
      user: name=nginx state=present
    - name: add user nginx
      user: name=nginx state=present group=nginx
    - name: install nginx
      zypper: name=nginx state=present
    - name: start nginx
      service: name=nginx state=started enabled=yes
```





```
root@ubuntu01:~/playbooks# ansible leo -a 'ss -ntl'
192.168.8.33 | CHANGED | rc=0 >>
State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
LISTEN 0      128     192.168.8.33:27017      0.0.0.0:*          
LISTEN 0      128        127.0.0.1:27017      0.0.0.0:*          
LISTEN 0      4096         0.0.0.0:80         0.0.0.0:*          
LISTEN 0      128          0.0.0.0:22         0.0.0.0:*          
LISTEN 0      100        127.0.0.1:25         0.0.0.0:*          
LISTEN 0      128             [::]:22            [::]:*          
LISTEN 0      100            [::1]:25            [::]:*          
192.168.8.32 | CHANGED | rc=0 >>
State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
LISTEN 0      128     192.168.8.32:27017      0.0.0.0:*          
LISTEN 0      128        127.0.0.1:27017      0.0.0.0:*          
LISTEN 0      4096         0.0.0.0:80         0.0.0.0:*          
LISTEN 0      128          0.0.0.0:22         0.0.0.0:*          
LISTEN 0      100        127.0.0.1:25         0.0.0.0:*          
LISTEN 0      128             [::]:22            [::]:*          
LISTEN 0      100            [::1]:25            [::]:* 
```



- 层次关系：

  playbook---task--module



# 模板



# ref

- https://docs.ansible.com/ansible/latest/