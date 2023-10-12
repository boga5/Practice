#trying something with serial numbers as well
Clear-Host
Set-Content profiles-serial.csv @"
1 sunil boga @sunboga 123
2 ramya ravirala @ramya 213
3 padma boga 321 @padma
4 krishna boga 231 @krish
5 maanu 111 @maanu boga
anand boga @anand 6 321
123 7 @manisha manisha boga
231 @anil anil boga 8
@nikhitha nikhitha 9 boga 105
"@

Write-Output "`n Profiles with serial number declared successfully`n"
Write-Output "`n Outputs using String patterns`n"
Get-ChildItem profiles-serial.csv | 
Select-String -Pattern "(\d) ([^-]+) (\w+) (@.+) (\d+)" |
ForEach-Object {
    $serial, $firstName, $lastName, $handle, $followers = $_.Matches[0].Groups[1..5].Value
    [PSCustomObject] @{
        Serial = $serial
        FirstName = $firstName
        LastName = $lastName
        Handle = $handle
        Followers = $followers
    }
} | Format-Table

$sunRamPattern = "(?<serial>\d) (?<firstName>[^-]+) (?<lastName>\w+) (?<handle>@.+) (?<followers>\d+)"
$krishPadPattern = "(?<serial>\d) (?<firstName>[^-]+) (?<lastName>\w+) (?<followers>\d+) (?<handle>@.+)"
$maanuPattern = "(?<serial>\d) (?<firstName>[^-]+) (?<followers>\d+) (?<handle>@.+) (?<lastName>\w+)"
$anandPattern = "(?<firstName>[^-]+) (?<lastName>\w+) (?<handle>@.+) (?<serial>\d) (?<followers>\d+)"
$manishaPattern = "(?<followers>\d+) (?<serial>\d) (?<handle>@.+) (?<firstName>[^-]+) (?<lastName>\w+)"
$anilPattern = "(?<followers>\d+) (?<handle>@.+) (?<firstName>[^-]+) (?<lastName>\w+) (?<serial>\d)"
$nikhithaPattern = "(?<handle>@.+) (?<firstName>[^-]+) (?<serial>\d) (?<lastName>\w+) (?<followers>\d+)"
Write-Output "`n Various Capture Groups declared successfully`n"
Write-Output "`n Outputs using Capture Groups`n"
Get-ChildItem profiles-serial.csv |
Select-String -Pattern $sunRamPattern, $krishPadPattern, $maanuPattern, `
                        $anandPattern, $manishaPattern, $anilPattern, $nikhithaPattern |
ForEach-Object {
    $serial, $firstName, $lastName, $handle, $followers = `
    $_.Matches[0].Groups['serial','firstName','lastName','handle','followers'].Value 
    [PSCustomObject] @{
        Serial = $serial
        FirstName = $firstName
        LastName = $lastName
        Handle = $handle
        Followers = [int] $followers
    }
} | Format-Table