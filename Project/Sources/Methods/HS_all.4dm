//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method routes HTTP requests for the caller host
* to the speified path with the specified callbacks.
* It will match all HTTP verbs.
* 
* @param {Text} $1 The path for which the callback function is invoked
* @param {Variant} ${2} Callback functions
* @return {Object} This object.
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$path_t)
C_VARIANT:C1683(${2})  // callback functions
C_OBJECT:C1216($0)  // This

C_COLLECTION:C1488($params_c)
C_OBJECT:C1216($formula_o)

$path_t:=$1

$params_c:=New collection:C1472()
$params_c.push("all")
$params_c.push($path_t)

For ($i;2;Count parameters:C259)
	
	$params_c.push(${$i})
	
End for 

$formula_o:=Formula:C1597(HS_addRoute )
$formula_o.apply(This:C1470;$params_c)

If (This:C1470.type="SingleRoute")
	
	$0:=This:C1470
	
End if 
