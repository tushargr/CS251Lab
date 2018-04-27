#!/usr/bin/gawk
BEGIN{
	cnt=0;
	arlen=0;
}
{
	split($1,TIME,":");
	hour=TIME[1];
	min=TIME[2];
	sec=TIME[3];
	split($9,dataTransfer,":")
	split(dataTransfer[2],end,",")	
	
	dataStart=dataTransfer[1];
	dataEnd=end[1];
	sender=$3;
	split($5,temp,":");
	receiver=temp[1];
	pair=sender" "receiver;
	
	len=$NF;
	again=0;
	for(key in shourDict){
		if(key==pair)again=1;
	}
	if(again==0){
		shourDict[pair]=hour;
		sminDict[pair]=min;
		ssecDict[pair]=sec;
		ehourDict[pair]=hour;
		eminDict[pair]=min;
		esecDict[pair]=sec;
		lenDict[pair]=len;
		if(len>0)
			datapacketsDict[pair]=1;
		else 	
			datapacketsDict[pair]=0;
		packetsDict[pair]=1;	
	}
	else{
		ehourDict[pair]=hour;
		eminDict[pair]=min;
		esecDict[pair]=sec;
		lenDict[pair]+=len;
		if(len>0)
			datapacketsDict[pair]+=1;
		packetsDict[pair]++;	
	}

}
END{
	for(key in shourDict){
		flag=0;
		for(i=0;i<arlen;i++){
			if(key == ar[i])flag=1;
		}
		if(flag==1)continue;
		split(key,temp," ");
		B=temp[1];
		A=temp[2];
		pair=A" "B;
		split(A,ss,".");
		split(B,rr,".");
		transmissiontime=(ehourDict[pair]-shourDict[pair])*3600+(eminDict[pair]-sminDict[pair])*60+(esecDict[pair]-ssecDict[pair])
		speed=lenDict[pair]/transmissiontime;
		print "Connection (A="ss[1]"."ss[2]"."ss[3]"."ss[4]":"ss[5]" B="rr[1]"."rr[2]"."rr[3]"."rr[4]":"rr[5]")"

		print "A-->B #packets="packetsDict[pair]", #datapackets="datapacketsDict[pair]", #bytes="lenDict[pair]", #retrans="0" xput="speed" bytes/sec"

		pair=B" "A;
		transmissiontime=(ehourDict[pair]-shourDict[pair])*3600+(eminDict[pair]-sminDict[pair])*60+(esecDict[pair]-ssecDict[pair]);
		speed=lenDict[pair]/transmissiontime;
		print "B-->A #packets="packetsDict[pair]", #datapackets="datapacketsDict[pair]", #bytes="lenDict[pair]", #retrans="0" xput="speed" bytes/sec"
		ar[cnt]=A" "B;cnt++;arlen++;	 
	}
	
}
