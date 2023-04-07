$Current_Year = Get-Date -Format "yyyy"

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

$Graduating_Elementary_OU = $Elementary_School_OUs | select -first 1

$Graduating_Middle_OU = $Middle_School_OUs | select -first 1

$Graduating_High_OU = $High_School_OUs | select -first 1

}
