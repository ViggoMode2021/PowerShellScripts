#Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms

Add-Type -AssemblyName PresentationCore,PresentationFramework

$Date = Get-Date -format "MM/dd/yyyy"

#$Forest = Get-ADDomain -Current LocalComputer | Select-Object -expand Forest

#$Logged_In_User = whoami /upn

#$Logged_In_User = $Logged_In_User.Replace($Forest, '')

$Logged_In_User = 'rva' # $Logged_In_User.Replace("@", '')

$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$Form.Text = "EleetShell - Practice Windows Server and PowerShell! | No game score file currently selected"

$Menu_Bar = New-Object System.Windows.Forms.MenuStrip
$File_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$New_Game_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Load_Game_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$View_Score_And_Stats_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_Learn = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_Practice = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_2 = New-Object System.Windows.Forms.ToolStripMenuItem

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
$Input_Box.Name = "Input_Box"
$Input_Box.Location = New-Object System.Drawing.Point(380,250)
$Input_Box.Size = New-Object System.Drawing.Size(380,250)

$Menu_Bar.Items.AddRange(@(
$File_Menu_Item,
$Windows_General_Strip_Menu_Item,
$DHCP_DNS_Strip_Menu_Item,
$Windows_General_Strip_Menu_Item_Learn,
$Windows_General_Strip_Menu_Item_Practice))

## start File menu item ##

$File_Menu_Item.Name = "File_Menu_Item"
$File_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$File_Menu_Item.Text = "File"

$New_Game_Strip_Menu_Item.Name = "New_Game_Strip_Menu_Item"
$New_Game_Strip_Menu_Item.Size = New-Object System.Drawing.Size(152, 22)
$New_Game_Strip_Menu_Item.Text = "New Game"

$Load_Game_Strip_Menu_Item.Name = "Load_Game_Strip_Menu_Item"
$Load_Game_Strip_Menu_Item.Size = New-Object System.Drawing.Size(152, 22)
$Load_Game_Strip_Menu_Item.Text = "Load Game"

$View_Score_And_Stats_Strip_Menu_Item.Name= "View_Score_And_Stats_Strip_Menu_Item"
$View_Score_And_Stats_Strip_Menu_Item.Size = New-Object System.Drawing.Size(152, 22)
$View_Score_And_Stats_Strip_Menu_Item.Text = "View Score + Stats"

$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item, $Load_Game_Strip_Menu_Item))

