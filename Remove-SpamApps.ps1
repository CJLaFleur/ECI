function Remove-SpamApps {

    BEGIN {
        
        $FilePath = "C:\SpamApps.csv"
        $Spam = "Spotify", "Wallet", "Advert", "Bing", "Xbox", "Camera", "Empires", "Minecraft", "Bubble", "Candy", "Zune", "Solitaire", "Messaging"
        $SpamApps = @()
    }

    PROCESS {

    foreach ($App in $Spam){

        $SpamApps += Get-AppxPackage | Where {$_.Name -Match $App} | Select -Property "PackageFullName"

    }

    foreach ($App in $SpamApps){

        Remove-AppxPackage $App

        }
    }
}