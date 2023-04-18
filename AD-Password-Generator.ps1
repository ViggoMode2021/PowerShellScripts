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

    # Label #1:

$Label_Title = New-Object $Label_Object # Calling object

$Label_Title.Text= "Password length:"

$Label_Title.AutoSize = $true

$Label_Title.Font = 'Verdana,8,style=Bold'

$Label_Title.Location = New-Object System.Drawing.Point(220,20)

## ---------------------------------------------------------------------------- ## 

# Password length choice radio buttons:

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

## ---------------------------------------------------------------------------- ## 

# Password theme option radio buttons:

$Password_Theme_Option_1 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_2 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_3 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_4 = New-Object System.Windows.Forms.RadioButton
$Password_Theme_Option_5 = New-Object System.Windows.Forms.RadioButton

$Password_Theme_Option_1.Checked = $True
$Password_Theme_Option_1.Name = "5 characters maximum"
$Password_Theme_Option_1.Text = "5" # Convert to Integer
$Password_Theme_Option_1.Location = New-Object System.Drawing.Point(520,60)

$Password_Theme_Option_2.Name = "6 characters maximum"
$Password_Theme_Option_2.Text = "6"
$Password_Theme_Option_2.Location = New-Object System.Drawing.Point(520,100)

$Password_Theme_Option_3.Name = "7 characters maximum"
$Password_Theme_Option_3.Text = "7"
$Password_Theme_Option_3.Location = New-Object System.Drawing.Point(520,140)

$Password_Theme_Option_4.Name = "8 characters maximum"
$Password_Theme_Option_4.Text = "8"
$Password_Theme_Option_4.Location = New-Object System.Drawing.Point(520,180)

$Password_Theme_Option_5.Name = "9 characters maximum"
$Password_Theme_Option_5.Text = "9"
$Password_Theme_Option_5.Location = New-Object System.Drawing.Point(520,220)

## ---------------------------------------------------------------------------- ##

<#

$CheckedListBox = New-Object System.Windows.Forms.CheckedListBox

$CheckedListBox.Location = New-Object System.Drawing.Size(500,50)

$CheckedListBox.Size = New-Object System.Drawing.Size(100,90)

$CheckedListBox.Items.AddRange(1..5)

$CheckedListBox.ClearSelected()

$CheckedListBox.CheckOnClick = $true

#>

# Add all objects to the form:

<#$CheckedListBox#>

$Application_Form.Controls.AddRange(@($Label_Title, $Password_Length_Option_1, $Password_Length_Option_2, $Password_Length_Option_3, 
$Password_Length_Option_4, $Password_Length_Option_5, $Password_Length_Option_6, $Password_Theme_Option_1, $Password_Theme_Option_2, $Password_Theme_Option_3,
$Password_Theme_Option_4, $Password_Theme_Option_5, $Password_Theme_Option_6))

$Application_Form.ShowDialog() # Show form on runtime

$Application_Form.Dispose() # Garbage collection
