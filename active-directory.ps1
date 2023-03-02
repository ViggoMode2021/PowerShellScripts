Import-Module ActiveDirectory

$Enrollment_Date =  Get-Date -Format "MMddyy"

$ = ""

$Password = "$Westbrook$Enrollment_Date"

$Default_Password = $Password | ConvertTo-SecureString -AsPlainText -Force

$First_Name = Read-Host "Enter First Name" 

if($First_Name -match "\d+")
{
   $First_Name = Read-Host "Input can't contain an integer. If you're adament, disregard and try again."
}

$First_Initial = $First_Name.Substring(0,1).ToLower()
$Last_Name = Read-Host "Enter Last Name"

if($Last_Name -match "\d+")
{
   $Last_Name = Read-Host "Input can't contain an integer. If you're adament, disregard and try again."
}

$First_Name_Lower = $First_Name.ToLower()
$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"
$Description = Read-Host "Enter a user description."

$Domain = "@.org"
$Comma = ","
$Period = "."

 New-ADUser `
 -Name "$Last_Name $Comma $First_Name" `
 -GivenName $First_Name `
 -Surname $Last_Name `
 -SamAccountName $Username `
 -UserPrincipalName "$Username $Domain" `
 -Displayname "$First_Name $Last_Name" `
 -Description $Description `
 -Path "OU=,DC=,DC=org" `
 -AccountPassword $Default_Password `
 -ScriptPath "logon.bat" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\\users\$Username" `
 -EmailAddress "$Username$Domain"

Unlock-ADAccount -Identity $Username

Enable-ADAccount -Identity $Username
 
$Student_Or_Staff_Account = Read-Host "Type 1 if this is a student account or any other key if this is a staff account." 

if($Student_Or_Staff_Account -match "1")
{
   Set-ADUser -Identity $Username -ChangePasswordAtLogon $false
     
   Set-AdUser -Identity $Username -EmailAddress "$First_Name_Lower$Period$Last_Name_Lower$Domain"
   
   Set-AdUser -Identity $Username -UserPrincipalName "$First_Name_Lower$Period$Last_Name_Lower$Domain"
   
   Write-Host " student account setup complete for $First_Name $Last_Name on $Enrollment_Date!" -ForegroundColor DarkGreen -BackgroundColor White
   Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White
}

else
{
   Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
   
   Write-Host " faculty account setup complete for $First_Name $Last_Name on $Enrollment_Date!" -ForegroundColor DarkGreen -BackgroundColor White
   Write-Host "Account name: $Username, Email: $Username$Domain" -ForegroundColor DarkGreen -BackgroundColor White   
}
