$name = Read-Host "What is the domain name?"

Write-Host "Creating the custom attribute report for $name"
Get-Mailbox -OrganizationalUnit $name | select name, CustomAttribute1 | ft > c:\temp\customattribute-$name.txt
Write-host "Done. The report is in c:\temp\customattribute-$name.txt"
