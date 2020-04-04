//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets Content-Type header to the MIME type
* as determined by MT_get method for the specified type.
* If type contains "/" character, it sets Content-Type to type.
*
* @param {Text} $1 Type parameter that can be file extension or mime type.
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$type_t)
C_OBJECT:C1216($0)

$type_t:=$1

If (Position:C15("/";$type_t)=0)
	
	$type_t:=MT_get ($type_t)
	
End if 

If ($type_t#"")
	
	This:C1470.set("Content-Type";$type_t)
	
End if 

$0:=This:C1470
