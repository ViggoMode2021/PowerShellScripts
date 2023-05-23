Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms

Add-Type -AssemblyName PresentationCore,PresentationFramework
`
$Date = Get-Date -format "MMddyy"

$Forest = Get-ADDomain -Current LocalComputer | Select-Object -expand Forest

$Logged_In_User = whoami /upn

$Logged_In_User = $Logged_In_User.Replace($Forest, '')

$Logged_In_User = $Logged_In_User.Replace("@", '')

$global:Game_Score_File = $null

<#
$Recent_Score_File = Get-ChildItem C:\Users\$Logged_In_User\desktop\ -File | Sort-Object LastWriteTime -Descending| Select-Object -First 1

Write-Host $Recent_Score_File

$CSV_Header_Check = (Get-Content $Recent_Score_File | Select-Object -First 1).Split($csvdelimiter)

Write-Host $CSV_Header_Check
#>

$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$Form.Text = "EleetShell - Practice Windows Server and PowerShell! | No game score file currently selected"

$Form.ForeColor = "Black"

$Form.Font = 'Verdana,11,style=Bold'

$Menu_Bar = New-Object System.Windows.Forms.MenuStrip
$File_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$New_Game_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Load_Game_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$View_Score_And_Stats_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_Server_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_Learn = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_Practice = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_2 = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_3 = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_4 = New-Object System.Windows.Forms.ToolStripMenuItem
$Windows_General_Strip_Menu_Item_5 = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_2 = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_3 = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_4 = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_5 = New-Object System.Windows.Forms.ToolStripMenuItem

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

$Title.Location = New-Object System.Drawing.Point(30,40)

$Body = New-Object $Label_Object

$Body.Text= ""

$Body.AutoSize = $true

$Body.Font = 'Verdana,11,style=Bold'

$Body.Location = New-Object System.Drawing.Point(30,80)

$Total_Number_Of_Answers_Label = New-Object $Label_Object

$Total_Number_Of_Answers_Label.Text = ""

$Total_Number_Of_Answers_Label.AutoSize = $true

$Total_Number_Of_Answers_Label.Font = 'Calibri,12,style=Bold'

$Total_Number_Of_Answers_Label.ForeColor = 'Blue'

$Total_Number_Of_Answers_Label.Location = New-Object System.Drawing.Point(800,600)

$Input_Box = New-Object System.Windows.Forms.TextBox
$Input_Box.Name = "Input_Box"
$Input_Box.Location = New-Object System.Drawing.Point(30,150)
$Input_Box.Size = New-Object System.Drawing.Size(380,1000)

$Menu_Bar.Items.AddRange(@(
$File_Menu_Item,
$Windows_General_Strip_Menu_Item,
$Windows_Server_Strip_Menu_Item,
$DHCP_DNS_Strip_Menu_Item,
$Windows_General_Strip_Menu_Item_Learn,
$Windows_General_Strip_Menu_Item_Practice,
$Windows_General_Strip_Menu_Item_2,
$Windows_General_Strip_Menu_Item_3,
$Windows_General_Strip_Menu_Item_4))

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
	
	if ($New_Game_Filename -eq ""){
		
	$MessageBoxTitle = "Please name your file."

    $MessageBoxBody = "Filename cannot be null. Please name your score file."

    $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconWarning)
	
	Invoke-Expression On_Click_New_Game_Strip_Menu_Item
	
	}
	
	else{	

    $New_Game_Filename_Csv = "$New_Game_Filename.csv"

    $New_Game_File_CheckSum = Get-ChildItem "C:\Users\administrator\desktop" -recurse | Where {$_.name -match $New_Game_Filename_Csv} | select-object -ExpandProperty name

    if($New_Game_Filename_Csv -eq $New_Game_File_CheckSum){
		
	$Form.Controls.AddRange(@($Menu_Bar))
	
		## Fix This Part!

    $MessageBoxTitle = "File creation error."

    $MessageBoxBody = "$New_Game_File_CheckSum already exists. Please try again."
	
    $New_Game_File = New-Item C:\Users\administrator\desktop\$New_Game_Filename$Date.csv -ItemType File
	
	$New_Game_Filename_Csv_Rename = "$New_Game_Filename$Date.csv"

    $File = "$New_Game_File"
    $Data = Get-Content -Path $File
    $Header = "Problem,Result,Date,CompletionTime,Points"
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
    $Header = "Problem,Result,Date,CompletionTime,Points"
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
}

function Dropdown_Problem_Completed_Check{
	
$Timer_Start_Time.Stop()

$Problem_Completed_Hostname = "hostname"
	
$Problem_Completed_Hostname = Select-String $Game_Score_File -Pattern $Problem_Completed_Hostname

if($Problem_Completed_Hostname -ne $null){
$Windows_General_Strip_Menu_Item_Learn.Text = 'Windows General #1 (hostname)'
$Windows_General_Strip_Menu_Item_Learn.ForeColor = 'Green'
} 

else{
	
$Windows_General_Strip_Menu_Item_Learn.Text = 'Windows General #1 (hostname)'
$Windows_General_Strip_Menu_Item_Learn.ForeColor = 'Blue'
}

$Problem_Completed_Uptime = "systeminfo | find 'Boot Time'"
	
$Problem_Completed_Uptime = Select-String $Game_Score_File -Pattern $Problem_Completed_Uptime
	
if($Problem_Completed_Uptime -ne $null){
$Windows_General_Strip_Menu_Item_2.Text = 'Windows General #2 (uptime)'
$Windows_General_Strip_Menu_Item_2.ForeColor = 'Green'
}

else{
	
$Windows_General_Strip_Menu_Item_2.Text = 'Windows General #2 (uptime)'
$Windows_General_Strip_Menu_Item_2.ForeColor = 'Blue'

}

$Problem_Completed_Env = "dir env:"
	
$Problem_Completed_Env = Select-String $Game_Score_File -Pattern $Problem_Completed_Env
	
if($Problem_Completed_Env -ne $null){
$Windows_General_Strip_Menu_Item_3.Text = 'Windows General #3 (env)'
$Windows_General_Strip_Menu_Item_3.ForeColor = 'Green'
} 

else{
	
$Windows_General_Strip_Menu_Item_3.Text = 'Windows General #3 (env)'
$Windows_General_Strip_Menu_Item_3.ForeColor = 'Blue'

}

$Problem_Completed_Cpu = "Get-Process | Where-Object { $_.CPU -gt 20 }"
	
$Problem_Completed_Cpu = Select-String $Game_Score_File -Pattern $Problem_Completed_Cpu

if($Problem_Completed_Cpu -ne $null){
$Windows_General_Strip_Menu_Item_4.Text = 'Windows General #4 (cpu)'
$Windows_General_Strip_Menu_Item_4.ForeColor = 'Green'
} 

else{
	
$Windows_General_Strip_Menu_Item_4.Text = 'Windows General #4 (cpu)'
$Windows_General_Strip_Menu_Item_4.ForeColor = 'Blue'

}

$Problem_Completed_DHCP = "Add-DhcpServerInDC -DNSName dhcp-practice -IPAddress 172.16.0.50"
	
$Problem_Completed_DHCP = Select-String $Game_Score_File -Pattern $Problem_Completed_DHCP

if($Problem_Completed_DHCP -ne $null){
$DHCP_DNS_Strip_Menu_Item_Practice.Text = 'DHCP #1 (server)'
$DHCP_DNS_Strip_Menu_Item_Practice.ForeColor = 'Green'
} 

else{
	
$DHCP_DNS_Strip_Menu_Item_Practice.Text = 'DHCP #1 (server)'
$DHCP_DNS_Strip_Menu_Item_Practice.ForeColor = 'Blue'

}

$Problem_Completed_DHCP_2 = "Add-DhcpServerV4Scope -name 'test' -StartRange 172.16.0.100 -Endrange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active"
	
$Problem_Completed_DHCP_2 = Select-String $Game_Score_File -Pattern $Problem_Completed_DHCP_2

if($Problem_Completed_DHCP_2 -ne $null){
$DHCP_DNS_Strip_Menu_Item_Practice_2.Text = 'DHCP #2 (scope)'
$DHCP_DNS_Strip_Menu_Item_Practice_2.ForeColor = 'Green'
} 

else{
	
$DHCP_DNS_Strip_Menu_Item_Practice_2.Text = 'DHCP #2 (scope)'
$DHCP_DNS_Strip_Menu_Item_Practice_2.ForeColor = 'Blue'

}

$Problem_Completed_DNS_1 = "Get-WindowsFeature -Name"
	
$Problem_Completed_DNS_1 = Select-String $Game_Score_File -Pattern $Problem_Completed_DNS_1

if($Problem_Completed_DNS_1 -ne $null){
	
$DHCP_DNS_Strip_Menu_Item_Practice_3.Text = 'DNS #1 (check install)'
$DHCP_DNS_Strip_Menu_Item_Practice_3.ForeColor = 'Green'
} 

else{
	
$DHCP_DNS_Strip_Menu_Item_Practice_3.Text = 'DNS #1 (check install)'
$DHCP_DNS_Strip_Menu_Item_Practice_3.ForeColor = 'Blue'

}

$Problem_Completed_DNS_2 = "Install-WindowsFeature -Name DNS -IncludeManagementTools"
	
$Problem_Completed_DNS_2 = Select-String $Game_Score_File -Pattern $Problem_Completed_DNS_2

if($Problem_Completed_DNS_2 -ne $null){
$DHCP_DNS_Strip_Menu_Item_Practice_4.Text = 'DNS #2 (install DNS)'
$DHCP_DNS_Strip_Menu_Item_Practice_4.ForeColor = 'Green'
} 

else{
	
$DHCP_DNS_Strip_Menu_Item_Practice_4.Text = 'DNS #2 (install DNS)'
$DHCP_DNS_Strip_Menu_Item_Practice_4.ForeColor = 'Blue'

}

$Problem_Completed_DNS_3 = "Add-DnsServerPrimaryZone -Name Eliteshell.org -Zonefile Eliteshell.org.DNS -DynamicUpdate NonsecureAndSecure"

$Problem_Completed_DNS_3 = Select-String $Game_Score_File -Pattern $Problem_Completed_DNS_3

if($Problem_Completed_DNS_3 -ne $null){
$DHCP_DNS_Strip_Menu_Item_Practice_5.Text = 'DNS #3 (forward lookup zone)'
$DHCP_DNS_Strip_Menu_Item_Practice_5.ForeColor = 'Green'
} 

else{
	
$DHCP_DNS_Strip_Menu_Item_Practice_5.Text = 'DNS #3 (forward lookup zone)'
$DHCP_DNS_Strip_Menu_Item_Practice_5.ForeColor = 'Blue'

}

}

function On_Click_Load_Game_Strip_Menu_Item($Sender,$e){ 

$Timer_Start_Time.Stop()

$Form.Controls.AddRange(@($Menu_Bar))

Add-Type -AssemblyName System.Windows.Forms
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.Title = "Please Select File"
$OpenFileDialog.InitialDirectory = $initialDirectory
$OpenFileDialog.filter = "(*.csv)|*.csv|SpreadSheet (*.xlsx)|*.xlsx'"

$OpenFileDialog.ShowDialog() | Out-Null

$CSV_Header_Check = (Get-Content $OpenFileDialog.FileName | Select-Object -First 1).Split($csvdelimiter)

if($CSV_Header_Check -ne "Problem,Result,Date,CompletionTime,Points"){ 
 
$MessageBoxTitle = "Incompatible csv file"

$MessageBoxBody = "Selected CSV file is incompatible with EleetShell due to header mismatch. Please select appropriate CSV."

$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconSuccess)

}

else{

$global:Game_Score_File = $OpenFileDialog.FileName

$CSV_Filename = Split-Path $Game_Score_File -Leaf

$Form.Text = "EleetShell - Current score file: $CSV_Filename"

$CSV_Length = Import-CSV $Game_Score_File | Measure-Object | Select-Object -expand Count

$global:Number_Of_Correct_Answers = $CSV_Length

$Total_Number_Of_Answers_Label.Text = "$Number_Of_Correct_Answers correct answers"

$File_Menu_Item.DropDownItems.AddRange(@($New_Game_Strip_Menu_Item, $Load_Game_Strip_Menu_Item, $View_Score_And_Stats_Strip_Menu_Item))

Invoke-Expression Dropdown_Problem_Completed_Check

}
}

function On_Click_View_Score_And_Stats_Strip_Menu_Item{
	
$Timer_Start_Time.Stop()
	
$Table_Data = Import-CSV -Path $Game_Score_File | Out-GridView 

$Total_Number_Of_Answers_Label.Text = "$Number_Of_Correct_Answers correct answers"

$CSV_Stuff = Import-CSV -Path $Game_Score_File

$CSV_Length = Import-CSV $Game_Score_File | Measure-Object | Select-Object -expand Count

#$Points = $CSV_Stuff | Select -ExpandProperty Points

foreach ($Points in $CSV_Stuff.Points) {
	
	$Total = $Points + $Points
	
	Write-Host $Total

}

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
$Windows_General_Strip_Menu_Item_Learn.Text = "Windows General #1 (hostname)"

$Windows_General_Strip_Menu_Item_2.Name = "Windows_General_Strip_Menu_Item_2"
$Windows_General_Strip_Menu_Item_2.Size = New-Object System.Drawing.Size(152, 22)
$Windows_General_Strip_Menu_Item_2.Text = "Windows General #2 (uptime)"

$Windows_General_Strip_Menu_Item_3.Name = "Windows_General_Strip_Menu_Item_3"
$Windows_General_Strip_Menu_Item_3.Size = New-Object System.Drawing.Size(152, 22)
$Windows_General_Strip_Menu_Item_3.Text = "Windows General #3 (env vars)"

$Windows_General_Strip_Menu_Item_4.Name = "Windows_General_Strip_Menu_Item_4"
$Windows_General_Strip_Menu_Item_4.Size = New-Object System.Drawing.Size(152, 22)
$Windows_General_Strip_Menu_Item_4.Text = "Windows General #4 (cpu)"

$Windows_General_Strip_Menu_Item.DropDownItems.AddRange(@($Windows_General_Strip_Menu_Item_Learn, $Windows_General_Strip_Menu_Item_2, $Windows_General_Strip_Menu_Item_3
$Windows_General_Strip_Menu_Item_4))

## end Windows General menu item ##

## Windows General #1 ##

function On_Click_Boot_Process_Strip_Menu_Item_Practice($Sender,$e){     
    $Title.Text= "Practice PowerShell for Windows environment"
	$Body.Text = ""
}

$Windows_General_Strip_Menu_Item_Practice.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Practice $Windows_General_Strip_Menu_Item_Practice $EventArgs} )

function On_Click_Boot_Process_Strip_Menu_Item_Learn($Sender,$e){
	
	$Timer_Start_Time.Stop()

    $Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text = "Windows General #!"
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Using PowerShell, find the computer name (hostname) of this device."
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_Practice_Problem})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "hostname"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "Windows General #1 (COMPLETED)"
	$Title.ForeColor = 'Green'} 
	
	else {
		
	$Title.Text = "Windows General #1"
	
	}
}

function Selected_Practice_Problem{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell."){
	if($Input_Box.Text -eq "hostname"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "Windows General #1" ; Result = "hostname" ; CompletionTime = $Timer ; Date = $Date ; Points = "1"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Correct, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)


	else{
		$Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell."}
	} 
}

}

## Windows General #2 ##

function On_Click_Uptime_Strip_Menu_Item($Sender,$e){
	
	$Timer_Start_Time.Stop()

    $Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text = "Windows General #2"
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Using PowerShell, find the uptime of this device. Note, use the 'systeminfo' command and a | (pipe)."
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_Windows_General_Problem_2})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "systeminfo | find 'Boot Time'"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "Windows General #2 (COMPLETED)"
	$Title.ForeColor = 'Green'} 
	
	else {
		
	$Title.Text = "Windows General #2"
	
	}
}

function Selected_Windows_General_Problem_2{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Using PowerShell, find the uptime of this device. Note, use the 'systeminfo' command and a | (pipe). Make sure there is proper spacing on  both sides of |"){
	if($Input_Box.Text -eq "systeminfo | find 'Boot Time'"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "Windows General #2" ; Result = "systeminfo | find 'Boot Time'" ; CompletionTime = $Timer ; Date = $Date ; Points = "2"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Using PowerShell, find the uptime of this device. Note, use the 'systeminfo' command and a | (pipe). `nCorrect, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)


	else{
		$Body.Text = "Using PowerShell, find the uptime of this device. Note, use the 'systeminfo' command and a | (pipe)."}
	} 
}

}

