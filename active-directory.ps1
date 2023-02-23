Import-Module ActiveDirectory

$First_Name = Read-Host "Enter First Name"
$First_Initial = $First_Name.Substring(0,1).ToLower()
$Last_Name = Read-Host "Enter Last Name"
$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"
$Description = Read-Host "Enter a user description."
$Password = Read-Host -AsSecureString "Enter a secure password"
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
 -Path "OU=kimport,DC=westbrookctschools,DC=org" `
 -AccountPassword $Password `
 -ScriptPath "logon.bat" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\wps-server01\users\$Username" `
 -EmailAddress "$Username$Domain"

#Set-ADUser $Username -Enabled $True
#Set-ADUser $Username -ChangePasswordAtLogon $False 
#Set-ADUser $Username -EmailAddress "$Username + '\' + $Domain"

Write-Host "Active Directory user account setup complete for $First_Name $Last_Name!" #-Color Green
