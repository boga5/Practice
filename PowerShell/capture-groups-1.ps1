Clear-Host
#setting the content
Set-Content profiles.txt -value @"
boga sunil @sunboga 400
ravirala ramya 256 @ramya
padma, boga 234 @padma
krishna boga, 243 @krish 
sun,boga,@boga,123
"@

#extracting the captured groups
Get-ChildItem profiles.txt | 
    Select-String -Pattern "([^-]+) (\w+) (\d+) (@\w+)" |
    ForEach-Object {
        $first, $last, $followers, $handle = $_.Matches[0].Groups[1..4].Value
        [PSCustomObject] @{
            FirstName = $first
            Surname = $last
            Followers = [int] $followers
            Handle = $handle
        }
    }


Write-Output "Starting multiple patterns"
#trying to get the different patterns of data
$FollowersLast = "^(<first>\w+) (<last>[^-]+) (<handle>@\w+) (<followers>\d+)"
Write-Output "Pattern 1 working"
#$FollowersFirst = "(\d+) (\w+) ([^-]+) (@\w+)"
#Write-Output "Pattern 2 working"
$HandleLast = "^(<last>[^\s,]+) (<first>[^-]+) (<followers>\d+) (<handle>@\w+)"
Write-Output "Pattern 3 working"

Get-ChildItem profiles.txt |
    Select-String -Pattern $FollowersLast, $HandleLast |
    ForEach-Object {
        $first, $last, $handle, $followers = $_.Matches[0].Groups['first', 'last', 'handle', 'followers'].Value
        [PSCustomObject] @{
            Firstname = $first
            Surname = $last
            Handle = $handle
            Followers = [int] $followers
        }
    }