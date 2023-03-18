Import-Module ActiveDirectory

#Add-WindowsFeature AD-Domain-Services

#Install-ADDSForest -DomainName vdom.local -InstallDNS

$DC = "vigschools"

$StudentAccounts = "StudentAccounts"

$HighSchool = "HighSchool"

$MiddleSchool = "MiddleSchool"

$ElementarySchool = "ElementarySchool"

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

$OrganizationalUnits = @("StudentAccounts", "HighSchool", "Class of 2023", "Class of 2024", "Class of 2025", "Class of 2026", "Class of 2027", 
"MiddleSchool", "Class of 2027", "Class of 2028", "Class of 2029", "Class of 2030", "ElementarySchool", "Class of 2031", "Class of 2032", "Class of 2033", "Class of 2034")

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
