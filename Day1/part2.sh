#!/bin/bash

input="$1"
PREV=""
INCREASES="0"
SUMS=""
SLIDING_WINDOW_SIZE="3"
LINES=""

IFS=$'\n' read -d '' -r -a LINES < "$input"

for ((i = 0 ; i < $((${#LINES[@]}-SLIDING_WINDOW_SIZE+1)) ; i++)); do
	SUM=0
	for ((j = 0; j < "$SLIDING_WINDOW_SIZE" ; j++)); do
		index=$((i+j))
		SUM=$((SUM+${LINES[$index]}))
	done
	SUMS+=" $SUM"
done

for sum in $SUMS ; do
	if [ -z "$PREV" ] ; then
		PREV="$sum"
	else
		if [ "$sum" -gt "$PREV" ] ; then
			INCREASES=$((INCREASES+1))
		fi
		PREV="$sum"
	fi
done

echo $INCREASES
