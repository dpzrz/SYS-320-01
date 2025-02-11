function gatherer {

    param (
        [Parameter(Mandatory = $true)]
        [string]$pg,  # Page visited or referred from (e.g., index.html)
        
        [Parameter(Mandatory = $true)]
        [string]$cd,  # HTTP code returned (e.g., 200)
        
        [Parameter(Mandatory = $true)]
        [string]$wb   # Web browser (e.g., Mozilla)
    )

    # Get all log entries that match the page pattern
    $result1 = Get-Content -Path C:\xampp\apache\logs\*.log | Select-String -Pattern $pg

    # Further filter log entries that match the HTTP code
    $result2 = $result1 | Select-String -Pattern $cd

    # Further filter log entries that match the web browser
    $result3 = $result2 | Select-String -Pattern $wb

    # Extract IP addresses from the filtered results using regex
    $IPs = foreach ($line in $result3) {
        if ($line -match "^(?<IP>\S+)") {
            $matches['IP']
        }
    }

    # Group and count unique IP addresses
    $GroupedIPs = $IPs | Group-Object | Select-Object Name, Count

    return $GroupedIPs
}

