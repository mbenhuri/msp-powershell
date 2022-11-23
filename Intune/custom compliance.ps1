# This is the script 
$avinfo = Get-CimInstance -Namespace root/SecurityCenter2 -Classname AntiVirusProduct

if ($avinfo.displayName -like '*Sentinel*') {
    $s1 = "Detected" # Also want to test $true but this was on the example I used 
}
else {
    $s1 = "Not Detected" # $False
}

$avhash = @{"Sentinel One" = $s1}

return $avhash | ConvertTo-Json -Compress

#--------------------------------- JSON for the portal:

{
"Rules":[ 
    { 
       "SettingName":"Sentinel One",
       "Operator":"IsEquals",
       "DataType":"String",
       "Operand":"Detected",
       "MoreInfoUrl":"https://bitxbit.com",
       "RemediationStrings":[ 
          { 
             "Language":"en_US",
             "Title":"Sentinel One must be deployed.",
             "Description": "Please make sure that the Sentintel One version is installed."
          }
       ]
    }
 ]
}