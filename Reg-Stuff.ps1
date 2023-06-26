#New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

<#
New-Item -Path "HKCR:\Directory\Background\shell" -Name "Open_PowerShell" 

New-Item -Path "HKCR:\Directory\Background\shell\Open_PowerShell" -Name "command" 

New-ItemProperty -Path "HKCR:\Directory\Background\shell\Open_PowerShell\command" -Name "(Default)" -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Type String
#>

#New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

<#
New-Item -Path "HKCR:\Directory\Background\shell" -Name "Open Spiceworks" 

New-Item -Path "HKCR:\Directory\Background\shell\Open SpiceWorks" -Name "command" 

New-ItemProperty -Path "HKCR:\Directory\Background\shell\Open Spiceworks\command" -Name "(Default)" -Value '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://wps-web:9675/tickets"' -Type String

#>

<#
New-Item -Path "HKCR:\Directory\Background\shell" -Name "Open PowerSchool" 

New-Item -Path "HKCR:\Directory\Background\shell\Open PowerSchool" -Name "command" 

New-ItemProperty -Path "HKCR:\Directory\Background\shell\Open PowerSchool\command" -Name "(Default)" -Value '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://powerschool.westbrookctschools.org/admin/pw.html"' -Type String

#>

<#
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows" -Name "Explorer"

New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value '1' -Type DWORD

#>

New-Item -Path "HKCR:\Directory\Background\shell" -Name "Check Email" 

New-Item -Path "HKCR:\Directory\Background\shell\Check Email" -Name "command" 

New-ItemProperty -Path "HKCR:\Directory\Background\shell\Check Email\command" -Name "(Default)" -Value '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "gmail.com"' -Type String
