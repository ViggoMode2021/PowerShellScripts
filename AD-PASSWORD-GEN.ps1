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

Add-Type -AssemblyName PresentationCore,PresentationFramework

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

$CSV_Name_Label = New-Object $Label_Object # Calling object

$CSV_Name_Label.Text= "Select CSV file:"

$CSV_Name_Label.AutoSize = $true

$CSV_Name_Label.Font = 'Verdana,8,style=Bold'

$CSV_Name_Label.Location = New-Object System.Drawing.Point(470,30)

## ---------------------------------------------------------------------------- ## 

    # Label #3:

$Generated_Password_Label = New-Object $Label_Object # Calling object

$Generated_Password_Label.Text= "*Generated password will appear here*"

$Generated_Password_Label.AutoSize = $true

$Generated_Password_Label.Font = 'Verdana,8,style=Bold'

$Generated_Password_Label.Location = New-Object System.Drawing.Point(620,620)

## ---------------------------------------------------------------------------- ## 

    # Label #4:

$User_Name_Password_Label = New-Object $Label_Object # Calling object

$User_Name_Password_Label.Text= "*Change password for (username)*"

$User_Name_Password_Label.AutoSize = $true

$User_Name_Password_Label.Font = 'Verdana,8,style=Bold'

$User_Name_Password_Label.Location = New-Object System.Drawing.Point(620,420)

## ---------------------------------------------------------------------------- ## 

    # Label #5:

$User_Password_Last_Set = New-Object $Label_Object # Calling object

$User_Password_Last_Set.Text= "*Password last set*"

$User_Password_Last_Set.AutoSize = $true

$User_Password_Last_Set.Font = 'Verdana,10,style=Bold'

$User_Password_Last_Set.Location = New-Object System.Drawing.Point(650,470)

## ---------------------------------------------------------------------------- ## 

    # Select user button:

$Select_User_Button = New-Object $Button_Object

$Select_User_Button.Text= "Select user"

$Select_User_Button.AutoSize = $true

$Select_User_Button.Font = 'Verdana,12,style=Bold'

$Select_User_Button.Location = New-Object System.Drawing.Point(220,40)

$Select_User_Button.Add_Click({Select_User})

## ---------------------------------------------------------------------------- ## 

# Label #6:

$Special_Characters_Label = New-Object $Label_Object # Calling object

$Special_Characters_Label.Text= "Special characters:"

$Special_Characters_Label.AutoSize = $true

$Special_Characters_Label.Font = 'Verdana,8,style=Bold'

$Special_Characters_Label.Location = New-Object System.Drawing.Point(750,20)

## ---------------------------------------------------------------------------- ## 

    # MessageBox:

$ButtonType = [System.Windows.MessageBoxButton]::Ok

$MessageIcon = [System.Windows.MessageBoxImage]::Warning

$Groupbox_2 = New-Object System.Windows.Forms.GroupBox

$Groupbox_2.Location = '483,50'
$Groupbox_2.size = '170,170'

$Upload_CSV_Button = New-Object System.Windows.Forms.RadioButton
$Select_Word_Button = New-Object System.Windows.Forms.RadioButton

$Upload_CSV_Button.Name = "Upload"
$Upload_CSV_Button.Text = "Upload CSV"
$Upload_CSV_Button.Location = New-Object System.Drawing.Point(490,60)

$Select_Word_Button.Name = "Select word"
$Select_Word_Button.Text = "NOT SELECTED"
$Select_Word_Button.Location = New-Object System.Drawing.Point(490,105)

$Groupbox_2.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation

## ---------------------------------------------------------------------------- ##

$Misc_Password_Params = New-Object System.Windows.Forms.CheckedListBox

$Misc_Password_Params.Location = New-Object System.Drawing.Size(700,50)

$Misc_Password_Params.Items.Insert(0, "Capitalize_first_letter"); 

$Misc_Password_Params.Items.Insert(1, "Include_numbers"); 

$Misc_Password_Params.Items.Insert(2, "Include_special_characters"); 

$Misc_Password_Params.ClearSelected()

$Misc_Password_Params.CheckOnClick = $true

$Misc_Password_Params.Size = New-Object System.Drawing.Size(500,300)
$Misc_Password_Params.Height = 200
$Misc_Password_Params.Font = New-Object System.Drawing.Font("Lucida Console",12,[System.Drawing.FontStyle]::Regular)

    # OU Dropdown list:

$OU_Select_Dropdown = New-Object $Combo_Box_Object

$OU_Select_Dropdown.Width='190'

$OU_Select_Dropdown.Text="Select an OU"

