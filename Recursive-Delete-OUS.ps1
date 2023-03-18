Get-ADOrganizationalUnit -Identity 'OU=,DC=,DC=COM' |
    Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru |
    Remove-ADOrganizationalUnit -Recursive -Confirm:$false
