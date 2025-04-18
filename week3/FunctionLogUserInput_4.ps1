﻿function Get-LogonLogoffEvents {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

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
            return $Sid  
        }
    }

    $startDate = (Get-Date).AddDays(-$Days)
    $eventList = @()

    Get-EventLog -LogName Security -After $startDate | Where-Object {$_.EventID -in @(4624, 4634)} | ForEach-Object {
        $sid = $_.ReplacementStrings[4]  
        $username = Convert-SidToUsername -Sid $sid

        $event = [PSCustomObject]@{
            Time = $_.TimeGenerated
            Id = $_.InstanceId
            Event = if ($_.EventID -eq 4624) { "Logon" } else { "Logoff" }
            User = $username
        }
        $eventList += $event
    }

    return $eventList
}


$userInput = Read-Host "Enter the number of days to retrieve logon/logoff events"


if ([int]::TryParse($userInput, [ref]$null)) {
    $days = [int]$userInput

    $results = Get-LogonLogoffEvents -Days $days
    $results | Format-Table -AutoSize
}
else {
    Write-Host "Invalid input. Please enter a valid number of days."
}
