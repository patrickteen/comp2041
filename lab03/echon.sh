#!/bin/sh

# check for correct num args
if [ $# -ne 2 ]
then
	echo "Usage: $0"
	exit
fi

# check for valid args
if [ $1 -lt 0  ]
then
	echo "$0: argument 1 must be a non-negative integer"
	exit
fi

counter=0
while [ $counter -lt $1 ] 
do
	echo $2
	counter=$((counter+1))
done
