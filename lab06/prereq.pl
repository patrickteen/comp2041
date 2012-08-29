#!/usr/bin/perl -w

my @prereqs;

my $resursive;
my $base_course;
my $last = "";

for $arg (@ARGV) {
	if ($arg =~ "-r") {
		$recursive = 1;
	} else {
		&get_prereqs($arg)
	}
}

for $prereq (sort(@prereqs)) {
	print "$prereq\n" if ($prereq ne $last); 	#there are duplicates in the array, hack so they aren't printed
	$last = $prereq;
}

sub get_prereqs {
	my @matches;
	$url1 = "http://www.handbook.unsw.edu.au/undergraduate/courses/2012/$_[0].html";
	$url2 = "http://www.handbook.unsw.edu.au/postgraduate/courses/2012/$_[0].html";
	open my $F, "wget -q -O- $url1 $url2|" or die $!;
	while ($line = <$F>) {
		if ($line =~ /.*Prerequisite:.*/) {
			@matches = $line =~ /[A-Z]{4}[0-9]{4}/gi;
			for $match (@matches) {
				if (!is_seen($match)) {
					push(@prereqs, $match);
					&get_prereqs($match) if $recursive;
				}
			}
		}
	}
}

sub is_seen {
	my $found;
	for $val (@prereqs) {
		if ($val eq $_[0]) {
			$found = 1;
		}
	}
	return $found;
}