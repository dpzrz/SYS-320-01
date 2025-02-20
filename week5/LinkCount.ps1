
$url = "http://10.0.17.16/ToBeScrapped.html"


$response = Invoke-WebRequest -Uri $url


$linkCount = ($response.ParsedHtml.getElementsByTagName("a") | Measure-Object).Count


Write-Output "Number of links on the page: $linkCount.links"
