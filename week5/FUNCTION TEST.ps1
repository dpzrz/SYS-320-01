

Function checkUser ($name){
$checkForUser = (Get-LocalUser).Name -Contains $name

if ($checkForUser -eq $false) { 
Write-Host "False" 
} ElseIf ($checkForUser -eq $true) { 
Write-Host "True"
}

}

checkUser "champuser"