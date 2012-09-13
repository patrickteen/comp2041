#!/usr/bin/python2.7

import sys
import re

source = sys.argv[1]
dest = sys.argv[2]

lines = sys.stdin.readlines()
adj_matrix = {}

visited = []

# parse input
for line in lines:
	line = line.rstrip('\n')
	components = re.compile('\s+').split(line)
	if not adj_matrix.has_key(components[0]):
		adj_matrix[components[0]] = {}
	adj_matrix[components[0]][components[1]] = int(components[2])

# brute force all paths as it's small input
# dijkstra/floyd for optimisation
final_path = ""
min_length = -1
def dfs(current, destination, path, distance):
	global min_length
	global final_path
	path = path + " " + current
	if current == destination:
		if (min_length == -1) or (distance < min_length):
			min_length = distance
			final_path = path
	else:
		for v in adj_matrix[current].keys():
			if v not in visited:
				visited.append(v)
				dfs(v, destination, path, distance + adj_matrix[current][v])

dfs(source, dest, "", 0)
print ("Shortest route is length = " + str(min_length) + ":" + final_path)