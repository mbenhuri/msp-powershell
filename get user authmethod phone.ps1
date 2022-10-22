# Needs the following modules:
# Install-module Microsoft.Graph.Identity.Signins
# Assumes a list of upns as csv with heading upn. I previously had this but can connect to azure ad and pull. 

Connect-MgGraph -Scopes UserAuthenticationMethod.ReadWrite.All
$users = Import-Csv C:\temp\users.csv

$authmethods = @{}

foreach ($user in $users){
$phone = Get-MgUserAuthenticationPhoneMethod -UserId $user.upn

write-host $user.upn
write-host $phone.PhoneNumber

$authmethods.add($user.upn,$phone.PhoneNumber)
}

[PSCustomObject]$authmethods | Export-Csv -Path .\authentication.csv -NoTypeInformation