## Windows General #3 ##

function On_Click_Env_Strip_Menu_Item($Sender,$e){
	
	$Timer_Start_Time.Stop()

    $Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text = "Windows General #3"
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Using PowerShell, find the environment variables on this system using a command `nthat has two different three letter words and a :"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_Windows_General_Problem_3})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "dir env:"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "Windows General #3 (COMPLETED)"
	$Title.ForeColor = 'Green'} 
	
	else {
		
	$Title.Text = "Windows General #3"
	
	}
}

function Selected_Windows_General_Problem_3{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Using PowerShell, find the environment variables on this system using a command `nthat has two different three letter words and a :"){
	if($Input_Box.Text -eq "dir env:"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "Windows General #3" ; Result = "dir env:" ; CompletionTime = $Timer ; Date = $Date ; Points = "2"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Using PowerShell, find the environment variables on this system using a command `nthat has two different three letter words and a : `nCorrect, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)


	else{
		$Body.Text = "Using PowerShell, find the environment variables on this system using a command `nthat has two different three letter words and a :."}
	} 
}

}

## Windows General #4 ##

function On_Click_Cpu_Strip_Menu_Item($Sender,$e){
	
	$Timer_Start_Time.Stop()

    $Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text = "Windows General #4"
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Using PowerShell, find the processes on this machine where the cpu consumption is greater than 20%. `nNote: Use Get-Process and Where-Object separated by a |"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_Windows_General_Problem_4})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Get-Process | Where-Object { $_.CPU -gt 20 }"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "Windows General #4 (COMPLETED)"
	$Title.ForeColor = 'Green'} 
	
	else {
		
	$Title.Text = "Windows General #4"
	
	}
}

function Selected_Windows_General_Problem_4{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Using PowerShell, find the processes on this machine where the cpu consumption is greater than 20%. `nNote: Use Get-Process and Where-Object separated by a |"){
	
	$CPU = 'Get-Process | Where-Object { $_.CPU -gt 20 }'
	
	if($Input_Box.Text -eq $CPU){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "Windows General #4" ; Result = "Get-Process | Where-Object { $_.CPU -gt 20 }" ; CompletionTime = $Timer ; Date = $Date ; Points = "3"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Using PowerShell, find the processes on this machine where the cpu consumption is greater than 20%. `nNote: Use Get-Process and Where-Object separated by a | `n`n`n`n`nCorrect, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)


	else{
		$Body.Text = "Using PowerShell, find the processes on this machine where the cpu consumption is greater than 20%. `nNote: Use Get-Process and Where-Object separated by a |"}
	} 
}

}

