..\Apache-Logs.ps1
..\ApacheLogsParsing1.ps1

# Define the parameters for filtering logs
$Page = "index.html"  # Page visited or referred from
$HttpCode = "200"     # HTTP code returned
$Browser = "Mozilla"  # Web browser name

# Call the Gatherer function with specified parameters
$Result = gatherer -pg $Page -cd $HttpCode -wb $Browser

# Display the results
#Write-Output "IP Addresses matching criteria:"
foreach ($IP in $Result) {
    Write-Output "$($IP.Name) - Count: $($IP.Count)"
}



$Result2 = ParseApacheLogs


Write-Output $Result2 