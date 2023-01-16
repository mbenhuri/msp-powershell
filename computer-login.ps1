# Query Active Directory for all computers
$computers = Get-ADComputer -Filter *

# Loop through each computer and display its last login date
foreach ($computer in $computers)
{
    # Retrieve the last login date for the computer
    $lastLogin = $computer.lastLogonDate

    # Create an object with the computer name and last login date
    $computerData = New-Object PSObject -Property @{
        Computer = $computer.Name
        LastLogin = $lastLogin
    }

    # Add the computer data to the list of results
    $results += $computerData
}

# Export the results to a CSV file
$results | Export-Csv -Path "last-login-dates.csv" -NoTypeInformation
