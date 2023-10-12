Clear-Host

Write-Output "`n Observations `n"
Write-Output "1. ? is important for naming the capture groups`n"
Write-Output "2. Groups[1..4] is named accordingly to declarations before this`n"
Write-Output "3. Multiple patterns will work only with Capture Groups`n"
Set-Content profiles.csv @"
sunil boga 123 @sunboga
ramya ravirala 231 @ramya5
krishna boga @krish 321
padma boga @padma 432
maanu @maanu 109 boga
"@

Write-Output " Defined the profiles.csv successfully"

Write-Output "`n Only the frst 2 rows will be displayed `n"
Get-ChildItem profiles.csv |
Select-String -Pattern "([^-]+) (\w+) (\d+) (@.+)" |
#Select-String -Pattern "(?<firstName>[^-]+)\s+(?<lastName>\w+)\s+(?<followers>\d+)\s+(?<userName>@.+)", "(?<firstName>[^-]+)\s+(?<lastName>\w+)\s+(?<userName>@.+)\s+(?<followers>\d+)" |
ForEach-Object {
    $firstName, $lastName, $followers, $userName = $_.Matches[0].Groups[1..4].Value
    [PSCustomObject] @{
        FirstName = $firstName
        LastName = $lastName
        Followers = $followers
        Username = $userName
    }
}

Write-Output "`n Only 3rd & 4th rows will be displayed`n"
Get-ChildItem profiles.csv |
Select-String -Pattern "([^-]+) (\w+) (@.+) (\d+)" |
ForEach-Object {
    $firstName, $lastName, $userName, $followers = $_.Matches[0].Groups[1..4].Value
    [PSCustomObject] @{
        FirstName = $firstName
        LastName = $lastName
        UserName = $userName
        Followers = $followers
    }
}


$profilesAtEnd = "(?<firstName>[^-]+)\s+(?<lastName>\w+)\s+(?<followers>\d+)\s+(?<userName>@.+)"
$followersAtEnd = "(?<firstName>[^-]+) (?<lastName>\w+) (?<userName>@.+) (?<followers>\d+)"
$pattern3 = "(?<firstName>[^-]+) (?<userName>@.+) (?<followers>\d+) (?<lastName>\w+)"
Write-Output "`nCapture Groups are declared successfully`n`nVariables for Capture Groups`n"

Get-ChildItem profiles.csv |
Select-String -Pattern $profilesAtEnd, $followersAtEnd, $pattern3 |
ForEach-Object {
    $firstName, $lastName, $followers, $userName = $_.Matches[0].Groups['firstName','lastName','followers','userName'].Value
    [PSCustomObject] @{
    FirstName = $firstName
    LastName = $lastName
    Followers = [int] $followers
    Username = $userName
    }
}