function Export-Mailbox{

  [cmdletbinding()]
     Param(

         [Parameter(Mandatory = $False,
                    Position = 0,
                    HelpMessage = "Specify the users whose mailboxes should be exported.")]
                    [String[]]$Users,

        [Parameter(Mandatory = $True,
                  HelpMessage = "Specify the destination path for the PST file.")]
                  [String]$OutPath,

          [Parameter(Mandatory = $False,
                    HelpMessage = "If using a CSV file to import users, specify the path to that file here.")]
                    [String]$InputPath
      )

      BEGIN{
        if($InputPath -NE $Null){
          $FileReader = New-Object System.IO.StreamWriter -Arg $InputPath
          $FileHandle.AutoFlush = $True

          while($FileReader.EndOfStream -EQ $False){
           $Users += $FileReader.ReadLine()
       }
        }

      }

      PROCESS{

        foreach($User in $Users){
          New-MailboxExportRequest -Mailbox $User.SamAccountName -FilePath $OutPath + "\" + $User.Name + ".pst"
        }
      }

      END{
        $FileReader.Flush()
        $FileReader.Dispose()
        $FileReader.Close()
      }

}
