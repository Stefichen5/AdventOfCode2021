#!/bin/bash

input="$1"
HORIZONTAL_POS="0"
DEPTH="0"
while IFS= read -r line
do
	COMMAND="$(echo "$line" | cut -d' ' -f1)"
	AMOUNT="$(echo "$line" | cut -d' ' -f2)"

	if [[ "$COMMAND" == "forward" ]] ; then
		HORIZONTAL_POS=$((HORIZONTAL_POS+AMOUNT))
	elif [[ "$COMMAND" == "up" ]] ; then
		DEPTH=$((DEPTH-AMOUNT))
	elif [[ "$COMMAND" == "down" ]] ; then
		DEPTH=$((DEPTH+AMOUNT))
	else
		echo "Unknown Command: $COMMAND"
	fi
done < "$input"

echo $((HORIZONTAL_POS*DEPTH))
