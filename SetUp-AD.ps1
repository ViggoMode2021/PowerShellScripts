Import-Module ActiveDirectory 3>$null -WarningAction SilentlyContinue

#Add-WindowsFeature AD-Domain-Services

#Install-ADDSForest -DomainName vdom.local -InstallDNS

$DC = "mikefrobbins"

$Domain = "@mikefrobbins.com"

$StudentAccounts = "StudentAccounts"

$HighSchool = "HighSchool"

$MiddleSchool = "MiddleSchool"

$ElementarySchool = "ElementarySchool"

$FacultyAccounts = "FacultyAccounts"

$OrganizationalUnits = @("StudentAccounts", "HighSchoolStudents", "Class of 2023", "Class of 2024", "Class of 2025", "Class of 2026", "Class of 2027", 
"MiddleSchoolStudents", "Class of 2027", "Class of 2028", "Class of 2029", "Class of 2030", "ElementarySchoolStudents", "Class of 2031", "Class of 2032", "Class of 2033", "Class of 2034",
"FacultyAccounts", "HighSchoolFaculty", "MiddleSchoolFaculty", "ElementarySchoolFaculty")

function CheckOU{
    foreach ($OU in $OrganizationalUnits){
        if (Get-ADOrganizationalUnit -Filter 'Name -like $OU' | Format-Table Name, DistinguishedName -A) {
            Write-Host "$OU already exists."
}
else {

Write-Host "Creating OU named $OU"
}
    
}
}

CheckOU

# Add student OUs below:

New-ADOrganizationalUnit -Name "StudentAccounts" -Path "DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "HighSchool" -Path "OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2023" -Path "OU=$HighSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2024" -Path "OU=$HighSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2025" -Path "OU=$HighSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2026" -Path "OU=$HighSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "MiddleSchool" -Path "OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2027" -Path "OU=$MiddleSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2028" -Path "OU=$MiddleSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2029" -Path "OU=$MiddleSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2030" -Path "OU=$MiddleSchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "ElementarySchool" -Path "OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2031" -Path "OU=$ElementarySchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2032" -Path "OU=$ElementarySchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2033" -Path "OU=$ElementarySchool,OU=$StudentAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "Class of 2034" -Path "OU=$ElementarySchool,OU=$StudentAccounts,DC=$DC,DC=COM"

#Add faculty OUs below:

New-ADOrganizationalUnit -Name "FacultyAccounts" -Path "DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "HighSchoolFaculty" -Path "OU=$FacultyAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "MiddleSchoolFaculty" -Path "OU=$FacultyAccounts,DC=$DC,DC=COM"

New-ADOrganizationalUnit -Name "ElementarySchoolFaculty" -Path "OU=$FacultyAccounts,DC=$DC,DC=COM"

# Logic to add CSV-Users to CSV

New-Item -Path 'C:\Users\Administrator\Desktop\CSV-Data' -ItemType Directory

Invoke-WebRequest "https://raw.githubusercontent.com/ViggoMode2021/PowerShellScripts/main/teacher-names.csv" -OutFile C:\Users\Administrator\Desktop\CSV-Data\HighSchoolTeachers.csv

$HighSchoolFacultyCSV=Import-CSV "C:\Users\Administrator\Desktop\CSV-Data\HighSchoolTeachers.csv"

$High_School_Faculty_Count = $HighSchoolFacultyCSV | Measure-Object | Select-Object -expand count

ForEach ($User in $HighSchoolFacultyCSV) {

$First_Name=$User.first_name

$Last_Name=$User.last_name

$First_Initial = $First_Name.Substring(0,1).ToLower()

$First_Name_Lower = $First_Name.ToLower()
$Last_Name_Lower = $Last_Name.ToLower()
$Username = "$First_Initial$Last_Name_Lower"

$Enrollment_Date =  Get-Date -Format "MMddyy"

$mikefrobbins = "Mikefrobbins"

$Password = "$mikefrobbins$Enrollment_Date"

$Default_Password = $Password | ConvertTo-SecureString -AsPlainText -Force

New-ADUser `
-Path "OU=HighSchoolFaculty,OU=$FacultyAccounts,DC=$DC,DC=COM" `
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
-HomeDirectory "\\mfr-server01\users\$Username" `
-EmailAddress "$Username$Domain"

Unlock-ADAccount -Identity $Username

Enable-ADAccount -Identity $Username
 
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true

Write-Host "Adding $Username, please wait..."

Write-Host "Added $High_School_Faculty_Count to HighSchoolFaculty OU!"

}
