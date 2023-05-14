# Connect to the SharePoint Online PowerShell module
Connect-SPOService -Url https://yourtenantname-admin.sharepoint.com

# Set the URL of the OneDrive site to search
$siteUrl = "https://yourtenantname-my.sharepoint.com/personal/user_name_domain_com"

# Set the maximum length of a file path
$maxPathLength = 260

# Get the user's login name
$user = Get-SPOUser -Site $siteUrl

# Get the OneDrive site
$site = Get-SPOSite $siteUrl

# Get the root folder of the OneDrive site
$rootFolder = $site.RootWeb.GetFolderByServerRelativeUrl("Shared%20Documents")

# Get all files and folders in the user's OneDrive site
$items = $rootFolder.Files + $rootFolder.Folders | Select-Object -Property Name, ServerRelativeUrl, FileSystemObjectType -Recursive

# Loop through each item in the OneDrive site and output any paths that are too long
foreach ($item in $items) {
    if ($item.ServerRelativeUrl.Length -gt $maxPathLength) {
        Write-Host $item.ServerRelativeUrl
    }
}
