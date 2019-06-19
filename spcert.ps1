
$currentDate = Get-Date

$expiryDate = $currentDate.AddYears(1)
$finalDate = $expiryDate.AddYears(1)

$appname = "mclasswednew"


$app = New-AzureRmADApplication -DisplayName $appname -IdentifierUris "http://$appname" -HomePage "http://$appname" -Verbose


$certificate = New-SelfSignedCertificate -Subject $appname -KeyExportPolicy Exportable -KeySpec Signature -NotAfter $finalDate -CertStoreLocation "Cert:\LocalMachine\My"

$certinBase64 = [System.Convert]::ToBase64String($certificate.GetRawCertData())

$certThumbprint = $certificate.Thumbprint

New-AzureADApplicationKeyCredential -ObjectId $app.ObjectId -CustomKeyIdentifier "test123" -StartDate $currentDate -EndDate $expiryDate -Type AsymmetricX509Cert -Usage Verify -Value $certinBase64 -Verbose

New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId -Role Owner  -Verbose

