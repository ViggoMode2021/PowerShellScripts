$ip = (Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred" -and $_.ValidLifetime -lt "24:00:00"}).IPAddress

-join ($ip.split(".") | foreach-object {[system.convert]::tostring($_, 2).padleft(8, "0")})
