//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0)

Use (Storage:C1525)
	
	If (Storage:C1525.httpServer=Null:C1517)
		
		Storage:C1525.httpServer:=New shared object:C1526(\
			"listenIP";"0.0.0.0";\
			"listenPort";80;\
			"listenSSLPort";443;\
			"start";Formula:C1597(HS_start );\
			"stop";Formula:C1597(HS_stop );\
			"restart";Formula:C1597(HS_restart ))
		
	End if 
	
	$0:=Storage:C1525.httpServer
	
End use 
