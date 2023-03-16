Import-Module ActiveDirectory

# Add student account functionality

$Domain="@domain"

$OU="OU=parent_OU,DC=state_schools,DC=org"

$Logged_In_User = whoami /upn

$Logged_In_Username = $Logged_In_User.Replace('@domain', '')

$NewUsersList=Import-CSV "C:\Users\$Logged_In_Username\Desktop\faculty-import-facultee.csv"

$User_Count = $NewUsersList | Measure-Object | Select-Object -expand count

$Enrollment_Date =  Get-Date -Format "MMddyy"

$ = ""

$Password = "$$Enrollment_Date"

$Default_Password = $Password | ConvertTo-SecureString -AsPlainText -Force

$Domain = "@domain"

$Period = "."

$elementary_School_Names = "DIS","elementary","elementary name_of_school School","name_of_school" # Any of these school names will satisfy the school placement logic.

$Middle-School_School_Names = "Middle-School","MS"," Middle School","Middle School","Middle" # Any of these school names will satisfy the school placement logic.

$High-School_School_Names = "High-School","HS"," High School","High School" # Any of these school names will satisfy the school placement logic.


$elementary_Graduation_Years = "2031","2032","2033","2034","2035"

$Middle_School_Graduation_Years = "2027","2028","2029","2030"

$High_School_Graduation_Years = "2023","2024","2025","2026"  

$Student_Or_Staff_Account = Read-Host "Type 1 if the csv contains STAFF or any other key if they're STUDENTS." 

# Loop through csv below

if($Student_Or_Staff_Account -match "1")
{

$Staff_School_Placement = Read-Host "Type the staff's school placement."

if ($elementary_School_Names -contains $Staff_School_Placement) {
       $OU="OU=Dname_of_school,OU=Beginners,OU=Facultad,OU=parent_OU,DC=state_schools,DC=org"
      }
      
 if ($Middle-School_School_Names -contains $Staff_School_Placement) {
       $OU="OU=Middleham,OU=Beginners,OU=Facultad,OU=parent_OU,DC=state_schools,DC=org"
      }
      
 if ($High-School_School_Names -contains $Staff_School_Placement) {
       $OU="OU=Highham,OU=Beginners,OU=Facultad,OU=parent_OU,DC=state_schools,DC=org"
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
-ScriptPath "logon" `
-HomeDrive "Y:" `
-HomeDirectory "\\wps-server01\users\$Username" `
-EmailAddress "$Username$Domain"

Unlock-ADAccount -Identity $Username

Enable-ADAccount -Identity $Username
 
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true

Write-Host "Adding $Username, please wait..."

}
}

else
{

$Student_Graduation_Year = Read-Host "Type the student's expected graduation year." 

if ($elementary_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=Elementary,OU=Estudiantes,OU=parent_OU,DC=state_schools,DC=org"
      }
      
 if ($Middle_School_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=Middle,OU=Estudiantes,OU=parent_OU,DC=state_schools,DC=org"
      }
      
 if ($High_School_Graduation_Years -contains $Student_Graduation_Year) {
       $OU="OU=$Student_Graduation_Year,OU=High,OU=Estudiantes,OU=parent_OU,DC=state_schools,DC=org"
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
-ScriptPath "logon" `
-HomeDrive "Y:" `
-HomeDirectory "\\wps-server01\users\$Username" `
-EmailAddress "$Username$Domain"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
 
 Set-AdUser -Identity $Username -EmailAddress "$First_Name_Lower$Period$Last_Name_Lower$Domain"
 
 Write-Host "Adding $Username, please wait..."
 
} 
}
 
if ($Staff_School_Placement) {

Write-Host "Successfully added $User_Count staff members to the OU for $Staff_School_Placement!" 

}

if ($Student_Graduation_Year) {

Write-Host "Successfully added $User_Count students to the OU for the Class of $Student_Graduation_Year!"

}
