#!/usr/bin/perl

use strict;

my %log_probability_hashes = ();
my %poem_log_probabilities = ();

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
	my $author = get_author_name_from_path($file);

	# init the hash of all log-probabilities
	$log_probability_hashes{$author} = {};
	for my $word_to_find (keys %word_hash) {
		$log_probability_hashes{$author}{$word_to_find} = log(($word_hash{$word_to_find}+1)/$total_word_count);
		$log_probability_hashes{$author}{"Total Word Count"} = $total_word_count;
	}

	close ($FH);
}


# poem1.txt most resembles the work of John Keats (log-probablity=-2721.2)
# sum of all log-probabilities of all words
for my $poem_file (@ARGV) {
	for my $author (keys %log_probability_hashes) {
		my $current_log_probability = 0;
		open(my $FH, $poem_file);
		while (my $line = <$FH>) {
			my @words = split("[^a-zA-Z]", $line);
			foreach my $word (@words) {
				$word =~ tr/A-Z/a-z/;
				if ($word !~ /^(\s+)?$/) {
					if (!$log_probability_hashes{$author}{$word}) {
						# additive smoothing
						$current_log_probability += log(1/$log_probability_hashes{$author}{"Total Word Count"});
					} else {
						$current_log_probability += $log_probability_hashes{$author}{$word};
					}
				}
			}
		}
		if ($current_log_probability > $poem_log_probabilities{$poem_file}{"p"} || !$poem_log_probabilities{$poem_file}{"p"}) {
			$poem_log_probabilities{$poem_file}{"p"} = $current_log_probability;
			$poem_log_probabilities{$poem_file}{"author"} = $author;
		}
	}
	printf("%s most resembles the work of %s (log-probablity=%.1f)\n",$poem_file,$poem_log_probabilities{$poem_file}{"author"},$poem_log_probabilities{$poem_file}{"p"});
}

sub get_author_name_from_path {
	my @parts = split("/", $_[0]);
	my $length = @parts;
	my $author = $parts[$length - 1];
	$author =~ s/\.txt//g;
	$author =~ tr/_/ /;
	return $author;
}