$OU_Select_Dropdown.Font = New-Object System.Drawing.Font("Lucinda Console",12)

$OU_Select_Dropdown.Location = New-Object System.Drawing.Point(10,10) # Add location to top left of GUI

# User Dropdown list:

$Users_Dropdown = New-Object $Combo_Box_Object

$Users_Dropdown.Width='190'

$Users_Dropdown.Text="Select a user"

$Users_Dropdown.Font = New-Object System.Drawing.Font("Lucinda Console",12)

$Users_Dropdown.Location = New-Object System.Drawing.Point(10,40) # Add location to top left of GUI

## Corresponding functions

Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Where-Object DistinguishedName -notlike "*Domain Controllers*" |Sort-Object CanonicalName | ForEach-Object {$OU_Select_Dropdown.Items.Add($_.Name)}

$User_Name=$Users_Dropdown.SelectedItem

# Function to show OUs: 

function Show_OUs{

$Users_Dropdown.Items.Clear()

$OU_Name=$OU_Select_Dropdown.SelectedItem

$global:OU_Global = $OU_Name

Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$OU_Name*" | ForEach-Object {$Users_Dropdown.Items.Add($_.Name)}

}

$OU_Select_Dropdown.Add_SelectedIndexChanged({Show_OUs})

function Select_User{

    $User_Name=$Users_Dropdown.SelectedItem

    $global:User_Name_Global = $User_Name

    $User_Name_Password_Label.Text = "Change password for $User_Name"

    $User_Name_Password_Last_Set = Get-ADUser -Filter {(enabled -eq $true)} -Properties PwdLastSet,PasswordLastSet | Where-Object DistinguishedName -like "*$User_Name*" | Sort Name | ft PasswordLastSet | Out-String

    $User_Password_Last_Set.Text = $User_Name_Password_Last_Set

    $User_Password_Last_Set.Location = New-Object System.Drawing.Point(650,470)

    }
  
# Function to generate new password for AD users:

function Generate_Active_Directory_Password{

if($Misc_Password_Params.CheckedItems -Contains "Capitalize_first_letter" -and $Misc_Password_Params.CheckedItems.Count -eq 1){

$Generated_Password_Label.Text = ""

$Password = $global:Password

$Capitalized_First_Letter_Password = $Password.substring(0,1).toupper()+$Password.substring(1).tolower()    

$Generated_Password_Label.Text = $Capitalized_First_Letter_Password

$New_User_Password = ConvertTo-SecureString $Capitalized_First_Letter_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Generated_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

if($Confirmation -eq 'No') {
    
    $Generated_Password_Label.Text = "*Generated password will appear here.*"
    Write-Host "Kodak"
    
      
} 

}

if($Misc_Password_Params.CheckedItems -Contains "Include_numbers" -and $Misc_Password_Params.CheckedItems.Count -eq 1){

$Random_Number = Get-Random -Minimum 1 -Maximum 9000

$Random_Number = [string]$Random_Number

$Password = $global:Password

$Include_Numbers_Password = $Password + $Random_Number

$Generated_Password_Label.Text = $Include_Numbers_Password

##

$New_User_Password = ConvertTo-SecureString $Include_Numbers_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
    
} 

}

if($Misc_Password_Params.CheckedItems -Contains "Capitalize_first_letter" -and $Misc_Password_Params.CheckedItems -Contains "Include_numbers" -and $Misc_Password_Params.CheckedItems.Count -eq 2){

$Password = $global:Password

$Capitalized_First_Letter_Password = $Password.substring(0,1).toupper()+$Password.substring(1).tolower()    

$Random_Number = Get-Random -Minimum 1 -Maximum 9000

$Random_Number = [string]$Random_Number

$Capitalized_First_Letter_And_Include_Numbers_Password = $Capitalized_First_Letter_Password + $Random_Number

$Generated_Password_Label.Text = $Capitalized_First_Letter_And_Include_Numbers_Password

##

$New_User_Password = ConvertTo-SecureString $Capitalized_First_Letter_And_Include_Numbers_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
      
} 

}

if($Misc_Password_Params.CheckedItems -Contains "Include_special_characters" -and $Misc_Password_Params.CheckedItems.Count -eq 1){

$Password = $global:Password 

$Random_Special_Characters = "~", "!", "~!@", "%^&*", ")(" | Get-Random

$Special_Characters_Password = $Password + $Random_Special_Characters

$Generated_Password_Label.Text = $Special_Characters_Password

##

$New_User_Password = ConvertTo-SecureString $Special_Characters_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
      
}

}

