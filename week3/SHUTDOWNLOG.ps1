function Get-StartupShutdownEvents {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

    $startDate = (Get-Date).AddDays(-$Days)
    $eventList = @()


    Get-EventLog -LogName System -After $startDate | Where-Object {$_.EventID -eq 6005} | ForEach-Object {
        $event = [PSCustomObject]@{
            Time  = $_.TimeGenerated
            Id    = $_.EventID
            Event = "Startup"
            User  = "System"
        }
        $eventList += $event
    }


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


$userInput = Read-Host "Enter the number of days to retrieve startup/shutdown events"


if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput

    $results = Get-StartupShutdownEvents -Days $days
    $results | Format-Table -AutoSize
}
else {
    Write-Host "Invalid input. Please enter a valid number of days."
}
