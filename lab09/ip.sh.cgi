#!/bin/sh

echo 'Content-type: text/html'
echo
cat <<eof
<html>
	<head>
	<title>IP, Host and Browser IP</title>
		<style type="text/css">
		table{border-collapse:collapse;margin:0 auto;line-height:20px;width:728px;table-layout:fixed;}
		tr{height:30px;}
		td{border: solid 1px;padding: 0px 10px;}
		</style>
	</head
	<body>
		<table id="info_table" >
			<tr><td>Browser IP Address<td>$REMOTE_ADDR
			<tr><td>Browser Hostname<td>`host $REMOTE_ADDR | grep Name | sed 's/.*: //g'`
			<tr><td>Browser<td>$HTTP_USER_AGENT
		</table>
	</body>
</html>

eof
