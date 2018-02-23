[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)

Class GUI {

#Window member variables
[Int]$Height
[Int]$Width
[String]$Position
[String]$Title
$Form

#Label Member variables
[Int]$LabelHeight
[Int]$LabelWidth
[Int]$XPos
[Int]$YPos
[String]$LabelTextPosition
[String]$LabelText
$Label

    GUI(){
        
    }

    SetWindowSize($Height, $Width, $Position, $Title){

        $this.Height = $Height
        $this.Width = $Width
        $this.Position = $Position
        $this.Title = $Title

    }

    [GUI]CreateWindow(){

        $this.Form = New-Object System.Windows.Forms.Form    
        $this.Form.Size = New-Object System.Drawing.Size($this.Height, $this.Width)
        $this.Form.Text = $this.Title
        $this.Form.FormBorderStyle = "FixedDialog"
        $this.Form.TopMost = $True
        $this.Form.MaximizeBox = $True
        $this.Form.MinimizeBox = $True
        $this.Form.ControlBox = $True
        $this.Form.StartPosition = $this.Position
        $this.Form.Font = "Segoe UI"

        return $this
    }

    [Void]Display() {

        [Void]$this.Form.ShowDialog()
    }

}

Class Label : GUI {

[Int]$LabelHeight
[Int]$LabelWidth
[Int]$XPos
[Int]$YPos
[String]$LabelTextPosition
[String]$LabelText
$Label
$TempForm

    Label($LabelHeight, $LabelWidth, $LabelTextPosition, $LabelText, $XPos, $YPos){

        $this.LabelHeight = $LabelHeight
        $this.LabelWidth = $LabelWidth
        $this.LabelTextPosition = $LabelTextPosition
        $this.LabelText = $LabelText
        $this.XPos = $XPos
        $this.YPos = $YPos

    }

    [Void]CreateLabel(){

        $this.Label = New-Object System.Windows.Forms.Label
        $this.Label.Location = New-Object System.Drawing.Size($this.XPos,$this.YPos)
        $this.Label.Size = New-Object System.Drawing.Size($this.LabelHeight, $this.LabelHeight)
        $this.Label.TextAlign = $this.LabelTextPosition
        $this.Label.Text = $this.LabelText
    }


    [Void]AddLabel(){

        $this.TempForm = [GUI]$this.Form

        $this.TempForm.Controls.Add($this.Label)

        #([GUI]$this.Form.Controls.Add($this.Label))
    }

}

$X = New-Object GUI -ArgumentList 1000, 1000, "CenterScreen", "Test"

$X.CreateWindow()

#$Y = New-Object -TypeName Label -ArgumentList 100, 100, "MiddleCenter", "Test", 100, 100

#$Y.CreateLabel()
#$Y.AddLabel()

$X.Display()


<#$Form = New-Object System.Windows.Forms.Form
$Form.Text ="Hello World"
$Form.Size = New-Object System.Drawing.Size(1000,1000)
$Form.FormBorderStyle = "FixedDialog"
$Form.TopMost = $True
$Form.MaximizeBox = $True
$Form.MinimizeBox = $True
$Form.ControlBox = $True
$Form.StartPosition = "CenterScreen"
$Form.Font = "Segoe UI"
$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Size(8,8)
$Label.Size = New-Object System.Drawing.Size(240,32)
$Label.TextAlign = "MiddleCenter"
$Label.Text = "Hello World"
#>
