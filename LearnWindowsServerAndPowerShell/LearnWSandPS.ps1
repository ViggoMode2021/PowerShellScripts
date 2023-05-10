Add-Type -assembly System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form

$main_form.Text ='GUI for my PoSh script'

$main_form.Width = 600

$main_form.Height = 400

$main_form.AutoSize = $true

$Label = New-Object System.Windows.Forms.Label

$Label.Text = "AD users"

$Label.Location  = New-Object System.Drawing.Point(0,10)

$Label.AutoSize = $true

$main_form.Controls.Add($Label)

$ComboBox = New-Object System.Windows.Forms.ComboBox

$ComboBox.Width = 300

$Topics = "DNS", "DHCP", "PowerShell", "ActiveDirectory"

Foreach ($Topic in $Topics)

{

$ComboBox.Items.Add($Topic);

}

$ComboBox.Location  = New-Object System.Drawing.Point(60,10)

$main_form.Controls.Add($ComboBox)

$main_form.ShowDialog()

#https://theitbros.com/powershell-gui-for-scripts/
