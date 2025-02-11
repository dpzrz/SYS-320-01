function Get-StartupShutdownEvents {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

    $startDate = (Get-Date).AddDays(-$Days)
    $eventList = @()

<<<<<<< HEAD
    # Get startup events (Event ID 6005)
=======

>>>>>>> 6f432b40b1bead579cdeb8660c48219eb42fa2ff
    Get-EventLog -LogName System -After $startDate | Where-Object {$_.EventID -eq 6005} | ForEach-Object {
        $event = [PSCustomObject]@{
            Time  = $_.TimeGenerated
            Id    = $_.EventID
            Event = "Startup"
            User  = "System"
        }
        $eventList += $event
    }

<<<<<<< HEAD
    # Get shutdown events (Event ID 6006)
=======

>>>>>>> 6f432b40b1bead579cdeb8660c48219eb42fa2ff
    Get-EventLog -LogName System -After $startDate | Where-Object {$_.EventID -eq 6006} | ForEach-Object {
        $event = [PSCustomObject]@{
            Time  = $_.TimeGenerated
            Id    = $_.EventID
            Event = "Shutdown"
            User  = "System"
        }
        $eventList += $event
    }

    return $eventList
}

<<<<<<< HEAD
# Prompt the user for the number of days
$userInput = Read-Host "Enter the number of days to retrieve startup/shutdown events"

# Validate the input
if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput
    # Call the function with the user-provided number of days and print the results
=======

$userInput = Read-Host "Enter the number of days to retrieve startup/shutdown events"


if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput

>>>>>>> 6f432b40b1bead579cdeb8660c48219eb42fa2ff
    $results = Get-StartupShutdownEvents -Days $days
    $results | Format-Table -AutoSize
}
else {
    Write-Host "Invalid input. Please enter a valid number of days."
}
