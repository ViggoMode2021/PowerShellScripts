#Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms

Add-Type -AssemblyName PresentationCore,PresentationFramework

$Date = Get-Date -format "MMddyyyy"

$Domain="@domain"

$Logged_In_User = whoami /upn

$Logged_In_Username = $Logged_In_User.Replace('@domain', '')

$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$Form.Text = "EleetShell - Practice Windows Server and PowerShell!"

$Menu_Bar = New-Object System.Windows.Forms.MenuStrip
$File_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$New_Game_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Learn= New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Practice= New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice= New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_2= New-Object System.Windows.Forms.ToolStripMenuItem

$ButtonTypeOk = [System.Windows.MessageBoxButton]::Ok

$ButtonTypeYesNoCancel = [System.Windows.MessageBoxButton]::YesNoCancel 

$MessageIconWarning = [System.Windows.MessageBoxImage]::Warning

$MessageIconError = [System.Windows.MessageBoxImage]::Error

$MessageIconSuccess = [System.Windows.MessageBoxImage]::Information

$Label_Object = [System.Windows.Forms.Label]

$Title = New-Object $Label_Object

$Title.Text= ""

$Title.AutoSize = $true

$Title.Font = 'Verdana,11,style=Bold'

$Title.Location = New-Object System.Drawing.Point(320,20)

$Body = New-Object $Label_Object

$Body.Text= ""

$Body.AutoSize = $true

$Body.Font = 'Verdana,11,style=Bold'

$Body.Location = New-Object System.Drawing.Point(320,80)

$Input_Box = New-Object System.Windows.Forms.TextBox
$Input_Box.Location = New-Object System.Drawing.Point(380,250)
$Input_Box.Size = New-Object System.Drawing.Size(380,250)

$Menu_Bar.Items.AddRange(@(
$File_Menu_Item,
$Windows_General_Strip_Menu_Item,
$DHCP_DNS_Strip_Menu_Item,
$Boot_Process_Strip_Menu_Item_Learn,
$Boot_Process_Strip_Menu_Item_Practice))

## start File menu item ##

$File_Menu_Item.Name = "File_Menu_Item"
$File_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$File_Menu_Item.Text = "File"

$New_Game_Strip_Menu_Item.Name = "New_Game_Strip_Menu_Item"
$New_Game_Strip_Menu_Item.Size = New-Object System.Drawing.Size(152, 22)
$New_Game_Strip_Menu_Item.Text = "New Game"

$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item))

function On_Click_New_Game_Strip_Menu_Item($Sender,$e){     
    $MessageBoxTitle = "New game file creation"

    $MessageBoxBody = "By starting a new game, a new csv file will be created on your desktop to track your score. Continue?"

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeYesNoCancel,$MessageIconWarning)
	
	if($Confirmation -eq 'Yes'){
		
	[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') 
	$New_Game_Filename = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the file name', 'Enter the filename')

    $New_Game_Filename_Csv = "$New_Game_Filename.csv"
	
	<#
	
	$Logged_In_User = whoami /upn

	$Logged_In_Username = $Logged_In_User.Replace('@domain', '')
	
	ADD THIS AFTER
	
	#>
		
	#New-Item C:\Users\Administrator\desktop\$New_Game_Filename.csv -ItemType File

    $New_Game_File_CheckSum = Get-ChildItem "C:\Users\rviglione\desktop" -recurse | where {$_.name -match "food.csv"} | select-object -ExpandProperty name

    if($New_Game_Filename_Csv -eq $New_Game_File_CheckSum){

    $MessageBoxTitle = "File creation error."

    $MessageBoxBody = "$New_Game_File_CheckSum already exists. Creating a file with the name $New_Game_Filename$Date.csv"

    $New_Game_File = New-Item C:\Users\rviglione\desktop\$New_Game_Filename$Date.csv -ItemType File

    $File = "$New_Game_File"
    $Data = Get-Content -Path $File
    $Header = "Problem,Result,Date,Points"
    Set-Content $File -Value $Header
    Add-Content -Path $File -Value $Data

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

    $global:Game_Score_File = "C:\Users\rviglione\desktop\$New_Game_Filename_Csv"

    $Form.Text = "EleetShell - Current score file: $New_Game_Filename_Csv"

    }

    if($New_Game_Filename.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ne -1)

    {

    $MessageBoxTitle = "File name contains invalid characters"

    $MessageBoxBody = "$New_Game_Filename contains invalid characters. Please try again."

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)
    
    }

    else{

    $New_Game_File = New-Item C:\Users\rviglione\desktop\$New_Game_Filename_Csv -ItemType File

    $File = "$New_Game_File"
    $Data = Get-Content -Path $File
    $Header = "Problem,Result,Date,Points"
    Set-Content $File -Value $Header
    Add-Content -Path $File -Value $Data

    $MessageBoxTitle = "New game created with the scorecard filename $New_Game_Filename_Csv"

    $MessageBoxBody = "New game created with the scorecard filename $New_Game_Filename_Csv"

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconSuccess)

    $global:Game_Score_File = "C:\Users\rviglione\desktop\$New_Game_Filename_Csv"

    $Form.Text = "EleetShell - Current score file: $New_Game_Filename_Csv"

    }

	}
}

