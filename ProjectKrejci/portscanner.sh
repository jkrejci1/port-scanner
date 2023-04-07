#!/bin/bash
#Bash port scanner

#Get the host to scan from the command line
check_t=0
host=$1 
startport=$2
stopport=$3

#Keep track of number of command line arguments the user entered
arguments=$#


#End the program immediately if these conditions aren't met!
if [[ "$arguments" -eq 1 || "$arguments" -eq 4 || "$arguments" -gt 5 ]]
then
    echo "Usage: ./portscanner.sh [-t timeout] [host startport stopport]"
    exit
fi

#Make program interactive when user fails to enter username
if [ "$host" == "" ]
then
    while true #Create a while loop when in interactive mode
    do
        echo "Enter a host name"
        read host #Use read command to assign the input to host; same idea for others!
        
        #Exit out of the program if condition is met to end while loop
        if [ "$host" == "" ]
        then
            exit
        fi

        echo "Enter starting port"
        read startport
   
        echo "Enter stopping port"
        read stopport
    
    	#Below is Interactive Mode
 	#Below is the function to check for a ping 
	function pingcheck 
	{
	#Run a ping command and scrape its output to see if its succeeded 
	pingresult=$(ping -c 1 $host | grep bytes | wc -l)
	if [ "$pingresult" -gt 1 ]
	then
	    echo "$host is up"
	else
	    echo "$host is down, quitting"
	    exit
	fi
	}
	
	#Function for the portcheck
	function portcheck
	{
	for ((counter=$startport; counter <= $stopport; counter++))
	do
            #Run this one if a time wasn't provided
	    if timeout 2 bash  -c "echo > /dev/tcp/$host/$counter"
            then
		echo "$counter is open"
	    else
		echo "$counter is closed"
	    fi
	done
	}

	#Now we need to call the function for it to do something
	pingcheck
	portcheck
    done  
fi

#If host is -t then all the variables need to be shifted
if [ "$host" == "-t" ]
then
    time=$2
    host=$3
    startport=$4
    stopport=$5
    check_t=1
    echo "Timeout changed to $time"
    
    #Make this part interactive if no hostname given
    if [ "$host" == "" ]
    then
    	while true
    	do
    	
            echo "Enter a host name"
            read host
            
            #Exit loop if no hostname given
            if [ "$host" == "" ] 
            then
            	exit
            fi
            	
            #echo "Enter timeout time (seconds)"
    	    #read time
    	    #Notify time change
    	    #echo "Time changed to $time"
        
            echo "Enter a starting port"
            read startport
        
            echo "Enter a stopping port"
            read stopport
            
            #Below is the interactiveness!
            #Below is the function to check for a ping
	     function pingcheck 
	     {
	     #Run a ping command and scrape its output to see if its succeeded 
	     pingresult=$(ping -c 1 $host | grep bytes | wc -l)
	     if [ "$pingresult" -gt 1 ]
	     then
	         echo "$host is up"
	     else
	         echo "$host is down, quitting"
	         exit
	     fi
	     }


	     #Function for the portcheck
	     function portcheck
	     {
	     for ((counter=$startport; counter <= $stopport; counter++))
	     do
	     #Need to make an if statement that accounts for a custom timeout
		if timeout "$time" bash -c "echo > /dev/tcp/$host/$counter"
		then
		    echo "$counter is open"
		else
		    echo "$counter is closed"

	         fi
	     done
	     }

	     #Now we need to call the function for it to do something
	     pingcheck
	     portcheck
            
        done
    fi
fi

#Below is the function to check for a ping (NOT INTERACTIVE MODE)
function pingcheck 
{
#Run a ping command and scrape its output to see if its succeeded 
pingresult=$(ping -c 1 $host | grep bytes | wc -l)
if [ "$pingresult" -gt 1 ]
then
    echo "$host is up"
else
    echo "$host is down, quitting"
    exit
fi
}


#Function for the portcheck (NOT INTERACTIVE MODE)
function portcheck
{
for ((counter=$startport; counter <= $stopport; counter++))
do
    #Need to make an if statement that accounts for a custom timeout
    if [ "$check_t" -eq 1 ]
    then
        if timeout "$time" bash -c "echo > /dev/tcp/$host/$counter"
        then
            echo "$counter is open"
        else
            echo "$counter is closed"
        fi
    else
        #Run this one if a time wasn't provided
        if timeout 2 bash  -c "echo > /dev/tcp/$host/$counter"
        then
            echo "$counter is open"
        else
            echo "$counter is closed"
        fi
    fi
done
}


#Now we need to call the function for it to do something
pingcheck
portcheck
