Import-Module ActiveDirectory

# Add student account functionality

$Domain="@.org"

$OU="OU=,DC=,DC=org"

$NewUsersList=Import-CSV "C:\Users\\faculty-import-facultee.csv"

$Password = 'westbrook4515' | ConvertTo-SecureString -AsPlainText -Force

$Domain = "@westbrookctschools.org"

$Period = "."

$_School_Names = "","","  School","" # Any of these school names will satisfy the school placement logic.

$MS_School_Names = "","MS"," Middle School","Middle School","Middle" # Any of these school names will satisfy the school placement logic.

$WHS_School_Names = "WHS","HS"," High School","High School" # Any of these school names will satisfy the school placement logic.

# Loop through csv below

$Staff_School_Placement = Read-Host "Type the staff's school placement."

if ($School_Names -contains $Staff_School_Placement) {
       $OU="OU=Dingraham,OU=Beginners,OU=Facultad,OU=kimport,DC=westbrookctschools,DC=org"
      }
      
 if ($WSchool_Names -contains $Staff_School_Placement) {
       $OU="OU=Middleham,OU=Beginners,OU=Facultad,OU=kimport,DC=westbrookctschools,DC=org"
      }
      
 if ($WSchool_Names -contains $Staff_School_Placement) {
       $OU="OU=Highham,OU=Beginners,OU=Facultad,OU=kimport,DC=westbrookctschools,DC=org"
      }

ForEach ($User in $NewUsersList) {

$First_Name=$User.First_Name

$Last_Name=$User.Last_Name

$First_Initial = $First_Name.Substring(0,1).ToLower()

$First_Name_Lower = $First_Name.ToLower()
$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"

New-ADUser `
-Path $OU `
-Enabled $True `
-ChangePasswordAtLogon $True `
-Name "$Last_Name$Comma $First_Name" `
-GivenName $First_Name `
-Surname $Last_Name `
-AccountPassword $Password `
-SamAccountName $Username `
-UserPrincipalName "$Username $Domain" `
-Displayname "$First_Name $Last_Name" `
-ScriptPath "logon.bat" `
-HomeDrive "Y:" `
-HomeDirectory "\" `
-EmailAddress "$Username$Domain"

Unlock-ADAccount -Identity $Username

Enable-ADAccount -Identity $Username
 
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true

}
