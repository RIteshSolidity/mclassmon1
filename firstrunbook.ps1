

write-output "My first Hello World automation runbook"
$myVar = Get-AutomationVariable -Name 'simpleVariable'
write-output $myVar

$cred = Get-AutomationPSCredential -name mycredential

write-output $cred.Username
Write-Output $cred.GetNetworkCredential().password

$con = Get-AutomationConnection -Name 'mclasswed'

Write-Output  $con.tenantid
Write-Output  $con.subscriptionId
Write-Output  $con.CertificateThumbprint
Write-Output  $con.applicationid

Write-Output  $con

Login-AzureRmAccount -ServicePrincipal -CertificateThumbprint  $con.CertificateThumbprint -ApplicationId $con.applicationid -Tenant $con.tenantid

Get-AzurermVM
