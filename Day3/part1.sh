#!/bin/bash

input="$1"

GAMMA=""
EPSILON=""
LINES="$(wc -l $input | cut -d' ' -f1)"

MOST_COMMON_BIT=("")
while IFS= read -r line
do
	for ((i=0; i<${#line}; i++)); do
		MOST_COMMON_BIT[$i]=$((MOST_COMMON_BIT[$i]+${line:$i:1}))
	done
done < "$input"

for bit in "${MOST_COMMON_BIT[@]}"; do
	if [ $bit -gt $((LINES/2)) ] ; then
		GAMMA="${GAMMA}1"
		EPSILON="${EPSILON}0"
	else
		GAMMA="${GAMMA}0"
		EPSILON="${EPSILON}1"
	fi
done

#binary to decimal
GAMMA="$((2#$GAMMA))"
EPSILON="$((2#$EPSILON))"

echo $((GAMMA*EPSILON))

