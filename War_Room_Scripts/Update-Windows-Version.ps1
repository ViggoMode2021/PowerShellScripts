#Work in progress

$OS = systeminfo | findstr /B /C:"OS Version"

$Desktop_Path = [Environment]::GetFolderPath("Desktop")

$Date = Get-Date 

$Computer = Hostname

$Ok_Button = [System.Windows.MessageBoxButton]::Ok

$Icon = [System.Windows.MessageBoxImage]::Warning

$Start_Title = “Windows update has commenced”

$Start_Body = “Windows has commenced on $Date for $Computer”

$Already_Updated_Title = “$Computer is already running $OS”

$Already_Updated_Body = “$Computer is already running $OS. No further action is required.”

if($OS -notmatch "10.0.19045"){

[System.Windows.MessageBox]::Show($Start_Title,$Start_Body,$Ok_Button,$Icon)

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?LinkID=799445" -OutFile "$Desktop_Path\Windows_Update_Assistant.exe"

Set-Location -Path $Desktop_Path

Start-Process -FilePath Windows_Update_Assistant.exe -Wait -Passthru

#DELETE ITEM HERE

}

else{

[System.Windows.MessageBox]::Show($Already_Updated_Body,$Already_Updated_Title,$Ok_Button,$Start_Icon)

}