$Windows_General_Strip_Menu_Item_Learn.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Learn $Windows_General_Strip_Menu_Item_Learn $EventArgs} )

$Windows_General_Strip_Menu_Item_2.Add_Click( { On_Click_Uptime_Strip_Menu_Item $Windows_General_Strip_Menu_Item_2 $EventArgs} )

$Windows_General_Strip_Menu_Item_3.Add_Click( { On_Click_Env_Strip_Menu_Item $Windows_General_Strip_Menu_Item_3 $EventArgs} )

$Windows_General_Strip_Menu_Item_4.Add_Click( { On_Click_Cpu_Strip_Menu_Item $Windows_General_Strip_Menu_Item_4 $EventArgs} )

## DHCP & DNS #1 (check install) ##

$DHCP_DNS_Strip_Menu_Item.Name = "DHCP_DNS_Strip_Menu_Item"
$DHCP_DNS_Strip_Menu_Item.Size = New-Object System.Drawing.Size(51, 20)
$DHCP_DNS_Strip_Menu_Item.Text = "DHCP + DNS"

$DHCP_DNS_Strip_Menu_Item_Practice.Name = "DHCP_DNS_Strip_Menu_Item_Practice"
$DHCP_DNS_Strip_Menu_Item_Practice.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice.Text = "DHCP #1 (server)"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice($Sender,$e){ 
	
	$Timer_Start_Time.Stop()

    $Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text= "DHCP #1"
	
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Create a DHCP server in the Domain controller named dhcp-practice with an IP address of 172.16.0.50"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_DHCP_DNS_Practice_Problem})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Add-DhcpServerInDC -DNSName dhcp-practice -IPAddress 172.16.0.50"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "DHCP #1 (COMPLETED)"
	$Title.ForeColor = 'Green'} 
	
	else {
		
	$Title.Text = "DHCP #1"
	
	}
}

