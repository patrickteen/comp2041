#!/usr/bin/python2.7

import sys
for arg in sys.argv[1:]:
	i = 0
	fp = open(arg)
	while (i < 10):
		print fp.readline().rstrip("\n")
		i = i + 1