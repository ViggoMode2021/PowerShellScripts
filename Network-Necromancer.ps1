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

if($Introduction -eq "1"){

$All_Networks = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} |
%{[PSCustomObject]@{ Network = $name}} | Format-Table -AutoSize | Out-Host

Write-Host $All_Networks 

$Introduction_1_Second__Prompt = Read-Host "What would you like to do?

1. View a network's password
2. Remove a network 
3. Go back"

if($Introduction_1_Second__Prompt -eq "3"){

Invoke-Expression Introduction
}


}

if($Introduction -eq "2"){

(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | 
%{[PSCustomObject]@{ Network = $name;Password = $pass }} | Format-Table -AutoSize 

}

if($Introduction -eq "3"){

if (Test-Path "XML-Network-Info"){

$Network_Search = Read-Host "All networks will be exported to the desktop. Press any key to continue."

netsh wlan export profile key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Total_XML_Files network XML files exported to the desktop."

}

else{

New-Item -Path 'XML-Network-Info' -ItemType Directory

Write-Host "Creating a directory titled 'XML-Network-Info' on the desktop."

netsh wlan export profile key=clear folder='XML-Network-Info'

$Total_XML_Files = ( Get-ChildItem XML-Network-Info | Measure-Object ).Count;

Write-Host "$Total_XML_Files network XML files exported to the desktop."

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
