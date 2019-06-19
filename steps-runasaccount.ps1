

1. downloaded AzureAD module using command
	install-module -name AzureAd -verbose

2. created a self signed certificate that is exportable having the same subject name as that of Azure Service application
	$certificate = New-SelfSignedCertificate -Subject $appname -KeyExportPolicy Exportable -KeySpec Signature -NotAfter $finalDate -CertStoreLocation "Cert:\LocalMachine\My"

3. Create a new Azure Service Application
	$app = New-AzureRmADApplication -DisplayName $appname -IdentifierUris "http://$appname" -HomePage "http://$appname" -Verbose

4. Convert the certificate into base64 before uploading to Service application	
	$certinBase64 = [System.Convert]::ToBase64String($certificate.GetRawCertData())

5. create a new ApplicationKeyCredential using the certificate	
	New-AzureADApplicationKeyCredential -ObjectId $app.ObjectId -CustomKeyIdentifier "test123" -StartDate $currentDate -EndDate $expiryDate -Type AsymmetricX509Cert -Usage Verify -Value $certinBase64 -Verbose

6. create a new Service application
	New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId -Role Owner  -Verbose

7. export the certificate with private key

8. create a new certificate shared asset on AA and upload the certificate to it using the same password as used while exporting it

9. create a new connection shared asset on AA and provide inforation about tenantid, subscriptionid, thumbprint and application id

10. write your runbook and use them to login to Azure
	Login-AzureRmAccount -ServicePrincipal -CertificateThumbprint "ED9DF4F30BDEA5160B206597E696B8310F243E78" -ApplicationId "cd02f784-c58c-4ce0-a128-f22e5a600e8c" -Tenant 771f1cf4-b1ac-4f2e-ad21-de39ea201e7e


