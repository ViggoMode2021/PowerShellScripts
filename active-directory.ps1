Import-Module ActiveDirectory

$First_Name = Read-Host "Enter First Name"

if($First_Name -match "\d+")
{
   $First_Name = Read-Host "First name should not contain a number. If you are adament, disregard this."
}

$First_Initial = $First_Name.Substring(0,1).ToLower()
$Last_Name = Read-Host "Enter Last Name"

if($Last_Name -match "\d+")
{
   $Last_Name = Read-Host "Last name should not contain a number. If you are adament, disregard this."
}

$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"
$Description = Read-Host "Enter a user description."
$Password = Read-Host -AsSecureString "Enter a secure password" # 
$Domain = "@.org"
$Comma = ","

 New-ADUser `
 -Name "$Last_Name $Comma $First_Name" `
 -GivenName $First_Name `
 -Surname $Last_Name `
 -SamAccountName $Username `
 -UserPrincipalName "$Username $Domain" `
 -Displayname "$First_Name $Last_Name" `
 -Description $Description `
 -Path "OU=,DC=,DC=" `
 -AccountPassword $Password `
 -ScriptPath ".bat" `
 -HomeDrive ":" `
 -HomeDirectory "" `
 -EmailAddress "$Username$Domain"

Write-Host "Active Directory user account setup complete for $First_Name $Last_Name!"
