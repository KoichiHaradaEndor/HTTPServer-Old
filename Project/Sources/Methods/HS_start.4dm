//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($0;$stdout_t)

C_TEXT:C284($listenIP_t)
C_LONGINT:C283($listenPort_l;$listenSSLPort_l;$applicationType_l)

If (WEB Is server running:C1313)
	
	$stdout_t:="Web server is already running."
	
Else 
	
	$listenIP_t:=This:C1470.listenIP
	$listenPort_l:=This:C1470.listenPort
	$listenSSLPort_l:=This:C1470.listenSSLPort
	
	$applicationType_l:=Application type:C494
	
	Case of 
		: ($listenIP_t="0.0.0.0")
			  // accepts all server IP addresses
			
		: ($applicationType_l=4D Remote mode:K5:5)
			WEB SET OPTION:C1210(Web Client IP address to listen:K73:25;$listenIP_t)
			
		Else 
			WEB SET OPTION:C1210(Web IP address to listen:K73:5;$listenIP_t)
			
	End case 
	
	WEB SET OPTION:C1210(Web Port ID:K73:14;$listenPort_l)
	WEB SET OPTION:C1210(Web HTTPS port ID:K73:10;$listenSSLPort_l)
	
	WEB START SERVER:C617
	
End if 

$0:=$stdout_t
