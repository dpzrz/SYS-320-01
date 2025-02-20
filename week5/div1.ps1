# URL of the webpage to be scraped
$url = "http://10.0.17.16/ToBeScrapped.html"

$response = Invoke-WebRequest -Uri $url

# Send a web request and store the response
$response = Invoke-WebRequest -Uri $url

# Parse the HTML content
$parsedHTML = $response.ParsedHtml

# Get all div elements with class "div-1"
$divElements = $parsedHTML.getElementsByTagName("div") | Where-Object { $_.className -eq "div-1" }

# Print the innerText of matching div element
foreach ($div in $divElements) {
    Write-Output $div.innerText
}