#!/usr/bin/perl -w
use strict;
my $d_flag;
my $t_flag;
for (@ARGV) {
	$d_flag = 1 if ($_ =~ /-d/);
	$t_flag = 1 if ($_ =~ /-t/);
}
my %timetable = ();
@ARGV = grep { $_ =~ /[A-Z]{4}[0-9]{4}/i } @ARGV;
for my $course (@ARGV) {
	my $url =  "http://www.timetable.unsw.edu.au/current/$course.html";
	my $i = -1;
	my $sem;
	open my $p, "wget -q -O- $url|" or die $!;
	while (my $line = <$p>) {
		my $course_name = $ARGV[0];
		if ($line =~ /<td class="data"><a href="#(S[12])-[0-9]+">Lecture<\/a><\/td>/) {
			$sem = $1;
			$i = 6; # skip 5 lines
		}
		if ($i == 0) {
			$line =~ /<td class="data">(.*?)<\/td>/;
			$line = $1;
			if ($d_flag) {
				if ($line) {
					$i = 0;
					my @matches = ($line =~ m/((Mon|Tue|Wed|Thu|Fri|Sat|Sun) [0-9]{2})/g);
					for (@matches) {
						print $sem." ".$course." ".$_, "\n" if ($_ =~ m/[0-9]/);
					}
				}
			} elsif ($t_flag) {
				$i = 0;
				if ($line) {
					my @matches = ($line =~ m/((Mon|Tue|Wed|Thu|Fri|Sat|Sun) [0-9]{2}:[0-9]{2} - [0-9]{2}:[0-9]{2})/g);
					for (@matches) {
						if ($_ =~ m/[0-9]/) {
							(my $day, my $start, my $end) = ($_ =~ m/([a-z]{3}) ([0-9]{2}):[0-9]{2} - ([0-9]{2}):[0-9]{2}/i);
							while ($start < $end) {
								$timetable{$sem}{$start}{$day}++;
								$start++;
							}
						}
					}
				}
			} else {
				if ($line) {
					print "$course: $sem $line\n";
				}
			}
			$i--;
		} else {
			$i-- if ($i > 0);
		}
	}
}

if ($t_flag) {

	for my $sem (keys %timetable) {
		print "$sem\t\tMon\tTue\tWed\tThu\tFri\n";
		for my $hour (@{[9,10,11,12,13,14,15,16,17,18,19,20]}) {
			printf "%02d:00\t", $hour;
			for my $day (@{["Mon","Tue","Wed","Thu","Fri"]}) {
				print "\t";
				if ( $timetable{$sem}{$hour}{$day}) {
					printf "%d", $timetable{$sem}{$hour}{$day};
				}
			}
			print "\n";
		}
	}

}