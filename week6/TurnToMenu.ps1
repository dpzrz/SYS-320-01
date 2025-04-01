. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logswk5.ps1)
. (Join-Path $PSScriptRoot ApacheLogsParsing1.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Fisplay last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser`n"
$Prompt += "5 - Exit`n"


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $logPath = "C:\xampp\apache\logs\access.log"
        $filteredLogs = ParseApacheLogs -Path $logPath
        $filteredLogs | Format-Table
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getFailedLogins 90
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    elseif($choice -eq 3){ 

      $days = Read-Host -Prompt "Please enter the number of days to check"
      $failedLogins = getFailedLogins $days
      $atRiskUsers = $failedLogins | Group-Object User | Where-Object { $_.Count -gt 10 } | Select-Object Name, Count
      Write-Host "Users with more than 10 failed logins in the last $days days:" | Out-String
      Write-Host ($atRiskUsers | Format-Table | Out-String)
    
     }
        


    elseif($choice -eq 4){
        $chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue

        if ($null -eq $chromeProcess) {
        Write-Host "Chrome is not running. Starting Chrome and navigating to champlain.edu..."
        Start chrome.exe -ArgumentList "https://champlain.edu"
        } else {
        Write-Host "Chrome is already running."
        }

    }
}
