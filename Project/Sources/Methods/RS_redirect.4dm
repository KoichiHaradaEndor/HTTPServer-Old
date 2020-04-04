//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to tell user agent to redirect
* to the specified path with the specified status code.
* If status code is omitted, it defaults to 302 ("Found").
*
* @param {Longint} $1 Status code (optional)
* @param {Text} $1 or $2 Redirect destination path
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_VARIANT:C1683($1)
C_TEXT:C284($2)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l;$statusCode_l)
C_TEXT:C284($statusCode_t;$path_t)

$type_l:=Value type:C1509($1)

Case of 
	: ($type_l=Is longint:K8:6)
		
		  // $1 is status code and $2 is path
		$statusCode_l:=$1
		$path_t:=$2
		
	: ($type_l=Is text:K8:3)
		
		  // $1 is path
		$statusCode_l:=302
		$path_t:=$1
		
End case 

This:C1470.status($statusCode_t)

  // Set http headers
$formula_o:=Formula:C1597(RS_setHeaders )
$formula_o.call(This:C1470)

WEB SEND HTTP REDIRECT:C659($path_t)

$0:=This:C1470
