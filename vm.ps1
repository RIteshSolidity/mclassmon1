param(
    [parameter(mandatory = $true)]
    [string] $location ,
    [parameter(mandatory = $true)] 
    [string] $rgName ,
    [parameter(mandatory = $true)]
    [string] $username ,
    [parameter(mandatory = $true)]    
    [string] $password ,
    [parameter(mandatory = $true)]    
    [string] $storageAccountName
)


$secureStringPassword = ConvertTo-SecureString -String $password -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPassword
  
New-AzureRmResourceGroup -Name $rgName -Location $location
try{

    $storage = New-AzureRmStorageAccount -ResourceGroupName $rgName -Name $storageAccountName -SkuName Standard_LRS -Location $location -Kind StorageV2 -AccessTier Hot -ErrorAction Stop
}
catch{
    
}


$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name "subnet1" -AddressPrefix "10.0.1.0/24"

$vnet = New-AzureRmVirtualNetwork -Name vnet01 -ResourceGroupName $rgname -Location $location -AddressPrefix "10.0.0.0/16" -Subnet $subnet

$pip = New-AzureRmPublicIpAddress -Name pip01 -ResourceGroupName $rgName -Location $location -Sku Basic -AllocationMethod Dynamic -DomainNameLabel mclassautounique

$nic = New-AzureRmNetworkInterface -Name nic01 -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].id -PublicIpAddressId $pip.Id -IpConfigurationName ipconfig01

$vm = New-AzureRmVMConfig -VMName vm001 -VMSize Standard_DS4

$vm | Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest
$vm | Set-AzureRmVMOperatingSystem -Windows -ComputerName vm001 -Credential $cred
$vm | Add-AzureRmVMNetworkInterface -Id $nic.Id -Primary 
$vm | Set-AzureRmVMOSDisk -Name "abcde.vhd" -VhdUri "https://$storageAccountName.blob.core.windows.net/vhds/abcde.vhd" -CreateOption FromImage

new-Azurermvm -ResourceGroupName $rgName -Location $location -VM $vm -Verbose

 