function On_Click_New_Game_Strip_Menu_Item($Sender,$e){  

	$Form.Controls.RemoveByKey("The_Submit_Button")
	
    $MessageBoxTitle = "New game file creation"

    $MessageBoxBody = "By starting a new game, a new csv file will be created on your desktop to track your score. Continue?"

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeYesNoCancel,$MessageIconWarning)
	
	if($Confirmation -eq 'Yes'){
		
	[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') 
	$New_Game_Filename = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the filename', 'Enter the filename')

    $New_Game_Filename_Csv = "$New_Game_Filename.csv"
		
	#New-Item C:\Users\Administrator\desktop\$New_Game_Filename.csv -ItemType File

    $New_Game_File_CheckSum = Get-ChildItem "C:\Users\administrator\desktop" -recurse | Where {$_.name -match $New_Game_Filename_Csv} | select-object -ExpandProperty name

    if($New_Game_Filename_Csv -eq $New_Game_File_CheckSum){
		
	$Form.Controls.AddRange(@($Menu_Bar))
	
		## Fix This PArt!

    $MessageBoxTitle = "File creation error."

    $MessageBoxBody = "$New_Game_File_CheckSum already exists. Creating a file with the name $New_Game_Filename$Date.csv"

    $New_Game_File = New-Item C:\Users\administrator\desktop\$New_Game_Filename$Date.csv -ItemType File
	
	$New_Game_Filename_Csv_Rename = "$New_Game_Filename$Date.csv"

    $File = "$New_Game_File"
    $Data = Get-Content -Path $File
    $Header = "Problem,Result,Date,Points"
    Set-Content $File -Value $Header
    Add-Content -Path $File -Value $Data

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

    $global:Game_Score_File = "C:\Users\$Logged_In_User\desktop\$New_Game_Filename_Csv_Rename"

    $Form.Text = "EleetShell - Current score file: $New_Game_Filename_Csv_Rename"
	
	$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item, $Load_Game_Strip_Menu_Item, $View_Score_And_Stats_Strip_Menu_Item))

    }

    if($New_Game_Filename.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ne -1)

    {
		
	$Form.Controls.AddRange(@($Menu_Bar))

    $MessageBoxTitle = "File name contains invalid characters"

    $MessageBoxBody = "$New_Game_Filename contains invalid characters. Please try again."

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)
	
	Invoke-Expression On_Click_New_Game_Strip_Menu_Item
    
    }

    else{
		
	$Form.Controls.AddRange(@($Menu_Bar))

    $New_Game_File = New-Item C:\Users\$Logged_In_User\desktop\$New_Game_Filename_Csv -ItemType File

    $File = "$New_Game_File"
    $Data = Get-Content -Path $File
    $Header = "Problem,Result,Date,Points"
    Set-Content $File -Value $Header
    Add-Content -Path $File -Value $Data

    $MessageBoxTitle = "New game created with the scorecard filename $New_Game_Filename_Csv"

    $MessageBoxBody = "New game created with the scorecard filename $New_Game_Filename_Csv"

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconSuccess)

    $global:Game_Score_File = "C:\Users\$Logged_In_User\desktop\$New_Game_Filename_Csv"

    $Form.Text = "EleetShell - Current score file: $New_Game_Filename_Csv"
	
	$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item, $Load_Game_Strip_Menu_Item, $View_Score_And_Stats_Strip_Menu_Item))

    }

	}
}

function Dropdown_Problem_Completed_Check{

$Problem_Completed_Hostname = "hostname"
	
$Problem_Completed_Hostname = Select-String $Game_Score_File -Pattern $Problem_Completed_Hostname

if($Problem_Completed_Hostname -ne $null){
$Windows_General_Strip_Menu_Item_Learn.Text = 'Windows General #1'
$Windows_General_Strip_Menu_Item_Learn.ForeColor = 'Green'
} 

else{
	
$Windows_General_Strip_Menu_Item_Learn.Text = 'Windows General #1'
}

}

function On_Click_Load_Game_Strip_Menu_Item($Sender,$e){ 

$Form.Controls.AddRange(@($Menu_Bar))

Add-Type -AssemblyName System.Windows.Forms
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Title = "Please Select File"
$OpenFileDialog.InitialDirectory = $initialDirectory
$OpenFileDialog.filter = "(*.csv)|*.csv|SpreadSheet (*.xlsx)|*.xlsx'"
# Out-Null supresses the "OK" after selecting the file.
$OpenFileDialog.ShowDialog() | Out-Null

$CSV_Header_Check = (Get-Content $OpenFileDialog.FileName | Select-Object -First 1).Split($csvdelimiter)

if($CSV_Header_Check -ne "Problem,Result,Date,Points"){

$MessageBoxTitle = "Incompatible csv file"

$MessageBoxBody = "Selected CSV file is incompatible with EleetShell due to header mismatch. Please select appropriate CSV."

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconSuccess)

}

else{

$Global:Game_Score_File = $OpenFileDialog.FileName

$CSV_Filename = Split-Path $Game_Score_File -Leaf

$Form.Text = "EleetShell - Current score file: $CSV_Filename"

$CSV_Length = Import-CSV $Game_Score_File | Measure-Object | Select-Object -expand Count

$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item, $Load_Game_Strip_Menu_Item, $View_Score_And_Stats_Strip_Menu_Item))

