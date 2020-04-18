//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set Vary header,
* if it is not already specified.
*
* @param {Text} $1 Vary field value
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$value_t)
C_OBJECT:C1216($0)

C_TEXT:C284($currentValue_t)

$value_t:=$1

$currentValue_t:=This:C1470.get("Vary")

If ($currentValue_t="")
	
	This:C1470.set("Vary";$value_t)
	
End if 

$0:=This:C1470
