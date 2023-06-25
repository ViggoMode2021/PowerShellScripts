<#
Invoke-Sqlcmd -Query "CREATE TABLE Persons (
    ID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int)" -ServerInstance "localhost\SQLEXPRESS"

#>

#Invoke-Sqlcmd -Query "INSERT INTO Persons (ID, LastName, FirstName, Age) VALUES (1, 'Roberts', 'Bill', 25);" -ServerInstance "localhost\SQLEXPRESS"

#Invoke-Sqlcmd -Query "SELECT * FROM Persons;" -ServerInstance "localhost\SQLEXPRESS"

#Invoke-Sqlcmd -Query "ALTER TABLE Persons DROP COLUMN ID;" -ServerInstance "localhost\SQLEXPRESS"

<#Problem,Description,Result,Date,CompletionTime,Points
Invoke-Sqlcmd -Query "CREATE TABLE Persons (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Problem varchar (100)L,
    Description 
    Age int)" -ServerInstance "localhost\SQLEXPRESS"
#>

<#

Invoke-Sqlcmd -Query "CREATE TABLE EliteShell (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int)" -ServerInstance "localhost\SQLEXPRESS"

Invoke-Sqlcmd -Query "INSERT INTO Persons (LastName, FirstName, Age) VALUES ('Roberts', 'Bill', 25);" -ServerInstance "localhost\SQLEXPRESS"

Invoke-Sqlcmd -Query "SELECT * FROM Persons;" -ServerInstance "localhost\SQLEXPRESS"

#>

<#
$Server = "localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;"

[string]$Database = "master"

[string]$SqlQuery= $("SELECT * FROM Persons;")



$Command = New-Object System.Data.SQLClient.SQLCommand

$Command.Connection = $Connection



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection

$SqlConnection.ConnectionString = "Server = $Server; Database = $Database; Integrated Security = True;"



$SqlCmd = New-Object System.Data.SqlClient.SqlCommand

$SqlCmd.CommandText = $SqlQuery

$SqlCmd.Connection = $SqlConnection

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

$SqlAdapter.SelectCommand = $SqlCmd

$DataSet = New-Object System.Data.DataSet

$SqlAdapter.Fill($DataSet)



$DataSet.Tables[0] | out-file "C:\Users\ryans\Desktop\SQL-Server\powershell_query_test_result2.csv"
#>


#Invoke-Sqlcmd -Query "SELECT name, database_id, create_date FROM sys.databases;" -ServerInstance $Server_Sans_Database
#>

#Invoke-Sqlcmd -Query "ALTER LOGIN LAPTOP-SLC514AD\ryans WITH DEFAULT_DATABASE = CSVLife" -ServerInstance $Server_Sans_Database

<#
Invoke-Sqlcmd -Query "CREATE TABLE TimeSheets(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Weekday varchar(10) NOT NULL,
    FullDate varchar(10) NOT NULL,
    TimeIn varchar (10) NOT NULL,
    TimeOut varchar (10) NOT NULL)" -ServerInstance $Server_Sans_Database
#>


$Server_Sans_Database = "localhost\SQLEXPRESS"

$Date = Get-Date -format "MM-dd-yy"

$Day_Of_Week = [string](Get-Date).DayOfWeek

$Time = (Get-Date).ToString('T')

$Time = $Time.Replace(':', "")

$Time = $Time.Replace('AM', "")

$Time_Out = "5"

Invoke-Sqlcmd -Query "INSERT INTO TimeSheets (Weekday, FullDate, TimeIn, TimeOut) VALUES ($Day_Of_Week, $Date, $Time, $Time_Out);" -ServerInstance "localhost\SQLEXPRESS"
