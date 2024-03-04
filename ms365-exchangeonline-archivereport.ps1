# Get all mailboxes
$mailboxes = Get-Mailbox -ResultSize Unlimited

# Create an empty array to hold the results
$results = @()

foreach ($mailbox in $mailboxes) {
    # Get mailbox statistics for Archiving status
    $mailboxStats = Get-MailboxStatistics -Identity $mailbox.Identity

    # Create a custom object for each mailbox
    $obj = New-Object PSObject -Property @{
        DisplayName = $mailbox.DisplayName
        EmailAddress = $mailbox.PrimarySmtpAddress
        MRMpolicy = $mailbox.RetentionPolicy
        ArchiveStatus = $mailboxStats.ArchiveStatus
    }

    # Add the object to the results array
    $results += $obj
}

# Display results in a grid view
$results | Out-GridView
