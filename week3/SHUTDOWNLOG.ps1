function Get-StartupShutdownEvents {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

    $startDate = (Get-Date).AddDays(-$Days)
    $eventList = @()

    # Get startup events (Event ID 6005)
    Get-EventLog -LogName System -After $startDate | Where-Object {$_.EventID -eq 6005} | ForEach-Object {
        $event = [PSCustomObject]@{
            Time  = $_.TimeGenerated
            Id    = $_.EventID
            Event = "Startup"
            User  = "System"
        }
        $eventList += $event
    }

    # Get shutdown events (Event ID 6006)
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

# Prompt the user for the number of days
$userInput = Read-Host "Enter the number of days to retrieve startup/shutdown events"

# Validate the input
if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput
    # Call the function with the user-provided number of days and print the results
    $results = Get-StartupShutdownEvents -Days $days
    $results | Format-Table -AutoSize
}
else {
    Write-Host "Invalid input. Please enter a valid number of days."
}
