#----- Declare variables -----# 
$Newname = "CTX" 
$IPAddress  = “192.168.1.100” 
$PrefixLength = "24" 
$DefaultGateway = “192.168.1.1” 
$ServerAddresses = “192.168.1.100” 
$DefaultUsername = "LAB\administrator" 
$DefaultPassword = "Password1" 

#----- Windows Configuration ------# 
set-timezone -Name "China Standard Time" 
#set-winsystemlocale -SystemLocale zh-HK 

#----- Enable Remote desktop ------ 
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0 
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" 

#----- Enable autoLogon ------ 
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -name 'AutoAdminLogon' -value 1 
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -name 'DefaultUsername' -value $DefaultUsername 
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -name 'DefaultPassword' -value $DefaultPassword 

#----- Network configure ------# 
$NIC=Get-NetAdapter 
New-NetIPAddress -InterfaceAlias $NIC[0].name -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway  
Set-DnsClientServerAddress -InterfaceAlias $NIC[0].name  -ServerAddresses $ServerAddresses 
Disable-NetAdapterBinding -InterfaceAlias $NIC[0].name -ComponentID ms_tcpip6 
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False 

$Firewallrule = "Firewallrule1 " 
$LocalPort = "3389" 

New-NetFirewallRule -Name $Firewallrule -DisplayName "$Firewallrule" -Profile    Domain -Direction  Inbound  -Action     Allow -Protocol   TCP -LocalPort  $LocalPort  -RemoteAddress LocalSubnet 

#----- Security configuration ------# 
# Disable-ieESC 
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" 
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" 
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 
    Stop-Process -Name Explorer 
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green 


# Disable-UserAccessControl 
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green     


#----- Windows Services configure ------# 
set-Service -Name Spooler -StartupType Automatic 


#----- remove Windows defender ------# 
Uninstall-WindowsFeature -Name Windows-Defender
 

#----- Renanme Computer name  ------# 
Rename-Computer -NewName $Newname -force -Restart 

