#!/bin/bash

input="$1"
HORIZONTAL_POS="0"
DEPTH="0"
AIM="0"
while IFS= read -r line
do
	COMMAND="$(echo "$line" | cut -d' ' -f1)"
	AMOUNT="$(echo "$line" | cut -d' ' -f2)"

	if [[ "$COMMAND" == "forward" ]] ; then
		HORIZONTAL_POS=$((HORIZONTAL_POS+AMOUNT))
		DEPTH=$((DEPTH+(AIM*AMOUNT)))
	elif [[ "$COMMAND" == "up" ]] ; then
		AIM=$((AIM-AMOUNT))
	elif [[ "$COMMAND" == "down" ]] ; then
		AIM=$((AIM+AMOUNT))
	else
		echo "Unknown Command: $COMMAND"
	fi
done < "$input"

echo $((HORIZONTAL_POS*DEPTH))
