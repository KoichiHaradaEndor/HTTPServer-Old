//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates Request object and return it.
*
* For more details, please refer to {@link Request#About Request Object}.
*
* @return {Object} $0 Request object
* @author: HARADA Koichi
*/

C_OBJECT:C1216($0;$request_o)

C_COLLECTION:C1488($headers_c;$queryResult_c;$cookies_c;$aCookie_c;$splitResult_c)
C_TEXT:C284($contentType_t;$body_t;$cookie_t;$pattern_t)
C_OBJECT:C1216($eachItem_o)
C_BOOLEAN:C305($matched_b)

$request_o:=New object:C1471()

  // Retrieves request header information
ARRAY TEXT:C222($headerNames_at;0)
ARRAY TEXT:C222($headerValues_at;0)
WEB GET HTTP HEADER:C697($headerNames_at;$headerValues_at)
ARRAY TO COLLECTION:C1563($headers_c;$headerNames_at;"name";$headerValues_at;"value")

  //#####
  // Request.body
  //#####
$queryResult_c:=$headers_c.query("name = :1";"Content-Type")
If ($queryResult_c.length>0)
	
	$contentType_t:=$queryResult_c[0].value
	Case of 
		: ($contentType_t="application/x-www-form-urlencoded")
			
			ARRAY TEXT:C222($dataNames_at;0)
			ARRAY TEXT:C222($dataValues_at;0)
			WEB GET VARIABLES:C683($dataNames_at;$dataValues_at)
			ARRAY TO COLLECTION:C1563($postedData_c;$dataNames_at;"name";$dataValues_at;"value")
			
			$request_o.body:=New object:C1471()
			For each ($eachItem_o;$postedData_c)
				
				If ($request_o.body[$eachItem_o.name]=Null:C1517)
					
					  // If the data name collection has not been created, add it with the value
					$request_o.body[$eachItem_o.name]:=New collection:C1472($eachItem_o.value)
					
				Else 
					
					  // If the data name collection had been created, append the value.
					$request_o.body[$eachItem_o.name].push($eachItem_o.value)
					
				End if 
				
			End for each 
			
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
$queryResult_c:=$headers_c.query("name = :1";"Host")
If ($queryResult_c.length>0)
	
	$splitResult_c:=Split string:C1554($queryResult_c[0].value;":";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	$request_o.hostname:=$splitResult_c[0]
	
Else 
	
	$request_o.hostname:=""
	
End if 

  //#####
  // Request.method
  //#####
$queryResult_c:=$headers_c.query("name = :1";"X-METHOD")
If ($queryResult_c.length>0)
	
	$request_o.method:=$queryResult_c[0].value
	
Else 
	
	$request_o.method:=""
	
End if 

  //#####
  // Request.path
  //#####
$queryResult_c:=$headers_c.query("name = :1";"X-URL")
If ($queryResult_c.length>0)
	
	$pattern_t:="^(.*?)(?:\\?.*)?(?:#.*)?$"
	ARRAY LONGINT:C221($positions_al;0)
	ARRAY LONGINT:C221($lengths_al;0)
	$matched_b:=Match regex:C1019($pattern_t;$queryResult_c[0].value;1;$positions_al;$lengths_al)
	If ($matched_b)
		
		$request_o.path:=Substring:C12($queryResult_c[0].value;$positions_al{1};$lengths_al{1})
		
	Else 
		
		$request_o.path:=""
		
	End if 
	
Else 
	
	$request_o.path:=""
	
End if 

  //#####
  // Request.protocol
  //#####
$request_o.protocol:=Choose:C955(WEB Is secured connection:C698;"https";"http")

$0:=$request_o
