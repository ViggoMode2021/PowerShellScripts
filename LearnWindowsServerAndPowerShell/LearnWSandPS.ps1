#Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$Menu_Bar = New-Object System.Windows.Forms.MenuStrip
$Windows_General_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Learn= New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Practice= New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice= New-Object System.Windows.Forms.ToolStripMenuItem
$DHCP_DNS_Strip_Menu_Item_Practice_2= New-Object System.Windows.Forms.ToolStripMenuItem

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
$Windows_General_Strip_Menu_Item,
$DHCP_DNS_Strip_Menu_Item,
$Boot_Process_Strip_Menu_Item_Learn,
$Boot_Process_Strip_Menu_Item_Practice))

$Windows_General_Strip_Menu_Item.Name = "Windows_General_Strip_Menu_Item"
$Windows_General_Strip_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$Windows_General_Strip_Menu_Item.Text = "Windows General"

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

$Boot_Process_Strip_Menu_Item_Learn.Name = "Boot_Process_Strip_Menu_Item_Learn"
$Boot_Process_Strip_Menu_Item_Learn.Size = New-Object System.Drawing.Size(152, 22)
$Boot_Process_Strip_Menu_Item_Learn.Text = "Boot Process #1"

$Windows_General_Strip_Menu_Item.DropDownItems.AddRange(@($Boot_Process_Strip_Menu_Item_Learn))

function On_Click_Boot_Process_Strip_Menu_Item_Practice($Sender,$e){     
    $Title.Text= "Practice PowerShell for Windows boot process"
	$Body.Text = ""
}

$Boot_Process_Strip_Menu_Item_Practice.Add_Click( { On_Click_Boot_Process_Strip_Menu_Item_Practice $Boot_Process_Strip_Menu_Item_Practice $EventArgs} )

function On_Click_Boot_Process_Strip_Menu_Item_Learn($Sender,$e){     
    $Title.Text= "Learn Windows boot process"
	$Body.Text = "Find the last time that your Windows machine booted. Use PowerShell."
	$Form.Controls.AddRange(@($Menu_Bar, $Title, $Body, $The_Submit_Button, $Input_Box))
}

function Selected_Practice_Problem{

$Answer = @($Input_Box.Text)

Start-Process Powershell -ArgumentList "-NoExit -command ""& $Answer""" -Verb runAs

if ($Body.Text = "Find the computer name (hostname) of your Windows machine. Use PowerShell."){
	if($Input_Box.Text -eq "hostname"){
	Write-Host "Success"
    $Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Correct, your answer was $Answer." }
	else{
		$Body.Text = "Find the last time that your Windows machine booted. Use PowerShell. Incorrect, your answer was $Answer." }
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
