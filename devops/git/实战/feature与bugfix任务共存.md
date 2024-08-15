在开发过程中经常会遇到，正在开发新功能，突然线上有bug需要修复。此时新功能有没有完成不想提交代码。

解决这个问题，首先需要

1. 将当前feature分支push到一个临时栈中，使用git stash命令

   ```bash
   #查看当前分支情况，只有一个本地master 分支
   Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/gittest (master)
   $ git branch -a 
   * master
     remotes/origin/HEAD -> origin/master
     remotes/origin/dev
     remotes/origin/feature/leo
     remotes/origin/feature/zhangsan
     remotes/origin/master
   ```

2. 创建一个开发分支，用于新功能的开发

   ```bash
   $ git branch newfun #新建分支
   $ git checkout newfun #切换分支
   Switched to branch 'newfun'
   $ git branch --set-upstream-to=origin/feature/leo#设置分支跟踪的远程分支
   Branch 'newfun' set up to track remote branch 'feature/leo' from 'origin'.
   $ git branch -vv #查看跟踪的远程分支
     master 00f652a [origin/master] add new file
   * newfun 00f652a [origin/feature/leo: behind 11] add new file
   $ git pull #拉取远程分支的提交到本地
   ```

3. 新功能开发一半的时候需要修复bug，当前开发分支需要的操作：

   ```bash
   $ echo "test" >> fun1
   $ git status 
   On branch newfun
   Your branch is up to date with 'origin/feature/leo'.
   Untracked files:
     (use "git add <file>..." to include in what will be committed)
           fun1
   $ git add . 
   $ git stash push -m 'add fun1' #暂存当前分支的变更
   Saved working directory and index state On newfun: add fun1
   ```

4. 拉一个新的hotfix分支，这个分支应该是基于master分支的，然后跟踪远程上已部署的的分支代码，这个分支的代码不包含feature的新功能

   ```bash
   git checkout master #切换到主分支
   git branch hotfix 
   git checkout hotfix
   git branch --set-upstream-to=origin/feature/leo
   git pull
   echo "bugfix" >> bugfix1
   git add .
   git commit -m 'bug fix'
   git push
   git push origin head:feature/leo # 将bugfix的修改推送到远程
   ```

5. 切换回被打断时的状态

   ```bash
   git checkout newfun
    git status
    git stash list #查看临时保存的工作现场
    git stash pop #恢复现场
    git commit -m 'add new fun1'#提交feature的修改
    git pull
    git stash clear #清理
   ```