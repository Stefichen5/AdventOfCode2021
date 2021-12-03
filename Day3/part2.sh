#!/bin/bash

input="$1"

OXYGEN_GENERATOR_RATING=""
CO2_SCRUBBER_RATING=""
OXY_DONE="false"
CO2_DONE="false"

LINE_LENGTH="$(($(head $input -n1 | wc -c)-1))"
MOST_COMMON_BIT=("")

for ((i=0; i<$LINE_LENGTH; i++)); do
	ONE_COUNT_OXY="0"
	ZERO_COUNT_OXY="0"
	ONE_COUNT_CO2="0"
	ZERO_COUNT_CO2="0"
	while IFS= read -r line
	do
		if [[ $line == ${OXYGEN_GENERATOR_RATING}* ]] ; then
			BIT="${line:$i:1}"
			if [ $BIT -eq 1 ] ; then
				ONE_COUNT_OXY=$((ONE_COUNT_OXY+1))
			else
				ZERO_COUNT_OXY=$((ZERO_COUNT_OXY+1))
			fi
		fi

		if [[ $line == ${CO2_SCRUBBER_RATING}* ]] ; then
			BIT="${line:$i:1}"
			if [ $BIT -eq 1 ] ; then
				ONE_COUNT_CO2=$((ONE_COUNT_CO2+1))
			else
				ZERO_COUNT_CO2=$((ZERO_COUNT_CO2+1))
			fi
		fi
	done < "$input"

	if [ "$OXY_DONE" == "false" ] ; then
		if [ $ONE_COUNT_OXY -ge $ZERO_COUNT_OXY ] ; then
			OXYGEN_GENERATOR_RATING="${OXYGEN_GENERATOR_RATING}1"
		else
			OXYGEN_GENERATOR_RATING="${OXYGEN_GENERATOR_RATING}0"
		fi
	fi

	if [ "$CO2_DONE" == "false" ] ; then
		if [ $ONE_COUNT_CO2 -ge $ZERO_COUNT_CO2 ] ; then
			CO2_SCRUBBER_RATING="${CO2_SCRUBBER_RATING}0"
		else
			CO2_SCRUBBER_RATING="${CO2_SCRUBBER_RATING}1"
		fi
	fi
	#check if only one line left
	if [ "$OXY_DONE" == "false" ] && [ "$(grep -Pc "^${OXYGEN_GENERATOR_RATING}" "$input")" -eq 1 ] ; then
		OXYGEN_GENERATOR_RATING=$(grep -P "^${OXYGEN_GENERATOR_RATING}" "$input")
		OXY_DONE="true"
	fi

	if [ "$CO2_DONE" == "false" ] && [ "$(grep -Pc "^${CO2_SCRUBBER_RATING}" "$input")" -eq 1 ] ; then
		CO2_SCRUBBER_RATING=$(grep -P "^${CO2_SCRUBBER_RATING}" "$input")
		CO2_DONE="true"
	fi
done

#binary to decimal
OXYGEN_GENERATOR_RATING="$((2#$OXYGEN_GENERATOR_RATING))"
CO2_SCRUBBER_RATING="$((2#$CO2_SCRUBBER_RATING))"
echo "$((OXYGEN_GENERATOR_RATING*CO2_SCRUBBER_RATING))"

