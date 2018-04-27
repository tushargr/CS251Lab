#!/bin/bash
created_1=0;
created_2=0;
created_4=0;
created_8=0;
created_16=0;

for i in 1 2 4 8 16
do
	prev_num=-1;
	sum=0;
	counter=0;

	while read line;
	do
		num_elements=`echo $line | cut -d " " -f1 | bc`
		time=`echo $line | cut -d " " -f2 | bc`
		if [ $num_elements -ne $prev_num ]
		then
			if [ $prev_num -ne -1 ]
			then
				average=`echo "scale=3 ; $sum / $counter" | bc`
				if [ $i -eq 1 ]
				then
					if [ $created_1 -eq 0 ]
					then
						echo $prev_num $average > single_$i.out
						created_1=1;
					elif [ $created_1 -eq 1 ] 
					then
						echo $prev_num $average >> single_$i.out
					fi	
				fi
				if [ $i -eq 2 ]
				then
					if [ $created_2 -eq 0 ]
					then
						echo $prev_num $average > single_$i.out
						created_2=1;
					elif [ $created_2 -eq 1 ] 
					then
						echo $prev_num $average >> single_$i.out
					fi	
				fi
				if [ $i -eq 4 ]
				then
					if [ $created_4 -eq 0 ]
					then
						echo $prev_num $average > single_$i.out
						created_4=1;
					elif [ $created_4 -eq 1 ] 
					then
						echo $prev_num $average >> single_$i.out
					fi	
				fi
				if [ $i -eq 8 ]
				then
					if [ $created_8 -eq 0 ]
					then
						echo $prev_num $average > single_$i.out
						created_8=1;
					elif [ $created_8 -eq 1 ] 
					then
						echo $prev_num $average >> single_$i.out
					fi	
				fi
				if [ $i -eq 16 ]
				then
					if [ $created_16 -eq 0 ]
					then
						echo $prev_num $average > single_$i.out
						created_16=1;
					elif [ $created_16 -eq 1 ] 
					then
						echo $prev_num $average >> single_$i.out
					fi	
				fi

					
			fi
			prev_num=$num_elements
			sum=0
			counter=0
		fi
		sum=$((sum + time))
		counter=$((counter + 1))
	done < scatter_$i.out

	if [ $counter -ne 0 ]
	then
		average=`echo "scale=3 ; $sum / $counter" | bc`
		if [ $i -eq 1 ]
		then
			if [ $created_1 -eq 0 ]
			then
				echo $prev_num $average > single_$i.out
				created_1=1;
			elif [ $created_1 -eq 1 ] 
			then
				echo $prev_num $average >> single_$i.out
			fi	
		fi
		if [ $i -eq 2 ]
		then
			if [ $created_2 -eq 0 ]
			then
				echo $prev_num $average > single_$i.out
				created_2=1;
			elif [ $created_2 -eq 1 ] 
			then
				echo $prev_num $average >> single_$i.out
			fi	
		fi
		if [ $i -eq 4 ]
		then
			if [ $created_4 -eq 0 ]
			then
				echo $prev_num $average > single_$i.out
				created_4=1;
			elif [ $created_4 -eq 1 ] 
			then
				echo $prev_num $average >> single_$i.out
			fi	
		fi
		if [ $i -eq 8 ]
		then
			if [ $created_8 -eq 0 ]
			then
				echo $prev_num $average > single_$i.out
				created_8=1;
			elif [ $created_8 -eq 1 ] 
			then
				echo $prev_num $average >> single_$i.out
			fi	
		fi
		if [ $i -eq 16 ]
		then
			if [ $created_16 -eq 0 ]
			then
				echo $prev_num $average > single_$i.out
				created_16=1;
			elif [ $created_16 -eq 1 ] 
			then
				echo $prev_num $average >> single_$i.out
			fi	
		fi
	fi

	prev_num=-1;
	sum=0;
	counter=0;
done
