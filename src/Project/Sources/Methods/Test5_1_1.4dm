//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$req_o)
C_OBJECT:C1216($2;$res_o)
C_OBJECT:C1216($3;$next_o)

$req_o:=$1
$res_o:=$2
$next_o:=$3

  // This method is called when 
  // path is /login
  // method is POST

C_TEXT:C284($username_t;$password_t)
C_BOOLEAN:C305($loginOK_b)

$loginOK_b:=False:C215

Case of 
	: ($req_o.body=Null:C1517)
	: ($req_o.body.username=Null:C1517)
	Else 
		$username_t:=$req_o.body.username
End case 

Case of 
	: ($req_o.body=Null:C1517)
	: ($req_o.body.password=Null:C1517)
	Else 
		$password_t:=$req_o.body.password
End case 

Case of 
	: ($username_t#"user")
	: (compareCaseSensitive ($password_t;"Password")=False:C215)
	Else 
		
		  // Login suceeded
		$loginOK_b:=True:C214
		
End case 

If ($loginOK_b)
	
	$res_o\
		.cookie("SESSID";"REALLY-SECURED-ID")\
		.type("text/plain")\
		.send("Login OK")
	
Else 
	
	$res_o.sendStatus(401)  // Unauthorized
	
End if 
