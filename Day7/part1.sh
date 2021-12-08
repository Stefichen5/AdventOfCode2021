#!/bin/bash

input=$1

OPTIMAL_FUEL=""

DATA=$(cat "$input")
IFS=',' read -r -a CRAB_ARRAY <<< "$DATA"

SUM="0"
MAX="$(echo "${CRAB_ARRAY[@]}" | tr ' ' '\n' | sort -nr | head -n1)"
MIN="$(echo "${CRAB_ARRAY[@]}" | tr ' ' '\n' | sort -nr | tail -n1)"

for ((i=MIN ; i <= MAX ; i++)) ; do
	SUM=0
	for elem in "${CRAB_ARRAY[@]}" ; do
		DIFF=0
		if [ "$elem" -gt "$i" ] ; then
			DIFF=$((elem-i))
		elif [ "$elem" -lt "$i" ] ; then
			DIFF=$((i-elem))
		fi
		SUM=$((SUM+DIFF))
	done

	#echo "Dest: $i / Fuel: $SUM"
	if [ -z "$OPTIMAL_FUEL" ] || [ $SUM -lt "$OPTIMAL_FUEL" ] ; then
		OPTIMAL_FUEL=$SUM
	fi
done

echo "$OPTIMAL_FUEL"
