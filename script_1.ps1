# PI.ps1

$PI = 3.14

$Date = Get-Date

#Write-Host "The value of $PI is $PI"
#Write-Host 'Here is $PI'

#Write-Host "An expression $($PI + 1)"
#Write-Host ""

#$test = 'h1'

#notepad.exe

Out-File -FilePath 'powershell_yes.txt'

$paragraph = @"
hey man $PI is Pi and the date is $Date
"@

$paragraph | Out-File -FilePath powershell_yes.txt

#Start-Process -FilePath "C:\Users\ryans\Desktop\Visual Studio Code.lnk"
#Start-Process -FilePath "www.VigLMS.org"
