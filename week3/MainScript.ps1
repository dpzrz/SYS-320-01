# MainScript.ps1

# Dot-source the Functions.ps1 file
. .\Functions.ps1

Write-Host "Choose an option:"
Write-Host "1. Retrieve Logon/Logoff Events"
Write-Host "2. Retrieve Startup/Shutdown Events"
$choice = Read-Host "Enter your choice (1 or 2)"

$userInput = Read-Host "Enter the number of days to retrieve events"


if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput

    switch ($choice) {
        "1" {
            Write-Host "`nRetrieving Logon/Logoff Events..."
            $results = Get-LogonLogoffEvents -Days $days
            $results | Format-Table -AutoSize
        }
        "2" {
            Write-Host "`nRetrieving Startup/Shutdown Events..."
            $results = Get-StartupShutdownEvents -Days $days
            $results | Format-Table -AutoSize
        }
        default {
            Write-Host "Invalid choice. Please enter either '1' or '2'."
        }
    }
}
else {
    Write-Host "Invalid input for days. Please enter a valid number."
}
