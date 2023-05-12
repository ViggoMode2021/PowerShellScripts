Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$Menu_Bar = New-Object System.Windows.Forms.MenuStrip
$Learn_Tool_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Practice_Tool_Strip_Menu_Item = New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Learn= New-Object System.Windows.Forms.ToolStripMenuItem
$Boot_Process_Strip_Menu_Item_Practice= New-Object System.Windows.Forms.ToolStripMenuItem

$Form.Controls.Add($Menu_Bar)

$Menu_Bar.Items.AddRange(@(
$Learn_Tool_Strip_Menu_Item,
$Practice_Tool_Strip_Menu_Item,
$Boot_Process_Strip_Menu_Item_Learn,
$Boot_Process_Strip_Menu_Item_Practice))

$Learn_Tool_Strip_Menu_Item.Name = "Learn_Tool_Strip_Menu_Item"
$Learn_Tool_Strip_Menu_Item.Size = New-Object System.Drawing.Size(35, 20)
$Learn_Tool_Strip_Menu_Item.Text = "Learn General"

$Practice_Tool_Strip_Menu_Item.Name = "Practice_Tool_Strip_Menu_Item"
$Practice_Tool_Strip_Menu_Item.Size = New-Object System.Drawing.Size(51, 20)
$Practice_Tool_Strip_Menu_Item.Text = "Practice General"

$Boot_Process_Strip_Menu_Item_Practice.Name = "Boot_Process_Strip_Menu_Item_Practice"
$Boot_Process_Strip_Menu_Item_Practice.Size = New-Object System.Drawing.Size(152, 22)
$Boot_Process_Strip_Menu_Item_Practice.Text = "Boot Process"

$Boot_Process_Strip_Menu_Item_Learn.Name = "Boot_Process_Strip_Menu_Item_Learn"
$Boot_Process_Strip_Menu_Item_Learn.Size = New-Object System.Drawing.Size(152, 22)
$Boot_Process_Strip_Menu_Item_Learn.Text = "Boot Process"

$Learn_Tool_Strip_Menu_Item.DropDownItems.AddRange(@($Boot_Process_Strip_Menu_Item_Learn))

$Practice_Tool_Strip_Menu_Item.DropDownItems.AddRange(@($Boot_Process_Strip_Menu_Item_Practice))

function On_Click_DC_Tool_Strip_Menu_Item_Practice($Sender,$e){     
    [void][System.Windows.Forms.MessageBox]::Show("Subscribe to my youtube")
}

$Boot_Process_Strip_Menu_Item.Add_Click( { On_Click_DC_Tool_Strip_Menu_Item_Practice $Boot_Process_Strip_Menu_Item_Practice $EventArgs} )

function On_Click_DC_Tool_Strip_Menu_Item_Learn($Sender,$e){     
    [void][System.Windows.Forms.MessageBox]::Show("Subscribe to my youtube")
}

$Boot_Process_Strip_Menu_Item_Learn.Add_Click( { On_Click_DC_Tool_Strip_Menu_Item_Learn $Boot_Process_Strip_Menu_Item_Learn $EventArgs} )

$Form.ShowDialog()
