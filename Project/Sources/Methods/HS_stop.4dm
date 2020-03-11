//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($0;$resultCode_l)

If (WEB Is server running:C1313)
	
	WEB STOP SERVER:C618
	
Else 
	
	$resultCode_l:=HTTPServer_is_not_running:K0:2
	
End if 

$0:=$resultCode_l
