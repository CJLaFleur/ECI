function Upload-SFTP{

        Param(

        [Parameter(Mandatory = $True,
                   Position = 0,
                   HelpMessage = "FTP address")]
        [String]$Name,

        [Parameter(Mandatory = $True,
                   Position = 1,
                   HelpMessage = "Username")]
        [String]$User,

        [Parameter(Mandatory = $True,
        Position = 2,
        HelpMessage = "Password")]
        [String]$Pass,

        [Parameter(Mandatory = $True,
        Position = 3,
        HelpMessage = "Local directory")]
        [String]$LocalDir,

        [Parameter(Mandatory = $True,
        Position = 4,
        HelpMessage = "Remote directory")]
        [String]$RemoteDir,

        [Parameter(Mandatory = $True,
        Position = 5,
        HelpMessage = "SSH host key for the remote server")]
        [String]$SSHKey
        
        )

    BEGIN{

        Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
        $SecurePass = ConvertTo-SecureString $Pass -AsPlainText -Force
    }

    PROCESS{

        #Sets details for the SFTP session
        $SessionOptions = New-Object WinSCP.SessionOptions
        $SessionOptions.Protocol = [WinSCP.Protocol]::Sftp
        $SessionOptions.HostName = $Name
        $SessionOptions.UserName = $User
        $SessionOptions.SecurePassword = $SecurePass
        $SessionOptions.SshHostKeyFingerprint = $SSHKey


        $Session = New-Object WinSCP.Session

        $Session.Open($SessionOptions)
            
        $Session.PutFiles($LocalDir, $RemoteDir, $False) | Format-List

    }

}