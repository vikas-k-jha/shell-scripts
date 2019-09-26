#!/bin/bash

# Description : Script to group file names having similar content.
# Interpreter : '/bin/bash' as a shell (Mac osx) (GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18))
# Assumption : Content order, blank space, tab, etc. should be intact. Any changes to above consider to be file mismatch
# Input      : file_path - directory

# Enable debugging - for developer
#set -x

# function to return Associative Array having matching files SubArray 
# Input 'directory path'
# return Associative Array (MAP)

getArrayListOfMachingFile () {

	# assign parameter - 'directory path'
	target_path=$1
	
	# Constant message variables
	ERR_MSG="Invalid input!"
	NO_MATCHING_MSG="No matching found!"
	
	# Assuming file having same content has exactly same CheckSum. We can keep this as a base to start the further grouping the similar files.
	# Verify : target path is empty, return 
	# Variable : file_checksum_list temporary variable to store list of Key=Value
	[[ -n "$target_path" ]] && file_checksum_list=$(find $target_path -maxdepth 1 -type f -exec md5 {} +) || echo "$ERR_MSG"
	
	# Get all the unique CheckSum 
	# Verify : file_checksum_list is empty, return 
	# Variable : unique_checksum_list temporary Array to store list of unique CheckSum
	[[ -n "$file_checksum_list" ]] && unique_checksum_list=($(echo "$file_checksum_list" | awk '{print $4}' | sort | uniq)) || echo "$NO_MATCHING_MSG"
	
	# Local variable
	declare -a mapArray=()
	matching_file_subarray=()
	
	# Group all the files having same CheckSum 
	# Iterate each CheckSum from unique_checksum_list and search list of matching files
	# Create matching files as temporary Array and push this SubArray to parent array
	for read_each_checksum in "${unique_checksum_list[@]}"; 
	do
		read -r -a array <<< "(`echo "$file_checksum_list" | grep "$read_each_checksum" | awk '{print $2}' | rev | cut -d \/ -f 1 | rev | cut -d ')' -f 1 | xargs`)"
		matching_file_subarray+=( ""${array[@]}"" )
	done
	
	# Push matching files SubArray to the map (Associative Array)
	[[ -n "${matching_file_subarray[@]}" ]] && mapArray[matching]="${matching_file_subarray[@]}"
	
	# Return Array
	echo "${mapArray[@]}"
}

# Input Validation
# verify if input count is 1 and is directory, rest all other exit.
if ([ $# -eq 1 ] && [ -d "$1" ] ); then 
	client=$( getArrayListOfMachingFile "$1" )
	[[ -n "$client" ]] && echo "${client[@]}" || echo "Internal Error!"
else
	echo "Invalid input!! Please provide absolute target path. \ne.g \n$ sh $0 <directory_path> \n" 
	exit 
fi

# END of the program

# TEST RUN
# $ sh list_file_name_having_same_contents.sh /Users/`whoami`/target_directory
# (( file1 file3 file4)(file2 file6)(file5))
