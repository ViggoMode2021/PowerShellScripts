Import-Module ActiveDirectory

$Enrollment_Date =  Get-Date -Format "MMddyy"

$Enrollment_Date_Slashes =  Get-Date -Format "MM/dd/yyyy"

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

$Daisy_Graduation_Years = "2031","2032","2033","2034","2035"

$Middle_School_Graduation_Years = "2027","2028","2029","2030"

$High_School_Graduation_Years = "2023","2024","2025","2026"  

$Student_Or_Staff_Account = Read-Host "Type 1 if this is a student account or any other key if this is a staff account." 

if($Student_Or_Staff_Account -match "1")
{
 New-ADUser `
 -Name "$First_Name $Last_Name" `
 -GivenName $First_Name `
 -Surname $Last_Name `
 -SamAccountName $Username `
 -UserPrincipalName "$Username $Domain" `
 -Displayname "$First_Name $Last_Name" `
 -Description $Description `
 -Path "OU=,DC=,DC=org" `
 -AccountPassword $Default_Password `
 -ScriptPath ".bat" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\w\\$" `
 -EmailAddress "$$"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $false
     
 Set-AdUser -Identity $Username -EmailAddress "$First_Name_Lower$Period$Last_Name_Lower$Domain"
     
 $Student_Graduation_Year = Read-Host "Type the student's expected graduation year." 
   
 $Class = "Class"
   
 $Student_Graduation_Year_OU = "$Student_Graduation_Year$Class"
   
 if ($ -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$,OU=,OU=Students,OU=UserAccounts,DC=westbrookctschools,DC=org" 
       Write-Host "DIS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($ -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$Student_Graduation_Year_OU,OU=,OU=,OU=UserAccounts,DC=westbrookctschools,DC=org"
       Write-Host "WMS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($ -contains $Student_Graduation_Year) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=$Student_Graduation_Year_OU,OU=WHS,OU=Students,OU=UserAccounts,DC=westbrookctschools,DC=org"
       Write-Host "WHS student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
       
 else
   
  {
  Write-Host "Graduation year $Student_Graduation_Year not found." -ForegroundColor DarkGreen -BackgroundColor White
  }
   
}

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
 -Path "OU=,DC=,DC=org" `
 -AccountPassword $Default_Password `
 -ScriptPath ".bat" `
 -HomeDrive "Y:" `
 -HomeDirectory "\\wps-\\$" `
 -EmailAddress "$$"

 Unlock-ADAccount -Identity $Username

 Enable-ADAccount -Identity $Username
 
 Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
 
 $_School_Names = "","","  School",""

 $_School_Names = "","MS"," Middle School","Middle School","Middle"

 $_School_Names = "WHS","HS","Westbrook High School","High School"
 
 $Staff_School_Placement = Read-Host "Type the staff's school placement."
 
 if ($Daisy_School_Names -contains $Staff_School_Placement) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU,OU,DC=,DC=org" 
       Write-Host " staff account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($Staff_School_Placement -contains $WMS_School_Names) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=WMS,OU=,DC=,DC=org"
       Write-Host " staff account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
 if ($Staff_School_Placement -contains $WHS_School_Names) {
       Get-ADUser -Identity $Username | Move-ADObject -TargetPath "OU=WHS,OU=,DC=,DC=org"
       Write-Host " student account setup complete for $First_Name $Last_Name on $Enrollment_Date_Slashes!" -ForegroundColor DarkGreen -BackgroundColor White | out-host
       Write-Host "Account name: $Username, Email: $First_Name_Lower$Period$Last_Name_Lower$Domain" -ForegroundColor DarkGreen -BackgroundColor White | out-host
      }
       
 else
   
  {
  Write-Host "School not found." -ForegroundColor DarkGreen -BackgroundColor White
  }
   
}
