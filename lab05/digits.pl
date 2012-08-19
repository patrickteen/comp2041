#!/usr/bin/perl

$input = <STDIN>;
$input =~ s/[0-4]/</g;
$input =~ s/[6-9]/>/g;
print $input