if($Misc_Password_Params.CheckedItems -Contains "Include_special_characters" -and "Capitalize_first_letter" -and $Misc_Password_Params.CheckedItems.Count -eq 2){

$Password = $global:Password

$Capitalized_First_Letter_Password = $Password.substring(0,1).toupper()+$Password.substring(1).tolower() 

$Random_Special_Characters = "~", "!", "~!@", "%^&*", ")(" | Get-Random

$Special_Characters_Capital_Password = $Capitalized_First_Letter_Password + $Random_Special_Characters

$Generated_Password_Label.Text = $Special_Characters_Capital_Password

##

$New_User_Password = ConvertTo-SecureString $Special_Characters_Capital_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
      
}

}

if($Misc_Password_Params.CheckedItems -Contains "Include_special_characters" -and "Include_numbers" -and $Misc_Password_Params.CheckedItems.Count -eq 2){

if($Misc_Password_Params.CheckedItems -NotContains "Capitalize_first_letter"){

$Password = $global:Password

$Random_Number = Get-Random -Minimum 1 -Maximum 9000

$Random_Number = [string]$Random_Number

$Random_Special_Characters = "~", "!", "~!@", "%^&*", ")(" | Get-Random

$Special_Characters_Numbers_Password = $Password + $Random_Special_Characters + $Random_Number

$Generated_Password_Label.Text = $Special_Characters_Numbers_Password

##

$New_User_Password = ConvertTo-SecureString $Special_Characters_Numbers_Password -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
      
}

}}

if($Misc_Password_Params.CheckedItems -Contains "Include_special_characters" -and "Include_numbers" -and "Capitalize_first_letter" -and $Misc_Password_Params.CheckedItems.Count -eq 3){

$Password = $global:Password

$Capitalized_First_Letter_Password = $Password.substring(0,1).toupper()+$Password.substring(1).tolower() 

$Random_Number = Get-Random -Minimum 1 -Maximum 9000

$Random_Number = [string]$Random_Number

$Random_Special_Characters = "~", "!", "~!@", "%^&*", ")(" | Get-Random

$Capitalized_First_Letter_Password_With_Numbers_And_Special_Characters = $Capitalized_First_Letter_Password + $Random_Number + $Random_Special_Characters

$Generated_Password_Label.Text = $Capitalized_First_Letter_Password_With_Numbers_And_Special_Characters

##

$New_User_Password = ConvertTo-SecureString $Capitalized_First_Letter_Password_With_Numbers_And_Special_Characters -AsPlainText -Force

$MessageBoxTitle = "Change password for $User_Name_Global"

$MessageBoxBody = "Change password to '$Include_Numbers_Password' for '$User_Name_Global'?"

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

$Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

if($Confirmation -eq 'Yes') {
    Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
    $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
}

else{
      
}

}
}

## ---------------------------------------------------------------------------- ##

$Desktop = 'Desktop'

function Select_CSV ($Desktop){
    Add-Type -AssemblyName System.Windows.Forms
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = "Please Select File"
    $OpenFileDialog.InitialDirectory = $initialDirectory
    $OpenFileDialog.filter = "(*.csv)|*.csv|SpreadSheet (*.xlsx)|*.xlsx'"
    # Out-Null supresses the "OK" after selecting the file.
    $OpenFileDialog.ShowDialog() | Out-Null

    $Global:Selected_File = $OpenFileDialog.FileName

    $CSV_Filename = Split-Path $Selected_File -Leaf

    $CSV = [string]$CSV_Filename

    [bool]$string

    if(!$CSV){

    $MessageBoxTitle = "No file selected error!"

    $MessageBoxBody = "No file has been selected. Please select a csv file."

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

    }

    elseif($CSV_Name_Label.Text= "Current CSV: $CSV_Filename"){

    $Select_Word_Button.Text = 'Select random word'

    $CSV_Name_Label.Text= "Current CSV: $CSV_Filename"

    $Upload_CSV_Button.Text = "CSV Selected"

    $Upload_CSV_Button.ForeColor = 'Green'

    }

    else{

    $Select_Word_Button.Text = 'Select random word'

    $CSV_Name_Label.Text= "Current CSV: $CSV_Filename"

    $Upload_CSV_Button.Text = "CSV Selected"

    $Upload_CSV_Button.ForeColor = 'Green'

    }

}

function Select_Random_Word{

Import-Csv $Selected_File | ForEach-Object {
    if($null -eq $First_Column_Name) {
        # first row, grab the first column name
        $First_Column_Name = @($_.psobject.Properties)[0].Name
    }
    }
    
    # access the value in the given column

$Random_CSV_Word = Import-Csv $Selected_File | select -ExpandProperty $First_Column_Name | Get-Random

$Generated_Password_Label.Text = "$Random_CSV_Word"

}

