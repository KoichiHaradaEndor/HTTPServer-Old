//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to generate Error object.
*
* @param {Text} $1 Error message
* @return {Object} $0 Error object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$message_t)
C_OBJECT:C1216($0;$error_o)

$error_o:=New object:C1471(\
"message";$message_t\
)

$0:=$error_o
