$EnrollmentsPath = "HKLM:\SOFTWARE\Microsoft\Enrollments\"
$Enrollments = Get-ChildItem -Path $EnrollmentsPath
Foreach ($Enrollment in $Enrollments)
{
      $EnrollmentObject = Get-ItemProperty Registry::$Enrollment
      if ($EnrollmentObject."DiscoveryServiceFullURL" -eq https://enrollment.manage.microsoft.com/enrollmentserver/discovery.svc) 
{
            $EnrollmentPath = $EnrollmentsPath + $EnrollmentObject."PSChildName"
            Remove-Item -Path $EnrollmentPath -Recurse
     }
}
