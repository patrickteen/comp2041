#!/bin/sh

# usage : ./date_image.sh file ...

# fetch the date information
dateRegex="^.*([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}).*$"
dateStamp=`ls -l "$1" | sed -r "s/$dateRegex/\1/g"`

# make the conversion

if convert -gravity south -pointsize 36 -annotate 0  "$dateStamp" "$1" "/tmp/$1.$$"
then

	# overwrite the original file if successful
	mv "/tmp/$1.$$" "./$1"
	rm "/tmp/$1.$$"
	
fi