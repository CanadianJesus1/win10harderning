Split-Path $MyInvocation.MyCommand.Path | Push-Location

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

winrm invoke Restore winrm/Config
winrm quickconfig

Install-Module AuditPolicyDSC -Force
Install-Module ComputerManagementDSC -Force
Install-Module SecurityPolicyDSC -Force

./literallyEverythingElse.ps1

Set-NetConnectionProfile -NetworkCategory Private
Set-Item -Path WSMan:\localhost\MaxEnvelopeSizeKb -Value 2048 -Force

Start-DscConfiguration -Path .\WindowsServer2016  -Force -Wait
