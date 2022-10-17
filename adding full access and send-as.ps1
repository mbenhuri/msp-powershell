# Replace mailbox with the mailbox you are granting permission to
# Replace user with user who needs permission to said mailbox

Add-MailboxPermission -Identity MAILBOX -User USER -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission -Identity MAILBOX -Trustee USER -AccessRights SendAs
