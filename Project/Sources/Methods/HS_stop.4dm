//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method is called to stop HTTP server.
  //* 
  //* @author: HARADA Koichi
  //* @return {Longint} Result code
  //*/

C_LONGINT:C283($0;$resultCode_l)

If (WEB Is server running:C1313)
	
	WEB STOP SERVER:C618
	
Else 
	
	$resultCode_l:=HTTPServer_is_not_running
	
End if 

$0:=$resultCode_l
