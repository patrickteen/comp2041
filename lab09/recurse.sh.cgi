#!/bin/sh

echo 'Content-type: text/html'
echo
cat <<eof
<html>
	<head>
		<title>Recurse</title>
	</head
	<body>
		<b>Level `expr $QUERY_STRING + 1`</b>: 
		<a href="$SCRIPT_NAME?`expr $QUERY_STRING + 1`">
			Run me again
		<a/>
	</body>
</html>
eof
