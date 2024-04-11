# 实践

## 撤销工作区的变更

```bash
git restore #撤销修改 
git clean -n  # -n参数来先看看会删掉哪些文件，防止重要文件被误删
git clean -fd #清理未跟踪的目录和文件
```

## 

## git log
```bash
git log  # 查看log日志 
git log --pretty=oneline #显示完整的hash
git log --oneline #显示hash的前七位
git log --author=zlgan #过滤作者
git log -3 #查询最近三次提交
git log  --grep=keywords #过滤comment包含特定关键字的提交记录 
git log  --before='2020-1-1' --after='2020-2-2' #过滤时间范围
git log  -- <file-path> #查询对指定目录的修改记录
git log -S "UpdateDateTime" #按修改内容的关键字搜索

则
```

## tag
```bash
#查看最近的三次tag
git tag --sort=-taggerdate --list 'GamificationSer*' -i | head -n 3 #按打tag时间排序
git tag --sort=-creatordate --list 'GamificationSer*' -i | head -n 3 #按commit时间排序
```


## git commit

```bash
git commit --amend -m 'comment' #追加提交
#如果前一个版本已经使用push 提交到远程版本库中
#应该使用 --force 强制推送追加之后的内容
git push --force
```

## git show 
```bash
git show #查看最后git库中的最后一次提交的信息
```

## git branch 
### 查看分支信息
```bash
git branch -a #-a显示所有分支
git branch -r #-r显示远程分支
git branch -v #-v查看当前分支最后提交的SHA1值

#查看跟踪的远程分支，以及当前分支的shar1
git branch -vv
dev         8a11c0b [origin/dev: behind 1] update file1 #当前分支落后远程分支一个提交
master      bc05d83 [origin/master] Merge branch 'master' of gitee.com:zlgan/gittest

#设置跟踪的远程分支
git branch --set-upstream-to=origin/branch-name
```
### 创建分支
```bash
git branch br4 #创建本地分支
git branch --set-upstream-to=origin/br4 br4 #将本地分支与远程分支建立关联

#创建与跟踪的远程分支同名的本地分支，并切换到该分支
git checkout --track origin/br4
#如果本地分支与远程分支名称不相同则使用-b参数指定新的分支名称
git checkout -b new_name --track origin/br4
git push origin br4:br4 #将本地分支推送到远程<本地分支名>:<远程分支名>
```

### 删除分支
```bash
git branch -d <local-branch-name> #删除本地分支
git push origin --delete <remote-branch-name> #删除远程分支
```

### 分支同步
```bash
git fetch #同步
git fetch --prune #同步，并删除远程不存在的本地跟踪分支
git pull # fetch并merge到当前分支 
```
### aaa
```bash

```
### aaa
```bash

```
### aaa
```bash

```
### aaa
```bash

```
### aaa
```bash

```

## git 仓库操作
```bash
#本地仓库与远程仓库建立关联
git remote add origin <remote-repository-url>
#查看远程仓库的详细信息
git remote show origin
```

## 撤销修改
### 清理工作区文件
```bash
git clean #清理工作区重未跟踪的文件和目录
git clean -n #选项提供"dry run"功能，查看需要清理的内容实际并不清理
git clean -f #强制清理所有的目录和文件
git clean -d #同时清理文件夹
```

### 撤销工作区的修改
```bash
git restore <path> #丢弃工作区的修改
git restore --staged <path> #丢弃暂存区的修改，相当与撤销了git ad操作
git restore  --source=origin/master  README.md #将文件恢复到远程分支的状态
git reset --hard head 将当前工作区和暂存区都丢弃，恢复到最后一次提交时的状态
```

### aaa
```bash
```

### aaa
```bash
```

## rename
1. 修改文件名，如果只修改文件名的大小写，git无法识别，此时应该使用 `git mv` 命令修改

# 钩子

```bash
#!/bin/bash

# 获取当前提交的 SHA-1 值
current_commit=$(git rev-parse HEAD)

# 获取前一个提交的 SHA-1 值
previous_commit=$(git rev-parse HEAD^)

# 检查某个文件的特定内容是否相对于前一个版本发生了变更
file_to_check="version.xml"

specific_content='s/.*<productVersion>\([^<]\+\)<\/productVersion>.*/\1/p'

# 获取前一个提交的特定内容
preVersion=$(git show "$previous_commit":"$file_to_check" | sed -n "$specific_content")
# 获取当前提交的特定内容
currentVersion=$(git show "$current_commit":"$file_to_check" | sed -n "$specific_content")

# 在此处添加你的逻辑来判断版本是否发生变化
if [ "$preVersion" = "$currentVersion" ]; then
   echo -e "\e[33mWarning:======Product version not updated yet!!!!!!======\e[0m"
   echo -e "\e[33mCurrent version: $currentVersion\e[0m"
fi
```

