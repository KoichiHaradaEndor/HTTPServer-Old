//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set key to HMAC object.
* When it is already set, it is replaced with the new key.
*
* @param {Text} $1 Key to set
* @return {Object} HMAC object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$key_t)
C_OBJECT:C1216($0)

$key_t:=$1

This:C1470.data.key:=$key_t

$0:=This:C1470
