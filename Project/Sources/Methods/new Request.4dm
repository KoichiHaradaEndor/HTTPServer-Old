//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method creates Request object and return it.
*
* For more details, please refer to {@link Request.About Request Object}.
*
* @param {Text} $1 IP address of the request sender
* @param {Text} $2 IP address of the server that receives the request
* @return {Object} $0 Request object
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$ipClient_t)
C_TEXT:C284($2;$ipServer_t)
C_OBJECT:C1216($0;$request_o)

C_COLLECTION:C1488($headers_c;$queryResult_c;$cookies_c;$aCookie_c;$splitResult_c)
C_TEXT:C284($contentType_t;$body_t;$cookie_t;$pattern_t)
C_BOOLEAN:C305($matched_b)

$ipClient_t:=$1
$ipServer_t:=$2

$request_o:=New object:C1471()
$request_o.__type__:="Request"
$request_o.__ipClient__:=$ipClient_t
$request_o.__ipServer__:=$ipServer_t

  //#####
  // Properties
  //#####

  // Retrieves request header information
ARRAY TEXT:C222($headerNames_at;0)
ARRAY TEXT:C222($headerValues_at;0)
WEB GET HTTP HEADER:C697($headerNames_at;$headerValues_at)
$headers_c:=New collection:C1472()
ARRAY TO COLLECTION:C1563($headers_c;$headerNames_at;"name";$headerValues_at;"value")

  // Stores header collection into request object for later use
$request_o.__headers__:=New collection:C1472()
$request_o.__headers__:=$headers_c

  //#####
  // Request.body
  //#####
$queryResult_c:=$headers_c.query("name = :1";"Content-Type")
If ($queryResult_c.length>0)
	
	$contentType_t:=$queryResult_c[0].value
	Case of 
		: ($contentType_t="application/x-www-form-urlencoded")
			
			$request_o.body:=RQ_parseWebVariables 
			
		: ($contentType_t="application/json")
			
			WEB GET HTTP BODY:C814($body_t)
			Case of 
				: (Length:C16($body_t)=0)
					
				: ($body_t[[1]]="{")  // Object structure
					
					$request_o.body:=New object:C1471()
					$request_o.body:=JSON Parse:C1218($body_t)
					
				: ($body_t[[1]]="[")  // Array structure
					
					ARRAY OBJECT:C1221($objects_ao;0)
					JSON PARSE ARRAY:C1219($body_t;$objects_ao)
					$request_o.body:=New collection:C1472()
					ARRAY TO COLLECTION:C1563($request_o.body;$objects_ao)
					
			End case 
			
	End case 
	
End if 

  //#####
  // Request.cookies
  //#####
$request_o.cookies:=New object:C1471()
$queryResult_c:=$headers_c.query("name = :1";"Cookie")
If ($queryResult_c.length>0)
	
	$cookies_c:=Split string:C1554($queryResult_c[0].value;";";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	For each ($cookie_t;$cookies_c)
		
		$aCookie_c:=Split string:C1554($cookie_t;"=";sk trim spaces:K86:2)
		Case of 
			: ($aCookie_c.length=1)
				$request_o.cookies[$aCookie_c[0]]:=""
				
			: ($aCookie_c.length=2)
				$request_o.cookies[$aCookie_c[0]]:=$aCookie_c[1]
				
		End case 
		
	End for each 
	
End if 

  //#####
  // Request.hostname
  //#####
$request_o.hostname:=""
$queryResult_c:=$headers_c.query("name = :1";"Host")
If ($queryResult_c.length>0)
	
	  // removes port number part
	$splitResult_c:=Split string:C1554($queryResult_c[0].value;":";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	$request_o.hostname:=$splitResult_c[0]
	
End if 

  //#####
  // Request.ip
  //#####
$request_o.ip:=$ipClient_t

  //#####
  // Request.method
  //#####
$request_o.method:=""
$queryResult_c:=$headers_c.query("name = :1";"X-METHOD")
If ($queryResult_c.length>0)
	
	$request_o.method:=$queryResult_c[0].value
	
End if 

  //#####
  // Request.path
  //#####
$request_o.path:=""
$queryResult_c:=$headers_c.query("name = :1";"X-URL")
If ($queryResult_c.length>0)
	
	$pattern_t:="^(.*?)(?:\\?.*)?(?:#.*)?$"
	ARRAY LONGINT:C221($positions_al;0)
	ARRAY LONGINT:C221($lengths_al;0)
	$matched_b:=Match regex:C1019($pattern_t;$queryResult_c[0].value;1;$positions_al;$lengths_al)
	If ($matched_b)
		
		$request_o.path:=Substring:C12($queryResult_c[0].value;$positions_al{1};$lengths_al{1})
		
	End if 
	
End if 

  //#####
  // Request.protocol
  //#####
$request_o.protocol:=Choose:C955(WEB Is secured connection:C698;"https";"http")

  //#####
  // Request.query
  //#####
$request_o.query:=New object:C1471()
$queryResult_c:=$headers_c.query("name = :1";"X-URL")
If ($queryResult_c.length>0)
	
	$pattern_t:="^(?:.*?)(?:\\?.*)+(?:#.*)?$"  // to find query string part
	$matched_b:=Match regex:C1019($pattern_t;$queryResult_c[0].value;1)
	If ($matched_b)
		
		$request_o.query:=RQ_parseWebVariables 
		
	End if 
	
End if 

  //#####
  // Request.secure
  //#####
$request_o.secure:=WEB Is secured connection:C698

  //#####
  // Request.xhr
  //#####
$request_o.xhr:=False:C215
$queryResult_c:=$headers_c.query("name = :1";"X-Requested-With")
If ($queryResult_c.length>0)
	
	$request_o.xhr:=($queryResult_c[0].value="XMLHttpRequest")
	
End if 

  //#####
  // Methods
  //#####

$request_o.get:=Formula:C1597(RQ_get )

$0:=$request_o
