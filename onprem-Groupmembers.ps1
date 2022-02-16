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
