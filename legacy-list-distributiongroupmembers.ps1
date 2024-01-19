# One of a few methods I devised to list all group members in a digestible file for people without access to AD

﻿$saveto = "C:\temp\listmembers.txt"

Get-DistributionGroup -OrganizationalUnit exampledomain.com | sort name | ForEach-Object {

	"`r`n$($_.Name)`r`n=============" | Add-Content $saveto
	Get-DistributionGroupMember $_.Name | sort Name | ForEach-Object {
		If($_.RecipientType -eq "UserMailbox")
			{
				$_.Name + " (" + $_.PrimarySMTPAddress + ")" | Add-Content $saveto
			}
	}
}
