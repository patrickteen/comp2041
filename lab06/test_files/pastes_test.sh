#!/bin/sh

../paste.pl file? > output1
paste -s file? > output2
diff output1 output2
