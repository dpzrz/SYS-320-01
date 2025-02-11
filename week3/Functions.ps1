# Functions.ps1

function Get-LogonLogoffEvents {
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
            Time  = $_.TimeGenerated
            Id    = $_.InstanceId
            Event = if ($_.EventID -eq 4624) { "Logon" } else { "Logoff" }
            User  = $username
        }
        $eventList += $event
    }

    return $eventList
}

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
