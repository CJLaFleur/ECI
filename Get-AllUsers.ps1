function Get-AllUsers{

    [cmdletbinding()]
    Param(

        [Parameter(Mandatory = $True,
                   Position =0,
                   HelpMessage ="Specify the first IP in the range(s).")]
                   [String]$OutPath
    )
    $FileHandle = New-Object System.IO.StreamWriter -Arg $OutPath
    $FileHandle.AutoFlush = $True

    $Users = Get-ADUser -Filter * | Select-Object -Property GivenName, Name, SamAccountName, Surname, UserPrincipalName, MemberOf | Where-Object {$_.GivenName -NE $Null}

    for([int]$i = 0; $i -LT $Users.Count; $i++){
    
         $UserInfo = New-Object -TypeName PSObject

          $UserInfo | Add-Member -Type NoteProperty -Name GivenName -Value $Users.GivenName -Force
          $UserInfo | Add-Member -Type NoteProperty -Name Name -Value $Users.Name -Force
          $UserInfo | Add-Member -Type NoteProperty -Name Surname -Value $Users.Surname -Force
          $UserInfo | Add-Member -Type NoteProperty -Name SamAccountName -Value $Users.SamAccountName -Force
          $UserInfo | Add-Member -Type NoteProperty -Name UserPrincipalName -Value $Users.UserPrincipalName -Force
          $UserInfo | Add-Member -Type NoteProperty -Name MemberOf -Value $Users.MemberOf -Force

          $FileHandle.WriteLine($UserInfo.GivenName + ", " + $UserInfo.Name + ", " + $UserInfo.Surname + ", " + $UserInfo.UserPrincipalName + ", " + $UserInfo.SamAccountName + ", " + $UserInfo.MemberOf)
    }
    
    Return $UserInfo

    $FileHandle.Flush()
    $FileHandle.Dispose()
    $FileHandle.Close()
    
}