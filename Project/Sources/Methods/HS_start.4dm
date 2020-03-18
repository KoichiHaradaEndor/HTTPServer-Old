//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($0;$resultCode_l)

$resultCode_l:=0
If (WEB Is server running:C1313)
	
	$resultCode_l:=HTTPServer_already_running
	
Else 
	
	$resultCode_l:=HS_configLoad 
	If ($resultCode_l=0)
		WEB START SERVER:C617
	End if 
	
End if 

$0:=$resultCode_l
