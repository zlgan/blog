**用.net 设置path变量**
例如将d:\test加入path变量
1. 设置环境变量
```powershell
[System.Environment]::SetEnvironmentVariable("path",$env:path+";d:\test\","user")
```
2. 关闭当前窗口
3. 重新打开窗口输入命令，查看path变量是否添加成功
```powershell
 $env:path
```

