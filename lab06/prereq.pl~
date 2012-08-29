#!/usr/bin/perl -w

$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2012/$ARGV[0].html";
open F, "wget -q -O- $url|" or die $!;
while ($line = <F>) {
	if ($line =~ /.*Prerequisite:.*/) {
		@matches = $line =~ /[A-Z]{4}[0-9]{4}/gi;
		for $match (@matches) {
			print "$match\n";
		}
	}
}
$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2012/$ARGV[0].html";
open F, "wget -q -O- $url|" or die $!;
while ($line = <F>) {
	if ($line =~ /.*Prerequisite:.*/) {
		@matches = $line =~ /[A-Z]{4}[0-9]{4}/gi;
		for $match (@matches) {
			print "$match\n";
		}
	}
}
