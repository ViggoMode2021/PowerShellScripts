Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms

$Current_Date = Get-Date -Format "MM/dd/$Current_Year"

$Current_Year = Get-Date -Format "yyyy"

$December_31st = [DateTime]"12/31/$Current_Year"


if($Current_Date -lt $December_31st){

$Kindergarten_Graduation_Year = [int]$Current_Year + 12

$First_Grade_Graduation_Year = [int]$Current_Year + 11

$Second_Grade_Graduation_Year = [int]$Current_Year + 10

$Third_Grade_Graduation_Year = [int]$Current_Year + 9

$Fourth_Grade_Graduation_Year = [int]$Current_Year + 8


$Fifth_Grade_Graduation_Year = [int]$Current_Year + 7

$Sixth_Grade_Graduation_Year = [int]$Current_Year + 6

$Seventh_Grade_Graduation_Year = [int]$Current_Year + 5

$Eighth_Grade_Graduation_Year = [int]$Current_Year + 4


$Ninth_Grade_Graduation_Year = [int]$Current_Year + 3

$Tenth_Grade_Graduation_Year = [int]$Current_Year + 2

$Eleventh_Grade_Graduation_Year = [int]$Current_Year + 1

$Twelfth_Grade_Graduation_Year = [int]$Current_Year + 0
}

else{

$Kindergarten_Graduation_Year = [int]$Current_Year + 13

$First_Grade_Graduation_Year = [int]$Current_Year + 1

$Second_Grade_Graduation_Year = [int]$Current_Year + 10

$Third_Grade_Graduation_Year = [int]$Current_Year + 9

$Fourth_Grade_Graduation_Year = [int]$Current_Year + 8


$Fifth_Grade_Graduation_Year = [int]$Current_Year + 7

$Sixth_Grade_Graduation_Year = [int]$Current_Year + 6

$Seventh_Grade_Graduation_Year = [int]$Current_Year + 5

$Eighth_Grade_Graduation_Year = [int]$Current_Year + 4


$Ninth_Grade_Graduation_Year = [int]$Current_Year + 3

$Tenth_Grade_Graduation_Year = [int]$Current_Year + 2

$Eleventh_Grade_Graduation_Year = [int]$Current_Year + 1

$Twelfth_Grade_Graduation_Year = [int]$Current_Year + 0

}

$All_Students_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Select Name

$First_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$First_Grade_Graduation_Year*" | Select Name

$First_Grade_NotLoggedIn_Accounts_Count = $First_Grade_NotLoggedIn_Accounts | Measure-Object

$First_Grade_NotLoggedIn_Accounts_Count = $First_Grade_NotLoggedIn_Accounts_Count.Count

$Second_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Second_Grade_Graduation_Year*" | Select Name

$Second_Grade_NotLoggedIn_Accounts_Count = $Second_Grade_NotLoggedIn_Accounts | Measure-Object

$Second_Grade_NotLoggedIn_Accounts_Count = $Second_Grade_NotLoggedIn_Accounts_Count.Count

$Third_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Third_Grade_Graduation_Year*" | Select Name

$Third_Grade_NotLoggedIn_Accounts_Count = $Third_Grade_NotLoggedIn_Accounts | Measure-Object

$Third_Grade_NotLoggedIn_Accounts_Count = $Third_Grade_NotLoggedIn_Accounts_Count.Count

$Fourth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Fourth_Grade_Graduation_Year*" | Select Name

$Fourth_Grade_NotLoggedIn_Accounts_Count = $Fourth_Grade_NotLoggedIn_Accounts | Measure-Object

$Fourth_Grade_NotLoggedIn_Accounts_Count = $Fourth_Grade_NotLoggedIn_Accounts_Count.Count

$Fifth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Fifth_Grade_Graduation_Year*" | Select Name

$Fifth_Grade_NotLoggedIn_Accounts_Count = $Fifth_Grade_NotLoggedIn_Accounts | Measure-Object

$Fifth_Grade_NotLoggedIn_Accounts_Count = $Fifth_Grade_NotLoggedIn_Accounts_Count.Count

$Sixth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Sixth_Grade_Graduation_Year*" | Select Name

