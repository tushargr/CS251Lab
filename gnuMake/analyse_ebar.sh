#!/bin/bash

created=0;
for i in 1 2 4 8 16
do
	prev_num=-1;
	sum=0;
	sq=0;
	counter=0;

	while read line;
	do
		num_elements=`echo $line | cut -d " " -f1 | bc`
		time=`echo $line | cut -d " " -f2 | bc`
		if [ $num_elements -ne $prev_num ]
		then
			if [ $prev_num -ne -1 ]
			then
				average=`echo "scale=4 ; $sum / $counter" | bc`
				y=`echo "scale=4 ; $average * $average" | bc`
				variance=`echo "scale=4 ; $sq / $counter" | bc`
				variance=`echo "scale=4 ; $variance - $y" | bc`
				echo $prev_num $average $variance >> error$i.txt
			fi
			prev_num=$num_elements
			sum=0
			sq=0
			counter=0
		fi
		sum=$((sum + time))
		x=$((time * time))
		sq=$((sq + x))
		counter=$((counter + 1))
	done < scatter_$i.out

	if [ $counter -ne 0 ]
	then
		average=`echo "scale=4 ; $sum / $counter" | bc`
		y=`echo "scale=4 ; $average * $average" | bc`
		variance=`echo "scale=4 ; $sq / $counter" | bc`
		variance=`echo "scale=4 ; $variance - $y" | bc`
		echo $prev_num $average $variance >> error$i.txt
	fi

	prev_num=-1;
	sum=0;
	sq=0;
	counter=0;
done

exec 3< error1.txt
exec 4< error2.txt
exec 5< error4.txt
exec 6< error8.txt
exec 7< error16.txt

while IFS= read -r -u3 line1;
do
    IFS= read -r -u4 line2
    IFS= read -r -u5 line3
    IFS= read -r -u6 line4
    IFS= read -r -u7 line5
    num_elements=`echo $line1 | cut -d " " -f1 | bc`
    avg1=`echo $line1 | cut -d " " -f2 | bc`
    avg2=`echo $line2 | cut -d " " -f2 | bc`
    avg3=`echo $line3 | cut -d " " -f2 | bc`
    avg4=`echo $line4 | cut -d " " -f2 | bc`
    avg5=`echo $line5 | cut -d " " -f2 | bc`
    var1=`echo $line1 | cut -d " " -f3 | bc`
    var2=`echo $line2 | cut -d " " -f3 | bc`
    var3=`echo $line3 | cut -d " " -f3 | bc`
    var4=`echo $line4 | cut -d " " -f3 | bc`
    var5=`echo $line5 | cut -d " " -f3 | bc`
    speedup1=`echo "scale=4 ; $avg1 / $avg1" | bc`
    speedup2=`echo "scale=4 ; $avg1 / $avg2" | bc`
    speedup4=`echo "scale=4 ; $avg1 / $avg3" | bc`
    speedup8=`echo "scale=4 ; $avg1 / $avg4" | bc`
    speedup16=`echo "scale=4 ; $avg1 / $avg5" | bc`
    
    if [ $created -eq 0 ]
    then
    	echo $num_elements $speedup1 $speedup2 $speedup4 $speedup8 $speedup16 $var1 $var2 $var3 $var4 $var5 > ebar.out
    	created=1;
    elif [ $created -eq 1 ]
    then
    	echo $num_elements $speedup1 $speedup2 $speedup4 $speedup8 $speedup16 $var1 $var2 $var3 $var4 $var5 >> ebar.out
    fi	
done

exec 3<&-
exec 4<&-
exec 5<&-
exec 6<&-
exec 7<&-
rm error1.txt
rm error2.txt
rm error4.txt
rm error8.txt
rm error16.txt