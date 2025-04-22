#!/bin/bash

# List all the ips in the given network prefix
[ "$#" -ne 1 ] && echo "Usage: $0  <Prefix>" && exit 1

prefix=$1

[ "${#prefix}" -le 5 ] && echo "Error: Prefix must be at least 5 charchters long." && exit 1



for i in {1..254}
do
	ping -c 1 "$prefix.$i" | grep "64 bytes from" | \
	grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done

