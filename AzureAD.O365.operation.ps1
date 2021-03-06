# ----- Create Demo user #list ----- #
get-msoluser
$LicenseAssignment =(Get-MsolAccountSku).accountskuid
#$userlist = "Bob", "Steve", "Mary", "Peter", "John", "Annie"
#$userlist = "Firefox", "Edge", "Chrome", "vivaldi", "opera", "IE11", "Brave"
$userlist |foreach-object {
$UserPrincipalName = "$_@$orgName.onMicrosoft.com"
New-MsolUser -UserPrincipalName $UserPrincipalName -DisplayName "$_" -FirstName "$_" -LastName "" -UsageLocation "HK" -LicenseAssignment $LicenseAssignment  -Password "Password1" 
}


# ----- Create Demo Guest user #list 
For ($i=100; $i -le 110; $i++) {
$displayName = "abc $i"
$email = "abc$i@gmail.com"
New-AzureADMSInvitation -InvitedUserDisplayName $displayName -InvitedUserEmailAddress $email -InviteRedirectURL https://myapps.microsoft.com -SendInvitationMessage $false
}


# ----- O365 License Assisgnemnt ----- #
Get-AzureADSubscribedSku | Select -Property Sku*,ConsumedUnits -ExpandProperty PrepaidUnits
Get-AzureADSubscribedSku | Select SkuPartNumber
$licenses = Get-AzureADSubscribedSku
$licenses[<index>].ServicePlans
Get-MsolAccountSku
Get-MsolAccountSku | Select -ExpandProperty ServiceStatus
$UserLicenses = Get-MsolUser -SearchString Brave
$UserLicenses.Licenses.Accountsku.Skupartnumber
$UserLicenses.Licenses[0].Servicestatus
$acctSKU=$orgName+":ENTERPRISEPACK"
$Licenseoptions = New-MsolLicenseOptions -AccountSkuId $acctSKU -DisabledPlans TEAMS1, SHAREPOINTWAC, SHAREPOINTENTERPRISE
Set-MsolUserLicense  -UserPrincipalName "Brave@emceuc1.onMicrosoft.com" -AddLicenses  $acctSKU -LicenseOptions $Licenseoptions


# ----- Create a security group for users who need to create Microsoft 365 groups ----- #
Get-AzureADDirectorySetting |foreach values
$group = Get-AzureADGroup -All $True | Where-Object {$_.DisplayName -eq “ENTER GROUP DISPLAY NAME HERE WHO WILL HAVE ACCESS TO CREATE GROUPS”} 

$settings = Get-AzureADDirectorySetting | where-object {$_.displayname -eq “Group.Unified”}
$settings["EnableMIPLabels"]
$settings["CustomBlockedWordsList"]
$settings["EnableMSStandardBlockedWords"]
$settings["ClassificationDescriptions"] = "Internal:This is internal only,External:External users can access,Confidential:Highly secure" 
$settings["DefaultClassification"] = "Confidential"
$settings["PrefixSuffixNamingRequirement"] = "ogrp-" 
$settings["AllowGuestsToBeGroupOwner"] = "false"
$settings["AllowGuestsToAccessGroups"] = "true" 
$settings["GuestUsageGuidelinesUrl"] = "https://domain.sharepoint.com/sites/intranet/Pages/Groups-Guest-Usage-Guidelines.aspx"
$settings["GroupCreationAllowedGroupId"] = $group.ObjectId 
$settings["AllowToAddGuests"] = "true"
$settings["UsageGuidelinesUrl"] = "https://domain.sharepoint.com/sites/intranet/Pages/Groups-Usage-Guidelines.aspx" 
$settings["ClassificationList"] = "Internal,External,Confidential"
$settings["EnableGroupCreation"] = "false" 
Set-AzureADDirectorySetting -Id $settings.Id -DirectorySetting $settings
(Get-AzureADDirectorySetting -Id $settings.Id).Values

https://drewmadelung.com/managing-office-365-group-using-azure-ad-powershell-v2/

https://docs.microsoft.com/en-us/microsoftteams/scripts/powershell-script-create-teams-from-managers-export-managers
https://docs.microsoft.com/en-us/microsoftteams/scripts/powershell-script-create-teams-from-managers-new-teams


# ----- Setting Group classification



# ----- Teams, operation ----- #
get-team
Get-TeamChannel
Get-TeamUser


#------ Teams, enable Guest Access ------#
$Cred = Get-Credential
$CSSession = New-CsOnlineSession -Credential $credential
Import-PSSession -Session $CSSession

Set-CsTeamsClientConfiguration -AllowGuestUser $True -Identity Global -Credential $credential


#----- Teams, Retrieve Teams chat history ------#     
Get-MailboxFolderStatistics -Identity "Donovan" |? {$_.Name -eq “Team Chat”} | Format-Table Name, ItemsInFolder


# ----- Microsoft, Teams policies ----- #
Get-CsTeamsMeetingPolicy
New-CsTeamsMeetingPolicy
Set-CsTeamsMeetingPolicy
Grant-CsTeamsMeetingPolicy

Get-CsTeamsClientConfiguration
Get-AzureADDirectorySetting |foreach values


#----- Steps to remove Group Settings -----#
$settings = Get-AzureADDirectorySetting | where-object {$_.displayname -eq “Group.Unified”}
Remove-AzureADDirectorySetting -Id$settings.Id


Get-MsolGroup
New-MsolGroup -DisplayName "MyGroup" -Description "My test group"

 $MSTeam=Connect-MicrosoftTeams  -Credential $credential
 $MSTeam

$sites = get-sposite -template "teamchannel#0"
$groupID = $MSTEam.tenantid
foreach ($site in $sites) {$x= Get-SpoSite -Identity
$site.url -Detail; if ($x.RelatedGroupId -eq $groupID)
{$x.RelatedGroupId;$x.url}}


New-TeamChannel –GroupId <Group_Id> –MembershipType Private –DisplayName "<Channel_Name>" –Owner <Owner_UPN>
New-TeamChannel –GroupId 1234 –MembershipType Private –DisplayName "<Channel_Name>" –Owner Donovan@emceuc1.onmicrosoft.com
New-TeamChannel -GroupId 126b90a5-e65a-4fef-98e3-d9b49f4acf12 -DisplayName "Engineering" -MembershipType Private
<Owner_UPN>

Get-MSolDevice
