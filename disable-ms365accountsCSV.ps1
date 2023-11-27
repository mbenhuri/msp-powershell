# Install and import the Microsoft Graph PowerShell module if not already installed
Install-Module -Name Microsoft.Graph.Authentication -Force -AllowClobber
Install-Module -Name Microsoft.Graph.Users -Force -AllowClobber

# Import the Microsoft Graph module
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users

# Authenticate with Microsoft Graph (you'll be prompted to sign in)
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Specify the path to your CSV file containing UPNs
$csvFilePath = "C:\Path\To\Your\File.csv"

# Read the UPNs from the CSV file
$upns = Import-Csv -Path $csvFilePath | Select-Object -ExpandProperty UPN

# Loop through each UPN and block sign-ins
foreach ($upn in $upns) {
    try {
        $user = Get-MgUser -Filter "userPrincipalName eq '$upn'"
        if ($user) {
            Set-MgUser -UserId $user.Id -AccountEnabled $false
            Write-Host "Blocked sign-in for user: $upn"
        } else {
            Write-Host "User not found: $upn"
        }
    } catch {
        Write-Host "Failed to block sign-in for user: $upn. Error: $($_.Exception.Message)"
    }
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph
