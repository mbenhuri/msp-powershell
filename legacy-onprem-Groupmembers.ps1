# For legacy exchange environments this will list out and export all the members of distribution lists to a csv
# I would then make a quick pivot table to review with clients

$Groups = Get-ADGroup -Filter {GroupScope -eq 'Global' -and Members -ne "NULL"}
$Users = foreach( $Group in $Groups ){
    Get-ADGroupMember -Identity $Group | foreach {
        [PSCustomObject]@{
            Group = $Group.Name
            UserName = $_.SamAccountName
        }
    }
}
$Users | Export-CSV C:\scripts\groups.csv -NoTypeInformation
