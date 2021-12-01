#!/bin/bash

input="$1"
PREV=""
INCREASES="0"
while IFS= read -r line
do
	if [ -z "$PREV" ] ; then
		PREV="$line"
	else
		if [ "$line" -gt "$PREV" ] ; then
			INCREASES=$((INCREASES+1))
		fi
		PREV="$line"
	fi
done < "$input"

echo $INCREASES
