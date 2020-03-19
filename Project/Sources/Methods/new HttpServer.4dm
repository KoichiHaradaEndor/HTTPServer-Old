//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method creates HttpServer object and return it.
  //* Since single 4D / 4D Server instance can serve one
  //* HTTP server, only one HttpServer object can reside.
  //* That's why Singleton DP is used to create the object.
  //* 
  //* @return {Object} HttpServer object.
  //* @author: HARADA Koichi
  //*/

C_OBJECT:C1216($0)

C_LONGINT:C283($resultCode_l)

Use (Storage:C1525)
	
	If (Storage:C1525.httpServer=Null:C1517)
		
		Storage:C1525.httpServer:=New shared object:C1526()
		Use (Storage:C1525.httpServer)
			
			Storage:C1525.httpServer.start:=Formula:C1597(HS_start )
			Storage:C1525.httpServer.stop:=Formula:C1597(HS_stop )
			Storage:C1525.httpServer.restart:=Formula:C1597(HS_restart )
			
			Storage:C1525.httpServer.config:=New shared object:C1526()
			Use (Storage:C1525.httpServer.config)
				
				Storage:C1525.httpServer.config.test:=Formula:C1597(HS_configTest )
				
			End use   // Use (Storage.httpServer.config)
			
		End use   // Use (Storage.httpServer)
		
	End if   // If (Storage.httpServer=Null)
	
	Use (Storage:C1525.httpServer.config)
		
		  // When creating the object, always reads config from file.
		$resultCode_l:=HS_configRead (Storage:C1525.httpServer.config)
		
	End use   // (Storage.httpServer.config)
	
	$0:=Storage:C1525.httpServer
	
End use   // Use (Storage)
