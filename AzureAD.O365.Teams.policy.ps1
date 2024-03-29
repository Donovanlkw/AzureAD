Get-Help New-Team -Full

#----- enquiry teams apps configuration
Get-CsTeamsAppSetupPolicy -Identity global
Get-CsTeamsCallingPolicy
Get-CsTeamsCallingPolicy
Get-CsTeamsChannelsPolicy
Get-CsTeamsClientConfiguration
Get-CsTeamsComplianceRecordingApplication
Get-CsTeamsComplianceRecordingPolicy
Get-CsTeamsCortanaPolicy
Get-CsTeamsMeetingBroadcastConfiguration
Get-CsTeamsMeetingBroadcastPolicy
Get-CsTeamsMeetingConfiguration
Get-CsTeamsMessagingPolicy -Identity Global
Get-CsTeamsNotificationAndFeedsPolicy
Get-CsTeamsPinnedApp
Get-CsTeamsShiftsAppPolicy
Get-CsTeamsTargetingPolicy
Get-CsTeamsTranslationRule
Get-CsTeamsUpgradeConfiguration
Get-CsTeamsVerticalPackagePolicy
Get-CsTeamsVideoInteropServicePolicy


#----- enquiry users configuration
Get-CsUserPolicyAssignment -Identity reda@contoso.com



#Set-CsTeamsMessagingPolicy -Identity Global -AllowUserEditMessage $false
#Grant-CsTeamsMeetingPolicy -Identity reda@contoso.com -PolicyName "Student Meeting Policy"
#Get-CsBatchPolicyAssignmentOperation
#Get-CsGroupPolicyAssignment -PolicyType TeamsMeetingPolicy

#---- 
get-CsMeetingConfiguration


#---- for VTC

$policyname = "TeacherMeeting"
$policyname = "allon"

$policyname = "TeacherMeeting"
$filterstring = "userprincipalname -like 't-*'"


#$filterstring = "userprincipalname -like 'abc*'"

#----- select the users with particular pattern
get-csonlineuser -filter $filterString  |select UserPrincipalName

#----- select the users with particular pattern
get-csonlineuser -filter $filterString  |where TeamsMeetingPolicy -ne $policyname |select UserPrincipalName

#----- apply policy to new teacher 
get-csonlineuser -filter $filterString  |where TeamsMeetingPolicy -ne $policyname |Grant-CsTeamsMeetingPolicy -PolicyName $policyname

#  or
$newuser = get-csonlineuser -filter $filterString  |where TeamsMeetingPolicy -ne $policyname
New-CsBatchPolicyAssignmentOperation -PolicyType TeamsMeetingPolicy -PolicyName $policyname -Identity $newuser.SipProxyAddress -OperationName "new2"

Get-CsBatchPolicyAssignmentOperation |fl
Get-CsBatchPolicyAssignmentOperation -OperationId 09b50e0f-c7cc-4ed5-9283-eeb6f13dbf93 |Select -ExpandProperty UserState


<#

$dataSetFilePath = "<csv file with user ids for newly provisioned students> "
 $dataSet = Import-Csv "$($dataSetFilePath)" -Header UserId –delimiter ","
 foreach($line in $dataSet)
 {
    $userId = $line.UserId
    Write-Host $userId
    Grant-CsTeamsMessagingPolicy -PolicyName "<<PolicyName for a policy created with Chat Off>>" -Identity $userId

 }

 #>


Scripting the Team Creation
Now I can script the entire thing like this with the groupid captured from the initial creation.
$group = New-Team -DisplayName "UK Finance Team" -AccessType Private -Description "This Team is for UK Finance"
Add-TeamUser -GroupId $group.GroupId -User "user@domain.onmicrosoft.com"
New-TeamChannel -GroupId $group.GroupId -DisplayName "Regulatory Compliance"
Set-TeamMemberSettings -GroupId $group.GroupId -AllowCreateUpdateChannels true -AllowDeleteChannels false -AllowAddRemoveApps false
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
