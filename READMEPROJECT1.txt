CPSC 42700 Project 1: Bash Port Scanner
Jack Krejci
1/28/2022

NAME
    portscanner.sh
    
USAGE
    -t, --timeout
    	Generate an optional timeout in seconds
    -host
    	The host name of the database you're looking into
    -startport
    	The starting port of where you're checking whether it's up or not
    -stopport
    	The final port that's being checked whether it's up or not.
    	
DESCRIPTION
	The purpose of this program is to allow for a user to enter a host name of a website, or ip, etc, and use a basic 
TCP port scanner to check for what ports are up for the host name given by the user. The program should output whether 
the given host name is up or down, and will go through each port and notify the user whether each port is open or not. If 
the user fails to provide a hostname, it will go into an infinite user friendly loop which will ask the user for the 
hostname, startport, and stopport. It will also do this if a user entered a timeout, but then didn't enter a host name. 
If the user presses enter, not giving a value to hostname, then the program will end. The program will also end if it 
doesn't have the right number of command line arguments giving the user an error message, showing what the user should've
entered.

COMMAND-LINE OPTIONS
	-There are a number of command line options you can make
	
	./portscanner.sh [hostname] [startport] [stopport]
	     Here the command will cause the portscanner program
	     to run once with a default value of 2 seconds set for
	     the timeout. 
	     
	./portscanner.sh [-t time] [hostname] [startport] [stopport]
	     Here the command will cause the program to run once
	     with a custom timeout value given at the beginning.
	     
	./portscanner.sh
	     Here the command will cause the program to go into a 
	     interactive mode asking the user for a hostname,
	     startport, and stopport, then will run the same as 
	     the first one above, except it will go into an 
	     infinite loop unti the user enters nothing for the 
	     hostname
	     
	./portscanner.sh [-t time]
	     Here the command will cause the program to do the same
	     as above except it will do so with a custom timeout
	     value that remains the same until the user enters 
	     nothing for the hostname. 

INPUT FILE FORMAT
	cat [hosts_to_scan.txt] | ./portscanner.sh
	     Here the values in the text file will be scanned one 
	     by one, and if it is the right information it will run
	     with a default timeout of 2.
	
	cat [hosts_to_scan.txt] | ./portscanner.sh [-t time]
	     Here the vaues in the text file will be scanned one by 
	     one, and if it's the right information it will run with
	     a custom timeout value given by the user.
	     
KNOWN BUGS AND LIMITATIONS
	The program will crash if you give the hostname as a number 
	by accident, along with giving values that are supposed to 
	be numbers as text. 

ADDITIONAL NOTES
	There is a variable in the code named check_t which is used
	as an indicator for when the user added a custom time value.
	This is so the program is able to tell which portcheck 
	function to use so that it runs properly. It also includes a
	variable named arguments which contains the amount of 
	arguments given by the user. This is so that the program 
	will know whether to break or not. 
        
