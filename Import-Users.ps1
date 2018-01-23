function Import-Users {

[CmdletBinding()]
  param(
    [Parameter(Mandatory=$True,
      ValueFromPipelineByPropertyName=$True,
      HelpMessage= "Enter the file path of the CSV where your users are located.")]
    [String]$InputFile
    )

BEGIN {

    $Users = @()

    $FileReader = New-Object System.IO.StreamReader -Arg $InputFile

    while($FileReader.EndOfStream -EQ $False){
            $Users += $FileReader.ReadLine()
        }

    $FileReader.Dispose()
    $FileReader.Close()
    }

    PROCESS {

    foreach ($User in $Users){
        
        New-ADUser -Name $User.Name -ChangePasswordAtLogon $True -SamAccountName $User.SamAccountName -GivenName $User.GivenName -Surname $User.Surname -UserPrincipalName $User.UserPrincipalName

    }

    }

}