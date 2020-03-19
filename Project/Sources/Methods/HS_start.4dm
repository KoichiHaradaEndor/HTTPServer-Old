//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method is called to start HTTP server.
  //* 
  //* @author: HARADA Koichi
  //* @return {Longint} Result code.
  //*/

C_LONGINT:C283($0;$resultCode_l)

$resultCode_l:=0
If (WEB Is server running:C1313)
	
	$resultCode_l:=HTTPServer_already_running
	
Else 
	
	This:C1470.config.load()
	WEB START SERVER:C617
	
End if 

$0:=$resultCode_l
