#Create an array 
#Input values from user
#Display array contents
#add a new element into array
#delete an element from array
#display the contents of array one by one

Clear-Host
#linear data seaprated by comma
Write-Output "Array Declaration by comma separation`r`n"
$data = @(1,2,3, ,10)
$data.count
$data

Write-Output "`r`nArray Declaration by line and without comma separation`r`n"
#array declaration line by line
$names = @(
'sunil'
'boga'
'krishna'
'padma'
)
$names.count
$names

Write-Output "`r`nArray Declaration without @()`r`n"
#array declaration without @()
$sample = 's1','s2','s3','s4', 's5', 's6'
$sample.Count
$sample

Write-Output "`r`nAccessing the first element of array`r`n"
Write-Output "`r`nThe first element is $($sample[0])`r`n"
Write-Output "`r`n One way of showing consecutive array elements - $($sample[1..4])`r`n"
Write-Output "`r`n One way of showing array by indexes $($sample[2,3,0,1])`r`n"
Write-Output "`r`n Using negative indexes $($sample[-1,-2])`r`n"

Write-Output "`r`nIterating through the arrays`r`n"
$sample | ForEach-Object {"Item: [$PSItem]"}

Write-Output "`r`nIterating through the arrays using foreach`r`n"
foreach ($node in $sample) {
    "Item: $node"
}

Write-Output "`r`n Using for loop`r`n"
for ( $index=0; $index -lt $sample.count; $index++ ) {
    "Item: {0}" -f $sample[$index]
}


Write-Output "`r`n Using switch for arrays`r`n"
switch( $sample ) {
's1' {'Tick'}
's3' {'Tick'}
's5' {'Tick'}
Default {'Tock'}
}

Write-Output "`r`n Array of Objects `r`n"
$profiles = @(
[PSCustomObject]@{FirstName='Sunil';LastName='Boga'}
[PSCustomObject]@{FirstName='Ramya';LastName='Ravirala'}
[PSCustomObject]@{FirstName='Krishna';LastName='Boga'}
[PSCustomObject]@{FirstName='Ganesh';LastName='Adapu'}
)
Write-Output "`r`n `r`n"
Write-Output "`r`n Array is declared successfully"
Write-Output "`r`n Displaying first row of array`r`n"
Write-Output $profiles[0]
Write-Output "`r`n Displaying only First Name of 1st row`r`n"
Write-Output "`r`n $($profiles[0].FirstName) `r`n"
Write-Output "`r`n Displaying array objects FirstNames in various ways `r`n"
#Write-Output "`r`n $($profiles) `r`n"
$profiles | ForEach-Object {"$($PSItem.FirstName)"}
$profiles | ForEach-Object {"$($_.FirstName)"}
$profiles | Select-Object -ExpandProperty FirstName
$profiles.FirstName


Write-Output "`r`n Usage of Where-Object/Where/Where() `r`n"
$profiles | Where-Object {$_.LastName -eq 'Boga'}
$profiles | Where LastName -eq Boga
$profiles.Where({$_.LastName -eq 'Boga'})

Write-Output "`r`n Usage of Joins `r`n"
$sample -join ','
$sample -join '-'
$sample -join $null

Write-Output "`r`n Replacing objects in Array `r`n"
$sample -replace 'S','Bogi '

Write-Output "`r`n Matching the contents in arrays `r`n"
$profiles -match 'Boga'
$profiles | Select-String Boga

Write-Output "`r`n Adding content to existing array `r`n"
$sample+= 's7'
$sample