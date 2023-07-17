$OU = 'OU=StudentAccounts, DC=vigschools, DC=org'

$Null_Display_Name_Count = Get-ADUser -Filter 'displayname -notlike "*"' -SearchBase $OU | Measure-Object | Select -expand count

$Null_Display_Name_First_Last = Get-ADUser -Filter 'displayname -notlike "*"' -SearchBase $OU | Select-Object -expand Name

foreach ($Name in $Null_Display_Name_First_Last){

$Sam_Account_Names = Get-ADUser -Filter "Name -eq '$Name'" | Select-Object -expand SamAccountName

foreach ($San in $Sam_Account_Names){
	
Set-ADUser -Identity $San -DisplayName $Name

}

}
