```powershell
param(
    [string]$SetupEnv="prod_st",
    [bool]$UseDummyData=$False,
    [string]$DestRootDirectory="D:\",
    [string]$AppLogsPath="E:\AppLog"
)

Import-Module WebAdministration

function CheckError(){
    param(
    [int]$ExitCode=1,
    [string]$ErrorMsg=""
    )

    if(!$?){
        if(![System.String]::IsNullOrWhiteSpace($ErrorMsg)){
            Write-output $ErrorMsg
        }
        exit $ExitCode
    }
}

function AddAppPool
{
    param($AppPoolName)

    try{
        if(!(test-path IIS:\AppPools\$AppPoolName))
        {
            #Remove-WebAppPool -Name $AppPoolName
            New-WebAppPool -Name $AppPoolName -ErrorAction Stop | Format-List
        }

        #No Managed Code
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name managedRuntimeVersion -Value "" -ErrorAction Stop
        #0:"Integraed", 1:"classic"
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name managedPipelineMode -Value 0 -ErrorAction Stop

        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name enable32BitAppOnWin64 -Value False -ErrorAction Stop

        #1:AlwaysRunning, 0:OnDemand()
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name startMode -Value 1 -ErrorAction Stop
        #autoStart
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name autoStart -Value True -ErrorAction Stop
        #processModel.idleTimeout
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name processModel.idleTimeout -Value 01:00:00 -ErrorAction Stop


        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name cpu.smpAffinitized -Value False -ErrorAction Stop
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name cpu.smpProcessorAffinityMask -Value 4294967295 -ErrorAction Stop

        #Time,Requests,Schedule,Memory,IsapiUnhealthy,OnDemand,ConfigChange,PrivateMemory
        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name recycling.logEventOnRecycle -Value $(1+2+4+8+16+32+64+128) -ErrorAction Stop

        Set-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name recycling.periodicRestart.Time -Value "00:00:00"

        Clear-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name recycling.periodicRestart.schedule
        New-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name recycling.periodicRestart.schedule -Value @{value="00:00:00"}

        [int]$minutes=0
        if($(hostname) -match "(\d*?)$"){
            $minutes = [int]$Matches[1]+2
        }
        New-ItemProperty -Path IIS:\AppPools\$AppPoolName -Name recycling.periodicRestart.schedule -Value @{value=(New-TimeSpan -Hours 9 -Minutes ($minutes%60)).ToString()}
    }
    catch [Exception]{
        Write-Output $Error[0]
        exit 1
    }
}

function StopAppPool
{
    param($AppPoolName)
    if(test-path IIS:\AppPools\$AppPoolName)
    {
        $state = (Get-WebAppPoolState $AppPoolName -ErrorAction stop).Value;
        Write-output "$AppPoolName status:$state"

        $StopStates = "Stopped","Stopping"
        if(!$StopStates.Contains($state))
        {
            Stop-WebAppPool $AppPoolName -ErrorAction stop
        }

        #Waiting for stop
        Start-Sleep -Seconds 5
        $state = (Get-WebAppPoolState $AppPoolName -ErrorAction stop).Value;
        Write-output "After 5 seconds, $AppPoolName status:$state"
        if($state -ne "Stopped")
        {
            write-output "Stop AppPool '$AppPoolName' failed"
            exit 1
        }
    }
}
function StartAppPool
{
    param($AppPoolName)
    if(test-path IIS:\AppPools\$AppPoolName)
    {
        $state = (Get-WebAppPoolState $AppPoolName).Value
        if($state -eq "Started")
        {
            restart-WebAppPool $AppPoolName
        }
        elseif($state -eq "Stopped")
        {
            start-WebAppPool $AppPoolName
        }
    }
}

function AddApplication()
{
    param(
        [string]$SiteName,
        [string]$AppName,
        [string]$AppPoolName,
        [string]$AppPhysicalPath=$(throw "Parameter missing: -AppPhysicalPath")
    )
    try{
        if(!(test-path $AppPhysicalPath))
        {
           New-Item $AppPhysicalPath -Force -ItemType Directory -ErrorAction Stop | Format-List
        }

        if(test-path IIS:\Sites\$SiteName\$AppName)
        {
            Remove-WebApplication -Site $SiteName -Name $AppName  -ErrorAction Stop
        }

        New-WebApplication -Site $SiteName -Name $AppName -PhysicalPath $AppPhysicalPath -ApplicationPool $AppPoolName  -ErrorAction Stop | Format-List
    }
    catch [exception]{
        Write-Output $Error[0]
        exit 1
    }
}
#applog
function createLogsVdir(){
    param(
        [string]$vdirName, 
        [string]$AppPhysicalPath=$(throw "Parameter missing: -AppPhysicalPath")
    )
    try{
        
        if(!$SetupEnv.StartsWith("prod",[System.StringComparison]::OrdinalIgnoreCase))
        {
            if([String]::IsNullOrWhiteSpace($vdirName)){
                Write-Error "vdirName can't be empty"
            }

            $SiteName = "Default web site"
            if(!(test-path $AppPhysicalPath))
            {
               New-Item $AppPhysicalPath -Force -ItemType Directory -ErrorAction Stop | Format-List
            }

            # add WebVirtualDirectory: applog
            New-WebVirtualDirectory -Site $SiteName -Name $vdirName -PhysicalPath $AppPhysicalPath -Force -ErrorAction Stop | Format-List
        
            $psPath = "IIS:\Sites\$SiteName"
            Set-WebConfigurationProperty -PSPath $psPath/$vdirName -Filter /system.webServer/directoryBrowse -Name enabled -value true
            $testResult = get-WebConfigurationProperty -PSPath $psPath/$vdirName -Filter /system.webServer/staticContent -Name collection[fileExtension='.log']
            if(!$testResult)
            {
                Add-WebConfigurationProperty -PSPath $psPath/$vdirName -Filter /system.webServer/staticContent -Name "." -value @{fileExtension='.log';mimeType='text/plain'}
            }
            else
            {
                write-output "fileExtension='.log';mimeType='text/plain' already exists"
            }
            write-output "The virtual directory applog has been created!"
        }
        else
        {
            write-output "The production environment does not create a log virtual directory!"
        }

    }
    catch [exception]{
        Write-Error $Error[0]
    }
}


#Initialize
$AppPoolName="PushWebAppPool"
$AppName="PushWeb"
$DefaultWebsite="Default Web Site"

$AppLogsVdirName="applog"

$WebAppPath=Join-Path -path $DestRootDirectory -Childpath "MobileServerS"
$DestPath=Join-Path -Path $WebAppPath -ChildPath "PushWeb"
$LogFile=Join-Path -Path $WebAppPath -ChildPath "PushWebSetup.log"
$PushWebReleaseZipFile= Join-Path -Path $PSScriptRoot -ChildPath ".\PushWeb.zip"
$UnzipVbs = Join-Path -Path $PSScriptRoot -ChildPath ".\checksum\unzip.vbs"
$UnzipCmd="cscript $unzipVbs";
$MD5ChkCmd=Join-Path -Path $PSScriptRoot -ChildPath ".\checksum\Md5Chk.ps1"
$Md5PushWebFile=Join-Path -Path $PSScriptRoot -ChildPath "Md5PushWeb.txt"
$EnvJsonFile = Join-Path -Path $DestPath -ChildPath "env.json"
$Md5ChkResult=Join-Path -Path $PSScriptRoot -ChildPath "md5chkresult.txt"
$UpdateEnvironmentFile = Join-Path -Path $PSScriptRoot -ChildPath "UpdateEnvironment.ps1"

if(!(test-path $DestPath))
{
    Write-Output "Start creating $DestPath" >> $LogFile
    New-Item -Path $DestPath -ItemType Directory >> $LogFile
    CheckError -ErrorMsg "Remove $DestPath failed" >> $LogFile
}
Write-Output "----------" >> $LogFile   #Don't remove
Write-Output "============================SetupPushWeb.ps1 starting===================================" >> $LogFile
Get-Date -Format "yyyy-MM-dd HH:mm:ss" >> $LogFile
Write-Output LogFile=$LogFile  >> $LogFile

Write-Output "=========================="  >> $LogFile
Write-Output $PSVersionTable >> $LogFile
Write-Output PSScriptRoot=$PSScriptRoot  >> $LogFile

Write-Output SetupEnv=$SetupEnv  >> $LogFile
Write-Output UseDummyData=$UseDummyData  >> $LogFile

Write-Output AppPoolName=$AppPoolName  >> $LogFile
Write-Output AppName=$AppName  >> $LogFile
Write-Output DefaultWebsite=$DefaultWebsite  >> $LogFile

Write-Output DestRootDirectory=$DestRootDirectory  >> $LogFile
Write-Output WebAppPath=$WebAppPath  >> $LogFile
Write-Output DestPath=$DestPath  >> $LogFile

Write-Output PushWebReleaseZipFile=$PushWebReleaseZipFile  >> $LogFile
Write-Output UpdateEnvironmentFile=$UpdateEnvironmentFile >> $LogFile

Write-Output UzipVbs=$UnzipVbs  >> $LogFile
Write-Output UnzipCmd=$UnzipCmd  >> $LogFile
Write-Output MD5ChkCmd=$MD5ChkCmd  >> $LogFile
Write-Output Md5PushWebFile=$Md5PushWebFile  >> $LogFile
Write-Output EnvJsonFile=$EnvJsonFile  >> $LogFile
Write-Output Md5ChkResult=$Md5ChkResult  >> $LogFile
Write-Output "==========================" >> $LogFile

#output dotnet runtimes
#&dotnet --list-runtimes | format-list >> $LogFile

#output Hosting Bundle
Get-WebGlobalModule -Name AspNetCoreModule*  | format-list >> $LogFile

#stop website
#stop-WebSite $DefaultWebsite >> $LogFile
Write-Output "StopAppPool $AppPoolName" >> $LogFile
StopAppPool $AppPoolName  >> $LogFile

#remove old directory then create directory
if((test-path $DestPath))
{
    Write-Output "Start removing $DestPath" >> $LogFile
    Remove-Item -Path "$DestPath" -Recurse -Force >> $LogFile
    CheckError -ErrorMsg "Remove $DestPath failed" >> $LogFile
}
Write-Output "Start creating $DestPath" >> $LogFile
New-Item $DestPath -ItemType Directory -Force | Format-List >> $LogFile
CheckError -ErrorMsg "Create $DestPath failed" >> $LogFile

#Expand-Archive 
Write-Output "Start unzip $PushWebReleaseZipFile to $DestPath" >> $LogFile
#Invoke-Expression "$unzipcmd $PushWebReleaseZipFile $DestPath" >> $LogFile

if((get-command -Name Expand-Archive* | Where-Object {$_.Name -eq "Expand-Archive"}).length -gt 0)
{
    Expand-Archive -Path $PushWebReleaseZipFile -DestinationPath $DestPath -Force >> $LogFile
}
else
{
    Invoke-Expression "$unzipcmd $PushWebReleaseZipFile $DestPath" >> $LogFile
}
CheckError -ErrorMsg "Unizp $PushWebReleaseZipFile to $DestPath failed" >> $LogFile

#Check MD5
#Write-Output "Invoke $MD5ChkCmd $DestPath $Md5PushWebFile $Md5ChkResult" >> $LogFile
#Invoke-Expression "$MD5ChkCmd $DestPath $Md5PushWebFile $Md5ChkResult" >> $LogFile
Invoke-Expression "$MD5ChkCmd -DistnationDirectory $DestPath -Md5File $Md5LYPushWebFile" >> $LogFile
if($LASTEXITCODE -ne 0)
{
    #Get-Content $Md5ChkResult -Encoding UTF8 >> $LogFile
    #Remove-Item $Md5ChkResult -Force -ErrorAction SilentlyContinue >> $LogFile

    Write-Output "Error when Checksum" >> $LogFile
    exit 1
}
else
{
    #Get-Content $Md5ChkResult -Encoding UTF8 >> $LogFile
    #Remove-Item $Md5ChkResult -Force -ErrorAction SilentlyContinue >> $LogFile
}

#Update env.json
Write-Output "Start updating $EnvJsonFile, set environment to $SetupEnv, set UseDummyData to $UseDummyData" >> $LogFile
& $UpdateEnvironmentFile -Path $EnvJsonFile -SetupEnv $SetupEnv -UseDummyData $UseDummyData >> $LogFile
CheckError -ErrorMsg "Update $EnvJsonFile failed" >> $LogFile


#Add AppPool to IIS
Write-Output "Add WebAppPool $AppPoolName" >> $LogFile
AddAppPool $AppPoolName >> $LogFile
CheckError -ErrorMsg "Add WebAppPool $AppPoolName failed" >> $LogFile

Get-WebAppPoolState $AppPoolName | Format-List >> $LogFile

#Add Application to IIS
Write-Output "Add WebApplication $AppName" >> $LogFile
AddApplication  -SiteName $DefaultWebsite -AppName $AppName -AppPoolName $AppPoolName -AppPhysicalPath $DestPath >> $LogFile
CheckError -ErrorMsg "Add WebApplication $AppName failed" >> $LogFile

#Create vdir: applog
Write-Output "Creating vdir: $AppLogsVdirName" >> $LogFile
createLogsVdir -vdirName $AppLogsVdirName -AppPhysicalPath $AppLogsPath >> $LogFile
Write-Output "" >> $LogFile
Write-Output "" >> $LogFile

#start website
#start-WebSite $DefaultWebsite >> $LogFile 
Write-Output "StartAppPool $AppPoolName" >> $LogFile
StartAppPool $AppPoolName  >> $LogFile
CheckError -ErrorMsg "StartAppPool $AppName failed" >> $LogFile

Get-WebAppPoolState $AppPoolName | Format-List >> $LogFile

Write-Output "SetupPushWeb finished" >> $LogFile
Write-Output "============================SetupPushWeb.ps1 finished===================================" >> $LogFile

#output log to console
[string]$logContent = [System.IO.File]::ReadAllText($LogFile, [System.Text.Encoding]::UTF8)
$index = $logContent.LastIndexOf("----------")
if($index -gt -1)
{
    Write-Host $logContent.Substring($index)
}

exit 0
```