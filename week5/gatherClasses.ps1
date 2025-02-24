function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 -Uri "http://10.0.17.16/Courses.html"  # Replace with actual URL
    $trs = $page.ParsedHtml.getElementsByTagName("tr")
    $FullTable = @()

    for ($i = 1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")
        $Times = $tds[5].innerText.Split(" - ") #Splitting time

        $FullTable += [PSCustomObject]@{
            "Class Code"  = $tds[0].innerText
            "Title"       = $tds[1].innerText
            "Days"        = $tds[4].innerText
            "Time Start"  = $Times[0]
            "Time End"    = $Times[1]
            "Instructor"  = $tds[6].innerText
            "Location"    = $tds[9].innerText
        }
  }
 
 return $FullTable 
}

function Translate-DaysToArray($FullTable) {

    foreach ($record in $FullTable) {
        $Days = @() # Empty array to hold days for every record

        if ($record.Days -ilike "*M*") { $Days += "Monday" }
        if (($record.Days -ilike "*T*") -and ($record.Days -notlike "*TH*")) { $Days += "Tuesday" }
        if ($record.Days -ilike "*W*") { $Days += "Wednesday" }
        if ($record.Days -ilike "*TH*") { $Days += "Thursday" }
        if ($record.Days -ilike "*F*") { $Days += "Friday" }

        $record.Days = $Days
    }

    return $FullTable
}

