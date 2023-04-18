# Generate a random password for an Active Directory user:

     # 1. User parameters selected from 4 different checkbox columns, such as: length + capitalization + number + special characters. 
    
     # script user can mix and match these parameters if they so please. Also, have a selected number of themes - animals, food, music etc.

     # 2. Allow user to save settings for 'presets' and save to a txt or csv (preferred) file. This will create a folder an then subsequent csv file.
     
     # 3. Select one or multiple users from an OU dropdown and an individual user dropdown. 

     # 4. Have a password security meter.

     # 5. Create a csv for user password history and show user password change dates.

     # 6. Send password change email to user and admin.

#Import-Module ActiveDirectory # Import Active Directory PowerShell module

Add-Type -AssemblyName System.Windows.Forms # Add .NET Windows Forms functionality

$Current_Date = Get-Date -Format "MM/dd/yyyy" # Get today's date

# GUI form code below:

$Form_Object = [System.Windows.Forms.Form] # Entire form/window for GUI
$Label_Object = [System.Windows.Forms.Label] # Label object for text
$Button_Object = [System.Windows.Forms.Button] # Button object
$Combo_Box_Object = [System.Windows.Forms.ComboBox] # Dropdown object

$Application_Form = New-Object $Form_Object # Create new form/window for GUI

$Application_Form.ClientSize= '500,300'

#$Domain = Get-ADDomain -Current LocalComputer | Select Name | foreach { $_.Name } |  Out-String # Get-AD Domain name

$Application_Form.Text = "Password generator for AD users in $Domain on $Current_Date" # Name of application

$Application_Form.BackColor= "#ffffff" # White bkgr color

# Building the form:

## ---------------------------------------------------------------------------- ## 

    # Label #1:

$Password_Length = New-Object $Label_Object # Calling object

$Password_Length.Text= "Password length:"

$Password_Length.AutoSize = $true

$Password_Length.Font = 'Verdana,8,style=Bold'

$Password_Length.Location = New-Object System.Drawing.Point(200,20)

## ---------------------------------------------------------------------------- ## 

    # Label #2:

$Password_Theme = New-Object $Label_Object # Calling object

$Password_Theme.Text= "Password theme:"

$Password_Theme.AutoSize = $true

$Password_Theme.Font = 'Verdana,8,style=Bold'

$Password_Theme.Location = New-Object System.Drawing.Point(420,20)

## ---------------------------------------------------------------------------- ## 

# Password length choice radio buttons:

$groupbox1 = New-Object System.Windows.Forms.GroupBox

$groupbox1.Location = '10,10'
$groupbox1.size = '420,400'

$Password_Length_Option_1 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_2 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_3 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_4 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_5 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_6 = New-Object System.Windows.Forms.RadioButton

$Password_Length_Option_1.Checked = $True
$Password_Length_Option_1.Name = "5 characters maximum"
$Password_Length_Option_1.Text = "5" # Convert to Integer
$Password_Length_Option_1.Location = New-Object System.Drawing.Point(320,20)

$Password_Length_Option_2.Name = "6 characters maximum"
$Password_Length_Option_2.Text = "6"
$Password_Length_Option_2.Location = New-Object System.Drawing.Point(320,60)

$Password_Length_Option_3.Name = "7 characters maximum"
$Password_Length_Option_3.Text = "7"
$Password_Length_Option_3.Location = New-Object System.Drawing.Point(320,100)

$Password_Length_Option_4.Name = "8 characters maximum"
$Password_Length_Option_4.Text = "8"
$Password_Length_Option_4.Location = New-Object System.Drawing.Point(320,140)

$Password_Length_Option_5.Name = "9 characters maximum"
$Password_Length_Option_5.Text = "9"
$Password_Length_Option_5.Location = New-Object System.Drawing.Point(320,180)

$Password_Length_Option_6.Name = "10 characters maximum"
$Password_Length_Option_6.Text = "10"
$Password_Length_Option_6.Location = New-Object System.Drawing.Point(320,220)

$groupbox1.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation 

## ---------------------------------------------------------------------------- ## 

# Password theme option radio buttons:

$groupbox2 = New-Object System.Windows.Forms.GroupBox

$groupbox2.Location = '500,50'
$groupbox2.size = '220,200'

