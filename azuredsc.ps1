New-AzureRmResourceGroupDeployment -Name "deploy1" -ResourceGroupName dscsamples -Mode Incremental -TemplateFile "C:\Ritesh\dsc\templatedisk.json" `
-adminUsername citynextadmin -adminPassword $(ConvertTo-SecureString -String citynext!1234 -AsPlainText -Force) -dnsNameForPublicIP sfwerfsdf -Verbose


Import-AzureRmAutomationDscConfiguration -SourcePath "C:\Ritesh\webserver.ps1" -ResourceGroupName ARMtemplatesamples -AutomationAccountName mclassmon1 -Force -Published -Verbose

Start-AzureRmAutomationDscCompilationJob -ConfigurationName webserver -ResourceGroupName ARMtemplatesamples -AutomationAccountName mclassmon1 -IncrementNodeConfigurationBuild -Verbose

Register-AzureRmAutomationDscNode -AzureVMName DSCVM0 -NodeConfigurationName webserver.myvm -ConfigurationMode ApplyAndAutocorrect `
-RefreshFrequencyMins 30 -ConfigurationModeFrequencyMins 15 -AzureVMResourceGroup DscSamples `
-AzureVMLocation "West Europe" -ResourceGroupName ARMtemplatesamples -AutomationAccountName mclassmon1  -Verbose
