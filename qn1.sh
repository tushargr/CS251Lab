
#!/bin/bash
inwrd=''
eng2(){
var=$1
case "$var" in      
01) inwrd+='one '
   ;;
02) inwrd+='two '	
   ;;            
03) inwrd+='three '
   ;;
04) inwrd+='four '	
   ;;           
05) inwrd+='five '
   ;;
06) inwrd+='six '	
   ;;           
07) inwrd+='seven '
   ;;
08) inwrd+='eight '    
   ;;           
09) inwrd+='nine '
   ;;                
10) inwrd+='ten '
   ;;
11) inwrd+='eleven '	
   ;;            
12) inwrd+='twelve '
   ;;
13) inwrd+='thirteen '     
   ;;           
14) inwrd+='fourteen '
   ;;
15) inwrd+='fifteen '	
   ;;           
16) inwrd+='sixteen '
   ;;
17) inwrd+='seventeen '    
   ;;           
18) inwrd+='eighteen '
   ;;                
19) inwrd+='nineteen '
   ;;
esac
}
eng3(){
var=$1
case "$var" in      
2)  inwrd+='twenty '	
   ;;               
3)  inwrd+='thirty '
   ;;
4)  inwrd+='forty '	
   ;;              
5)  inwrd+='fifty '
   ;;
6)  inwrd+='sixty '	
   ;;              
7)  inwrd+='seventy '
   ;;
8)  inwrd+='eighty '    
   ;;              
9)  inwrd+='ninety '
   ;;      
esac   
}

eng(){
var=$1
case "$var" in      
1)  inwrd+='one '
   ;;      
2)  inwrd+='two '	
   ;;               
3)  inwrd+='three '
   ;;      
4)  inwrd+='four '	
   ;;              
5)  inwrd+='five '
   ;;      
6)  inwrd+='six '	
   ;;              
7)  inwrd+='seven '
   ;;      
8)  inwrd+='eight '	
   ;;        
9)  inwrd+='nine '
   ;;
esac   
}

ans(){
n=$1
digits=`echo ${#n}`           
if [ $digits -eq 4 ]
then    var=`echo ${n:0:1}`
	if [ $var -ne 0 ]
	then 
	     eng $var 
	     inwrd+='thousand '
	fi
	var=`echo ${n:1:1}`
	if [ $var -ne 0 ]
        then 
             eng $var
             inwrd+='hundred '
        fi
	var=`echo ${n:2:2}`
	if [ $var -lt 20 ]
	then eng2 $var       
	else 
	     var=`echo ${n:2:1}`
	     eng3 $var
	     var=`echo ${n:3:1}`
	     eng $var   
	fi
fi
                                           
if [ $digits -eq 3 ]
then    var=`echo ${n:0:1}`
	if [ $var -ne 0 ]
	then 
	     eng $var 
	     inwrd+='hundred '
	fi
	var=`echo ${n:1:2}`
	if [ $var -lt 20 ]
	then eng2 $var       
	else 
	     var=`echo ${n:1:1}`
	     eng3 $var
	     var=`echo ${n:2:1}`
	     eng $var  
	fi
fi                                                                              
if [ $digits -eq 2 ]
then    
	var=`echo ${n:0:2}`
	if [ $var -lt 20 ]
	then eng2 $var       
	else 
	     var=`echo ${n:0:1}`
	     eng3 $var
	     var=`echo ${n:1:1}`
	     eng $var  
	fi
fi                                                                      
if [ $digits -eq 1 ]
then    
   	 var=`echo ${n:0:1}`
	 eng $var  
fi                                      
}



read a
size=${#a}
if [[ $size -lt 12 ]]
then 	regrex2='^[0]+$'
	if [[ $a =~ $regrex2 ]]
	then echo zero
	else
	count=0
	if [ $size -lt 4 ]
	then count=1 
	elif [ $size -lt 6 ]
	then count=2	
	     a=`echo $a|rev|sed 's/./& /3'|rev`	
	elif [ $size -lt 8 ]	
	then count=3
	     a=`echo $a|rev|sed 's/./& /3'|sed 's/./& /6'|rev`			
	else 
	    count=4
            a=`echo $a|rev|sed 's/./& /3'|sed 's/./& /6'|sed 's/./& /9'|rev`
	fi
	num=$a
	if [ $count -eq 4 ]
	then 
		num1=`echo $num|cut -f 1 -d ' '`
		if [ $num1 -gt 0 ]
		then ans $num1
		     inwrd+='crore '
		fi
		
		num2=`echo $num|cut -f 2 -d ' '` 	
		if [ $num2 -gt 0 ]
               	then ans $num2
               	inwrd+='lakh '
		fi
		num3=`echo $num|cut -f 3 -d ' '` 	
		if [ $num3 -gt 0 ]
		then ans $num3
		inwrd+='thousand '
		fi		
		num4=`echo $num|cut -f 4 -d ' '`	
		ans $num4
		
	fi
	if [ $count -eq 3 ]
	then 
 		num1=`echo $num|cut -f 1 -d ' '` 		
		if [ $num1 -gt 0 ]
  		then ans $num1
 		inwrd+='lakh '
 		fi
		num2=`echo $num|cut -f 2 -d ' '` 
		if [ $num2 -gt 0 ]
        	then ans $num2
        	inwrd+='thousand '
		fi 		
		num3=`echo $num|cut -f 3 -d ' '`
 		ans $num3

	fi
	if [ $count -eq 2 ]
	then
 	
		num1=`echo $num|cut -f 1 -d ' '`
	 	if [ $num1 -gt 0 ]
		then ans $num1
		inwrd+='thousand '
		fi
		num2=`echo $num|cut -f 2 -d ' '`
		ans $num2
	fi
	if [ $count -eq 1 ]
	then
		ans $num	
	fi
	echo $inwrd
	fi	
else
	echo Enter a valid number
fi