$Sixth_Grade_NotLoggedIn_Accounts_Count = $Sixth_Grade_NotLoggedIn_Accounts | Measure-Object

$Sixth_Grade_NotLoggedIn_Accounts_Count = $Sixth_Grade_NotLoggedIn_Accounts_Count.Count

$Seventh_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Seventh_Grade_Graduation_Year*" | Select Name

$Seventh_Grade_NotLoggedIn_Accounts_Count = $Seventh_Grade_NotLoggedIn_Accounts | Measure-Object

$Seventh_Grade_NotLoggedIn_Accounts_Count = $Seventh_Grade_NotLoggedIn_Accounts_Count.Count

$Eighth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Eighth_Grade_Graduation_Year*" | Select Name

$Eighth_Grade_NotLoggedIn_Accounts_Count = $Eighth_Grade_NotLoggedIn_Accounts | Measure-Object

$Eighth_Grade_NotLoggedIn_Accounts_Count = $Eighth_Grade_NotLoggedIn_Accounts_Count.Count

$Ninth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Ninth_Grade_Graduation_Year*" | Select Name

$Ninth_Grade_NotLoggedIn_Accounts_Count = $Ninth_Grade_NotLoggedIn_Accounts | Measure-Object

$Ninth_Grade_NotLoggedIn_Accounts_Count = $Ninth_Grade_NotLoggedIn_Accounts_Count.Count

$Tenth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Tenth_Grade_Graduation_Year*" | Select Name

$Tenth_Grade_NotLoggedIn_Accounts_Count = $Tenth_Grade_NotLoggedIn_Accounts | Measure-Object

$Tenth_Grade_NotLoggedIn_Accounts_Count = $Tenth_Grade_NotLoggedIn_Accounts_Count.Count

$Eleventh_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Eleventh_Grade_Graduation_Year*" | Select Name

$Eleventh_Grade_NotLoggedIn_Accounts_Count = $Eleventh_Grade_NotLoggedIn_Accounts | Measure-Object

$Eleventh_Grade_NotLoggedIn_Accounts_Count = $Eleventh_Grade_NotLoggedIn_Accounts_Count.Count

$Twelfth_Grade_NotLoggedIn_Accounts = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$Twelfth_Grade_Graduation_Year*" | Select Name


$Twelfth_Grade_NotLoggedIn_Accounts_Count = $Twelfth_Grade_NotLoggedIn_Accounts | Measure-Object

$Twelfth_Grade_NotLoggedIn_Accounts_Count = $Twelfth_Grade_NotLoggedIn_Accounts_Count.Count


$Form_Object = [System.Windows.Forms.Form]
$Label_Object = [System.Windows.Forms.Label]
$Button_Object = [System.Windows.Forms.Button]

$Application_Form = New-Object $Form_Object

$Application_Form.ClientSize= '500,300'

$Application_Form.Text = 'Disable Users'

$Application_Form.BackColor= "#ffffff"

$Label_Title = New-Object $Label_Object

$Label_Title.Text= "Disable Users"

$Label_Title.AutoSize = $true

$Label_Title.Font = 'Verdana,24,style=Bold'

$Label_Title.Location = New-Object System.Drawing.Point(120,20)

$Button_All_Inactive_Users = New-Object $Button_Object

$Button_All_Inactive_Users.Text = 'View all inactive users'

$Button_All_Inactive_Users.AutoSize=$true

$Button_All_Inactive_Users.Location = New-Object System.Drawing.Point(185,180)

$Button_All_Inactive_Users.Font='Verdana, 12'

$Application_Form.Controls.AddRange(@($Label_Title,$Button_All_Inactive_Users))

$Application_Form.Controls.AddRange(@($Label_Title))


function View_All_Inactive_Users{

    if($Label_Title.Text -eq $Eighth_Grade_NotLoggedIn_Accounts){
       $Label_Title.Text='View all inactive users'}

    else{
        $Label_Title.Text = $Eighth_Grade_NotLoggedIn_Accounts | Out-String}
}

$Button_All_Inactive_Users.Add_Click({View_All_Inactive_Users})

$Application_Form.ShowDialog()

#$Application_Form.Dispose()
