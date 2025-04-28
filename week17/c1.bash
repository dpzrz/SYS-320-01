#! /bin/bash

link="http://10.0.17.6/IOC.html"
logFile="/home/champuser/SYS-320-01/week17/access.log"

:> ioc.txt


basePage=$(curl -sL "$link")

filteredIOChtml=$(echo "$basePage" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of \
"//html//body//table//td")

IOC=$(echo "$filteredIOChtml" | sed 's/<\/td>/\n/g' | sed 's/<td>//g' | sed -n '2~2!p')

echo "$IOC" >> ioc.txt
