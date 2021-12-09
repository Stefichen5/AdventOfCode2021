#!/bin/bash

input=$1

readarray -t input_array < "$input"

RISK_SUM="0"

Y_MAX=${#input_array[@]}

for ((y=0 ; y<Y_MAX ; y++)) ; do
	PREV_LINE="${input_array[$((y-1))]}"
	CUR_LINE="${input_array[y]}"
	NEXT_LINE="${input_array[$((y+1))]}"
	X_MAX=${#CUR_LINE}

	for ((x=0; x<X_MAX ; x++)) ; do
		SMALLEST="true"
		CUR_CHAR="${CUR_LINE:x:1}"

		#compare left
		if [ "$x" -ne 0 ] && [ "$CUR_CHAR" -ge "${CUR_LINE:x-1:1}" ] ; then
			SMALLEST=false
			continue
		fi

		#compare right
		if [ "$x" -lt "$((X_MAX-1))" ] && [ "$CUR_CHAR" -ge "${CUR_LINE:x+1:1}" ] ; then
			SMALLEST=false
			continue
		fi

		#compare up
		if [ "$y" -ne 0 ] && [ "$CUR_CHAR" -ge "${PREV_LINE:x:1}" ]  ; then
			SMALLEST=false
			continue
		fi

		#compare down
		if [ "$y" -lt "$((Y_MAX-1))" ] && [ "$CUR_CHAR" -ge "${NEXT_LINE:x:1}" ] ; then
			SMALLEST=false
			continue
		fi
		
		if [ "$SMALLEST" == "true" ] ; then
			#echo "$CUR_CHAR"
			#echo "x: $x / y: $y; l:${CUR_LINE:x-1:1}, r:${CUR_LINE:x+1:1}, u:${PREV_LINE:x:1}, d:${NEXT_LINE:x:1}"
			RISK_SUM=$((RISK_SUM+CUR_CHAR+1))
		fi
	done
done

echo "$RISK_SUM"
