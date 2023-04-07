$Current_Year = Get-Date -Format "yyyy"

$New_Elementary_School_Graduation_Year = [int]$Current_Year + 12

$OU_Move_Date = [DateTime]"07/01/$Current_Year"

$Today_Full_Date = Get-Date -Format "MM/dd/yyyy"

$Elementary_School_Top_OU = 'OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org'

$Middle_School_Top_OU = 'OU=MiddleSchool,OU=StudentAccounts,DC=vigschools,DC=org'

$High_School_Top_OU = 'OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org'

$Elementary_School_OUs = Get-ADOrganizationalUnit -SearchBase $Elementary_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name

$Middle_School_OUs = Get-ADOrganizationalUnit -SearchBase $Middle_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name 

$High_School_OUs = Get-ADOrganizationalUnit -SearchBase $High_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name 

if($OU_Move_Date -lt $Today_Full_Date){ # << Swap position of these two variables in when executing script in prod 

Write-Host "It is too early to move the Organizational Units for the new school year."

}

else{

Try {
  New-ADOrganizationalUnit -Name "ClassOf$New_Elementary_School_Graduation_Year" -Path "OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org" -ProtectedFromAccidentalDeletion $False 
}
Catch {
  Write-Host "A ClassOf$New_Elementary_School_Graduation_Year OU already exists."
}

$Graduating_Elementary_OU = $Elementary_School_OUs | select -first 1

$Graduating_Middle_OU = $Middle_School_OUs | select -first 1

$Graduating_High_OU = $High_School_OUs | select -first 1


Try {
  New-ADOrganizationalUnit -Name "Graduated_Classes" -Path "OU=StudentAccounts,DC=vigschools,DC=org" -ProtectedFromAccidentalDeletion $False 
}
Catch {
  Write-Host "A Graduated_Classes OU already exists."
}

}
