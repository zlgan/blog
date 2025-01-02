```bash
#!/bin/bash

# 检查是否传递了脚本文件路径作为参数
if [ -z "$1" ]; then
    echo "Usage: $0 <local_script.sh>"
    exit 1
fi

# 本地脚本文件路径通过参数传递
LOCAL_SCRIPT="$1"

# 密码（建议安全方式存储，例如环境变量）
# SSH_PASSWD="root"

# 主机列表，存储在数组中
HOSTS=(
"suse02"
"suse03"
)

# 远程脚本存放路径
REMOTE_SCRIPT="/tmp/$1"

# 循环遍历主机列表
for host in "${HOSTS[@]}"; do
    echo "Copying script to $host..."

    # 使用 sshpass 自动传输脚本到远程主机
    sshpass -p "$SSH_PASSWD" scp -o StrictHostKeyChecking=no "$LOCAL_SCRIPT" root@"$host":"$REMOTE_SCRIPT"

    # 执行远程脚本
    echo "Executing script on $host..."
    sshpass -p "$SSH_PASSWD" ssh -o StrictHostKeyChecking=no root@"$host" "bash $REMOTE_SCRIPT"

    echo "Script executed on $host."
done
```

