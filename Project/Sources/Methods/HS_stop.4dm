//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($0;$stdout_t)

If (WEB Is server running:C1313)
	
	WEB STOP SERVER:C618
	
Else 
	
	$stdout_t:="HTTP server is not running."
	
End if 

$0:=$stdout_t