function Selected_DHCP_DNS_Practice_Problem{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Create a DHCP server in the Domain controller named dhcp-practice with an IP address of 172.16.0.50"){
	if($Input_Box.Text -eq "Add-DhcpServerInDC -DNSName dhcp-practice -IPAddress 172.16.0.50"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "DHCP #1" ; Result = "Add-DhcpServerInDC -DNSName dhcp-practice -IPAddress 172.16.0.50" ; CompletionTime = $Timer ; Date = $Date ; Points = "5"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Create a DHCP server in the Domain controller named dhcp-practice with an IP address of 172.16.0.50. Correct, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
	$MessageBoxTitle = "Null input box"

	$MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 
	$Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError) }

	else{
		$Body.Text = "Create a DHCP server in the Domain controller named dhcp-practice with an IP address of 172.16.0.50. Incorrect, your answer was $Answer."}
	}
}

## DHCP & DNS #2 (install DNS) ##

$DHCP_DNS_Strip_Menu_Item_Practice_2.Name = "DHCP_DNS_Strip_Menu_Item_Practice_2"
$DHCP_DNS_Strip_Menu_Item_Practice_2.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice_2.Text = "DHCP #2 (scope)"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice_2($Sender,$e){

	$Timer_Start_Time.Stop()
	
	$Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text= "DHCP #2"
	
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Create an active IPv4 DHCP scope named 'test' with a start range of 172.16.0.100, `nend range of 172.16.0.200 and subnet mask of 255.255.255.0"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_DHCP_DNS_Practice_Problem_2})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Add-DhcpServerV4Scope -name 'test' -StartRange 172.16.0.100 -Endrange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "DHCP #2 (COMPLETED)" ## Fix this!
	$Title.ForeColor = 'Green' } 
	
	else {
		
	$Title.Text = "DHCP #2"
	
	}

}

function Selected_DHCP_DNS_Practice_Problem_2{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Create an active IPv4 DHCP scope named 'test' with a start range of 172.16.0.100, `nend range of 172.16.0.200 and subnet mask of 255.255.255.0"){
	if($Input_Box.Text -eq "Add-DhcpServerV4Scope -name 'test' -StartRange 172.16.0.100 -Endrange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "DHCP #2" ; Result = "Add-DhcpServerV4Scope -name 'test' -StartRange 172.16.0.100 -Endrange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active" ; CompletionTime = $Timer ; Date = $Date ; Points = "5"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Create a DHCP scope in the Domain controller named dhcp-practice with an IP address of 172.16.0.50. Correct, your answer was $Answer."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

	else{
		$Body.Text = "Create an active IPv4 DHCP scope named 'test' with a start range of 172.16.0.100, end range of 172.16.0.200 and subnet mask of 255.255.255.0Incorrect, your answer was $Answer."}
	}
}

}

