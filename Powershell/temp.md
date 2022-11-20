### $PSItem  遍历的当前item
 ------- Example 5: Start PowerShell as an administrator -------
Start-Process -FilePath "powershell" -Verb RunAs


$env:PSMODULEPATH

man *task* #搜索所有的带task关键字的命令

PS C:\WINDOWS\system32> man *task*
Name                              Category  Module                    Synopsis
----                              --------  ------                    --------
Start-AppBackgroundTask           Function  AppBackgroundTask         ...
Get-AppBackgroundTask             Function  AppBackgroundTask         ...
Set-AppBackgroundTaskResourceP... Cmdlet    AppBackgroundTask         Set-AppBackgroundTaskResourcePolicy...
Disable-AppBackgroundTaskDiagn... Cmdlet    AppBackgroundTask         Disable-AppBackgroundTaskDiagnosticLog...
Get-NetAdapterEncapsulatedPack... Function  NetAdapter                ...
Set-NetAdapterEncapsulatedPack... Function  NetAdapter                ...
Disable-NetAdapterEncapsulated... Function  NetAdapter                ...
Enable-NetAdapterEncapsulatedP... Function  NetAdapter                ...
Get-CertificateNotificationTask   Cmdlet    PKI                       Get-CertificateNotificationTask...
New-CertificateNotificationTask   Cmdlet    PKI                       New-CertificateNotificationTask...
Remove-CertificateNotification... Cmdlet    PKI                       Remove-CertificateNotificationTask...
Register-ScheduledTask            Function  ScheduledTasks            ...
Disable-ScheduledTask             Function  ScheduledTasks            ...
Export-ScheduledTask              Function  ScheduledTasks            ...
New-ScheduledTask                 Function  ScheduledTasks            ...
Unregister-ClusteredScheduledTask Function  ScheduledTasks            ...
Get-ScheduledTaskInfo             Function  ScheduledTasks            ...
Unregister-ScheduledTask          Function  ScheduledTasks            ...
Stop-ScheduledTask                Function  ScheduledTasks            ...
Set-ScheduledTask                 Function  ScheduledTasks            ...
Get-ScheduledTask                 Function  ScheduledTasks            ...
Register-ClusteredScheduledTask   Function  ScheduledTasks            ...
New-ScheduledTaskTrigger          Function  ScheduledTasks            ...
Start-ScheduledTask               Function  ScheduledTasks            ...
New-ScheduledTaskAction           Function  ScheduledTasks            ...


PS C:\WINDOWS\system32> get-command -Module ScheduledTasks

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Disable-ScheduledTask                              1.0.0.0    ScheduledTasks
Function        Enable-ScheduledTask                               1.0.0.0    ScheduledTasks
Function        Export-ScheduledTask                               1.0.0.0    ScheduledTasks
Function        Get-ClusteredScheduledTask                         1.0.0.0    ScheduledTasks
Function        Get-ScheduledTask                                  1.0.0.0    ScheduledTasks
Function        Get-ScheduledTaskInfo                              1.0.0.0    ScheduledTasks
Function        New-ScheduledTask                                  1.0.0.0    ScheduledTasks
Function        New-ScheduledTaskAction                            1.0.0.0    ScheduledTasks
Function        New-ScheduledTaskPrincipal                         1.0.0.0    ScheduledTasks
Function        New-ScheduledTaskSettingsSet                       1.0.0.0    ScheduledTasks
Function    



1.0.0.0    ScheduledTasks
Function        Register-ClusteredScheduledTask                    1.0.0.0    ScheduledTasks
Function        Register-ScheduledTask                             1.0.0.0    ScheduledTasks
Function        Set-ClusteredScheduledTask                         1.0.0.0    ScheduledTasks
Function        Set-ScheduledTask                                  1.0.0.0    ScheduledTasks
Function        Start-ScheduledTask                                1.0.0.0    ScheduledTasks
Function        Stop-ScheduledTask                                 1.0.0.0    ScheduledTasks
Function        Unregister-ClusteredScheduledTask                  1.0.0.0    ScheduledTasks
Function        Unregister-ScheduledTask                           1.0.0.0    ScheduledTasks
Get-Module -ListAvailable
Get-Command -Module  IISAdministration
man  Get-IISSite -Examples

PS C:\WINDOWS\system32> man New-ScheduledTask -Full
    New-ScheduledTask

    Creates a scheduled task instance.


    New-ScheduledTask [[-Action] <CimInstance[]>] [[-Trigger] <CimInstance[]>] [[-Settings] <CimInstance>] [[-Principal] <CimInstance>] [[-Description] <String>] [-CimSession <CimSession[]>
    ] [-ThrottleLimit <Int32>] [<CommonParameters>]


    The New-ScheduledTask cmdlet creates an object that contains the definition of a scheduled task. New-ScheduledTask does not automatically register the object with the Task Scheduler ser
    vice.

    You can register a task to run any of the following application or file types: Win32 applications, Win16 applications, OS/2 applications, MS-DOS applications, batch files (*.bat), comma
    nd files (*.cmd), or any properly registered file type.


    -Action [<CimInstance[]>]
        Specifies an array of work items for a task to run. When you specify multiple actions, they run sequentially. A task can have up to 32 actions.

        是否必需?                    False
        位置?                        1
        默认值                none
        是否接受管道输入?            false
        是否接受通配符?              False

    -CimSession [<CimSession[]>]
        Runs the cmdlet in a remote session or on a remote computer. Enter a computer name or a session object, such as the output of a New-CimSession or Get-CimSession cmdlet. The default
        is the current session on the local computer.

        是否必需?                    False
        位置?                        named
        默认值                none