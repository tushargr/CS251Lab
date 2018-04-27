#! /bin/bash

declare -a sum
sum[0]=0
sum[1]=0

indent=-1
doindent(){
	i=0
	while [ $i -lt $indent ];
	do
		echo -n "   "
		i=$(($i+1))
	done
}

calculate(){
regrex='[^0-9]\.[^0-9]|[0-9]\.[^0-9]|[^0-9]\.[0-9]|\.$|!'
regrex2='?'                                                                                                                                    
var1=`egrep -o $regrex "$1"|wc -l`
var2=`grep -o $regrex2 "$1"|wc -l`
sentences=$(($var1+$var2))

tnum=`egrep -o '[0-9]+' "$1"|wc -l`
decimals=`egrep -o '[0-9]\.[0-9]' "$1"|wc -l` 
integers=$(($tnum-$((2*$decimals))))
doindent
echo "(F) $1-$sentences-$integers"
sum[0]=$((${sum[0]}+$sentences))
sum[1]=$((${sum[1]}+$integers))
}

recurse(){
	if [ -f "$1" ]
	then 	indent=$(($indent+1))
		calculate "$1"
                indent=$(($indent-1))
	fi
	if [ -d "$1" ]
	then 	indent=$(($indent+1))
		declare -a ar
		ar[0]=$((${sum[0]})) 
		ar[1]=$((${sum[1]}))	
	 		
		cd "$1"
		
		fileanddir=`find -mindepth 1 -maxdepth 1 -printf '%P\n'`
		while read -r line
		do 	
			recurse "$line"
		done <<< "$fileanddir"
		doindent
		echo "(D) $1-$((${sum[0]}-${ar[0]}))-$((${sum[1]}-${ar[1]}))"		
		cd ..
		indent=$(($indent-1))
	fi	 
}
dir="$1"
recurse "$dir"

