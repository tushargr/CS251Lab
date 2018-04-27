#!/bin/bash

strings=0
comments=0
var=`find $1 -type f -name '*.c' -printf '%p\n'`
while read -r filepath 
do 
output=`awk -f qn1.awk "$filepath"`
var2=($output)
strings=$(($strings+${var2[0]}))
comments=$(($comments+${var2[1]}))
done <<< "$var"
echo $comments lines of comments
echo $strings quoted strings
