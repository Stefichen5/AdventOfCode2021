#!/bin/bash

input="$1"
DAYS=256

#count base
for ((i=0 ; i<9 ; i++)) ; do
	FISH_ARRAY[$i]=$(tr -dc "$i" < "$input" | wc -c)
done

for ((day=0 ; day<DAYS ; day++)) ; do
	TMP=${FISH_ARRAY[6]}
	#not beautiful because it's hardcoded but I don't have time for a more beautiful solution right now
	FISH_ARRAY[6]=$((FISH_ARRAY[7]+FISH_ARRAY[0]))
	FISH_ARRAY[7]=$((FISH_ARRAY[8]))
	FISH_ARRAY[8]=$((FISH_ARRAY[0]))	
	FISH_ARRAY[0]=$((FISH_ARRAY[1]))
	FISH_ARRAY[1]=$((FISH_ARRAY[2]))
	FISH_ARRAY[2]=$((FISH_ARRAY[3]))
	FISH_ARRAY[3]=$((FISH_ARRAY[4]))
	FISH_ARRAY[4]=$((FISH_ARRAY[5]))
	FISH_ARRAY[5]=$((TMP))
done

SUM=0
for ((i=0; i<9; i++)) ; do
	SUM=$((SUM+FISH_ARRAY[i]))
done

echo "${SUM}"
