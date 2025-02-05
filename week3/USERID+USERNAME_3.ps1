function Convert-SidToUsername {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Sid
    )

    try {
        $securityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($Sid)
        $ntAccount = $securityIdentifier.Translate([System.Security.Principal.NTAccount])
        return $ntAccount.Value
    }
    catch {
        return $Sid  # Return the original SID if translation fails
    }
}

$startDate = (Get-Date).AddDays(-14)
$eventList = @()

Get-EventLog -LogName Security -After $startDate | Where-Object {$_.EventID -in @(4624, 4634)} | ForEach-Object {
    $sid = $_.ReplacementStrings[4]  # SID is typically in index 4 for these events
    $username = Convert-SidToUsername -Sid $sid

    $event = [PSCustomObject]@{
        Time = $_.TimeGenerated
        Id = $_.InstanceId
        Event = if ($_.EventID -eq 4624) { "Logon" } else { "Logoff" }
        User = $username
    }
    $eventList += $event
}

$eventList | Format-Table -AutoSize
