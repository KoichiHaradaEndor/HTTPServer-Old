//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method creates RequestHandler object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @param {Text} $1 Host name
  //* @return {Object} RequestHandler object.
  //*/

C_TEXT:C284($1;$hostName_t)
C_OBJECT:C1216($0;$requestHandler_o)

If (Count parameters:C259=0)
	$hostName_t:=""
Else 
	$hostName_t:=$1
End if 

$requestHandler_o:=New shared object:C1526()
Use ($requestHandler_o)
	
	$requestHandler_o.PrimitiveValue:=New shared object:C1526()
	
	Use ($requestHandler_o.PrimitiveValue)
		
		$requestHandler_o.PrimitiveValue.type:="RequestHandler"
		
	End use   // Use ($requestHandler_o.PrimitiveValue)
	
	$requestHandler_o.hostName:=$hostName_t
	$requestHandler_o.route:=New shared collection:C1527()
	
	$requestHandler_o.addRoute:=Formula:C1597(RH_addRoute )
	
End use   // Use ($requestHandler_o)

$0:=$requestHandler_o
