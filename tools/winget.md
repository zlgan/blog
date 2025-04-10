
# 安装winget
```powershell
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
```
# winget source
> https://mirrors.ustc.edu.cn/winget-source/ 中科大的源
## winget source list
## winget source update --name Contoso
> 从远程源中同步Manifest清单文件到本地
# winget list [name]
# winget search <name>  
## winget search "Visual Studio Code" -s msstore
# winget show <appname>
> show the details of specified apppackage
# winget install <name>
# winget upgrade
> 查看可用的更新
# winget uninstall <name>
- --purge 保留客户数据
# winget export 
# winget import
# winget download 
> winget download --id Microsoft.PowerToys --scope machine --architecture x64 --download-directory <Path>


