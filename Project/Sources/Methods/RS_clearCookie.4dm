//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to tell browser to clear browser
* cookie. This is done by setting maxAge property value
* to 0.
*
* Note that options must identical to existing cookie
* except expires and maxAge, otherwise the cookie will
* not be cleared.
* 
* @param {Text} $1 Name of the cookie
* @param {Object} $2 Options of the cookie
* @return {Object} $0 Request object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$cookieName_t)
C_OBJECT:C1216($2;$options_o)
C_OBJECT:C1216($0)

$cookieName_t:=$1

If (Count parameters:C259>=2)
	
	$options_o:=$2
	$options_o.maxAge:=0
	
Else 
	
	$options_o:=New object:C1471("maxAge";0)
	
End if 

$0:=This:C1470.cookie($cookieName_t;"";$options_o)
