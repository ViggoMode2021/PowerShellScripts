Get-ADOrganizationalUnit -Identity 'OU=FacultyAccounts,DC=vigschools,DC=ORG' |
    Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru |
    Remove-ADOrganizationalUnit -Recursive -Confirm:$false

Get-ADOrganizationalUnit -Identity 'OU=StudentAccounts,DC=vigschools,DC=ORG' |
    Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru |
    Remove-ADOrganizationalUnit -Recursive -Confirm:$false

Remove-Item C:\Users\Administrator\Desktop\CSV-Data 
