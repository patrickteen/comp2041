#!/usr/bin/perl -w

@files = ();
$n=10;
foreach $arg (@ARGV) {
	if ($arg eq "--version") {
		print "$0: version 0.1\n";
		exit(0);
	} elsif ($arg =~ /-[0-9]+/) {
		$n = $arg;
		$n =~ s/-//g;
	} else {
		push @files, $arg;
	}
}
foreach $f (@files) {
	$wc_result = `wc -l $f 2>/dev/null`;
	($num_lines) = split " ", $wc_result;
	open(F,"<$f") or die "$0: Can't open $f: $!\n";
	if (@files > 1) {
		print "==> $f <==\n";
	}
	$i = 0;
	while ($line = <F>) {
		if ($i >= ($num_lines - $n)) {
			print $line;
		}
		$i++;
	}
	close(F);
}
