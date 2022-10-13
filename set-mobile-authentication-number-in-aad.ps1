# This script connects to Microsoft graph then inputs a CSV file and sets a mobile authentication for all the users in the file
# The CSV file has two columns UserID and PhoneNumber

# Connect to api and set scope

install-module Microsoft.Graph.Identity.Signins    
Connect-MgGraph -scopes UserAuthenticationMethod.ReadWrite.All
Select-MgProfile -Name beta

# import csv and cycle through users, will continue if any don't exist or fail

$users = import-csv .\users.csv
foreach ($user in $users){New-MgUserAuthenticationPhoneMethod -UserId $user.UserID -phoneType "mobile" -phoneNumber $user.PhoneNumber}
