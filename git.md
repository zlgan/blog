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
     git log  -- dir #查询对指定目录的修改记录
     git log -S "UpdateDateTime" #按修改内容的关键字搜索
     git log -G "Update.*Time" #按修改内容的关键字搜索,支持正则
 ```

