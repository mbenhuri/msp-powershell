# This will stamp all accounts with the tenant.mail.onmicrosoft routing domain and the tenant.onmicrosoft.com domain as smtp aliases. If you only need one or the other
# comment out line 8 and line 30 - 32

#Variables
$Domain = "tenant.mail.onmicrosoft.com"

#Comment out if not needed:
$Domain2 = "tenant.onmicrosoft.com"
 
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

#Comment out if not needed:
$Alias2 = "smtp:" + $User.SamAccountName + "@" + $Domain2
Set-ADUser $User -Add @{Proxyaddresses="$Alias2"}
Write-Host " Second Alias addded to $User.SamAccountName..." -ForegroundColor Green

}
}
Write-Host "Done" -ForegroundColor Green