## DHCP & DNS #3 (forward lookup zone) ##

$DHCP_DNS_Strip_Menu_Item_Practice_3.Name = "DHCP_DNS_Strip_Menu_Item_Practice_3"
$DHCP_DNS_Strip_Menu_Item_Practice_3.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice_3.Text = "DNS #1 (check install)"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice_3($Sender,$e){

	$Timer_Start_Time.Stop()
	
	$Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text = "DNS #1 (check install)"
	
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Check if DNS is installed on this system."
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_DHCP_DNS_Practice_Problem_3})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Get-WindowsFeature -Name *DNS*"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "DNS #1 (check install) (COMPLETED)"
	$Title.ForeColor = 'Green'} ## Fix this!
	
	else {
		
	$Title.Text = "DNS #1 (check install)"
	
	}
	
}

function Selected_DHCP_DNS_Practice_Problem_3{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Check if DNS is installed on this system."){
	if($Input_Box.Text -eq "Get-WindowsFeature -Name *DNS*"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "DNS #1 (check install)" ; Result = "Get-WindowsFeature -Name *DNS*" ; CompletionTime = $Timer ; Date = $Date ; Points = "1"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Check if DNS is installed on this system."

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

	else{
		$Body.Text = "Check if DNS is installed on this system. Incorrect, your answer was $Answer."}
	}
}

}

