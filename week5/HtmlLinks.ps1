# URL of the webpage to be scraped
$url = "http://10.0.17.16/ToBeScrapped.html"

# Send a web request and store the response
$response = Invoke-WebRequest -Uri $url

# Get all the links
$links = $response.Links

# Output the links
Write-Output "Links found on the page:"
$links | ForEach-Object { $_.href }

# Output the total count of links
Write-Output "`nTotal number of links: $($links.Count)"

$response.Links