$New_Game_Strip_Menu_Item.Add_Click( { On_Click_New_Game_Strip_Menu_Item $New_Game_Strip_Menu_Item $EventArgs} )

## end File menu item ##

## start Windows General menu item ##

$Windows_General_Strip_Menu_Item.Name = "Windows_General_Strip_Menu_Item"
$Windows_General_Strip_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$Windows_General_Strip_Menu_Item.Text = "Windows General"

$Boot_Process_Strip_Menu_Item_Learn.Name = "Boot_Process_Strip_Menu_Item_Learn"
$Boot_Process_Strip_Menu_Item_Learn.Size = New-Object System.Drawing.Size(152, 22)
$Boot_Process_Strip_Menu_Item_Learn.Text = "Boot Process #1"

## end Windows General menu item ##

$DHCP_DNS_Strip_Menu_Item.Name = "DHCP_DNS_Strip_Menu_Item"
$DHCP_DNS_Strip_Menu_Item.Size = New-Object System.Drawing.Size(51, 20)
$DHCP_DNS_Strip_Menu_Item.Text = "DHCP + DNS"

$The_Submit_Button = New-Object System.Windows.Forms.Button

$The_Submit_Button.Text= "Submit"

$The_Submit_Button.AutoSize = $True

$The_Submit_Button.Font = 'Verdana,12,style=Bold'

$The_Submit_Button.ForeColor = 'Blue'

$The_Submit_Button.Location = New-Object System.Drawing.Point(420,300)

$The_Submit_Button.Add_Click({Selected_Practice_Problem})

## Windows Boot Process ##

$Windows_General_Strip_Menu_Item.DropDownItems.AddRange(@($Boot_Process_Strip_Menu_Item_Learn))

function On_Click_Boot_Process_Strip_Menu_Item_Practice($Sender,$e){     
    $Title.Text= "Practice PowerShell for Windows environment"
	$Body.Text = ""
}

$Boot_Process_Strip_Menu_Item_Practice.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Practice $Boot_Process_Strip_Menu_Item_Practice $EventArgs} )

function On_Click_Boot_Process_Strip_Menu_Item_Learn($Sender,$e){     
    $Title.Text= "Learn Windows environment"
	$Body.Text = "Using PowerShell, find the computer name (hostname) of this device."
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
}

function Selected_Practice_Problem{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell."){
	if($Input_Box.Text -eq "hostname"){

    Write-Host 
    $Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Correct, your answer was $Answer."

    $Views = "fRE"

    $Likes = "JS"

    $Comments = "paper"
    
    $New_Row = "$Date,$Views,$Likes,$Comments"

    $New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = $Date ; Result = "$Views" ; Date = $Likes ; Comments = $Comments }
    
    $New_Results += $New_Row

    $New_Results | Export-csv -append $Game_Score_File

    }

	else{
		$Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Incorrect, your answer was $Answer."}
	}
}

$Boot_Process_Strip_Menu_Item_Learn.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Learn $Boot_Process_Strip_Menu_Item_Learn $EventArgs} )

## DHCP & DNS ##

$DHCP_DNS_Strip_Menu_Item_Practice.Name = "DHCP_DNS_Strip_Menu_Item_Practice"
$DHCP_DNS_Strip_Menu_Item_Practice.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice.Text = "DHCP + DNS #1"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice($Sender,$e){     
    $Title.Text= "Practice PowerShell for DHCP + DNS"
	$Body.Text = ""
}

$DHCP_DNS_Strip_Menu_Item_Practice_2.Name = "DHCP_DNS_Strip_Menu_Item_Practice_2"
$DHCP_DNS_Strip_Menu_Item_Practice_2.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice_2.Text = "DHCP + DNS #2"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice_2($Sender,$e){     
    $Title.Text= "Practice PowerShell for DHCP + DNS #2"
	$Body.Text = ""
}

$DHCP_DNS_Strip_Menu_Item_Practice.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice $DHCP_DNS_Strip_Menu_Item_Practice $EventArgs} )

$DHCP_DNS_Strip_Menu_Item_Practice_2.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice_2 $DHCP_DNS_Strip_Menu_Item_Practice_2 $EventArgs} )

$DHCP_DNS_Strip_Menu_Item.DropDownItems.AddRange(@($DHCP_DNS_Strip_Menu_Item_Practice, $DHCP_DNS_Strip_Menu_Item_Practice_2))

$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button))

## Form dialogue
$Form.ShowDialog()
