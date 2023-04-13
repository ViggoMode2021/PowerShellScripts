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

# GUI form code below:

$Form_Object = [System.Windows.Forms.Form]
$Label_Object = [System.Windows.Forms.Label]
$Button_Object = [System.Windows.Forms.Button]
$Combo_Box_Object = [System.Windows.Forms.ComboBox]

# Base form code:

$Application_Form = New-Object $Form_Object

$Application_Form.ClientSize= '500,300'

$Application_Form.Text = 'Disable Users'

$Application_Form.BackColor= "#ffffff"

# Building the form:

$Label_Title = New-Object $Label_Object

$Label_Title.Text= "Select an OU from the dropdown to see inactive users who have never logged in."

$Label_Title.AutoSize = $true

$Label_Title.Font = 'Verdana,12,style=Bold'

$Label_Title.Location = New-Object System.Drawing.Point(120,20)

$Label_Title_2 = New-Object $Label_Object

$Label_Title_2.Text= ""

$Label_Title_2.AutoSize = $true

$Label_Title_2.Font = 'Verdana,12,style=Bold'

$Label_Title_2.Location = New-Object System.Drawing.Point(340,30)

$Disable_Users_Dropdown = New-Object $Combo_Box_Object

$Disable_Users_Dropdown.Width='300'

$Disable_Users_Dropdown.Text="Select an OU"

$Button_Object = [System.Windows.Forms.Button]

$Disable_Users_Button = New-Object $Button_Object

$Disable_Users_Button.Text= "Disable these users."

$Disable_Users_Button.AutoSize = $true

$Disable_Users_Button.Font = 'Verdana,12,style=Bold'

$Disable_Users_Button.Location = New-Object System.Drawing.Point(320,190)

$Enable_Users_Button = New-Object $Button_Object

$Enable_Users_Button.Text= "Enable these users."

$Enable_Users_Button.AutoSize = $true

$Enable_Users_Button.Font = 'Verdana,12,style=Bold'

$Enable_Users_Button.Location = New-Object System.Drawing.Point(320,120)

$Application_Form.Controls.AddRange(@($Label_Title,$Disable_Users_Dropdown,$Label_Title_2, $Disable_Users_Button, $Enable_Users_Button))

Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Where-Object DistinguishedName -notlike "*Domain Controllers*" |Sort-Object CanonicalName | ForEach-Object {$Disable_Users_Dropdown.Items.Add($_.Name)}

function Show_Inactive_Users{

    $OU_Name=$Disable_Users_Dropdown.SelectedItem
    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text
  
    $Inactive_Users = $Inactive_Users | Out-String
    $Label_Title.Text = $Inactive_Users
}

function Disable_Inactive_Users{

    $OU_Name=$Disable_Users_Dropdown.SelectedItem
    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Disable-ADAccount

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text

}

function Enable_Inactive_Users{

    $OU_Name=$Disable_Users_Dropdown.SelectedItem
    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Enable-ADAccount

}

$Disable_Users_Button.Add_Click({Disable_Inactive_Users})

$Enable_Users_Button.Add_Click({Enable_Inactive_Users})

$Disable_Users_Dropdown.Add_SelectedIndexChanged({Show_Inactive_Users})

$Application_Form.ShowDialog()

$Application_Form.Dispose()
