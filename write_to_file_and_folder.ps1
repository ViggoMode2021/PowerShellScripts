# PI.ps1

$PI = 3.14

$Date = Get-Date

$Item_Path = "C:/Users/ryans/Desktop/new_folder"

Remove-Item -path $Item_Path -Recurse -Force

Out-File -FilePath 'powershell_yes.txt'

$paragraph = @"
hey man $PI is Pi and the date is $Date What is goodie?
"@

New-Item -Path $Item_Path -ItemType directory

$paragraph | Out-File -FilePath powershell_yes.txt

Move-Item -Path powershell_yes.txt -Destination .\new_folder
