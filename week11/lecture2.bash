#!bin/bash

file="/var/log/apache2/access.log"

function countingCurlAccess(){

        #cCurl=$(grep "curl" "$file" | cut -d ' ' -f1| sort | uniq -c)
	cCurl=$(grep "curl" "$file" | awk '{print $1, "\""$12"\""}' | sort | uniq -c | sort -nr)
	

}

countingCurlAccess
echo $cCurl
