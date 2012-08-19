#!/bin/bash

echo "Small files: "`wc -l * | sed 's/^ *//g' | sort -n  | head -n-1 | egrep "^[0-9] " | sort -r | cut -d' ' -f2`
echo "Medium files: "`wc -l * | sed 's/^ *//g' | sort -n  | head -n-1 | egrep "^[1-9][0-9] " | sort -r |  cut -d' ' -f2`
echo "Large files: "`wc -l * | sed 's/^ *//g' | sort -n  | head -n-1 | egrep "^[1-9][0-9][0-9]+ "| sort -r |  cut -d' ' -f2`
