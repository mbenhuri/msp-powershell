# I ran into an issue where the email address policy was not enabled on an onprem exchange server so I ran this script to manually add the 
# routing addresses needed for microsoft 365 hybrid environment


#Variables
$Domain = "xxxxx.mail.onmicrosoft.com"
$Domain2 = "xxxxx.onmicrosoft.com"
 
#Get all users in ActiveDirectory
$Users = Get-ADUser -Filter * -Properties ProxyAddresses
 
#Some output is always nice
Write-Host "Processing $Users.Count users..." -ForegroundColor Green
 
#Go through all users
foreach ($User in $Users) {
 
#Check if <domain>.mail.onmicrosoft.com alias is present, if not add it as an alias
if ($User.Proxyaddresses -like "*$Domain*") {
Write-Host "$User.SamAccountName has an alias matching $Domain..." -ForegroundColor Yellow 
}
else {

$Alias = "smtp:" + $User.SamAccountName + "@" + $Domain
Set-ADUser $User -Add @{Proxyaddresses="$Alias"}
Write-Host "Alias addded to $User.SamAccountName..." -ForegroundColor Green

$Alias2 = "smtp:" + $User.SamAccountName + "@" + $Domain2
Set-ADUser $User -Add @{Proxyaddresses="$Alias2"}
Write-Host " Second Alias addded to $User.SamAccountName..." -ForegroundColor Green

}
}
Write-Host "Done" -ForegroundColor Green
