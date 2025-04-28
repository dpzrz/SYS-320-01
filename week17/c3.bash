#! /bin/bash

report="report.txt"
destfile="/var/www/html/report.html"

heading=\
"<html>\n"\
"<head>\n"\
"<title>Access logs woth IOC indicators</title>\n"\
"<style> table, th, td {border: 1px solid black; }</style>\n"\
"</head>\n"\
"<body>\n"\
"<br>\n"\
"<br>\n"\
"Access logs with IOC indicators:\n"\
"</br>\n"\
"</br>\n"\
"<table>\n"\
"<tbody>\n"

closer=\
"</tbody>\n"\
"</table>\n"\
"</body>\n"\
"</html>\n"

echo -e ${heading} > "$destfile"

while read -r line; do

echo "<tr><td>" >> "$destfile"
echo "$line" | sed 's/ / <\/td><td> /g' >> "$destfile"
echo "</td></tr>" >> "$destfile"
done < "$report"

echo -e "$closer" >> "$destfile"




