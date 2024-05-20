```bash
# create ans switch to new branch
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