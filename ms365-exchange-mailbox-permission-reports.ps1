# Create mailbox Permission reports

#Connect Exchange online
Connect-ExchangeOnlineManagement

# Create Mailbox full access permission report
Get-Mailbox -resultsize unlimited | Get-MailboxPermission | Select Identity, User, Deny, AccessRights, IsInherited| Where {($_.user -ne "NT AUTHORITY\SELF")}| Export-Csv -Path "c:\temp\NonOwnerPermissions.csv" -NoTypeInformation

# Create Mailbox Send-as permission report
Get-Mailbox -resultsize unlimited | Get-RecipientPermission| where {($_.trustee -ne "NT AUTHORITY\SELF")}|select Identity,Trustee,AccessControlType,AccessRights,IsInherited  | Export-Csv -Path "c:\temp\sendaspermissions.csv" –NoTypeInformation

# Create Mailbox Send on behalf permission report
$GrantSendOn= Get-Mailbox-resultsize unlimited| where {($_.GrantSendOnBehalfTo -ne "")} 

$Out=foreach ($user in $GrantSendOn.GrantSendOnBehalfTo) {
$obj= New-Object System.Object
$obj|Add-MemberNoteProperty eMail$GrantSendOn.WindowsEmailAddress
$obj|Add-Member NoteProperty DisplayName $GrantSendOn.DisplayName
$obj|Add-Member NoteProperty User $user
$obj }

$Out| Export-Csv -Path "c:\temp\sendonbehalfpermissions.csv" –NoTypeInformation 
