
cat C:\xampp\apache\logs\access.log 
#cat C:\xampp\apache\logs\access.log -Tail 5
#cat C:\xampp\apache\logs\access.log | Select-String ' 400 ', ' 404 '
#cat C:\xampp\apache\logs\access.log | Select-String ' 200 ', ' OK ' -NotMatch