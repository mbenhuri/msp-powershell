$saveto = "C:\temp\listmembers.txt"

Get-DistributionGroup -OrganizationalUnit exampledomain.com | sort name | ForEach-Object {

	"`r`n$($_.Name)`r`n=============" | Add-Content $saveto
	Get-DistributionGroupMember $_.Name | sort Name | ForEach-Object {
		If($_.RecipientType -eq "UserMailbox")
			{
				$_.Name + " (" + $_.PrimarySMTPAddress + ")" | Add-Content $saveto
			}
	}
}