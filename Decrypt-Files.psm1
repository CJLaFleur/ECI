function Decrypt-Files{

        Param(

        [Parameter(Mandatory = $True,
                   ValueFromPipelineByPropertyName=$True,
                   Position = 0,
                   HelpMessage = "Location of the file containing the passphrase.")]
        [String]$Passphrase,

        [Parameter(Mandatory = $True,
                   Position = 1,
                   HelpMessage = "Directory of files to be decrypted.")]
        [String]$Directory

        )
        

        cd "C:\Program Files (x86)\GNU\GnuPG"

        $Files = Get-ChildItem -Path $Directory -Filter "*.pgp"

        foreach ($File in $Files){

            .\gpg2.exe --decrypt $File --batch --passphrase $Passphrase --yes
        }
}