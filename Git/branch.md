```bash
# create and switch to new branch
git checkout -b test
#push local test to remote as branch test2
git push origin test:test2
#set local branch test trace test2 on remote branch 
git branch --set-upstream-to=origin/test2

#delete remote branch test2 
git push --delete origin test2
#delte local branch 
git branch -D test
```



# 新建分支流程

```bash
#1. create new branch on remote server
#2. switch to develop branch on local repository 
#3. create local branch and trace remote branch 
git checkout -b feature/2024Sep_Leo  origin/feature/2024Sep_Leo
#4. add new worktree for new branch 
git worktree add ../../worktree/ec-push/feature_2024Sep_Leo feature/2024Sep_Leo
```