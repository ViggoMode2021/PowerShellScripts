Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms

$Current_Date = Get-Date -Format "MM/dd/$Current_Year"

$Current_Year = Get-Date -Format "yyyy"

$December_31st = [DateTime]"12/31/$Current_Year"

# GUI form code below:

$Form_Object = [System.Windows.Forms.Form]
$Label_Object = [System.Windows.Forms.Label]
$Button_Object = [System.Windows.Forms.Button]
$Combo_Box_Object = [System.Windows.Forms.ComboBox]
$Scrollbar_Object = [System.Windows.Forms.VScrollBar]

# Base form code:

$Application_Form = New-Object $Form_Object

$Application_Form.ClientSize= '500,300'

$Domain = Get-ADDomain -Current LocalComputer | Select Name | foreach { $_.Name } |  Out-String

$Application_Form.Text = 'Disable and Enable unused accounts'

$Application_Form.BackColor= "#ffffff"

# Building the form:

    # Label/Text box #1:

$Label_Title = New-Object $Label_Object

$Label_Title.Text= "Select a $Domain OU from the dropdown to see inactive users who have never logged in."

$Label_Title.AutoSize = $true

$Label_Title.Font = 'Verdana,12,style=Bold'

$Label_Title.Location = New-Object System.Drawing.Point(320,20)

    # Label/Text box #2:

$Label_Title_2 = New-Object $Label_Object

$Label_Title_2.Text= ""

$Label_Title_2.AutoSize = $true

$Label_Title_2.Font = 'Verdana,12,style=Bold'

$Label_Title_2.ForeColor = 'Green'

$Label_Title_2.Location = New-Object System.Drawing.Point(340,30)

# Label/Text box #3:

$Label_Title_3 = New-Object $Label_Object

$Label_Title_3.Text= ""

$Label_Title_3.AutoSize = $true

$Label_Title_3.Font = 'Verdana,12,style=Bold'

$Label_Title_3.ForeColor = 'Red'

$Label_Title_3.Location = New-Object System.Drawing.Point(345,60)

# Label/Text box #4:

$Label_Title_4 = New-Object $Label_Object

$Label_Title_4.Text= ""

$Label_Title_4.AutoSize = $true

$Label_Title_4.Font = 'Verdana,12,style=Bold'

$Label_Title_4.Location = New-Object System.Drawing.Point(650,550)

    # Dropdown list:

$Disable_Users_Dropdown = New-Object $Combo_Box_Object

$Disable_Users_Dropdown.Width='300'

$Disable_Users_Dropdown.Text="Select an OU"

$Disable_Users_Dropdown.Font = New-Object System.Drawing.Font("Lucinda Console",12)

    # Dropdown list:

$Disable_Individual_Users_Dropdown = New-Object $Combo_Box_Object

$Disable_Individual_Users_Dropdown.Width='300'

$Disable_Individual_Users_Dropdown.Text="Select a user"

$Disable_Individual_Users_Dropdown.Font = New-Object System.Drawing.Font("Lucinda Console",12)

$Disable_Individual_Users_Dropdown.Location = New-Object System.Drawing.Point(700,200)

    # Input box: 

$Input_Box = New-Object System.Windows.Forms.TextBox

$Input_Box.Location = New-Object System.Drawing.Point (10,40)

$Input_Box.Size = New-Object System.Drawing.Size(275,500)

$Input_Box.Multiline = $false

$Input_Box.AcceptsReturn = $false

$Input_Box.Location = New-Object System.Drawing.Point(360,250)

    #Disable users button:

$Button_Object = [System.Windows.Forms.Button]

$Disable_Users_Button = New-Object $Button_Object

$Disable_Users_Button.Text= "Disable these users."

$Disable_Users_Button.AutoSize = $true

$Disable_Users_Button.Font = 'Verdana,12,style=Bold'

$Disable_Users_Button.Location = New-Object System.Drawing.Point(350,190)

#Disable individual user button:

$Button_Object = [System.Windows.Forms.Button]

$Disable_Individual_User_Button = New-Object $Button_Object

$Disable_Individual_User_Button.Text= "Disable selected user."

$Disable_Individual_User_Button.AutoSize = $true

$Disable_Individual_User_Button.Font = 'Verdana,12,style=Bold'

$Disable_Individual_User_Button.Location = New-Object System.Drawing.Point(700,600)

    # Enable users button:

$Enable_Users_Button = New-Object $Button_Object

$Enable_Users_Button.Text= "Enable these users."

$Enable_Users_Button.AutoSize = $true

$Enable_Users_Button.Font = 'Verdana,12,style=Bold'

$Enable_Users_Button.Location = New-Object System.Drawing.Point(350,120)

    # Scrollbar:

