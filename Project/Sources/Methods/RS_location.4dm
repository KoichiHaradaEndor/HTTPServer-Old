//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets Location response header.
* It does not modify given path. So it is developer's
* responsibility to check validity and encoding of the url.
* When the path parameter is "back", the value of
* Location header will be taken from Referer request header.
* If Referer is not present, "/" is used.
*
* @param {Text} $1 Path value for the Location header
* @return {Object} Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$path_t)
C_OBJECT:C1216($0)

C_COLLECTION:C1488($headers_c;$queryResult_c)

$path_t:=$1

If ($path_t="back")
	
	ARRAY TEXT:C222($headerNames_at;0)
	ARRAY TEXT:C222($headerValues_at;0)
	WEB GET HTTP HEADER:C697($headerNames_at;$headerValues_at)
	ARRAY TO COLLECTION:C1563($headers_c;$headerNames_at;"name";$headerValues_at;"value")
	$queryResult_c:=$headers_c.query("name = :1";"Referer")
	If ($queryResult_c.length=0)
		
		  // No Referer header present
		$path_t:="/"
		
	Else 
		
		$path_t:=$queryResult_c[0].value
		
	End if 
	
End if 

This:C1470.set("Location";$path_t)

$0:=This:C1470
