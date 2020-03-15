//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($0;$resultCode_l)

C_TEXT:C284($configPath_t)

$configPath_t:=Get 4D folder:C485(Database folder:K5:14)+"httpServer.conf"

If (Test path name:C476($configPath_t)#Is a document:K24:1)
	
	$resultCode_l:=Config_does_not_exist
	
Else 
	
	
	
End if 
