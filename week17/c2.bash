#! /bin/bash


if [ ! ${#} -eq 2 ]; then
	echo " NEED path to the log file + path to the ioc file"
else
	log=$1
	IOC=$2
	:> report.txt

	IOCLogs=$(cat "$log" | grep -f "$IOC" | cut -d' ' -f1,4,7 | tr -d '[')
	echo "${IOCLogs}"
	echo "$IOCLogs" >> report.txt
fi
