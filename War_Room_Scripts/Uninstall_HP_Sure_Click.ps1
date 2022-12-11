Function Uninstall_HP_Sure_Click {
    $HP_Sure_Click = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%HP Sure Click% WHERE NOT '%HP...''" #Add to this

    $uninstall = $HP_Sure_Click.Uninstall()

    Write-Host 'Uninstalling HP Sure Click:
     ' -NoNewline

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

Uninstall_HP_Sure_Click