$Application_Form.Controls.AddRange(@($Label_Title,$Disable_Users_Dropdown,$Label_Title_2, $Disable_Users_Button, $Enable_Users_Button, $Label_Title_3, $Label_Title_4, $Disable_Individual_Users_Dropdown, $Disable_Individual_User_Button))

    # Get all OUs for the GUI and add them to the dropdown list:

Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Where-Object DistinguishedName -notlike "*Domain Controllers*" |Sort-Object CanonicalName | ForEach-Object {$Disable_Users_Dropdown.Items.Add($_.Name)}

function Show_Inactive_Users{

    $Label_Title.Location = New-Object System.Drawing.Point(120,20)

    $Label_Title.Font = 'Verdana,10,style=Bold'

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Remove($_.Name)}

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " active/enabled users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text
  
    $Inactive_Users = $Inactive_Users | Out-String
    $Label_Title.Text = $Inactive_Users

    $Total_Users_Not_Logged_In = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In | Measure-Object
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In_Count.Count
    $Total_Users_Not_Logged_In_Count_Text = [string]$Total_Users_Not_Logged_In_Count + " disabled users that haven't logged in."
    $Label_Title_3.Text = $Total_Users_Not_Logged_In_Count_Text

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Add($_.Name)}
}

function Disable_Inactive_Users{

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Remove($_.Name)}

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Disable-ADAccount

    $Disable_Individual_Users_Dropdown.Items.Clear()

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Add($_.Name)}

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " active/enabled users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text
    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name
    $Label_Title.Text = $Inactive_Users

    $Total_Users_Not_Logged_In = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In | Measure-Object
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In_Count.Count
    $Total_Users_Not_Logged_In_Count_Text = [string]$Total_Users_Not_Logged_In_Count + " disabled users that haven't logged in."
    $Label_Title_3.Text = $Total_Users_Not_Logged_In_Count_Text

    #Change
    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Add($_.Name)}
}

function Enable_Inactive_Users{

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Remove($_.Name)}

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Enable-ADAccount

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name

    $Disable_Individual_Users_Dropdown.Items.Clear()

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Add($_.Name)}

    $Label_Title.Text = $Inactive_Users

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text

    $Inactive_Users = $Inactive_Users | Out-String
    $Label_Title.Text = $Inactive_Users

    $Total_Users_Not_Logged_In = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In | Measure-Object
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In_Count.Count
    $Total_Users_Not_Logged_In_Count_Text = [string]$Total_Users_Not_Logged_In_Count + " disabled users that haven't logged in."
    $Label_Title_3.Text = $Total_Users_Not_Logged_In_Count_Text
}

function Disable_Individual_User{

    $User_Name=$Disable_Individual_Users_Dropdown.SelectedItem

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name*" | Disable-ADAccount

    $Label_Title_4.Text= "$User_Name has been disabled."

    $Disable_Individual_Users_Dropdown.Text="Select a user"

    #Get OU of user

    $Disable_Individual_Users_Dropdown.Items.Clear()

    $OU_Name=$Disable_Users_Dropdown.SelectedItem

    Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Disable_Individual_Users_Dropdown.Items.Add($_.Name)}

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name

    $Inactive_Users = $Inactive_Users | Out-String
    $Label_Title.Text = $Inactive_Users

    $Label_Title.Text = $Inactive_Users

    $Inactive_Users = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name

    $Inactive_Users_Count = $Inactive_Users | Measure-Object
    $Inactive_Users_Count = $Inactive_Users_Count.Count
    $Inactive_Users_Count_Text = [string]$Inactive_Users_Count + " active/enabled users that haven't logged in."
    $Label_Title_2.Text = $Inactive_Users_Count_Text

    $Total_Users_Not_Logged_In = Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $false)} | Where-Object DistinguishedName -like "*$OU_Name*" | Select Name
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In | Measure-Object
    $Total_Users_Not_Logged_In_Count = $Total_Users_Not_Logged_In_Count.Count
    $Total_Users_Not_Logged_In_Count_Text = [string]$Total_Users_Not_Logged_In_Count + " disabled users that haven't logged in."
    $Label_Title_3.Text = $Total_Users_Not_Logged_In_Count_Text
}

    # Add functions to GUI:

$Disable_Users_Button.Add_Click({Disable_Inactive_Users})

$Enable_Users_Button.Add_Click({Enable_Inactive_Users})

$Disable_Individual_User_Button.Add_Click({Disable_Individual_User})

$Disable_Users_Dropdown.Add_SelectedIndexChanged({Show_Inactive_Users})

$Application_Form.ShowDialog()

$Application_Form.Dispose()
