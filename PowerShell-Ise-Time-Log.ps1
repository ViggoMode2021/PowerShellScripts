$Server_Sans_Database = "localhost\SQLEXPRESS"

$Date = Get-Date -format "MM-dd-yy"

$Day_Of_Week = [string](Get-Date).DayOfWeek

$Name = "powershell_ise"

function Get-ServiceUptime{

$Service = Get-CimInstance -ClassName Win32_Process -Filter "Name LIKE 'powershell_ise.exe'"

$Process = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId = $($Service.ProcessId)"

$Total_PowerShell_Ise_Time = (Get-Date) - $Process.CreationDate

$Total_PowerShell_Ise_Time = [string]$Total_PowerShell_Ise_Time

$Total_PowerShell_Ise_Time = $Total_PowerShell_Ise_Time.Substring(0, $Total_PowerShell_Ise_Time.IndexOf('.'))

$Total_PowerShell_Ise_Time = [timespan]$Total_PowerShell_Ise_Time

$Process_ID = Get-Process "powershell_ise" | Select -expand Id

Invoke-Sqlcmd -Query "INSERT INTO PowerShellTimeLog (Weekday, Date, ProcessId, TotalTime) VALUES ('$Day_Of_Week', '$Date', $Process_ID, '$Total_PowerShell_Ise_Time');" -ServerInstance "localhost\SQLEXPRESS"
}

Get-ServiceUptime

$Time = (get-date).ToString('T')

$Time = [DateTime]$Time

Invoke-Sqlcmd -Query "SELECT * FROM PowerShellTimeLog" -ServerInstance "localhost\SQLEXPRESS"

<#


Register-EngineEvent -SourceIdentifier PowerShell.Exiting -SupportEvent -Action {
    Start-Process "www.google.com"

<#
Invoke-Sqlcmd -Query "CREATE TABLE PowerShellTimeLog(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Weekday varchar(10),
    Date varchar(10),
    ProcessId INT,
    TotalTime time)" -ServerInstance "localhost\SQLEXPRESS"

<#



Invoke-Sqlcmd -Query "DROP TABLE PowerShellTimeLog" -ServerInstance "localhost\SQLEXPRESS"


#>

#>
