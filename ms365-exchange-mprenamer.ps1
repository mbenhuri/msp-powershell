# I have no idea why this was used, it apears to convert shared mailboxes to archive names then creates a distribution list for the old emails
# while pausing in between to let the service not throw an error

$mpusers = Import-Csv C:\temp\mpusers.csv

foreach ($mpuser in $mpusers){

    $moldemail = $mpuser.oldemail
    $marchivename = $mpuser.archivename
    $malias = $mpuser.alias 
    $mnewemail = $mpuser.newemail 
    $mdgname = $mpuser.dgname 
    
    Write-Host "I am renaming $moldemail"
    Set-MsolUserPrincipalName -UserPrincipalName $moldemail -NewUserPrincipalName $marchivename
    Write-Host "I finished renaming $moldemail and now waiting 1 minute to proceed"
    Start-Sleep -s 60 
    Write-Host "I am going to remove $oldemail from the shared mailbox with alias $malias"
    get-mailbox -identity $malias | set-mailbox -emailaddresses @{remove=$moldemail}
    Write-Host "I have finished removing $oldemail email address from the shared mailbox."
    Write-Host "I am creating a new distribution group $mdgname with $mnewemail in it"
    new-distributiongroup -Name $mdgname -Members $mnewemail -PrimarySmtpAddress $moldemail -RequireSenderAuthenticationEnabled $false
    Write-Host "I have finished creating this distribution list and am going to the next person or ending"

    }
