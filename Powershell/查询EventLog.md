```powershell
 Get-EventLog 
 -LogName gamificationservice  #名称
 -Newest 20  #最新的20条
 -After '2023-02-27 15:37' #指定日期之后 
 -EntryType Error -Message *base*  #按关键字过滤
 | Format-List -Property Message # 按Key value的方式显示
```