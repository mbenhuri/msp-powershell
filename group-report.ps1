$Result=@()
$groups = Get-DistributionGroup -ResultSize Unlimited
$totalmbx = $groups.Count
$i = 1

$groups | ForEach-Object {
    Write-Progress -Activity "Processing $_.DisplayName" -Status "$1 out of $totalmbx completed"
    $group = $_
    Get-DistributionGroupMember -Identity $group.Name -ResultSize Unlimited | ForEach-Object {
        $member = $_
        $Result += New-Object psobject -Property @{
            GroupName = $group.Name 
            EmailAddress = $member.PrimarySMTPAddress
            RecipientType= $member.RecipientType
        }
      }
      $i++
   }

   $Result | Export-Csv "C:\temp\All-Distribution-Group-Members.csv" -NoTypeInformation -Encoding UTF8