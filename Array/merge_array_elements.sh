#!/bin/bash

# Description : Program to merge SubArray if last element of an array is same as first element of next array.
# Date : 08/19/2019
# Interpreter : '/bin/bash' as a shell (Mac osx) (GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18))
# @author - Vikas Jha

# Input  : ('(2 3)' '(4 5)' '(5 8)' '(9 10)' '(10 13)' '(13 19)')
# Output : ('(2 3)' '(4 8)' '(9 19)')


# Enable debugging - for developer
#set -x

# Local Variable
inputArrayList=('(2 3)' '(4 5)' '(5 8)' '(9 10)' '(10 13)' '(13 19)')

# function to compute Array list and return merged subArray 
getMergedArrayListOfMachingInput () {

	# assign parameter - 'directory path'
	input_arrayList=("$@")
	
	# Constant message variables
	ERR_MSG="Invalid input!"
	NO_MATCHING_MSG="No matching found!"
	
	COUNTER=0
	index=-1
	
	while [ $COUNTER -lt "${#input_arrayList[@]}" ];
	do
		current_index_item_floor=`echo "${input_arrayList[$COUNTER]}" | cut -d " " -f 1 | cut -d "(" -f 2`
		current_index_item_ceiling=`echo "${input_arrayList[$COUNTER]}" | cut -d " " -f 2 | cut -d ")" -f 1`
		
		let COUNTER=COUNTER+1
		[[ $COUNTER -lt "${#input_arrayList[@]}" ]] && next_index_item_floor=`echo "${input_arrayList[$COUNTER]}" | cut -d " " -f 1 | cut -d "(" -f 2`
		
		while [[ $current_index_item_ceiling -eq $next_index_item_floor ]] && [[ $COUNTER -lt "${#input_arrayList[@]}" ]]
		do 
			current_index_item_ceiling=`echo "${input_arrayList[$COUNTER]}" | cut -d " " -f 2 | cut -d ")" -f 1`
			let COUNTER=COUNTER+1
			[[ $COUNTER -lt "${#input_arrayList[@]}" ]] && next_index_item_floor=`echo "${input_arrayList[$COUNTER]}" | cut -d " " -f 1 | cut -d "(" -f 2` || next_index_item_floor=''
		done
		
		next_index_item_ceiling=`echo "${input_arrayList[$COUNTER-1]}" | cut -d " " -f 2 | cut -d ")" -f 1`
		
		let index=index+1
		input_arrayList[$index]="($current_index_item_floor $next_index_item_ceiling)"
	done	
	
	let i=index+1
	while [ $i -lt "${#input_arrayList[@]}" ]
	do
		input_arrayList[$i]=''
		let i=i+1
	done
	echo "${input_arrayList[@]}"
}

# Input Validation
# verify if input count is 1 and is directory, rest all other exit.
if [[ -z "${inputArrayList[@]}" || "${inputArrayList[@]}" == null ]]; then 
	echo "Invalid input!!"
	exit
elif [[ "${#inputArrayList[@]}" -eq 1 ]]; then 
	echo "${inputArrayList[@]}"  
else 
	client=$( getMergedArrayListOfMachingInput "${inputArrayList[@]}" )
	[[ -n "$client" ]] && echo "${client[@]}" || echo "Internal Error!"
fi

