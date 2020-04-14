//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set message to HMAC object.
* When a message is already set, given text is appended to the original message.
*
* @param {Text} $1 Message to set
* @return {Object} HMAC object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$message_t)
C_OBJECT:C1216($0)

$message_t:=$1

If (This:C1470.data.message=Null:C1517)
	
	This:C1470.data.message:=$message_t
	
Else 
	
	This:C1470.data.message:=This:C1470.data.message+$message_t
	
End if 

$0:=This:C1470
