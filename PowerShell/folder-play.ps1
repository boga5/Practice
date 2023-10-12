Clear-Host
Write-Output "Folder play`n"
Write-Output "Enter the user that you want`n"
$user = Read-Host user
Write-Output "`n Displaying contents of $user `n"
Get-ChildItem -Path C:\Users\$user -Recurse -Directory -Depth 1 | Select-Object FullName

$user = Read-Host user
Write-Output "`n Displaying only *.txt files"
Get-ChildItem -Path C:\Users\$user -Include *.txt
Write-Output "`n wthout asterik in path, there wont be any output"

Get-ChildItem -Path C:\Users\$user\* -Include *.txt