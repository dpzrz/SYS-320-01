. "C:\Users\champuser\SYS-320-01\week5\gatherClasses.ps1"

$classes = Translate-DaysToArray(gatherClasses)

#Write-Output $classes


$furkanClasses = $classes | Where-Object {$_.Instructor -eq "Furkan Paligu"}

Write-Output $furkanClasses
$joyc310Mondays = $classes | Where-Object {
   # $_. "Class Code" -eq "JOYC 310" -and $_.Days -contains "Monday"
}

 #Sort by Start Time
 $joyc310MondaysSorted = $joyc310Mondays | Sort-Object "Time Start"

classes | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.Days -contains "Monday") } | 
Sort-Object "Time Start" | Format-Table "Time Start", "Time End", "Class Code"


<#$classes | Where-Object {
    $_. "Class Code" -like "SYS*" -or
    $_. "Class Code" -like "NET*" -or
    $_. "Class Code" -like "SEC*" -or
    $_. "Class Code" -like "FOR*" -or
    $_. "Class Code" -like "CSI*" -or
    $_. "Class Code" -like "DAT*"
`} | Select-Object Instructor -Unique | Sort-Object Instructor
#>


$classes | Group-Object Instructor | Select-Object Name, Count | Sort-Object Count -Descending