## ---------------------------------------------------------------------------- ##

function Generate_Password{

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

# 'If' statements for password theme selection:

if ($Password_Theme_Option_1.Checked){

#Food

$Password_Theme_Selection = $Food | Get-Random

$global:Password = $Password_Theme_Selection

if($Misc_Password_Params.CheckedItems.Count -eq 0){
    $Generated_Password = $Password_Theme_Selection
    $Generated_Password_Label.Text = $Generated_Password

    $New_User_Password = ConvertTo-SecureString $Generated_Password -AsPlainText -Force

    $MessageBoxTitle = "Change password for $User_Name_Global"

    $MessageBoxBody = "Change password to '$Generated_Password' for '$User_Name_Global'?"

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonType,$MessageIcon)

    $Sam_Account_Name = Get-ADUser -Filter {(enabled -eq $true)} | Where-Object DistinguishedName -like "*$User_Name_Global*" | Select-Object SamAccountName | Out-Host

    if($Confirmation -eq 'Yes') {
        Set-ADAccountPassword -Identity $Sam_Account_Name -NewPassword $New_User_Password -Reset
        $Generated_Password_Label.Text = "Password updated for $User_Name_Global on $Current_Date."
    }

    else{
      
    }
    }

    }

Import-Csv $Selected_File | ForEach-Object {
    if($null -eq $First_Column_Name) {
        # first row, grab the first column name
        $First_Column_Name = @($_.psobject.Properties)[0].Name
    }
    }
    
    # access the value in the given column

}

if ($Select_Word_Button.Checked){

#Music

$Random_CSV_Word = Import-Csv $Selected_File | select -ExpandProperty $First_Column_Name | Get-Random

$Generated_Password_Label.Text = "$Random_CSV_Word" 

if($Misc_Password_Params.CheckedItems.Count -eq 0){
    $Generated_Password = $Password_Theme_Selection
    $Generated_Password_Label.Text = $Generated_Password
    }

else{

Invoke-Expression Generate_Active_Directory_Password

}

}

function Copy_Password_To_Clipboard{

$Generated_Password_Label.Text | Set-Clipboard

}

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

$Select_Word_Button.Add_Click({Select_Random_Word})

$Copy_To_Clipboard_Button = New-Object $Button_Object

$Copy_To_Clipboard_Button.Text= "Copy password"

$Copy_To_Clipboard_Button.AutoSize = $true

$Copy_To_Clipboard_Button.Font = 'Verdana,12,style=Bold'

$Copy_To_Clipboard_Button.Location = New-Object System.Drawing.Point(950,350)

$Copy_To_Clipboard_Button.Add_Click({Copy_Password_To_Clipboard})

$Upload_CSV_Button.Add_Click({Select_CSV})

$Application_Form.DataBindings.DefaultDataSourceUpdateMode = [System.Windows.Forms.DataSourceUpdateMode]::OnValidation 

$Application_Form.Controls.AddRange(@($CSV_Name_Label, $Upload_CSV_Button, $Select_Word_Button, $Misc_Password_Params, $Create_Password_Button, $Groupbox_2, $Generated_Password_Label,
$Copy_To_Clipboard_Button, $OU_Select_Dropdown, $Users_Dropdown, $Select_User_Button, $User_Name_Password_Label, $User_Password_Last_Set,
$Special_Characters_Label))

#$Groupbox_1.Controls.AddRange(@($Password_Length_Option_1,$Password_Length_Option_2,$Password_Length_Option_3,$Password_Length_Option_4,$Password_Length_Option_5,$Password_Length_Option_6))
$Groupbox_2.Controls.AddRange(@())

$Application_Form.ShowDialog() # Show form on runtime

$Application_Form.Dispose() # Garbage collection

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

#########################################################

<#


$Desktop = 'Desktop'

Function Open-File($Desktop)
{
    Add-Type -AssemblyName System.Windows.Forms
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = "Please Select File"
    $OpenFileDialog.InitialDirectory = $initialDirectory
    $OpenFileDialog.filter = "(*.csv)|*.csv|SpreadSheet (*.xlsx)|*.xlsx'"
    # Out-Null supresses the "OK" after selecting the file.
    $OpenFileDialog.ShowDialog() | Out-Null
    $Global:Selected_File = $OpenFileDialog.FileName
}

$ColNames = ($Selected_File[0].psobject.Properties).name

Open-File

$Custom_CSV = Import-CSV -Path $Selected_File | Get-Random | Select -ExpandProperty $ColNames | Select-Object -Skip 1 | Format-List

$Custom_CSV

#>
