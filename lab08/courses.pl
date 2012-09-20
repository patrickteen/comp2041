#!/usr/bin/perl -w
use strict;
if (!$ARGV[0]) {
	print "Usage: ./courses.pl <coursename>\n";
	exit(1);
}
my $url =  "http://www.timetable.unsw.edu.au/current/$ARGV[0]KENS.html";
open my $p, "wget -q -O- $url|" or die $!;
while (my $line = <$p>) {
	my $course_name = $ARGV[0];
	if ($line =~ /<td class="data"><a href="($course_name[0-9]{4}).html">$course_name[0-9]{4}<\/a><\/td>/) {
		print $1."\n";
	}
}