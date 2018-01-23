function Set-StaticIP {

    [cmdletbinding()]
    Param(

        [Parameter(Mandatory = $True,
                   HelpMessage ="Specify the name of the network interface")]
        [String]$Interface,

        [Parameter(Mandatory = $False,
                   HelpMessage ="Specify the IP address to assign to this device.")]
                   [Alias('IP')]
        [String]$NewIP,

        [Parameter(Mandatory = $False,
        HelpMessage ="Specify the default gateway to use.")]
        [String]$Gateway,

        [Parameter(Mandatory = $False,
        HelpMessage ="Specify the default gateway to use.")]
        [String]$DNS

    )

    BEGIN {

        [void][System.Reflection.Assembly]::LoadWithPartialName( “System.Windows.Forms”)
        [void][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)

        function Create-UI {
            $Form = New-Object “System.Windows.Forms.Form”
            $Form.Width = 500
            $Form.Height = 150
            $Form.Text = $title
            $Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

            $TextLabel1 = New-Object “System.Windows.Forms.Label”
            $TextLabel1.Left = 25
            $TextLabel1.Top = 15
        }

    }

    PROCESS {

        $NetAdapter = Get-NetAdapter -Name $Interface

        $NetAdapter | Set-NetIPInterface -Dhcp Disabled

        $NetAdapter | New-NetIPAddress -AddressFamily IPv4 -IPAddress $NewIP -PrefixLength 24 -Type Unicast -DefaultGateway $Gateway

        Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses $DNS

    }

}