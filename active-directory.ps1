Import-Module ActiveDirectory

$Enrollment_Date =  Get-Date -Format "MMddyy"

$Town = "town"

$Password = "$Town$Enrollment_Date"

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

$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"
$Description = Read-Host "Enter a user description."

$Domain = "@domain"
$Comma = ","

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
 -HomeDirectory "homedirectory" `
 -EmailAddress "$Username$Domain"

Write-Host "Active Directory user account setup complete for $First_Name $Last_Name!"

Enable-ADAccount -Identity $Username 
