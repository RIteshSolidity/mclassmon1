
$username = ".\"
$pass = ConvertTo-SecureString -String  -AsPlainText -Force

$cred = New-Object  System.Management.Automation.PSCredential -ArgumentList $username,$pass

$session = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

$pss = New-PSSession -ComputerName mclassautounique.westus.cloudapp.azure.com -Credential $cred -Port 5986 -UseSSL -SessionOption $session 

Invoke-Command -Session $pss -ScriptBlock {get-date} -Verbose


#$thumbprint = (New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\my).Thumbprint

#winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="VM001";CertificateThumbprint="A7BE22301BE208AE8893AFC8A32DBFC08FDDFF25"}
