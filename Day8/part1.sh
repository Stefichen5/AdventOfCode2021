#!/bin/bash

input=$1

OCCURANCES="0"
while IFS= read -r line
do
	OUTPUT="$(echo "$line" | cut -d'|' -f2)"
	for word in $OUTPUT ; do
		#easy digits: 1, 4, 7, 8
		if [ ${#word} -eq 2 ] || [ ${#word} -eq 4 ] || [ ${#word} -eq 3 ] || [ ${#word} -eq 7 ] ; then
			OCCURANCES="$((OCCURANCES+1))"
		fi
	done
done < "$input"

echo $OCCURANCES
