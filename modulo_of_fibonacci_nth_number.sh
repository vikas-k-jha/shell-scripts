#!/usr/bin/env bash

# Description : Program to find F(n) % m from fibonacci series
# Interpreter : '/bin/bash' as a shell (Mac osx) (GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18))
# @author - Vikas Jha

########## Input 
#	a - first element
#	b - second element
#	n - number of element in fibonacci series 
# 	m - random number
########## OUTPUT
#	F(n) % m 	 

# Enable debugging - for developer
#set -x

# function to get F(n) % m
_get_modulo_from_fibonacci_series () {

	# read input 
	a=$1
	b=$2
	n=$3
	m=$4
	
	for (( counter=1; counter<$n; counter++ )) 
	do
    	temp=$(( $a + $b )) 
   		a=$b 
   		b=$temp
	done
	echo "$(( $b % $m ))"
	
}

## User input validation 
# total number of parameter = 4
# a [first element] 	- non-empty, number, 0<=a<=100000
# b [second element] 	- non-empty, number, 0<=b<=100000
# n [fibo length] 	- non-empty, number, 2<=n<=100000
# m [random number] 	- non-empty, number, 2<=m<=100000
# a < b

if ! [ $# -eq 4 ] || ! [ "$1" -eq "$1" 2> /dev/null ] || ! [ "$1" -ge 0 ] || ! [ "$1" -le 100000 ] || ! [ "$2" -eq "$2" 2> /dev/null ] || ! [ "$2" -ge 0 ] || ! [ "$2" -le 100000 ] || ! [ "$1" -le "$2" ] || ! [ "$3" -eq "$3" 2> /dev/null ] || ! [ "$3" -ge 2 ] || ! [ "$3" -le 100000 ] || ! [ "$4" -eq "$4" 2> /dev/null ] || ! [ "$4" -ge 2 ] || ! [ "$4" -le 100000 ]; then
	echo "Invalid input!!"
else
	_get_modulo_from_fibonacci_series "$1" "$2" "$3" "$4"
fi


##### TEST CASE
# Fail
# sh get_modulo_from_fibonacci_series.sh 1
# sh get_modulo_from_fibonacci_series.sh 1 2 3
# sh get_modulo_from_fibonacci_series.sh 1 2 3 4 5
# sh get_modulo_from_fibonacci_series.sh a 2 3 4
# sh get_modulo_from_fibonacci_series.sh a  3 4
# sh get_modulo_from_fibonacci_series.sh 1 b 3 4
# sh get_modulo_from_fibonacci_series.sh 1 2 n 4
# sh get_modulo_from_fibonacci_series.sh 1 2 3 m
# sh get_modulo_from_fibonacci_series.sh 1 2 3 1
# sh get_modulo_from_fibonacci_series.sh 1 2 1 4
# sh get_modulo_from_fibonacci_series.sh -1 2 3 4
# sh get_modulo_from_fibonacci_series.sh 1 -2 3 4
# sh get_modulo_from_fibonacci_series.sh 100001 2 3 4
# sh get_modulo_from_fibonacci_series.sh 1 2 100001 4
# sh get_modulo_from_fibonacci_series.sh 4 2 3 4

# PASS
# sh get_modulo_from_fibonacci_series.sh 1 2 3 4
# sh get_modulo_from_fibonacci_series.sh 100000 2 3 5
# sh get_modulo_from_fibonacci_series.sh 1 2 100000 3
