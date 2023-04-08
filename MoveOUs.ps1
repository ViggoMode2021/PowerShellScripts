# README at bottom of script

$Current_Year = Get-Date -Format "yyyy"

$New_Elementary_School_Graduation_Year = [int]$Current_Year + 12

$OU_Move_Date = [DateTime]"07/01/$Current_Year"

$Today_Full_Date = Get-Date -Format "MM/dd/yyyy"

$Elementary_School_Top_OU = 'OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org'

$Middle_School_Top_OU = 'OU=MiddleSchool,OU=StudentAccounts,DC=vigschools,DC=org'

$High_School_Top_OU = 'OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org'

$Elementary_School_OUs = Get-ADOrganizationalUnit -SearchBase $Elementary_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name -ExpandProperty Name

$Middle_School_OUs = Get-ADOrganizationalUnit -SearchBase $Middle_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name -ExpandProperty Name

$High_School_OUs = Get-ADOrganizationalUnit -SearchBase $High_School_Top_OU -SearchScope Subtree -Filter "name -like '*Class*'" | 
     Select-Object Name -ExpandProperty Name

if($OU_Move_Date -lt $Today_Full_Date){ # << Swap position of these two variables in when executing script in prod 

Write-Host "It is too early to move the Organizational Units for the new school year."

}

else{

$Graduating_Elementary_OU = $Elementary_School_OUs | select -first 1

Get-ADOrganizationalUnit -Identity "OU=$Graduating_Elementary_OU,OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org" | Set-ADObject -ProtectedFromAccidentalDeletion $false

Write-Host "Moving $Graduating_Elementary_OU from ElementarySchool to MiddleSchool OU."

$Graduating_Elementary_OU_Name = Get-ADOrganizationalUnit -Identity "OU=$Graduating_Elementary_OU,OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org"

Move-ADObject $Graduating_Elementary_OU_Name -TargetPath "OU=MiddleSchool,OU=StudentAccounts,DC=vigschools,DC=org"

$Graduating_Middle_OU = $Middle_School_OUs | select -first 1

Get-ADOrganizationalUnit -Identity "OU=$Graduating_Middle_OU,OU=MiddleSchool,OU=StudentAccounts,DC=vigschools,DC=org" | Set-ADObject -ProtectedFromAccidentalDeletion $false

Write-Host "Moving $Graduating_Middle_OU from MiddleSchool to HighSchool OU."

$Graduating_Middle_OU = Get-ADOrganizationalUnit -Identity "OU=$Graduating_Middle_OU,OU=MiddleSchool,OU=StudentAccounts,DC=vigschools,DC=org"

Move-ADObject $Graduating_Middle_OU -TargetPath "OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org"

$Graduating_High_OU = $High_School_OUs | select -first 1

Get-ADOrganizationalUnit -Identity "OU=$Graduating_High_OU,OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org" | Set-ADObject -ProtectedFromAccidentalDeletion $false

$Graduating_High_OU_Name = Get-ADOrganizationalUnit -Identity "OU=$Graduating_High_OU,OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org"

# Remove -ProtectedFromAccidentalDeletion $False in New OU below when running script in prod. 

Try {
  New-ADOrganizationalUnit -Name "Graduated_Classes" -Path "OU=StudentAccounts,DC=vigschools,DC=org" -ProtectedFromAccidentalDeletion $False 
  Write-Host "Creating a new top-level OU titled Graduated_Classes in the StudentAccounts top-level OU."
  Write-Host "Moving $Graduating_High_OU to HighSchool OU."
  $Graduating_High_OU = Get-ADOrganizationalUnit -Identity "OU=$Graduating_High_OU,OU=HighSchool,OU=StudentAccounts,DC=vigschools,DC=org"
  Move-ADObject $Graduating_High_OU_Name -TargetPath "OU=Graduated_Classes,OU=StudentAccounts,DC=vigschools,DC=org"
  Get-ADOrganizationalUnit -filter * -Properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $false} | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $true
}
Catch {
  Write-Host "A Graduated_Classes top-level OU already exists in the StudentAccounts top-level OU."
  Write-Host "Moving $Graduating_High_OU to Graduated_Classes OU."
  $Graduating_High_OU = Get-ADOrganizationalUnit -Filter 'Name -like "*$Graduating_High_OU*"'
  Move-ADObject $Graduating_High_OU_Name -TargetPath "OU=Graduated_Classes,OU=StudentAccounts,DC=vigschools,DC=org"
  Get-ADOrganizationalUnit -filter * -Properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $false} | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $true
}

# Remove -ProtectedFromAccidentalDeletion $False in New OU below when running script in prod. 

Try {
  New-ADOrganizationalUnit -Name "ClassOf$New_Elementary_School_Graduation_Year" -Path "OU=ElementarySchool,OU=StudentAccounts,DC=vigschools,DC=org" -ProtectedFromAccidentalDeletion $False 
  Write-Host "Creating a new OU titled ClassOf$New_Elementary_School_Graduation_Year in the ElementarySchool OU."
}
Catch {
  Write-Host "A ClassOf$New_Elementary_School_Graduation_Year OU already exists in the ElementarySchool OU."
}

}

<#

#ReadME

This script checks the date that it is run to see if today’s date is before or after 7/1 (July 1st) of a given year. 

If the date is after July 1st of any given year, it will shift the Organizational Unit (Ou) that contains Elementary 4th graders to the Middle School, 
Middle 8th graders to the High School, and moves the Senior class to an OU called Graduated_Classes. It also adds the current year + 11 and creates a new OU 
for the incoming elementary students. If the incoming elementary OU and the Graduated_Classes OU aren’t made, then it will create them.

It’s not 100% done but it works. I want to re-enable the PreventAgainstAccidentalDeletion for the OUs, attach a pre-existing GPO to the new Elementary OU, 
and add some bells and whistles (text colors and who knows what else). Plus I want to write a read me and add more logic to make it more optimized.

Plus you can run it in Task Scheduler. I will say though that cron jobs in Linux are more satisfying and efficient.

Yes you can click and drag in the GUI but where is the satisfaction in that?

#>
