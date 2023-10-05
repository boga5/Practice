#Get all the services and copy them to a file
Get-Service >> service.xls

Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Select-Object Status, Name, StartType >> stopped_services.xls

#Display the services that are stopped and disabled
Get-Service | Where-Object { $_.Status -eq 'Stopped' -and $_.StartType -eq 'Disabled' } | 
Select-Object Status, Name, StartType >> stopped_disabled_services.xls

#Displays the content inside files
Get-Content .\stopped_disabled_services.xls

#Create a directory
New-Item -ItemType Directory -Name PowerShell_Samples

#Move files to a directory.
#Cannot move multiple files (unless asterik) like in BASH
Move-Item -Path .\stopped* -Destination .\PowerShell_Samples
Move-Item -Path .\service.xls -Destination .\PowerShell_Samples

#messed up my file
Get-Content .\stopped_disabled_services.xls | Select-Object *,@{Name='Column';Expression={'setValue'}} >> modified_file.xls

#creating a new csv file for get service
Get-Service | Where-Object { $_.Status -eq 'Stopped' -and $_.StartType -eq 'Disabled' } >> disabled_services.csv

#adding a new column to CSV file
Import-Csv .\disabled_services.csv | Select-Object *,@{ Name='column5';Expression={'added'} } | Export-Csv mod_disabled_serv1.csv -NoTypeInformation

#Copy file 
Copy-Item -Path .\mod_disabled_serv1.csv .\mod_disabled_serv2.csv

#adding a new row to CSV file
$Time = Get-Date -Format "yyyy-MM-dd HH:mm"
$Description = "Completed on time 2"
"$Time,$Description" | Add-Content -Path .\mod_disabled_serv2.csv

#Displaying the number of lines
$File = ".\mod_disabled_serv2.csv"
$FileContent = Get-Content $File
$EndofFile = $FileContent | Measure-Object -Line
Write-Output "Lines from File: $($EndofFile.Lines)" #17 - correct
Write-Output "Count from File: $($EndofFile.Count)" #1 - donno
Write-Output "Char from File: $($EndofFile.Characters)" #null - donno

#Displaying the number of lines
$File_Lines = Get-Content .\mod_disabled_serv1.csv | Measure-Object -Line
$File_Words = Get-Content .\mod_disabled_serv1.csv | Measure-Object -Word
$File_Char = Get-Content .\mod_disabled_serv1.csv | Measure-Object -Character
Write-Output "Lines from file: $($File_Lines.Lines)"
Write-Output "Words from file: $($File_Words.Words)"
Write-Output "Char from file: $($File_Char.Characters)"