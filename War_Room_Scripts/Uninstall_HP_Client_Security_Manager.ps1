Function Uninstall_HP_Client_Security_Manager {
    $HP_Client_Security_Manager = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%HP Client Security Manager% WHERE NOT '%HP...''" #Add to this

    $uninstall = $HP_Client_Security_Manager.Uninstall()

    Write-Host 'Uninstalling HP Client Security Manager:
     ' -NoNewline

	$ExitCode = (Start-Process $uninstall).ExitCode
    
    if ($ExitCode -eq 0) {
        Write-Host 'Success! Please restart the computer in order for changes to take effect.' -ForegroundColor Green
    } else {
        Write-Host "Failed. There was a problem." -ForegroundColor Red
        Clean-Up
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}

Uninstall_HP_Client_Security_Manager