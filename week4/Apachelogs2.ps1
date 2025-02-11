#$A = Get-Content -Path C:\xampp\apache\logs\*.log | Select-String -Pattern "error"
$A = Select-String -Pattern "error" -Path "C:\xampp\apache\logs\*.log"

#$A[-4 .. -1]

$notfounds = Select-String -Pattern " 404 " -Path "C:\xampp\apache\logs\*.log"

$regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

#$ipsUnorganized

$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
 }
 $ipsoften = $ips | Where-Object {$_.IP -ilike "10.*"}
 $counts = $ipsoften | Group-Object "IP"
 $counts | Select-Object Count, Name






