#!/bin/bash

input="$1"
DAYS=256

FISHES="$(cat "$input")"
IFS=',' read -r -a FISH_ARRAY <<< "$FISHES"

#for every day
for ((day=0 ; day<DAYS ; day++)) ; do
	NR_OF_FISHES=${#FISH_ARRAY[@]}
	for ((i=0 ; i<NR_OF_FISHES; i++)) ; do
		VAL="${FISH_ARRAY[$i]}"
		if [ "$VAL" -eq 0 ] ; then
			FISH_ARRAY[$i]=6
			FISH_ARRAY+=("8")
		else
			FISH_ARRAY[$i]=$((VAL-1))
		fi
	done
	#echo "$day: ${FISH_ARRAY[@]}"
done

echo "${#FISH_ARRAY[@]}"
