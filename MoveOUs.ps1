$Current_Year = Get-Date -Format "yyyy"

$OU_Move_Date = [DateTime]"07/01/$Current_Year"

$Today_Full_Date = Get-Date -Format "MM/dd/yyyy"

if($Today_Full_Date -lt $OU_Move_Date){

Write-Host "It is too early to move the Organizational Units for the new school year."
} 

else{



}
