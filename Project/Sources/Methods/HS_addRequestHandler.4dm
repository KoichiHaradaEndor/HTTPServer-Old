//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method is used to register request handler to HttpServer object.
  //* 
  //* @author: HARADA Koichi
  //* @param {Object} $1 The RequestHandler object to register
  //*/

C_OBJECT:C1216($1;$requestHandler_o)

$requestHandler_o:=$1

Case of 
	: ($requestHandler_o.PrimitiveValue=Null:C1517)
		
	: ($requestHandler_o.PrimitiveValue.type=Null:C1517)
		
	: ($requestHandler_o.PrimitiveValue.type#"RequestHandler")
		
	Else 
		
		Use (This:C1470)
			
			Use (This:C1470.requestHandler)
				
				This:C1470.requestHandler.hostName.push($requestHandler_o.hostName)
				This:C1470.requestHandler.route.push($requestHandler_o.route)
				
			End use   // Use (This.requestHandler)
			
		End use   // Use (This)
		
End case 
