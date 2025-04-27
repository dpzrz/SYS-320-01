#! /bin/bash

logDir="/var/log/apache2"

alllogs=$(ls "${logDir}" | grep "access.log" | grep -v "other_vhosts" | grep -v "gz")

:> access.txt

for i in ${alllogs}
do
     cat "${logDir}${i}" >> access.txt
done

tail access.txt
