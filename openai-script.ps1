# Connect to the SharePoint Online PowerShell module
Connect-SPOService -Url https://yourtenantname-admin.sharepoint.com

# Set the URL of the OneDrive site to search
$siteUrl = "https://yourtenantname-my.sharepoint.com/personal/user_name_domain_com"

# Set the maximum length of the filename (including the path)
$maxPathLength = 260

# Recursively search the site and identify files or folders with long names
Get-SPOSite $siteUrl | Get-SPOUser | ForEach-Object {
    Write-Host "Checking OneDrive site:" $_.LoginName
    $rootFolder = "/" + $_.UserPrincipalName.Replace("@","_").Replace(".","_") + "/"
    Get-SPOFolder -SiteRelativeUrl $rootFolder -Recursive | ForEach-Object {
        $itemPath = $_.ServerRelativeUrl
        if ($itemPath.Length -gt $maxPathLength) {
            Write-Host "Long filename found:" $itemPath
        }
    }
}
