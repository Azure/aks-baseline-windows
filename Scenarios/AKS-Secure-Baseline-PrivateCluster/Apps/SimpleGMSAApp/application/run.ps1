$ErrorActionPreference = "Stop" 
Write-Output "Configuring IIS with authentication." 
Install-WindowsFeature "Web-Windows-Auth", "Web-Asp-Net45" 
New-Item -Force -ItemType Directory -Path 'C:\inetpub\wwwroot\app' 
Set-Content -Path 'C:\inetpub\wwwroot\app\default.aspx' -Value 'Authenticated as <B><%=User.Identity.Name%></B>, Type of Authentication: <B><%=User.Identity.AuthenticationType%></B>'
Import-Module IISAdministration 
Start-IISCommitDelay 
(Get-IISConfigSection -SectionPath 'system.webServer/security/authentication/windowsAuthentication').Attributes['enabled'].value = $true 
(Get-IISConfigSection -SectionPath 'system.webServer/security/authentication/anonymousAuthentication').Attributes['enabled'].value = $false 
(Get-IISServerManager).Sites[0].Applications[0].VirtualDirectories[0].PhysicalPath = 'C:\inetpub\wwwroot\app'
Stop-IISCommitDelay 
Write-Output "IIS with authentication is ready." 