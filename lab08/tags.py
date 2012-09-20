#!/usr/bin/python2.7

import urllib
import sys
import re

if len(sys.argv[1:]) is 0:
	print "No url specified."
	sys.exit(1)

for arg in sys.argv[1:]:
	if arg == "-f":
		f_flag = 1
	else:
		f_flag = 0

# grab source
src = urllib.urlopen(str(sys.argv[1])).read()

# remove comments
src = re.sub("<!--(.*?)-->", "", src)

# count tags
tags = {}
for tag in re.compile("<\s*\w+\s*.*?>", re.IGNORECASE).findall(src):
	tag = re.sub("<\s*(\w+)\s*.*?>", r"\1", tag)
	if not tags.has_key(tag):
		tags[tag] = 0
	tags[tag] = tags[tag] + 1

# sort tags by frequency
if f_flag:
	tags = sorted(tags.items(), key=lambda x: x[1])
	for tag in tags:
		print str(tag[1]) + "\t" + tag[0]
else:
	for tag in tags.keys():
		print str(tags[tag]) + "\t" + tag

