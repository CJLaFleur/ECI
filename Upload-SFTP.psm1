<#
.Synopsis
A script that Uploads files to a remote SFTP source. 

.Parameter Name
The host name of the FTP source. It SHOULD NOT be a URL, and should not include any "/" characters. "." is an acceptable character.

.Parameter SSHKey
This is the SSH key that helps to authenticate this script. This can be retrieved through PuTTY.

.Notes
Author: Connor James LaFleur
Copyright: Connor James LaFleur, 2/20/18 1:38PM Eastern Time
#>

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