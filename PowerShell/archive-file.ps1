Clear-Host

#region variables assignment
$FileName = "trial.csv"
$ZipFile = "$FileName.zip"
$Folder = Get-Location
#endregion variables assignment

#region get content 
try {
    #Copy contents to a file
    if (Test-Path -Path $FileName) {
        Write-Output "-*-*-*-*-* $($FileName) already exists in this folder -*-*-*-*-*"
    }
    else {
        Get-Service | Where-Object { $_.Status -eq 'Stopped' -and $_.StartType -eq 'Disabled' } >> $FileName -ErrorAction Stop
        Write-Output "-*-*-*-*-* Created $FileName successfully -*-*-*-*-*"
    }
}

catch {
    Write-Output "-*-*-*-*-*-*-*-*-*-* Get-Content failed -*-*-*-*-*-*-*-*-*-*-*-*-*-"
    Write-Output $Error
    $Error.Clear()
}
#endregion get content

#region archive the file
try {
    if (Test-Path -Path $ZipFile) {
        Write-Output "-*-*-*-*-* $ZipFile already exists -*-*-*-*-*"
    }

    else {
        Compress-Archive $FileName -DestinationPath "$Folder\$FileName.zip" -ErrorAction Stop
        Write-Output "-*-*-*-*-* Archived $($FileName) file successfully -*-*-*-*-*"
    }
}
catch {
    Write-Output "-*-*-*-*-*-*-*-*-*-* Archived $($FileName) file failed -*-*-*-*-*-*-*-*-*-*-*-*-*-"
    Write-Output $Error
    $Error.Clear()
}
#endregion archive file