Import-Module ActiveDirectory

# Add student account functionality

$Domain="@.org"

$OU="OU=,DC=,DC=org"

$NewUsersList=Import-CSV "C:\Users\\\-import-facultee.csv"

$Enrollment_Date =  Get-Date -Format "MMddyy"

$ = ""

$Password = "$$Enrollment_Date"

$Default_Password = $Password | ConvertTo-SecureString -AsPlainText -Force

$Domain = "@.org"

$Period = "."

$y_School_Names = "",""," School","" # Any of these school names will satisfy the school placement logic.

$_School_Names = "","","  School","Middle School","Middle" # Any of these school names will satisfy the school placement logic.

$_School_Names = "",""," High School","High School" # Any of these school names will satisfy the school placement logic.


$_Graduation_Years = "2031","2032","2033","2034","2035"

$_School_Graduation_Years = "2027","2028","2029","2030"

$_School_Graduation_Years = "2023","2024","2025","2026"  

$Student_Or_Staff_Account = Read-Host "Type 1 if this csv contains STAFF names or any other key if these are STUDENT accounts." 

# Loop through csv below

if($Student_Or_Staff_Account -match "1")
{

$Staff_School_Placement = Read-Host "Type the staff's school placement."

if ($Daisy_School_Names -contains $Staff_School_Placement) {
       $OU="OU=,OU=,OU=,OU=,DC=,DC=org"
      }
      
 if ($WMS_School_Names -contains $Staff_School_Placement) {
       $OU="OU=,OU=,OU=,OU=kimport,DC=,DC=org"
      }
      
 if ($WHS_School_Names -contains $Staff_School_Placement) {
       $OU="OU=,OU=,OU=,OU=,DC=westbrookctschools,DC=org"
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
-AccountPassword $Default_Password `
-SamAccountName $Username `
-UserPrincipalName "$Username $Domain" `
-Displayname "$First_Name $Last_Name" `
-ScriptPath "logon.bat" `
-HomeDrive "Y:" `
-HomeDirectory "\\\\$Username" `
-EmailAddress "$$Domain"

Unlock-ADAccount -Identity $

Enable-ADAccount -Identity $
 
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true

}
}

else
{

$Student_Graduation_Year = Read-Host "Type the student's expected graduation year." 

if ($Daisy_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=,OU=,OU=,DC=,DC=org"
      }
      
 if ($Middle_School_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=Middle,OU=,OU=,DC=,DC=org"
      }
      
 if ($High_School_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=,OU=,OU=,DC=,DC=org"
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
-Name "$First_Name $Last_Name" `
-GivenName $First_Name `
-Surname $Last_Name `
-AccountPassword $Default_Password `
-SamAccountName $Username `
-UserPrincipalName "$Username $Domain" `
-Displayname "$First_Name $Last_Name" `
-ScriptPath "logon.bat" `
-HomeDrive "Y:" `
-HomeDirectory "\\w\\$Username" `
-EmailAddress "$Username$Domain"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
 
 Set-AdUser -Identity $Username -EmailAddress "$First_Name_Lower$Period$Last_Name_Lower$Domain"
 
}
}