$Password_Theme_Option_1 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_2 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_3 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_4 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_5 = New-Object System.Windows.Forms.RadioButton

$Password_Theme_Option_1.Checked = $True
$Password_Theme_Option_1.Name = "Food"
$Password_Theme_Option_1.Text = "Food" # Convert to String
$Password_Theme_Option_1.Location = New-Object System.Drawing.Point(520,60)

$Password_Theme_Option_2.Name = "Animals"
$Password_Theme_Option_2.Text = "Animals"
$Password_Theme_Option_2.Location = New-Object System.Drawing.Point(520,100)

$Password_Theme_Option_3.Name = "Places"
$Password_Theme_Option_3.Text = "Places"
$Password_Theme_Option_3.Location = New-Object System.Drawing.Point(520,140)

$Password_Theme_Option_4.Name = "Music"
$Password_Theme_Option_4.Text = "Music"
$Password_Theme_Option_4.Location = New-Object System.Drawing.Point(520,180)

$Password_Theme_Option_5.Name = "Random"
$Password_Theme_Option_5.Text = "Random"
$Password_Theme_Option_5.Location = New-Object System.Drawing.Point(520,220)

$groupbox2.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation

## ---------------------------------------------------------------------------- ##

$Misc_Password_Params = New-Object System.Windows.Forms.CheckedListBox

$Misc_Password_Params.Location = New-Object System.Drawing.Size(700,50)

$Misc_Password_Params.Size = New-Object System.Drawing.Size(200,180)

$Misc_Password_Params.Items.Insert(0, "Capital first letter"); 

$Misc_Password_Params.Items.Insert(1, "Include numbers"); 

$Misc_Password_Params.Items.Insert(2, "Include special characters"); 

#$Misc_Password_Params.Items.AddRange(1..5)

$Misc_Password_Params.ClearSelected()

$Misc_Password_Params.CheckOnClick = $true

$Misc_Password_Params.Size = New-Object System.Drawing.Size(500,300)
$Misc_Password_Params.Height = 200
$Misc_Password_Params.Font = New-Object System.Drawing.Font("Lucida Console",12,[System.Drawing.FontStyle]::Regular)

## ---------------------------------------------------------------------------- ##

function Generate_Password{

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

if ($Password_Length_Option_1.Checked){

$Password_Length_Selection = 5

}

if ($Password_Length_Option_2.Checked){

$Password_Length_Selection = 6

}

if ($Password_Length_Option_3.Checked){

$Password_Length_Selection = 7

}

if ($Password_Length_Option_4.Checked){

$Password_Length_Selection = 8

}

if ($Password_Length_Option_5.Checked){

$Password_Length_Selection = 9

}

if ($Password_Length_Option_6.Checked){

$Password_Length_Selection = 10

}










}
















## ---------------------------------------------------------------------------- ##

$Button_Object = [System.Windows.Forms.Button]

$Create_Password_Button = New-Object $Button_Object

$Create_Password_Button.Text= "Generate Password"

$Create_Password_Button.AutoSize = $true

$Create_Password_Button.Font = 'Verdana,12,style=Bold'

$Create_Password_Button.Location = New-Object System.Drawing.Point(550,350)

$Create_Password_Button.Add_Click({Generate_Password})

$Application_Form.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation 

$Application_Form.Controls.AddRange(@($Password_Length, $Password_Length_Option_1, $Password_Length_Option_2, $Password_Length_Option_3, 
$Password_Length_Option_4, $Password_Length_Option_5, $Password_Length_Option_6, $Password_Theme, $Password_Theme_Option_1, $Password_Theme_Option_2, $Password_Theme_Option_3,
$Password_Theme_Option_4, $Password_Theme_Option_5, $Password_Theme_Option_6, $Misc_Password_Params, $Create_Password_Button, $groupbox1, $groupbox2))

$groupbox1.Controls.AddRange(@($Password_Length_Option_1,$Password_Length_Option_2, $Password_Length_Option_3, $Password_Length_Option_4, $Password_Length_Option_5, $Password_Length_Option_6))
$groupbox2.Controls.AddRange(@($Password_Theme_Option_1,$Password_Theme_Option_2, $Password_Theme_Option_3))

$Application_Form.ShowDialog() # Show form on runtime

$Application_Form.Dispose() # Garbage collection
