#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

#results=$(cat "$file"| grep "page2.html"|cut -d' ' -f1,7 | tr -d "[")

function getAllLogs(){
	allLogs=$(cat "$file"|cut -d' ' -f1,4,7 | tr -d "[")
}



function ips(){
	ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)

}



function pageCount(){

	pagefinal=$(cat "$file"| cut -d' ' -f1,7 | tr -d "[" | sort | uniq -c | sort -rn)


}



getAllLogs
ips
pageCount
echo "$pagefinal"
echo "$ipsAccessed"
