#!/bin/sh

kill -9 echo `ps | grep -e netcat -e webserver | grep -v $$ | cut -c1-5`

while true
do
	netcat -vvl localhost -p 2041 -c '
		set -x
		read http_request
		file=.`echo $http_request | sed -r "s/^GET ((\/[^ ]*)+).*?$/\1/g"`
		echo HTTP/1.0 200 OK
		echo halp
	'
done

		if ls -l $file > /dev/null
		
		then 
			echo halp
		else
			echo HTTP/1.0 404
		fi
