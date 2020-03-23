//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  //**
  //* This method creates Request object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @return {Object} Request object.
  //*/

C_OBJECT:C1216($0;$request_o)

C_LONGINT:C283($i)
C_COLLECTION:C1488($cookie_c;$aCookie_c)
C_TEXT:C284($aCookie_t;$dataName_t;$dataValue_t)

$request_o:=New object:C1471()

  // Retrieves request header information
ARRAY TEXT:C222($headerNames_at;0)
ARRAY TEXT:C222($headerValues_at;0)
WEB GET HTTP HEADER:C697($headerNames_at;$headerValues_at)

$request_o.header:=New object:C1471()
For ($i;1;Size of array:C274($headerNames_at))
	
	If ($headerNames_at{$i}="cookie")
		
		$cookie_c:=New collection:C1472()
		$cookie_c:=Split string:C1554($headerValues_at{$i};";";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		$request_o.header.cookie:=New object:C1471()
		For each ($aCookie_t;$cookie_c)
			
			$aCookie_c:=New collection:C1472()
			$aCookie_c:=Split string:C1554($aCookie_t;"=";sk trim spaces:K86:2)
			Case of 
				: ($aCookie_c.length=1)
					$request_o.header.cookie[$aCookie_c[0]]:=""
					
				: ($aCookie_c.length=2)
					$request_o.header.cookie[$aCookie_c[0]]:=$aCookie_c[1]
					
			End case 
			
		End for each 
		
	Else 
		
		$request_o.header[$headerNames_at{$i}]:=$headerValues_at{$i}
		
	End if 
	
End for 

  // Retrieves query parameters and/or posted data
ARRAY TEXT:C222($dataNames_at;0)
ARRAY TEXT:C222($dataValues_at;0)
WEB GET VARIABLES:C683($dataNames_at;$dataValues_at)

$request_o.params:=New object:C1471()
For ($i;1;Size of array:C274($dataNames_at))
	
	$dataName_t:=$dataNames_at{$i}
	$dataValue_t:=$dataValues_at{$i}
	
	If (OB Is defined:C1231($request_o.params;$dataName_t))
		
		$request_o.params[$dataName_t].push($dataValue_t)
		
	Else 
		
		$request_o.params[$dataName_t]:=New collection:C1472($dataValue_t)
		
	End if 
	
End for 

$0:=$request_o
