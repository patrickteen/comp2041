#!/usr/bin/perl -w
$i = 0;
# read all lines into an array
while ($line = <STDIN>) {
	$lines[$i] = $line;
	$i++;
}
# randomly print them out
$j = 0;
while ($j < $i) {
	$random_n = rand($i);
	if ($lines[$random_n] !~ /NaN/) {
		print $lines[$random_n];
		$lines[$random_n] = "NaN";
		$j++;
	}
}
