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

    # Label #3:

$Generated_Password_Label = New-Object $Label_Object # Calling object

$Generated_Password_Label.Text= "Password theme:"

$Generated_Password_Label.AutoSize = $true

$Generated_Password_Label.Font = 'Verdana,8,style=Bold'

$Generated_Password_Label.Location = New-Object System.Drawing.Point(620,20)

## ---------------------------------------------------------------------------- ## 

# Password length choice radio buttons:

$Groupbox_1 = New-Object System.Windows.Forms.GroupBox

$Groupbox_1.Location = '10,10'
$Groupbox_1.size = '420,400'

$Password_Length_Option_1 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_2 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_3 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_4 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_5 = New-Object System.Windows.Forms.RadioButton
$Password_Length_Option_6 = New-Object System.Windows.Forms.RadioButton

$Password_Length_Option_1.Checked = $True
$Password_Length_Option_1.Name = "5 characters maximum"
$Password_Length_Option_1.Text = "5" # Convert to Integer
$Password_Length_Option_1.Location = New-Object System.Drawing.Point(320,40)

$Password_Length_Option_2.Name = "6 characters maximum"
$Password_Length_Option_2.Text = "6"
$Password_Length_Option_2.Location = New-Object System.Drawing.Point(320,80)

$Password_Length_Option_3.Name = "7 characters maximum"
$Password_Length_Option_3.Text = "7"
$Password_Length_Option_3.Location = New-Object System.Drawing.Point(320,120)

$Password_Length_Option_4.Name = "8 characters maximum"
$Password_Length_Option_4.Text = "8"
$Password_Length_Option_4.Location = New-Object System.Drawing.Point(320,160)

$Password_Length_Option_5.Name = "9 characters maximum"
$Password_Length_Option_5.Text = "9"
$Password_Length_Option_5.Location = New-Object System.Drawing.Point(320,200)

$Password_Length_Option_6.Name = "10 characters maximum"
$Password_Length_Option_6.Text = "10"
$Password_Length_Option_6.Location = New-Object System.Drawing.Point(320,240)

$Groupbox_1.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation 

## ---------------------------------------------------------------------------- ## 

# Password theme option radio buttons:

$Groupbox_2 = New-Object System.Windows.Forms.GroupBox

$Groupbox_2.Location = '500,50'
$Groupbox_2.size = '220,200'

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
$Password_Theme_Option_2.Location = New-Object System.Drawing.Point(520,90)

$Password_Theme_Option_3.Name = "Places"
$Password_Theme_Option_3.Text = "Places"
$Password_Theme_Option_3.Location = New-Object System.Drawing.Point(520,120)

$Password_Theme_Option_4.Name = "Music"
$Password_Theme_Option_4.Text = "Music"
$Password_Theme_Option_4.Location = New-Object System.Drawing.Point(520,150)

$Password_Theme_Option_5.Name = "Random"
$Password_Theme_Option_5.Text = "Random"
$Password_Theme_Option_5.Location = New-Object System.Drawing.Point(520,180)

$Groupbox_2.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation

## ---------------------------------------------------------------------------- ##

$Misc_Password_Params = New-Object System.Windows.Forms.CheckedListBox

$Misc_Password_Params.Location = New-Object System.Drawing.Size(700,50)

$Misc_Password_Params.Size = New-Object System.Drawing.Size(200,180)

$Misc_Password_Params.Items.Insert(0, "Capitalize_first_letter"); 

$Misc_Password_Params.Items.Insert(1, "Include_numbers"); 

$Misc_Password_Params.Items.Insert(2, "Include_special_characters"); 

#$Misc_Password_Params.Items.AddRange(1..5)

$Misc_Password_Params.ClearSelected()

$Misc_Password_Params.CheckOnClick = $true

$Misc_Password_Params.Size = New-Object System.Drawing.Size(500,300)
$Misc_Password_Params.Height = 200
$Misc_Password_Params.Font = New-Object System.Drawing.Font("Lucida Console",12,[System.Drawing.FontStyle]::Regular)

## Corresponding functions

function Capitalize_first_letter{

$Password = $global:Password

$Generated_Password = $Password.substring(0,1).toupper()+$Password.substring(1).tolower()    

$global:Gen_Capital_Password = $Generated_Password

$Generated_Password_Label.Text = $Generated_Password


}

function Include_numbers{

if($Misc_Password_Params.CheckedItems -Contains "Capitalize_first_letter"){

$Password = $global:Password

$Capital_Password = $global:Gen_Capital_Password

$Generated_Password = $Capital_Password + "1"

$Generated_Password_Label.Text = $Generated_Password

}
else{

$Generated_Password = $global:Password

$Generated_Password_Label.Text = $Generated_Password
}
}

function Include_special_characters{

Write-Host "Characters"

}

## ---------------------------------------------------------------------------- ##

function Generate_Password{

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

# 'If' statements for password theme selection:

$Music = "guitar", "drums", "piano"

$Food = "bagel", "pizza", "sandwich"

$Animals = “dog”,”cat”,”chicken”, "frog", "bull"

$Places = "boston", "ecuador", "westbrook"

if ($Password_Theme_Option_1.Checked){

#Food

$Password_Theme_Selection = $Food | Get-Random

$global:Password = $Password_Theme_Selection

if($Misc_Password_Params.CheckedItems.Count -eq 0){
    Write-Host $Misc_Password_Params.CheckedItems.Count
    }

else{

foreach($Param in $Misc_Password_Params.CheckedItems){

    Invoke-Expression $Param   
}
}

}

if ($Password_Theme_Option_2.Checked){

#Animals

$Password_Theme_Selection = $Animals | Get-Random

}

if ($Password_Theme_Option_3.Checked){

#Places

$Password_Theme_Selection = $Places | Get-Random

}

if ($Password_Theme_Option_4.Checked){

#Music

$Password_Theme_Selection = $Music | Get-Random

}

if ($Password_Theme_Option_5.Checked){

#Random

}
}

<#

# If statements for password length selection:

# 

if ($Password_Length_Option_1.Checked){

$Password_Length_Selection = 5

if($Password_Theme_Selection.Length -eq $Password_Length_Selection){

$global:Password = $Password_Theme_Selection

foreach($Param in $Misc_Password_Params.CheckedItems){

    Invoke-Expression $Param 

}

}

elseif($Password_Theme_Selection.Length -eq $Password_Length_Selection){

Write-Host $Password_Theme_Selection

Write-Host "Equal length"

}

else{

Write-Host $Password_Theme_Selection

Write-Host "More than"
}
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
#>

## ---------------------------------------------------------------------------- ##


## ---------------------------------------------------------------------------- ##

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
$Password_Theme_Option_4, $Password_Theme_Option_5, $Password_Theme_Option_6, $Misc_Password_Params, $Create_Password_Button, $Groupbox_1, $Groupbox_2, $Generated_Password_Label))

$Groupbox_1.Controls.AddRange(@($Password_Length_Option_1,$Password_Length_Option_2,$Password_Length_Option_3,$Password_Length_Option_4,$Password_Length_Option_5,$Password_Length_Option_6))
$Groupbox_2.Controls.AddRange(@())

$Application_Form.ShowDialog() # Show form on runtime

$Application_Form.Dispose() # Garbage collection