## DHCP & DNS #4 ##

$DHCP_DNS_Strip_Menu_Item_Practice_4.Name = "DHCP_DNS_Strip_Menu_Item_Practice_4"
$DHCP_DNS_Strip_Menu_Item_Practice_4.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice_4.Text = "DNS #2 (install DNS)"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice_4($Sender,$e){

	$Timer_Start_Time.Stop()
	
	$Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text= "DNS #1 (check install)"
	
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Install DNS and management tools on this system"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_DHCP_DNS_Practice_Problem_4})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Install-WindowsFeature -Name DNS -IncludeManagementTools"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "DNS #2 (install DNS) (COMPLETED)"
	$Title.ForeColor = 'Green'} ## Fix this!
	
	else {
		
	$Title.Text = "DNS #2 (install DNS)"
	
	}
}

function Selected_DHCP_DNS_Practice_Problem_4{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Install DNS and management tools on this system"){
	if($Input_Box.Text -eq "Install-WindowsFeature -Name DNS -IncludeManagementTools"){
		
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "DNS #2 (install DNS)" ; Result = "Install-WindowsFeature -Name DNS -IncludeManagementTools" ; CompletionTime = $Timer ; Date = $Date ; Points = "1"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Install-WindowsFeature -Name DNS -IncludeManagementTools"

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

	else{
		$Body.Text = "Install-WindowsFeature -Name DNS -IncludeManagementTools Incorrect, your answer was $Answer."}
	}
}

}

