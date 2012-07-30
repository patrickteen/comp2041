#!/bin/bash
counter=0
while [ $counter -lt $1 ] 
do
	echo $2
	counter=$((counter+1))
done


