//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is called to start HTTP server.
* 
* @return {Text} Result message
* @author: HARADA Koichi
*/

C_TEXT:C284($0;$resultMessage_t)

C_OBJECT:C1216($config_o)

$resultMessage_t:=0
If (WEB Is server running:C1313)
	
	$resultMessage_t:=Storage:C1525.messages.httpServerIsAlreadyRunning
	
Else 
	
	  // When start the http server, always loads config from file,
	  // so that modified config will take effect when (re)starting
	  // the server.
	Config_load 
	WEB START SERVER:C617
	
End if 

$0:=$resultMessage_t
