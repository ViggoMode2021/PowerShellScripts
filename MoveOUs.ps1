$Current_Year = Get-Date -Format "yyyy"

$OU_Move_Date = [DateTime]"07/01/$Current_Year"

$Today_Full_Date = Get-Date -Format "MM/dd/yyyy"

$OU = 'OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org'

$Elementary_School_OUs = Get-ADOrganizationalUnit -SearchBase $OU -SearchScope Subtree -Filter * | 
     Select-Object Name 

if($Today_Full_Date -lt $OU_Move_Date){

Write-Host "It is too early to move the Organizational Units for the new school year."

foreach ($Unit in $Elementary_School_OUs){

$Unit.Name.Substring($Unit.Name.Length - 8)

}


} 

else{



}
