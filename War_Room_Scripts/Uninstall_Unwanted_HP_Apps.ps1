Function Uninstall_Unwanted_HP_Apps {
    $unwanted_hp_apps = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%HP% WHERE NOT '%HP...''" #Add to this

    $uninstall = foreach ($app in $unwanted_hp_apps)
    {
      $app.Uninstall()
    }

    Write-Host 'Uninstalling the following unwanted HP applications:
    HP Drive Encryption=
    HP ePrint SW
    HP Documentation +
    HP Notifications
    HP Registration Service=
    HP Softpaq Download Manager
    HP Support Assistant
    HP Welcome=
    HP Support Solutions Framework
    HP Software Setup=
    HP Device Access Manager
    HP Jumpstart Bridge
    HP Jumpstart Launch
    HP Jumpstart Apps
    HP Workwise Service
    HP Velocity
    HP Sure Connect
    HP Mac Address Manager
    HP Wolf Security
     ' -NoNewline

    # Install Chrome

	$ExitCode = (Start-Process $uninstall).ExitCode
    
    if ($ExitCode -eq 0) {
        Write-Host 'success!' -ForegroundColor Green
    } else {
        Write-Host "failed. There was a problem." -ForegroundColor Red
        Clean-Up
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}

Uninstall_Unwanted_HP_Apps
