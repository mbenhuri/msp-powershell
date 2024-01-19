# This was for the legacy bit by bit hosted exchange to audit an OU to see if anyone had the wrong custom attribute
# we used customattribute1 to segment the gal

$name = Read-Host "What is the domain name?"

Write-Host "Creating the custom attribute report for $name"
Get-Mailbox -OrganizationalUnit $name | select name, CustomAttribute1 | ft > c:\temp\customattribute-$name.txt
Write-host "Done. The report is in c:\temp\customattribute-$name.txt"
