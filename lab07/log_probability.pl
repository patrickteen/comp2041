#!/usr/bin/perl

use strict;
my $word_to_find = $ARGV[0];

if ($word_to_find) {
	foreach my $file (glob "test_files/poets/*.txt") {
		my %word_hash = ();
		my $total_word_count = 0;
		open(my $FH, $file);
		while (my $line = <$FH>) {
			my @words = split("[^a-zA-Z]", $line);
			foreach my $word (@words) {
				$word =~ tr/A-Z/a-z/;
				if ($word !~ /^(\s+)?$/) {
					$word_hash{$word}++;
					$total_word_count++;
				}
			}
		}

		#includes additive smoothing
		my $log_probability = log(($word_hash{$word_to_find}+1)/$total_word_count);
		my $author = get_author_name_from_path($file);

		printf("log((%d+1)/%6d) = %8.4f %s\n", $word_hash{$word_to_find}, $total_word_count, $log_probability, $author);

		close ($FH);
	}
} else {
	print "Specify a word to find.\n";
}


sub get_author_name_from_path {
	my @parts = split("/", $_[0]);
	my $length = @parts;
	my $author = $parts[$length - 1];
	$author =~ s/\.txt//g;
	$author =~ tr/_/ /;
	return $author;
}