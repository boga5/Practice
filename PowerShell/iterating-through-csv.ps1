Clear-Host

$csv = Import-csv "C:\Users\bogas\PowerShell_Samples\csv_sample.csv"

Write-Host "`n Iterating through entire CSV file `n"
foreach ($user in $csv) {
    Write-Host "ID: $($user.id) is assigned to $($user.name) whose age is $($user.age)"
}

Write-Host "`n Iterating through fixed number of times`n"
$count = 0
foreach ($user in $csv) {
    if ( $count -lt 3 ) {
        Write-Host "ID: $($user.id) is assigned to $($user.name) whose age is $($user.age)"
        $count++
    }
}

Write-Host "`n Iterating thorugh CSV till particular value inside CSV column`n"
try {
    if ($csv) { 
    #if there's no CSV it'll display the same msg on the screen
        foreach ($user in $csv) {
            if ( $user.name -eq 'padma' ) {
                Write-Host "`n The user wants to end this`n`n So we ended it" -ErrorAction Stop
                Break
            }
            else {
                Write-Host "ID: $($user.id) is assigned to $($user.name) whose age is $($user.age)" -ErrorAction Stop
            }
        }
    }
    else {
        Write-Host "`n You don't fucking have the CSV dude.`n"
    }
} 
catch {
    Write-Output "`n Well, IF YOU'RE SEEING THIS,`n`n`n`n`n`nBelieve Me`n`n`n`nSomething's messed up`n"
    Write-Output $Error
    $Error.Clear()
}

Write-Host "`n Assigning the csv values to variables and then using them.`n"
foreach ($user in $csv) {
    $user_id = $user.id
    $user_name = $user.name
    $user_age = $user.age
    Write-Host "ID $user_id is assigned to $user_name whose age is $user_age"
}