# quickly gets all the mailboxes and dumps their rules in order to a text file for a review after a breach.
# no bs

$mailboxes=get-mailbox
foreach ($mailbox in $mailboxes){get-inboxrule -mailbox $mailbox.alias | fl identity, description | out-file c:\temp\rules.txt -Append}
