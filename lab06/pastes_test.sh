#!/bin/sh

echo "Running /usr/bin/paste"
paste -s test_files/file? > output2

echo "Running ./pastes.pl"
./pastes.pl test_files/file? > output1

echo "Running diff on the output"
if diff output1 output2
then
	echo "Test succeeded - output of ./pastes.pl matched /usr/bin/paste"
fi
