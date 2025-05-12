# 拉取远程分支信息
git fetch origin

# 创建新工作区feature-aaa并关联远程分支
git worktree add -b feature/aaa ../feature-aaa origin/feature/aaa

# 进入新工作区并验证
cd ../feature-aaa
git status  # 确认分支状态
git push -u origin feature/aaa  # 首次推送本地分支到远程（若需要）