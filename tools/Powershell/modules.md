```powershell
# 显示当前session中已经加载的module    
PS C:\Users\leozlgan>  **Get-Module** 

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}


# 显示所有可用的module
PS C:\Users\leozlgan>  **Get-Module -ListAvailable** 


    Directory: C:\Windows\system32\WindowsPowerShell\v1.0\Modules


ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0.0.0    AppLocker                           {Set-AppLockerPolicy, Get-AppLockerPolicy, Test-AppLockerPolicy, Get-AppLockerFileInformation...}
Manifest   1.0.0.0    BitsTransfer                        {Add-BitsFile, Remove-BitsTransfer, Complete-BitsTransfer, Get-BitsTransfer...}
Manifest   1.0.0.0    CimCmdlets                          {Get-CimAssociatedInstance, Get-CimClass, Get-CimInstance, Get-CimSession...}
Script     1.0.0.0    ISE                                 {New-IseSnippet, Import-IseSnippet, Get-IseSnippet}


    Directory: C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules


ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   2.0        SQLASCMDLETS                        {Add-RoleMember, Backup-ASDatabase, Invoke-ASCmd, Invoke-ProcessCube...}
Manifest   1.0        SQLPS                               {Backup-SqlDatabase, Save-SqlMigrationReport, Add-SqlAvailabilityDatabase, Add-SqlAvailabilityGroupListenerStaticIp...}


    Directory: C:\Program Files\WindowsPowerShell\Modules


ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Binary     1.0.0.1    PackageManagement                   {Find-Package, Get-Package, Get-PackageProvider, Get-PackageSource...}
Script     1.0.0.1    PowerShellGet                       {Install-Module, Find-Module, Save-Module, Update-Module...}
Manifest   20.0       SqlServer                           {Backup-SqlDatabase, Save-SqlMigrationReport, Add-SqlAvailabilityDatabase, Add-SqlAvailabilityGroupListenerStaticIp...}


#显示Module的搜索路径
PS C:\Users\leozlgan> $env:PSModulePath
C:\Users\leozlgan\Documents\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules\;C:\Program Files\WindowsPowerShell\Modules\

PS C:\Users\leozlgan> Get-Module sqlserver -ListAvailable

Directory: C:\Program Files\WindowsPowerShell\Modules

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   20.0       SqlServer                           {Add-SqlColumnEncryptionKeyValue, Complete-SqlColumnMasterKeyRotation, Get-SqlColumnEncryptionKey, Get-SqlColumnMasterKey...}


#对象转换
$CustomObject |
  Select-Object -Property @{name='Name';expression={$_.Service}} 

#多列排序
 Sort-Object -Property @{Expression = "Status"; Descending = $true},
                          @{Expression = "DisplayName"; Descending = $false}
```