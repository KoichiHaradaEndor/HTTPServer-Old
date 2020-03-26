//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method creates HttpServer object and return it.
  //* Since single 4D / 4D Server instance can serve one
  //* HTTP server, only one HttpServer object can reside.
  //* That's why Singleton design pattern is used 
  //* to create the object.
  //* 
  //* @author: HARADA Koichi
  //* @return {Object} HttpServer object.
  //*/

C_OBJECT:C1216($0)

C_LONGINT:C283($resultCode_l)

Use (Storage:C1525)
	
	If (Storage:C1525.httpServer=Null:C1517)
		
		Storage:C1525.httpServer:=New shared object:C1526()
		Use (Storage:C1525.httpServer)
			
			Storage:C1525.httpServer.PrimitiveValue:=New shared object:C1526()
			
			Use (Storage:C1525.httpServer.PrimitiveValue)
				
				Storage:C1525.httpServer.PrimitiveValue.type:="HttpServer"
				
			End use   // Use (Storage.httpServer.PrimitiveValue)
			
			Storage:C1525.httpServer.start:=Formula:C1597(HS_start )
			Storage:C1525.httpServer.stop:=Formula:C1597(HS_stop )
			Storage:C1525.httpServer.restart:=Formula:C1597(HS_restart )
			Storage:C1525.httpServer.addRequestHandler:=Formula:C1597(HS_addRequestHandler )
			
			Storage:C1525.httpServer.config:=New shared object:C1526()
			Storage:C1525.httpServer.requestHandler:=New shared object:C1526()
			
			Use (Storage:C1525.httpServer.requestHandler)
				
				Storage:C1525.httpServer.requestHandler.hostName:=New shared collection:C1527()
				Storage:C1525.httpServer.requestHandler.route:=New shared collection:C1527()
				
			End use   // Use (Storage.httpServer.requestHandler)
			
		End use   // Use (Storage.httpServer)
		
	End if   // If (Storage.httpServer=Null)
	
End use   // Use (Storage)

Use (Storage:C1525.httpServer.config)
	
	  // When creating the object, always reads config from file,
	  // so that modified config will take effect when restarting
	  // the web server.
	$resultCode_l:=HS_configRead (Storage:C1525.httpServer.config)
	Storage:C1525.httpServer.config.test:=Formula:C1597(HS_configTest )
	Storage:C1525.httpServer.config.load:=Formula:C1597(HS_configLoad )
	
End use   // Use (Storage.httpServer.config)

$0:=Storage:C1525.httpServer
