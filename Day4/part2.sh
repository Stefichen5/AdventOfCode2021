#!/bin/bash

input="$1"
OFFSET="3"

BINGO_NUMBERS="$(head "$input" -n1 | tr ',' ' ')"

INDEX=0
BINGO_FIELD=()
while IFS= read -r line ;	do
		if [ -z "$line" ] ; then
			INDEX=$((INDEX+1))
		else
			BINGO_FIELD[$INDEX]="${BINGO_FIELD[$INDEX]} $line "
		fi
done < <(tail -n +$OFFSET "$input")

for number in $BINGO_NUMBERS ; do
	for ((i=0 ; i<${#BINGO_FIELD[@]} ; i++)); do
		BINGO_FIELD[$i]=${BINGO_FIELD[$i]// $number /' X '}
		
		#Evaluate
		FIELD="$(echo "${BINGO_FIELD[$i]}" | xargs)"
		for k in {0..4} ; do
			XCNT="0"
			YCNT="0"
			for j in {0..4} ; do
				INDEXA=$((k+(j*5)))

				if [ "$(echo "$FIELD" | cut -d' ' -f $((INDEXA+1)) | xargs)" == "X" ] ; then
					XCNT=$((XCNT+1))
				fi

				INDEXB=$((j+(k*5)))

				if [ "$(echo "$FIELD" | cut -d' ' -f $((INDEXB+1)) | xargs)" == "X" ] ; then
					YCNT=$((YCNT+1))
				fi
				
				if [ "$XCNT" -eq 5 ] || [ "$YCNT" -eq 5 ] ; then
					echo "BINGO"
					echo "$FIELD"

					RESULT="0"
					for nr in $(echo "$FIELD" | tr -d 'X' | xargs) ; do
						RESULT=$((RESULT+nr))
					done 

					echo "$((RESULT*number))"

					#delete current line and continue
					BINGO_FIELD=( "${BINGO_FIELD[@]/${BINGO_FIELD[$i]}}"  )

#					exit
				fi
			done
		done
	done
done

exit

while IFS= read -r line
do
echo "$line"
done < "$input"
