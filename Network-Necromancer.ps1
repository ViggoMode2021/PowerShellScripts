#https://lazyadmin.nl/it/netsh-wlan-commands/ 

$Current_Date = Get-Date -Format "MM/dd/yyyy" # Get today's date

$DesktopPath = [Environment]::GetFolderPath("Desktop")

function Introduction{

$Introduction = Read-Host "Welcome to the Network Necromancer! With this program, you can view, delete, and backup stored networks on your computer. You can also easily connect to a network or view the password
in the event that you may have forgotten it. What would you like to do?

1. View all networks
2. View all networks and passwords
3. Backup all networks to XML files
4. Backup a certain network to XML file
5. Add network with XML file

Please type the corresponding number here" 

####################################################### First main option ###############################################################

if($Introduction -eq "1"){

$All_Networks = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} |
%{[PSCustomObject]@{ Network = $name}} | Format-Table -AutoSize | Out-Host

Write-Host $All_Networks 

$Network_Count = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} |
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} |
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Measure-Object | Select-Object -expandproperty Count | Out-String

Write-Host "You currently have $Network_Count networks on your device." 

$Introduction_1_Second__Prompt = Read-Host "What would you like to do?

1. View a network's password
2. Remove a network 
3. Go back"

if($Introduction_1_Second__Prompt -eq "3"){

Introduction

}

}

####################################################### Second main option ###############################################################

if($Introduction -eq "2"){

(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Format-Table -AutoSize 

$Network_Count = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} |
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} |
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Measure-Object | Select-Object -expandproperty Count | Out-String

Write-Host "You currently have $Network_Count networks on your device." -ForegroundColor "Yellow"

Sleep 2 

Introduction
#foodenvy
}

#netsh wlan delete profile name=LinkTest
#netsh wlan add profile filename="LinkTest.xml" user=current
#netsh wlan connect name=Uplink

####################################################### Third main option ###############################################################

if($Introduction -eq "3"){

if (Test-Path "XML-Network-Info"){

$Network_Search = Read-Host "All networks will be exported to the 'XML-Network-Info' directory in the same directory as this script. Press any key to continue."

netsh wlan export profile key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Total_XML_Files network XML files exported to the 'XML-Network-Info' directory."

Sleep 5

Introduction

}

else{

New-Item -Path 'XML-Network-Info' -ItemType Directory

Write-Host "All networks will be exported to the 'XML-Network-Info' directory in the same directory as this script. Press any key to continue."

netsh wlan export profile key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Total_XML_Files network XML files exported to the 'XML-Network-Info' directory."

Sleep 5

Introduction

}

}

####################################################### Fourth main option ###############################################################

if($Introduction -eq "4"){

$All_Networks = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Format-Table -AutoSize | Out-Host

Write-Host $All_Networks -ForegroundColor "Green"

$Network_To_XML = Read-Host "Which network would you like to backup to an XML file?"

if($Network_To_XML -notmatch $All_Networks){

Write-Host "$Network_To_XML is not located on the device, please try again."

Introduction

}

if (Test-Path "XML-Network-Info"){

$Network_Search = Read-Host "$Network_To_XML will be exported to the 'XML-Network-Info' directory in the same directory as this script. Press any key to continue."

netsh wlan export profile name=$Network_To_XML key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Network_To_XML exported to the 'XML-Network-Info' directory."

Sleep 2

Introduction

}

else{

New-Item -Path 'XML-Network-Info' -ItemType Directory

Write-Host "All networks will be exported to the 'XML-Network-Info' directory in the same directory as this script. Press any key to continue."

netsh wlan export profile key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Total_XML_Files network XML files exported to the 'XML-Network-Info' directory."

Sleep 5

Introduction

}

}

}

Introduction 

# All wifi networks and passwords

$All_Networks_And_Passwords = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Format-Table -AutoSize 

# All single networks and passwords 

#$Wifi_Network = Read-Host "Type the wifi network you wish to delete."

netsh wlan show profile name="$Wifi_Network" key=clear | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Format-Table -AutoSize 
