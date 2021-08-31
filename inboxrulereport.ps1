import-module exchangeonline
connect-exchangeonline
$mailboxes=get-mailbox
foreach ($mailbox in $mailboxes){get-inboxrule -mailbox $mailbox.alias | fl identity, description | out-file c:\temp\rules.txt -Append}
