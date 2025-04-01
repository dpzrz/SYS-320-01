function ParseApacheLogs {
    param (
        [string]$Path
    )

    # Regular expression to match Apache log format; found this piece online
    $regex = '^(?<IP>\S+) (?<LogName>\S+) (?<User>\S+) \[(?<DateTime>[^\]]+)\] "(?<Request>[^"]+)" (?<Status>\d+) (?<BytesSent>\d+) "(?<Referer>[^"]+)" "(?<UserAgent>[^"]+)"'

    # Get content of the log file
    $logContent = Get-Content -Path C:\xampp\apache\logs\access.log

    # Parse each line into a PSCustomObject
    $parsedLogs = foreach ($line in $logContent) {
        if ($line -match $regex) {
            [PSCustomObject]@{
                IP        = $Matches.IP
                LogName   = $Matches.LogName
                User      = $Matches.User
                DateTime  = $Matches.DateTime
                Request   = $Matches.Request
                Status    = $Matches.Status
                BytesSent = $Matches.BytesSent
                Referer   = $Matches.Referer
                UserAgent = $Matches.UserAgent
            }
        }
    }

    # Filter for IP addresses starting with 10.
   # $filteredLogs = $parsedLogs | Where-Object { $_.IP -like '10.*' }

    return $parsedLogs | Select-Object -Last 10
}

# Example usage
$logPath = "C:\xampp\apache\logs\access.log"
$filteredLogs = ParseApacheLogs -Path $logPath
$filteredLogs | Format-Table
