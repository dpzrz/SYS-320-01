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


$response.Links | ForEach-Object { Write-Host "URL: $($_.href), Text: $($_.outerText)" }



$parsedHTML = $response.ParsedHtml

# Get all h2 elements
$h2Elements = $parsedHTML.getElementsByTagName("h2")

# Extract the outer text of each h2 element
$h2TextArray = $h2Elements | ForEach-Object { $_.outerText }

# Output the results
$h2TextArray