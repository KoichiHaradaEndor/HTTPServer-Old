//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sends HTTP response.
* The body parameter can be Text, Blob, Object or Collection type.
* 
* Content-type header defaults to:
* Text : text/html
* Blob : application/octet-stream
* Object : application/json
* Collection : application/json
* unless previously defined.
*
* When it is Object or Collection, the response will be
* converted to text with JSON Stringify.
*
* @param {Variant} $1 HTTP response body content
* @param {Object} $0 Response object
*/

C_VARIANT:C1683($1)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l)
C_TEXT:C284($content_t;$contentType_t)
C_OBJECT:C1216($formula_o)

$type_l:=Value type:C1509($1)

Case of 
	: ($type_l=Is text:K8:3)
		$content_t:=$1
		
	: ($type_l=Is object:K8:27) | ($type_l=Is collection:K8:32)
		$content_t:=JSON Stringify:C1217($1)
		
End case 

$contentType_t:=This:C1470.get("Content-Type")

If ($contentType_t="")
	
	  // It is not previously specified.
	  // Sets to default
	Case of 
		: ($type_l=Is text:K8:3)
			$contentType_t:="text/html"
			
		: ($type_l=Is object:K8:27) | ($type_l=Is collection:K8:32)
			$contentType_t:="application/json"
			
		: ($type_l=Is BLOB:K8:12)
			$contentType_t:="application/octet-stream"
			
	End case 
	
Else 
	
	  // It is previously specified.
	  // Remove it from header storage
	$formula_o:=Formula:C1597(RS_remove )
	$formula_o.call(This:C1470;"Content-Type")
	
End if 

  // Set http headers
$formula_o:=Formula:C1597(RS_setHeaders )
$formula_o.call(This:C1470)

  // Send response
Case of 
	: ($type_l=Is text:K8:3) | ($type_l=Is object:K8:27) | ($type_l=Is collection:K8:32)
		
		WEB SEND TEXT:C677($content_t;$contentType_t)
		
	: ($type_l=Is BLOB:K8:12)
		
		WEB SEND BLOB:C654($1;$contentType_t)
		
End case 

$0:=This:C1470
