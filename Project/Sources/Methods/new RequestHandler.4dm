//%attributes = {}
  //**
  //* This method creates RequestHandler object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @return {Object} RequestHandler object.
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
			
		End use   // Use (Storage.httpServer)
		
	End if   // If (Storage.httpServer=Null)
	
	Use (Storage:C1525.httpServer.config)
		
		  // When creating the object, always reads config from file.
		$resultCode_l:=HS_configRead (Storage:C1525.httpServer.config)
		Storage:C1525.httpServer.config.test:=Formula:C1597(HS_configTest )
		Storage:C1525.httpServer.config.load:=Formula:C1597(HS_configLoad )
		
	End use   // (Storage.httpServer.config)
	
	$0:=Storage:C1525.httpServer
	
End use   // Use (Storage)
