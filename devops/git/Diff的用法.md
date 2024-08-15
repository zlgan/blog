---
title: Git Diff的用法
date: 2021-12-04 07:36:18
tags:
categories: Git
---

### 文件比较

``` bash
#1.先将文件的第1次修改提交到仓库
Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ echo "first commit" >> file1

Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ git add file1
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory

Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ git commit -m 'fiel1 modified'
[master (root-commit) 12e8cea] fiel1 modified
 1 file changed, 1 insertion(+)
 create mode 100644 file1
 
 #2.将文件的第2次修改添加到暂存区
 Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ echo "Second Modify" >> file1

Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ git add file1
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory

#3.在工作区进行第3次修改
Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ echo "Third Modify" >> file1

Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)

#4.查看file1的状态
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file1

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file1

```

#### 1.工作区与暂存区比较 git diff file1

~~~ bash
#5.git diff 工作区与暂存区的比较
$ git diff file1
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory
diff --git a/file1 b/file1
index 3abf720..bc7af51 100644
--- a/file1
+++ b/file1
@@ -1,2 +1,3 @@
 first commit
 Second Modify
+Third Modify

~~~

#### 2.暂存区与版本库比较 git diff --cached 

~~~ bash
#6 暂存区与版本库比较 git diff --cached 
$ git diff --cached file1
diff --git a/file1 b/file1
index 5ec586d..3abf720 100644
--- a/file1
+++ b/file1
@@ -1 +1,2 @@
 first commit
+Second Modify

~~~



#### 3.工作区与版本库比较 git diff  head file1

~~~ bash
#7工作区与版本库的比较
Administrator@LeoComputer MINGW64 /e/workspace/Project/Git/testProject (master)
$ git diff head file1
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory
diff --git a/file1 b/file1
index 5ec586d..bc7af51 100644
--- a/file1
+++ b/file1
@@ -1 +1,3 @@
 first commit
+Second Modify
+Third Modify

~~~

#### 4.版本库之间的比较 git diff  head  head^

~~~ bash
#7工作区与版本库的比较
$ git diff head head^
diff --git a/file2 b/file2
index 6e1e513..7c315bb 100644
--- a/file2
+++ b/file2
@@ -1,2 +1 @@
 first modify
-second

~~~



---



### 分支比较

~~~bash
~~~



```bash
git ls-files
```



| --cached(-c)   | 查看暂存区               |
| -------------- | ------------------------ |
| --deleted(-d)  | 删除的文件               |
| --modified(-f) | 修改的文件               |
| --other(-o)    | 其他，例如：未跟踪的文件 |



- 常用的命令

  ```bash
  #追加提交
  git commit --amend
  ```

  

- 版本回退

  ```bash
  #使用Stage区或者版本库中的文件覆盖工作区文件，工作区的修改全部丢弃（慎用）
  git checkout --file1
  #使用版本库替换stage区域
  git reset head file1
  ```
  
  
  
- ###### 代码比较

  ```bash
  #工作区与暂存区比较
  git diff 
  #工作区与版本库比较
  git diff head 
  #比较State与版本库
  git diff --cached
  ```

  

- 分支

  ```
  
  ```

  

