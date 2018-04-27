#!/bin/bash

created1=0
created2=0
created4=0
created8=0
created16=0

while read line;
do
	thread=`echo $line | cut -d " " -f1 | bc`
	num_elements=`echo $line | cut -d " " -f2 | bc`
	time=`echo $line | cut -d " " -f3 | bc`
	
	if [ $thread -eq 1 ]
	then
		if [ $created1 -eq 0 ]
		then
			echo $num_elements $time > scatter_1.out
			created1=1
		elif [ $created1 -eq 1 ]
		then	
			echo $num_elements $time >> scatter_1.out
		fi
	fi

	if [ $thread -eq 2 ]
	then
		if [ $created2 -eq 0 ]
		then
			echo $num_elements $time > scatter_2.out
			created2=1
		elif [ $created2 -eq 1 ]
		then	
			echo $num_elements $time >> scatter_2.out
		fi
	fi

	if [ $thread -eq 4 ]
	then
		if [ $created4 -eq 0 ]
		then
			echo $num_elements $time > scatter_4.out
			created4=1
		elif [ $created4 -eq 1 ]
		then	
			echo $num_elements $time >> scatter_4.out
		fi
	fi

	if [ $thread -eq 8 ]
	then
		if [ $created8 -eq 0 ]
		then
			echo $num_elements $time > scatter_8.out
			created8=1
		elif [ $created8 -eq 1 ]
		then	
			echo $num_elements $time >> scatter_8.out
		fi
	fi

	if [ $thread -eq 16 ]
	then
		if [ $created16 -eq 0 ]
		then
			echo $num_elements $time > scatter_16.out
			created16=1
		elif [ $created16 -eq 1 ]
		then	
			echo $num_elements $time >> scatter_16.out
		fi
	fi
done < log.out