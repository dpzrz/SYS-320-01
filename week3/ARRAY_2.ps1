$startDate = (Get-Date).AddDays(-14)
$eventList = @()

Get-EventLog -LogName Security -After $startDate | Where-Object {$_.EventID -in @(4624, 4634)} | ForEach-Object {
    $event = [PSCustomObject]@{
        Time = $_.TimeGenerated
        Id = $_.InstanceId
        Event = if ($_.EventID -eq 4624) { "Logon" } else { "Logoff" }
        User = $_.ReplacementStrings[5]
    }
    $eventList += $event
}

$eventList | Format-Table -AutoSize
