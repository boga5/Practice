Clear-Host
$Folder = "C:\Users\bogas\PowerShell_Samples"
$File = "csv_sample.csv"
$ModFile = "mod1_sample.csv"
$ModFile2 = "mod2_sample.csv"
#Get-Content "$Folder\$File"
Write-Output "`n Modifying content using Add-Member `n"
Import-Csv "$Folder\$File" |
Add-Member -MemberType ScriptProperty -Name "Sr/Jr" -Value {if ($this.age -lt 50) { 'Jr' } else { 'Sr' }} -PassThru |
Add-Member -MemberType ScriptProperty -Name "Sr Discount Applicable?" -Value {if($this.age -lt 50) {'No'} else {'Yes'}} -Passthru |
Add-Member -MemberType ScriptProperty -Name "Discount %" -Value {if ($this.'Sr/Jr' -eq 'Sr')  {'40%'} else {'20%'}} -PassThru |
Export-Csv "$Folder\$ModFile" -NoTypeInformation

Write-Output "`r`n Modified content using Add-Member is displayed below`r`n"
Get-Content "$Folder\$ModFile"


Write-Output "`n Modifying content using Select-Object"
Import-Csv "$Folder\$File" |
Select-Object *,@{Name='Discount %';Expression={'20%'}} |
Export-Csv "$Folder\$ModFile2" -NoTypeInformation

Write-Output "`r`n Modified content using Seect-Object is displayed below`r`n"
Get-Content "$Folder\$ModFile2"

Write-Output "`n Iterating through CSV file using foreach loop`n"
$users = Import-Csv "$Folder\$File"
foreach ($val in $users ){
    $val.name
}

Write-Output "`n Iterating through CSV file using ForEach-Object `n"
ForEach-Object {$users}
ForEach-Object {$users.id}

Write-Output "`n Iterating through CsV file using for loop`n"
for ( $i = 0; $i -lt $users.Count; $i++ ) {
    $users[$i]
}

for ( $i=0; $i -lt $users.Count; $i++ ) {
    $users[$i].id, $users[$i].name
}