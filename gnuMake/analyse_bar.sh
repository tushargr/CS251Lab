#!/bin/bash

created=0;
exec 3< single_1.out
exec 4< single_2.out
exec 5< single_4.out
exec 6< single_8.out
exec 7< single_16.out

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
    speedup1=`echo "scale=4 ; $avg1 / $avg1" | bc`
    speedup2=`echo "scale=4 ; $avg1 / $avg2" | bc`
    speedup4=`echo "scale=4 ; $avg1 / $avg3" | bc`
    speedup8=`echo "scale=4 ; $avg1 / $avg4" | bc`
    speedup16=`echo "scale=4 ; $avg1 / $avg5" | bc`
    
    if [ $created -eq 0 ]
    then
    echo $num_elements $speedup1 $speedup2 $speedup4 $speedup8 $speedup16 > bar.out
    created=1;
	elif [ $created -eq 1 ]
    then
    echo $num_elements $speedup1 $speedup2 $speedup4 $speedup8 $speedup16 >> bar.out
	fi
done

exec 3<&-
exec 4<&-
exec 5<&-
exec 6<&-
exec 7<&-