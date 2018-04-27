import copy
import os
import sys
import re


def convert(a,base):
	if(a>-1 and a<10):
		return a
	else:
		return ord(a)-ord('A')+10	

def checker(validset,num):
	
	for i in range(0,len(num)):
		
		if num[i] in validset:
			continue
		else:
			return 0
	return 1	
			
def formbase(st):
	pattern = re.compile("^[0-9]+$")
	if(pattern.match(st)):
		base=0
		for i in range(0,len(st)):
			base=base*10+(ord(st[i])-ord('0'))
		return base
	else:
		print "Invalid Input"
		os._exit(1)
		
base=formbase(sys.argv[2])
number=sys.argv[1]
if(base<2):
	print "Invalid Input"
	os._exit(1)
if(base>36):
	print "Invalid Input"
	os._exit(1)	
num=[]
for i in range(0,len(number)):
	if((ord(number[i])>=ord('0')) and (ord(number[i])<=ord('9'))):
		num.append(ord(number[i])-48)
	else:
		num.append(number[i])	
validset=[]
for i in range(0,base):
	if(i>=base):
		break
	else:
		if(i<10):
			validset.append(i)
		else:
			j=i
			j=j-10
			validset.append(chr(ord('A')+j))


validset.append('-')	
validset.append('.')
negative=0;
dotposition=-2
dots=0
dash=0
for i in range(0,len(num)):
	if(num[i]=='.'):
		dots=dots+1
	if(num[i]=='-'):
		dash=dash+1

if(dots>1):			
	print "Invalid Input"
	os._exit(1)
if(dash>1):		
	print "Invalid Input"
	os._exit(1)
if(dash==1):
	if(num[0]!='-'):
		print "Invalid Input"
		os._exit(1)	
		
if(checker(validset,num)==0):
	print "Invalid Input"
	os._exit(1)
if(num[len(num)-1]=='.'):
	print "Invalid Input"
	os._exit(1)
if(num[0]=='-'):
	negative=1
	num.pop(0)		

for i in range(0,len(num)):
	if(num[i]=='.'):
		dotposition=i-1
		num.pop(i)
		break
if(dotposition==-2):
	dotposition=len(num)-1		
ans=0

for i in range(0,len(num)):
	ans=(ans)+(convert(num[i],base))*(((base)**(dotposition)))
	dotposition=dotposition-1
if(negative==1):
	ans=ans*(-1)
if((ans<=999999999) and (ans>=-999999999)):		
	aa=str('%.6f' %ans)
	aa=aa.rstrip("0")
	aa=aa.rstrip(".")
	print aa
else:
	print "Invalid Input"	



