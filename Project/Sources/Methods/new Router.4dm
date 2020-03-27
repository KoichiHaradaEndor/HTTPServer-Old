//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method creates Router object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @param {Text} $1 Host name
  //* @return {Object} RequestHandler object.
  //*/

C_TEXT:C284($1;$hostName_t)
C_OBJECT:C1216($0;$router_o)

If (Count parameters:C259=0)
	$hostName_t:=""
Else 
	$hostName_t:=$1
End if 

$router_o:=New shared object:C1526()
Use ($router_o)
	
	$router_o.PrimitiveValue:=New shared object:C1526()
	
	Use ($router_o.PrimitiveValue)
		
		$router_o.PrimitiveValue.type:="Router"
		
	End use   // Use ($router_o.PrimitiveValue)
	
	$router_o.hostName:=$hostName_t
	$router_o.route:=New shared collection:C1527()
	
	$router_o.addRoute:=Formula:C1597(RH_addRoute )
	
End use   // Use ($router_o)

$0:=$router_o
