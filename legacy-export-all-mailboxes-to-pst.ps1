# Exchange 2010 
# Export all mailboxes to Share 

# Assumes you have the mailbox import-export management role 
# New-ManagementRoleAssignment -Role "Mailbox Import Export" -User 

# Assumes MailboxExport share has been created and Exchange Trusted Subsystem User has full control of the share

$mailboxes = get-mailbox
$extension = ".pst"
$filepath = "\\Servername\MailboxExport\"

foreach ($mbx in $mailboxes){
$alias = $mbx.alias
new-mailboxexportrequest -mailbox $alias -FilePath ($filepath + $alias + $extension) -name $alias
}
