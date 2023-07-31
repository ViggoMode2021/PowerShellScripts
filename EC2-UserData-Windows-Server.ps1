# This script sets up a Windows Server custom image

# Part one

function Setup_Windows_Firewall_Custom_Rules{

# FireShell

# This script will recursively block all IP addresses associated with the websites below. 

# You can view and alter these settings via Windows Defender Firewall with Advanced Security.

$Adult_Websites = "pornhub.com", "xvideos.com", "xnxx.com", "youporn.com", "xhamster.com", "hqporner.com",  "pornpics.com"

foreach ($Website in $Adult_Websites){

$IP_Addresses = Resolve-DnsName $Website | Select -Expand IPAddress

$IP_Count = $IP_Addresses | Measure-Object | Select -expand Count

Write-Host "Blocking all $IP_Count IP addresses associated with $Website." -ForeGroundColor "Cyan"

foreach ($IP in $IP_Addresses){

New-NetFirewallRule -DisplayName "Block $Website HTTPS" -Direction Outbound -RemotePort 443 -Protocol TCP -Action Block -RemoteAddress $IP

Write-Host "Successfully blocked $Website" -ForeGroundColor "Green"

}

}

$Social_Media_Webistes = "facebook.com", "instagram.com", "myspace.com", "linkedin.com", "discord.com", "reddit.com", "4chan.com"

foreach ($Website in $Social_Media_Webistes){

$IP_Addresses = Resolve-DnsName $Website | Select -Expand IPAddress

$IP_Count = $IP_Addresses | Measure-Object | Select -expand Count

Write-Host "Blocking all $IP_Count IP addresses associated with $Website." -ForeGroundColor "Cyan"

foreach ($IP in $IP_Addresses){

New-NetFirewallRule -DisplayName "Block $Website HTTPS" -Direction Outbound -RemotePort 443 -Protocol TCP -Action Block -RemoteAddress $IP

Write-Host "Successfully blocked $Website" -ForeGroundColor "Green"

}

}

}

Setup_Windows_Firewall_Custom_Rules

## Part two

function Install_Chocolatey_And_Packages {

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco upgrade chocolatey

choco install awscli

}

Install_Chocolatey_And_Packages

# Part three 

function Custom_Registry_Edits {

New-Item -Path "HKCR:\Directory\Background\shell" -Name "Check Email" 

New-Item -Path "HKCR:\Directory\Background\shell\Check Email" -Name "command" 

New-ItemProperty -Path "HKCR:\Directory\Background\shell\Check Email\command" -Name "(Default)" -Value '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "gmail.com"' -Type String

##

}