## DHCP & DNS #5 ##

$DHCP_DNS_Strip_Menu_Item_Practice_5.Name = "DHCP_DNS_Strip_Menu_Item_Practice_5"
$DHCP_DNS_Strip_Menu_Item_Practice_5.Size = New-Object System.Drawing.Size(152, 22)
$DHCP_DNS_Strip_Menu_Item_Practice_5.Text = "DNS #3 (forward lookup zone)"

function On_Click_DHCP_DNS_Strip_Menu_Item_Practice_5($Sender,$e){

	$Timer_Start_Time.Stop()
	
	$Timer = [System.Diagnostics.Stopwatch]::StartNew()
	
	$global:Timer_Start_Time = $Timer
	
    $Title.Text= "DNS #3 (forward lookup zone)"
	
	$Title.ForeColor = 'Blue'
	
	$Body.Text = "Add a forward lookup zone with DynamicUpdate for Eliteshell.org `nwith secure and nonsecure dynamic updates"
	
	$The_Submit_Button = New-Object System.Windows.Forms.Button
	
	$The_Submit_Button.Name = "The_Submit_Button"

	$The_Submit_Button.Text = "Submit"

	$The_Submit_Button.AutoSize = $True

	$The_Submit_Button.Font = 'Verdana,12,style=Bold'

	$The_Submit_Button.ForeColor = 'Blue'

	$The_Submit_Button.Location = New-Object System.Drawing.Point(30,200)

	$The_Submit_Button.Add_Click({Selected_DHCP_DNS_Practice_Problem_5})
	
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
	
	$Problem_Completed = "Add-DnsServerPrimaryZone -Name Eliteshell.org -Zonefile Eliteshell.org.DNS -DynamicUpdate NonsecureAndSecure"
	
	$Problem_Completed_Check = Select-String $Game_Score_File -Pattern $Problem_Completed
	
	if($Problem_Completed_Check -ne $null) {
	$Title.Text = "DNS #3 (forward lookup zone) (COMPLETED)"
	$Title.ForeColor = 'Green'} ## Fix this!
	
	else {
		
	$Title.Text = "DNS #3 (forward lookup zone)"
	
	}
}

