$service = Get-Process -Name chrome 

if(-not $service){
    Start-Process "chrome" "www.champlain.edu"
    "Chrome is now running"

}else{
Stop-Process $service
"chrome is already running"
}