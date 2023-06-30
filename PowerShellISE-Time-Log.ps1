Start-Job -ScriptBlock{

$Server_Sans_Database = "localhost\SQLEXPRESS"

$Date = Get-Date -format "MM-dd-yy"

$Day_Of_Week = [string](Get-Date).DayOfWeek

$Time = (Get-Date).ToString('T')

$Time = $Time.Replace(':', "")

if($Time -contains "AM"){

$Time = $Time.Replace('AM', "")

}

else{

$Time = $Time.Replace('PM', "")

$Time_Out = "5"}

<#
Invoke-Sqlcmd -Query "CREATE TABLE PowerShellTimeLog(
    ID int NOT NULL PRIMARY KEY,
    Weekday varchar(10),
    Date varchar(10),
    TimeOn varchar(10),
    TimeOff varchar(10),
    TotalTime INT)" -ServerInstance "localhost\SQLEXPRESS"

    #>
<#
$Running_Processes = Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object -ExpandProperty ProcessName

if($Running_Processes -contains "powershell_ise"){

Write-Host "PowerShell ISE is running"

}

else{

Write-Host "Ise"

}

#>

$Name = "powershell_ise"

function Get-ServiceUptime{

$Service = Get-CimInstance -ClassName Win32_Process -Filter "Name LIKE 'powershell_ise.exe'"

$Process = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId = $($Service.ProcessId)"

$Creation_Date = (Get-Date) - $Process.CreationDate

$Process_ID = Get-Process "powershell_ise" | Select -expand Id

Write-Host $Process_ID $Creation_Date

} 

Get-ServiceUptime

}
