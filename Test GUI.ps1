[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)

$Form = New-Object System.Windows.Forms.Form
$Form.Text ="Hello World"
$Form.Size = New-Object System.Drawing.Size(1000,1000)
$Form.FormBorderStyle = "FixedDialog"
$Form.TopMost = $True
$Form.MaximizeBox = $False
$Form.MinimizeBox = $True
$Form.ControlBox = $True
$Form.StartPosition = "CenterScreen"
$Form.Font = "Segoe UI"

$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Size(8,8)
$Label.Size = New-Object System.Drawing.Size(240,32)
$Label.TextAlign = "MiddleCenter"
$Label.Text = "Hello World"

$Button = New-Object System.Windows.Forms.Label
$Button.Location = New-Object System.Drawing.Size(8,80)
$Button.Size = New-Object System.Drawing.Size(240,32)
$Button.TextAlign = "MiddleCenter"
$Button.Text = "Hello World"
$Button.Add_Click({$Button.Text = "Goodbye World"})

$Form.Controls.Add($Label)
$Form.Controls.Add($Button)
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()