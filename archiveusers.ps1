# PowerShell script to archive a Microsoft 365 user
# Requires the Microsoft Exchange Online Management Module and the MSOnline Module

# Connect to Microsoft Online Services
Connect-MsolService

# Connect to Exchange Online
Connect-ExchangeOnline

# Ask for the User Principal Name (UPN)
$userUPN = Read-Host -Prompt "Enter the user's UPN"

# Get the user
$user = Get-MsolUser -UserPrincipalName $userUPN

# Rename the user's display name
$newDisplayName = "Archive - " + $user.DisplayName
Set-MsolUser -UserPrincipalName $userUPN -DisplayName $newDisplayName

# Convert the mailbox to a shared mailbox
Set-Mailbox -Identity $userUPN -Type Shared

# Remove the license
$license = $user.Licenses.AccountSkuId
Set-MsolUserLicense -UserPrincipalName $userUPN -RemoveLicenses $license

# Optional: Update primary SMTP address
$updateSMTP = Read-Host -Prompt "Do you want to update the primary SMTP address to make the mailbox undeliverable? (yes/no)"
if ($updateSMTP -eq "yes") {
    $newPrimarySMTP = "archive" + $user.PrimarySmtpAddress
    Set-Mailbox -Identity $userUPN -PrimarySmtpAddress $newPrimarySMTP
}

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false

# Disconnect from Microsoft Online Services
Disconnect-MsolService
