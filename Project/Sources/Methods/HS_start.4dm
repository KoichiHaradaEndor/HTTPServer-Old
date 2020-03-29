//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method is called to start HTTP server.
  //* 
  //* @author: HARADA Koichi
  //* @return {Longint} Result code.
  //*/

C_LONGINT:C283($0;$resultCode_l)

C_OBJECT:C1216($config_o)

$resultCode_l:=0
If (WEB Is server running:C1313)
	
	$resultCode_l:=HTTPServer_already_running
	
Else 
	
	  // When start the http server, always loads config from file,
	  // so that modified config will take effect when (re)starting
	  // the server.
	HS_configLoad 
	WEB START SERVER:C617
	
End if 

$0:=$resultCode_l
