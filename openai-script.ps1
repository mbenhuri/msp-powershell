# Connect to the SharePoint Online PowerShell module
Connect-SPOService -Url https://yourtenantname-admin.sharepoint.com

# Set the URL of the OneDrive site to search
$siteUrl = "https://yourtenantname-my.sharepoint.com/personal/user_name_domain_com"

# Set the maximum length of a file path
$maxPathLength = 260

# Get the user's login name
$user = Get-SPOUser -Site $siteUrl

# Construct the URL of the user's OneDrive site
$oneDriveUrl = "$siteUrl/Documents"

# Get all files and folders in the user's OneDrive site
$items = Get-SPOFolderItem -FolderSiteRelativeUrl "/Documents" -Recursive -ItemType All -ErrorAction SilentlyContinue

# Loop through each item in the OneDrive site and output any paths that are too long
foreach ($item in $items) {
    if ($item.ServerRelativeUrl.Length -gt $maxPathLength) {
        Write-Host $item.ServerRelativeUrl
    }
}
