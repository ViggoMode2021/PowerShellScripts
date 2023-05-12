Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = 'CenterScreen'

$MenuBar = New-Object System.Windows.Forms.MenuStrip
$fileToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$editionToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$socialToolStripMenuItem  = New-Object System.Windows.Forms.ToolStripMenuItem
$YtToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem

$Form.Controls.Add($MenuBar)

$MenuBar.Items.AddRange(@(
$fileToolStripMenuItem,
$editionToolStripMenuItem,
$socialToolStripMenuItem))

$fileToolStripMenuItem.Name = "fileToolStripMenuItem"
$fileToolStripMenuItem.Size = New-Object System.Drawing.Size(35, 20)
$fileToolStripMenuItem.Text = "&File"

$editionToolStripMenuItem.Name = "editionToolStripMenuItem"
$editionToolStripMenuItem.Size = New-Object System.Drawing.Size(51, 20)
$editionToolStripMenuItem.Text = "&Edition"

$socialToolStripMenuItem.DropDownItems.AddRange(@($YtToolStripMenuItem))
$socialToolStripMenuItem.Name = "socialToolStripMenuItem"
$socialToolStripMenuItem.Size = New-Object System.Drawing.Size(67, 20)
$socialToolStripMenuItem.Text = "&Socials"

$YtToolStripMenuItem.Name = "YtToolStripMenuItem"
$YtToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 22)
$YtToolStripMenuItem.Text = "&YouTube"

function OnClick_YtToolStripMenuItem($Sender,$e){
    #powershell -w h -NoP -NonI -Exec Bypass Start-Process https://www.youtube.com"     
    [void][System.Windows.Forms.MessageBox]::Show("Subscribe to my youtube")
}
$YtToolStripMenuItem.Add_Click( { OnClick_YtToolStripMenuItem $YtToolStripMenuItem $EventArgs} )

$Form.ShowDialog()
