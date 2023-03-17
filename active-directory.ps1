Import-Module ActiveDirectory

## Variables listed below. Some logic to check to make sure names contain proper characters.

$Enrollment_Date =  Get-Date -Format "MMddyy"

$Enrollment_Date_Slashes =  Get-Date -Format "MM/dd/yyyy"

$ = ""

$Password = "$$Enrollment_Date"

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

# I plan to add logic to swap out the graduation years depending on what school year the script is run in.

$_Graduation_Years = "2031","2032","2033","2034","2035"

$Middle_School_Graduation_Years = "2027","2028","2029","2030"

$High_School_Graduation_Years = "2023","2024","2025","2026"  

$Student_Or_Staff_Account = Read-Host "Type 1 if this is a student account or any other key if this is a staff account." 

## Code to create a student account below ##

if($Student_Or_Staff_Account -match "1")
{
 $Username = "$First_Name_Lower$Period$Last_Name_Lower"
 New-ADUser `
 -Name "$First_Name $Last_Name" `
 -GivenName $First_Name `
 -Surname $Last_Name `
 -SamAccountName "$First_Name_Lower$Period$Last_Name_Lower" `
 -UserPrincipalName "$Username $Domain" `
 -Displayname "$First_Name $Last_Name" `
 -Description $Description `
 -Path "OU=kimport,DC=,DC=org" `
 -AccountPassword $Default_Password `
 -ScriptPath "logon" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\\users\$Username" `
 -EmailAddress "$Username$Domain"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $false
     
 Set-AdUser -Identity $Username -EmailAddress "$First_Name_Lower$Period$Last_Name_Lower$Domain"
     
 $Student_Graduation_Year = Read-Host "Type the student's expected graduation year." 
   
 $Class = "Class"
   
 $Student_Graduation_Year_OU = "$Student_Graduation_Year$Class"
   
 if ($_Graduation_Years -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$Student_Graduation_Year_OU,OU=,OU=,OU=,DC=,DC=org"
       Set-ADUser -Identity $Username -HomeDirectory "\\\\$Student_Graduation_Year_OU\$Username"
       Write-Host "DIS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain YOG: $Student_Graduation_Year" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($Middle_School_Graduation_Years -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$Student_Graduation_Year_OU,OU=MS,OU=,OU=,DC=,DC=org"
       Set-ADUser -Identity $Username -HomeDirectory "\\\\$Student_Graduation_Year_OU\$Username"
       Write-Host "MS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain YOG: $Student_Graduation_Year" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($High_School_Graduation_Years -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$Student_Graduation_Year_OU,OU=HS,OU=,OU=,DC=,DC=org"
       Set-ADUser -Identity $Username -HomeDirectory "\\\\$Student_Graduation_Year_OU\$Username"
       Write-Host "HS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain YOG: $Student_Graduation_Year" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }

       
 else
   
  {
  Write-Host "Graduation year '$Student_Graduation_Year' not found. Student placed in the kimport ou." -ForegroundColor DarkGreen -BackgroundColor White
  }
   
}

## Code to create a staff account below ##

else
{

 New-ADUser `
 -Name "$Last_Name $Comma $First_Name" `
 -GivenName $First_Name `
 -Surname $Last_Name `
 -SamAccountName $Username `
 -UserPrincipalName "$Username $Domain" `
 -Displayname "$First_Name $Last_Name" `
 -Description $Description `
 -Path "OU=kimport,DC=,DC=org" `
 -AccountPassword $Default_Password `
 -ScriptPath "logon" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\\users\$Username" `
 -EmailAddress "$Username$Domain"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
 
 $_School_Names = "DIS","dis","","  School","" # Any of these school names will satisfy the school placement logic.

 $MS_School_Names = "MS","MS","MS"," Middle School","Middle School","Middle" # Any of these school names will satisfy the school placement logic.

 $HS_School_Names = "HS","HS","HS"," High School","High School" # Any of these school names will satisfy the school placement logic.
 
 $Staff_School_Placement = Read-Host "Type the staff's school placement."
 
 if ($_School_Names -contains $Staff_School_Placement) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=DIS,OU=GoogleStaffAccounts,DC=,DC=org" 
       Write-Host "DIS staff account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($MS_School_Names -contains $Staff_School_Placement) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=MS,OU=GoogleStaffAccounts,DC=,DC=org"
       Write-Host "MS staff account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($HS_School_Names -contains $Staff_School_Placement) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=HS,OU=GoogleStaffAccounts,DC=,DC=org"
       Write-Host "HS staff account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain"  -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
       
else
   
 {
 Write-Host "School '$Staff_School_Placement' not found. Staff member placed in the kimport ou." -ForegroundColor DarkRed -BackgroundColor White
 }
   
}