function Selected_DHCP_DNS_Practice_Problem_5{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Add a forward lookup zone with DynamicUpdate for Eliteshell.org `nwith secure and nonsecure dynamic updates"){

	if($Input_Box.Text -eq "Add-DnsServerPrimaryZone -Name Eliteshell.org -Zonefile Eliteshell.org.DNS -DynamicUpdate NonsecureAndSecure"){
	
	$Time_Elapsed = $Timer_Start_Time.Elapsed

	$Timer = $([string]::Format("`{0:d2}:{1:d2}:{2:d2}",
	$Time_Elapsed.hours,
	$Time_Elapsed.minutes,
	$Time_Elapsed.seconds))
	
	$New_Row | Add-Content -Path $Game_Score_File

    $New_Row = New-Object PsObject -Property @{Problem = "DNS #3 (forward lookup zone)" ; Result = "Add-DnsServerPrimaryZone -Name Eliteshell.org -Zonefile Eliteshell.org.DNS -DynamicUpdate NonsecureAndSecure" ; CompletionTime = $Timer ; Date = $Date ; Points = "4"}
	
    $New_Results += $New_Row

    $New_Results | Export-CSV -append $Game_Score_File
	
	$Timer.Stop
	
    Invoke-Expression Dropdown_Problem_Completed_Check

    $Body.Text = "Add a forward lookup zone with DynamicUpdate for Eliteshell.org `nwith secure and nonsecure dynamic updates"

    }
	
	if($Input_Box.Text -eq ""){
		
		 $MessageBoxTitle = "Null input box"

		 $MessageBoxBody = "Input box is null. Please type an answer to see if it is correct."
		 
		 $Confirmation = [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$ButtonTypeOk,$MessageIconError)

	else{
		$Body.Text = "Add a forward lookup zone with DynamicUpdate for Eliteshell.org `nwith secure and nonsecure dynamic updatesIncorrect, your answer was $Answer."}
	}
}

}

$DHCP_DNS_Strip_Menu_Item_Practice.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice $DHCP_DNS_Strip_Menu_Item_Practice $EventArgs} )

$DHCP_DNS_Strip_Menu_Item_Practice_2.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice_2 $DHCP_DNS_Strip_Menu_Item_Practice_2 $EventArgs} )

$DHCP_DNS_Strip_Menu_Item_Practice_3.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice_3 $DHCP_DNS_Strip_Menu_Item_Practice_3 $EventArgs} )

$DHCP_DNS_Strip_Menu_Item_Practice_4.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice_4 $DHCP_DNS_Strip_Menu_Item_Practice_4 $EventArgs} )

$DHCP_DNS_Strip_Menu_Item_Practice_5.Add_Click( { On_Click_DHCP_DNS_Strip_Menu_Item_Practice_5 $DHCP_DNS_Strip_Menu_Item_Practice_5 $EventArgs} )

$DHCP_DNS_Strip_Menu_Item.DropDownItems.AddRange(@($DHCP_DNS_Strip_Menu_Item_Practice, $DHCP_DNS_Strip_Menu_Item_Practice_2, $DHCP_DNS_Strip_Menu_Item_Practice_3, $DHCP_DNS_Strip_Menu_Item_Practice_4, $DHCP_DNS_Strip_Menu_Item_Practice_5))

## Windows Server ##

$Windows_Server_Strip_Menu_Item.Name = "Windows_Server_Strip_Menu_Item"
$Windows_Server_Strip_Menu_Item.Size = New-Object System.Drawing.Size(51, 20)
$Windows_Server_Strip_Menu_Item.Text = "Windows Server"

$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Total_Number_Of_Answers_Label))

## Form dialogue
$Form.ShowDialog()
