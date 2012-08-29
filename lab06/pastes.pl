#!/usr/bin/perl -w

foreach $file (@ARGV) {
	open F, "<$file" or die $!;
	$line = <F>;
	chomp $line;
	print "$line";
	while ($line = <F>) {
		chomp $line;
		print "\t$line";
	}
	close (F);
	print "\n";
}
