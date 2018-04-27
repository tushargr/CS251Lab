#!/bin/bash
created=0;
while read num_elements;
do
	while read num_threads;
	do
		for (( c=1; c<=100; c++ ))
		do  
   			op=`./app "$num_elements" "$num_threads"`
   			time=`echo $op | cut -d " " -f4 | bc`
			if [ $created -eq 0 ]
			then
				echo $num_threads $num_elements $time > log.out
				created=1;
			elif [ $created -eq 1 ]
			then
				echo $num_threads $num_elements $time >> log.out
			fi
		done
	done < <(tr ' ' '\n' < threads.txt)
done < <(tr ' ' '\n' < params.txt)