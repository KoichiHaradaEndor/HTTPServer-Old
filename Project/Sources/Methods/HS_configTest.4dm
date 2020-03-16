//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method tests if configuration names and values are valid.
  //* 
  //* @author: HARADA Koichi
  //* @return {Text} The result of the test.
  //*/

C_TEXT:C284($0;$result_t)

C_OBJECT:C1216($config_o)
C_LONGINT:C283($resultCode_l)

$result_t:="Syntax OK"

$config_o:=New object:C1471()
$resultCode_l:=HS_configRead ($config_o)

Case of 
	: ($resultCode_l=Config_does_not_exist)
		
		$result_t:="Configuration file could not be found at "+Get 4D folder:C485(Database folder:K5:14)+"httpServer.conf"
		
	Else 
		
		
		
End case 

$0:=$result_t