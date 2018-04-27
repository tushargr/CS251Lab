#!/usr/bin/gawk
BEGIN{
           checker=1;
           comments=0;
           strings=0;
           pos=1;
           matchchar=""
           includecomment=1;    
           
}
function search3(line)
{     
      if(pos>length(line)){matchchar="";pos=-1;}
      else{
        substring=substr(line,pos,(length(line)-pos+1));
        
        
        st1=index(substring,"//");
        st2=index(substring,"\"");
        st3=index(substring,"/*");
        if(index(substring,"//")>0)st1=index(substring,"//");
        else st1=length(line)+1;
        if(index(substring,"\"")>0)st2=index(substring,"\"");
        else st2=length(line)+1;
        if(index(substring,"/*")>0)st3=index(substring,"/*");
        else st3=length(line)+1;

        if((st1<st2)&&(st1<st3)){
          pos=pos+st1+1;
          matchchar="//";
        }
        else if((st2<st1)&&(st2<st3)){
          
          pos=pos+st2;
          matchchar="\"";
        }
        else if((st3<st2)&&(st3<st2)){
          pos=pos+st3+1;
          matchchar="/*";  
        }
        else{
          pos=-1;
          matchchar="";
        }
      }  
}

function search1(line)  
{
     if(matchchar == "\""){
        substring=substr(line,pos,(length(line)-pos+1));
        if(index(substring,"\\\"")>0){
          ignore=index(substring,"\\\"");
          st2=index(substring,"\"");
          if(ignore<st2){
            pos=pos+ignore+1;
            substring=substr(line,pos,(length(line)-pos+1));
            st2=index(substring,"\"");
            pos=pos+st2;
          }
          else if(ignore>st2){
            pos=pos+st2;
          }  
        }
        else{
          if(index(substring,"\"")>0){
            st2=index(substring,"\"");
            pos=pos+st2;
          }
        }  
    }
     else if(matchchar == "/*"){
        substring=substr(line,pos,(length(line)-pos+1));
        if(index(substring,"*/")>0){
          st3=index(substring,"*/");
          pos=pos+st3+1;
        }
        else{
          pos=-1;
        }
     }            
}

{
        
    if(checker == 1){
      while(pos > -1){
        search3($0);
        
        if(matchchar == "//"){
          if(includecomment == 1)comments++;
          pos=-1;
          matchchar="";
        }
        else if(matchchar == "\""){
            
          search1($0);
          strings++;
          matchchar="";
        }
        else if(matchchar == "/*"){
          if(includecomment == 1)comments++;
          matchchar="/*";
          search1($0);
          if(pos > 0)includecomment=0;
          if(pos == -1){
            checker=-1;
          }
        }
           
      }
    }  


    else if(checker == -1){
      matchchar="/*"
      search1($0);
      comments++;

      if(pos == -1){
        checker=-1;
      }
      else if(pos > -1){
        checker=1;


        while(pos > -1){
          search3($0);
        
          if(matchchar == "//"){
            comments++;
            pos=-1;
            matchchar="";
          }
          else if(matchchar == "\""){
            search1($0);
            strings++;
            matchchar="";
          }
          else if(matchchar == "/*"){
            comments++;
            matchchar="*/";
            search1($0);
            if(pos == -1){
              checker=-1;
            }
          }
        }
      }

    }
    includecomment=1;
    pos=1;
 
}
END{
         
    print strings" "comments;
      
}
