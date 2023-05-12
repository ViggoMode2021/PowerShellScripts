Add-Type -AssemblyName System.Windows.Forms
$form=New-Object System.Windows.Forms.Form
$form.StartPosition='CenterScreen'

$MenuBar = New-Object System.Windows.Forms.MenuStrip
$fileToolStripMenuItem        = new-object System.Windows.Forms.ToolStripMenuItem
$editionToolStripMenuItem     = new-object System.Windows.Forms.ToolStripMenuItem
$socialToolStripMenuItem      = new-object System.Windows.Forms.ToolStripMenuItem
$YtToolStripMenuItem      = new-object System.Windows.Forms.ToolStripMenuItem

$Form.Controls.Add($MenuBar)

$MenuBar.Items.AddRange(@(
$fileToolStripMenuItem,
$editionToolStripMenuItem,
$socialToolStripMenuItem))

$fileToolStripMenuItem.Name = "fileToolStripMenuItem"
$fileToolStripMenuItem.Size = new-object System.Drawing.Size(35, 20)
$fileToolStripMenuItem.Text = "&File"

$editionToolStripMenuItem.Name = "editionToolStripMenuItem"
$editionToolStripMenuItem.Size = new-object System.Drawing.Size(51, 20)
$editionToolStripMenuItem.Text = "&Edition"

$socialToolStripMenuItem.DropDownItems.AddRange(@($YtToolStripMenuItem))
$socialToolStripMenuItem.Name = "socialToolStripMenuItem"
$socialToolStripMenuItem.Size = new-object System.Drawing.Size(67, 20)
$socialToolStripMenuItem.Text = "&Socials"

$YtToolStripMenuItem.Name = "YtToolStripMenuItem"
$YtToolStripMenuItem.Size = new-object System.Drawing.Size(152, 22)
$YtToolStripMenuItem.Text = "&YouTube"

function OnClick_YtToolStripMenuItem($Sender,$e){
    #powershell -w h -NoP -NonI -Exec Bypass Start-Process https://www.youtube.com"     
    [void][System.Windows.Forms.MessageBox]::Show("Subscribe to my youtube")
}
$YtToolStripMenuItem.Add_Click( { OnClick_YtToolStripMenuItem $YtToolStripMenuItem $EventArgs} )

$form.ShowDialog()
