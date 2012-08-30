#!/usr/bin/python2.7

import sys

if len(sys.argv) != 3:
	print "Usage: " + sys.argv[0] + " num str"
else:
	i = 0
	while (i < int(sys.argv[1])):
		print sys.argv[2]
		i = i + 1