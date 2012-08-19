#!/usr/bin/perl
$num_args = @ARGV;
if ($num_args != 2) {
	print "Usage: ./echon.pl num str\n";
	exit;
}
for ($i = 0; $i < $ARGV[0]; $i++) {
	print $ARGV[1];
	print "\n";
}