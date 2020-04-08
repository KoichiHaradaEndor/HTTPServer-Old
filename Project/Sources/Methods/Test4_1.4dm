//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$req_o)
C_OBJECT:C1216($2;$res_o)
C_OBJECT:C1216($3;$next_o)

$req_o:=$1
$res_o:=$2
$next_o:=$3

C_COLLECTION:C1488($candidates_c)
C_TEXT:C284($accepts_t;$response_t)
C_OBJECT:C1216($response_o)
C_LONGINT:C283($status_l)

  // This app accepts "application/json" and "text/plain"
$candidates_c:=New collection:C1472("application/json";"text/plain")

  // Determines which mimetype is requested
$accepts_t:=$req_o.accepts($candidates_c)

Case of 
	: ($accepts_t="application/json")
		
		$response_o:=New object:C1471("response";"This is JSON text.")
		$response_t:=JSON Stringify:C1217($response_o)
		$status_l:=200
		
	: ($accepts_t="text/plain")
		
		$response_t:="This is plain text."
		$status_l:=200
		
	Else 
		
		$status_l:=406  // Not Acceptable
		
End case 

If ($status_l=200)
	
	$res_o.type($accepts_t).send($response_t)
	
Else 
	
	$res_o.sendStatus($status_l)
	
End if 
