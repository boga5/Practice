Clear-Host
Write-Output "`n This script does the following`n"
$a=1;
Write-Output "$a. Converts the unstructured data into structured data"; $a++;
Write-Output "$a. Exports this structured data into a CSV"; $a++;
Write-Output "$a. Displays respective user values using ForEach loop"
$a=1;
Write-Output "`n Observations`n"
Write-Output "$a. ? is important for naming the capture groups"; $a++;
Write-Output "$a. Groups[1..4] is named accordingly to declarations before this"; $a++;
Write-Output "$a. Multiple patterns will work only with Capture Groups"; $a++;

Set-Content profiles.csv @"
sunil, boga, 123, @sunboga;
ramya, ravirala, 231, @ramya5;
krishna, boga, @krish, 321;
padma, boga, @padma, 432;
maanu, @maanu, 109, boga;
"@

Write-Output "`nDefined the profiles.csv successfully"

$profilesAtEnd = "(?<firstName>[^-]+),\s+(?<lastName>\w+),\s+(?<followers>\d+),\s+(?<userName>@.+);"
$followersAtEnd = "(?<firstName>[^-]+), (?<lastName>\w+), (?<userName>@.+), (?<followers>\d+);"
$pattern3 = "(?<firstName>[^-]+), (?<userName>@.+), (?<followers>\d+), (?<lastName>\w+);"
Write-Output "`nCapture Groups are declared successfully`n"


Get-ChildItem profiles.csv |
Select-String -Pattern $profilesAtEnd, $followersAtEnd, $pattern3 |
ForEach-Object {
    $firstName, $lastName, $followers, $userName = $_.Matches[0].Groups['firstName','lastName','followers','userName'].Value
    [PSCustomObject] @{
    FirstName = $firstName;
    LastName = $lastName;
    Followers = [int] $followers;
    Username = $userName
    }
} | Export-Csv modified_profiles3.csv -NoTypeInformation

#Write-Output "Displaying the modified CSV file"
#Get-Content modified_profiles3.csv #| Select-Object -Skip 1 | Set-Content modified_profiles4.csv

$Users = Import-Csv "modified_profiles3.csv"
foreach ($user in $Users) {
    $user_firstname = $user.FirstName
    $user_lastname = $user.LastName
    $user_followers = $user.Followers
    $user_username = $user.Username
    Write-Output "$user_firstname $($user_lastname) has $($user_followers) followers for their handle $($user_username)"
}