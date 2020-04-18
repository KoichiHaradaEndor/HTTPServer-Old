//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is called to stop HTTP server.
* 
* @return {Text} Result message
* @author: HARADA Koichi
*/

C_TEXT:C284($0;$resultMessage_t)

If (WEB Is server running:C1313)
	
	WEB STOP SERVER:C618
	
Else 
	
	$resultMessage_t:=Storage:C1525.messages.httpServerIsNotRunning
	
End if 

$0:=$resultMessage_t
