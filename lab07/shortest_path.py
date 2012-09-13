#!/usr/bin/python2.7

import sys
import re

source = sys.argv[1]
dest = sys.argv[2]

lines = sys.stdin.readlines()
adj_matrix = {}

visited_nodes = []
all_nodes = []

# parse input
for line in lines:
	line = line.rstrip('\n')
	components = re.compile('\s+').split(line)
	if not adj_matrix.has_key(components[0]):
		adj_matrix[components[0]] = {}
	adj_matrix[components[0]][components[1]] = int(components[2])
	if not components[0] in all_nodes:
		all_nodes.append(components[0])
	if not components[1] in all_nodes:
		all_nodes.append(components[1])

# brute force as it's small input
# dijkstra/floyd for optimisation
visited = []
distance = 0
def dfs(current, destination):
	found = 0
	if current == destination:
		found = 1
	else:
		for v in adj_matrix[current].keys():
			if not v in visited:
				found = dfs(v, destination)

	return found

dfs(source, dest)


