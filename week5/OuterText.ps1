# URL of the webpage to be scraped
$url = "http://10.0.17.16/ToBeScrapped.html"

# Send a web request and store the response
$response = Invoke-WebRequest -Uri $url


$parsedHTML = $response.ParsedHtml

# Get all h2 elements
$h2Elements = $parsedHTML.getElementsByTagName("h2")

# Extract the outer text of each h2 element
$h2TextArray = $h2Elements | ForEach-Object { $_.outerText }

# Output the results
$h2TextArray