//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is called to restart HTTP server.
* 
* @return {Text} Result message
* @author: HARADA Koichi
*/

C_TEXT:C284($0;$resultMessage_t)

$resultMessage_t:=HS_stop ()
$resultMessage_t:=HS_start ()

$0:=$resultMessage_t
