
$myurl = "https://s2events.azure-automation.net/webhooks?token=%2bkO0MP98eBFwvMi9st9h%2bFuGJGV%2bW40ypfC0X9G49O4%3d"

$mybody = @(
    @{message = "my first web hook"}
)

$jsonbody = ConvertTo-Json -InputObject $mybody

$myheader = @{headermessgae = "this is message from the header"}

Invoke-RestMethod -Method Post -Uri $myurl -Headers $myheader -Body $jsonbody
