//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to set Redirect header with
* specified status code. If status code is omitted,
* status defaults to 302 ("Found").
*
* @param {Longint} $1 Status code (optional)
* @param {Text} $1 or $2 Redirect destination path
* @return {Object} $0 Response object
* @author HARADA Koichi
* 
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

Case of 
	: ($statusCode_l=301)
		$statusCode_t:="301 Moved Permanently"
		
	: ($statusCode_l=302)
		$statusCode_t:="302 Found"
		
	: ($statusCode_l=303)
		$statusCode_t:="303 See Other"
		
	: ($statusCode_l=307)
		$statusCode_t:="307 Temporary Redirect"
		
	: ($statusCode_l=308)
		$statusCode_t:="308 Permanent Redirect"
		
End case 

This:C1470.set("X-STATUS";$statusCode_t).location($path_t)

$0:=This:C1470
