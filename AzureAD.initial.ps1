###--- before install the Module ---# 
$webclient=New-Object System.Net.WebClient  
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials  
[Net.ServicePointManager]::SecurityProtocol = "tls12"  


# ----- Install the Module for Azure ----- #  
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
Import-Module az.accounts
Install-Module AzureAD
Import-Module AzureAD
Install-Module AzureADPreview  
Install-Module Az -AllowClobber  
Import-Module Az.Account


# ----- Install the Module for O365----- #  
Install-Module MSOnline  
Install-Module Microsoft.Online.SharePoint.PowerShell  
Install-Module MicrosoftTeams  
Install-Module NetworkTestingCompanion -RequiredVersion 1.5.2  
Install-module cqdpowershell  
Import-Module SkypeOnlineConnector  
# https://www.microsoft.com/en-us/download/details.aspx?id=39366  
# Install and connect to the SharePoint Online Management Shell with your admin account. 
# https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps  


Set-ExecutionPolicy RemoteSigned  
winrm get winrm/config/client/auth  
winrm set winrm/config/client/auth @{Basic="true"}  