Invoke-Expression Dropdown_Problem_Completed_Check

}
}

function On_Click_View_Score_And_Stats_Strip_Menu_Item{
	
$Form.Controls.RemoveByKey("The_Submit_Button")

$Form.Controls.RemoveByKey("Input_Box")

$Table_Data = Get-Content -Path $Game_Score_File | Format-Table | Out-String

$Body.Text = $Table_Data
	
}

$New_Game_Strip_Menu_Item.Add_Click( { On_Click_New_Game_Strip_Menu_Item $New_Game_Strip_Menu_Item $EventArgs} )

$Load_Game_Strip_Menu_Item.Add_Click( { On_Click_Load_Game_Strip_Menu_Item $Load_Game_Strip_Menu_Item $EventArgs} )

$View_Score_And_Stats_Strip_Menu_Item.Add_Click( { On_Click_View_Score_And_Stats_Strip_Menu_Item $View_Score_And_Stats_Strip_Menu_Item $EventArgs} )

## end File menu item ##

## start Windows General menu item ##

$Windows_General_Strip_Menu_Item.Name = "Windows_General_Strip_Menu_Item"
$Windows_General_Strip_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$Windows_General_Strip_Menu_Item.Text = "Windows General"

$Windows_General_Strip_Menu_Item_Learn.Name = "Windows_General_Strip_Menu_Item_Learn"
$Windows_General_Strip_Menu_Item_Learn.Size = New-Object System.Drawing.Size(152, 22)
$Windows_General_Strip_Menu_Item_Learn.Text = "Windows General #1"

## end Windows General menu item ##

$DHCP_DNS_Strip_Menu_Item.Name = "DHCP_DNS_Strip_Menu_Item"
$DHCP_DNS_Strip_Menu_Item.Size = New-Object System.Drawing.Size(51, 20)
$DHCP_DNS_Strip_Menu_Item.Text = "DHCP + DNS"

## Windows General #1 ##

$Windows_General_Strip_Menu_Item.DropDownItems.AddRange(@($Windows_General_Strip_Menu_Item_Learn))

function On_Click_Boot_Process_Strip_Menu_Item_Practice($Sender,$e){     
    $Title.Text= "Practice PowerShell for Windows environment"
	$Body.Text = ""
}

$Windows_General_Strip_Menu_Item_Practice.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Practice $Windows_General_Strip_Menu_Item_Practice $EventArgs} )

function On_Click_Boot_Process_Strip_Menu_Item_Learn($Sender,$e){

    $StopWatch = [system.diagnostics.stopwatch]::StartNew()
         
    $Title.Text= "Learn Windows environment"
	$Body.Text = "Using PowerShell, find the computer name (hostname) of this device."
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(420,300)

	$The_Submit_Button.Add_Click({Selected_Practice_Problem})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "hostname"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text= "Learn Windows environment (COMPLETED)" } 
	
	else {
	$Title.Text= "Learn Windows environment"
	}
}

function Selected_Practice_Problem{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell."){
	if($Input_Box.Text -eq "hostname"){

    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Correct, your answer was $Answer."

    $New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "Windows General #1" ; Result = "hostname" ; Date = $Date ; Points = "1"}
    
    $New_Results += $New_Row

    $New_Results | Export-csv -append $Game_Score_File

    }

	else{
		$Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell. Incorrect, your answer was $Answer."}
	}
}

$Windows_General_Strip_Menu_Item_Learn.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Learn $Windows_General_Strip_Menu_Item_Learn $EventArgs} )

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


<#


$Time = [System.Diagnostics.Stopwatch]::StartNew()
    $CurrentTime = $Time.Elapsed
    write-host $([string]::Format("`rTime: {0:d2}:{1:d2}:{2:d2}",
                                  $CurrentTime.hours,
                                  $CurrentTime.minutes,
                                  $CurrentTime.seconds)) -nonewline

                                  #>
