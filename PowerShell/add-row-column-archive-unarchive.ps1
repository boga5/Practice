#This script will Add a column to exisiting CSV File
#It'll archive the file
#It'll unarchive the file too

Clear-Host
$Folder = "C:\Users\bogas\PowerShell_Samples\"
$CSVFile = "csv_sample.csv"
$ModifiedFile = "mod_csv_sample1.csv"
$UnarchiveFile = "unarchive_csv"
$RowFile = "row_csv.csv"
$ColFile = "col_csv.csv"

Copy-Item -Path $Folder\$CSVFile -Destination $Folder\$RowFile

#region searching for file and displaying file contents
try {
    if (Test-Path -Path "$Folder\$CSVFile") { 
        Write-Output "`r`n$FileName is present in the given directory`r`n"
        Write-Output "`r`nDisplaying contents of $FileName before archiving`r`n"
        Get-Content $CSVFile -ErrorAction Stop
    }
    else {
        Write-Output "`r`n$CSVFile not found"
        Write-Output "`r`nCreate the file and execute this script"
        Write-Output "`r`nExiting the script right now"
        Exit
    }
}
catch {
    Write-Output "`r`nSearch and Display File error"
    Write-Output $Error
    $Error.Clear()
    Exit
}
#endregion searching for file and displaying file contents

#region add column
try {
    Write-Output  "`r`nAdding a new column to the csv file"
    #Get-Content $CSVFile | Select-Object *,@{Name="gender";Expression={""}} >> $ModifiedFile -ErrorAction Stop
    Import-Csv $CSVFile | 
    #this is working and is adding an empty column
    #Select-Object *,@{Name='Sr/Jr';Expression={''}} | 
    Add-Member -MemberType ScriptProperty -Name "Sr/Jr" -Value {if ($this.age -gt 50) {'Sr'} else { 'Jr' }} -PassThru |
    Export-Csv "$Folder\$ModifiedFile" -NoTypeInformation -ErrorAction Stop
    Write-Output "`r`nContents of $CSVFile after modification"
    Get-Content $ModifiedFile
}
catch {
    Write-Output "`r`nAdding column is fucked up"
    Write-Output $Error
    $Error.Clear()
}
#endregion column addition

#adding column with conditions isn't working without using CSV
#region adding a new column with CSV
#try {
#    Write-Output "`r`nAdding a new column without CSV cmdlets"
#    Get-Content $CSVFile |
#    #Select-Object *,@{Name="col5";Expression={''}} >> $ColFile -ErrorAction Stop
#    Add-Member -MemberType ScriptProperty -Name "Kid" -Value {if ($this.age -lt 5) {'Y'} else {'N'}} -PassThru >> $ColFile |
#    Get-Content $ColFile
#}
#catch {
#    Write-Output "`r`n Column addition without CSV failed. `r`n Check below errors"
#    Write-Output $Error
#    $Error.Clear()
#}
#endregion without csv

#region compress this file
try {
    if (!(Test-Path -Path "$FileName.zip")) {
        Write-Output "`r`nLooks like there is no zip filer`nStarting the Archive Process"
        Compress-Archive -Path $CSVFile -DestinationPath "$CSVFile.zip" -ErrorAction Stop
        Write-Output "`r`nCompressed the file successfully"
    }
    else {
        Write-Output "`r`nFile exists dude. Look for it"
        Exit
    }
}

catch {
    Write-Output "`r`nFile Compression failed"
    Write-Output $Error
    $Error.Clear()
}
#endregion compress

#region uncompressing the file and displaying the contents
try {
    if (Test-Path -Path "$CSVFile.zip") {
        Write-Output "Guess whaaat? `r`n `r`n `r`nThe file exists`r`n Starting Unarchive"
        Expand-Archive "$CSVFile.zip" -DestinationPath $UnarchiveFile -ErrorAction Stop
        Write-Output "`r`n Displaying the unarchived file contents`r`n "
        Get-Content "$UnarchiveFile\$CSVFile"
    }
    else {
        Write-Output "`r`nArchive the file dude.`r`nThen come back to me.`r`nBye for now`r`n"
        Exit
    }
}
catch{
    Write-Output "`r`n Unarchive failed due to below error."
    Write-Output $Error
    $Error.Clear()
}
#endregion unarchive

#region add a row 
try {
    if (Test-Path -Path $CSVFile) {
        Write-Output "`r`n$CSVFile exists`r`n Adding a new row"
        $NewRow = "{0}" -f $(Get-Date) #adding new row
        $NewRow | Add-Content -Path $RowFile -ErrorAction Stop
        Write-Output "`r`nNew Row has been added to the file `r`n Displaying contents of file"
        Get-Content $RowFile
    }
    else {
        Write-Output "`r`nThe file doesn't exist `r`n Please add it"
    }
}
catch {
    Write-Output "`r`nCheck the below error`r`n"
    Write-Output $Error
    $Error.Clear()
}
#endregion