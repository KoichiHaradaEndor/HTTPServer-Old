//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0)

C_OBJECT:C1216($config_o)
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
				$resultCode_l:=HS_configRead (Storage:C1525.httpServer.config)
				Storage:C1525.httpServer.config.test:=Formula:C1597(HS_configTest )
			End use 
			
		End use   // (Storage.httpServer)
		
	End if   // (Storage.httpServer=Null)
	
	$0:=Storage:C1525.httpServer
	
End use 
