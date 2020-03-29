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
	
	  //*****
	  // Declares HttpServer object
	  //*****
	If (Storage:C1525.httpServer=Null:C1517)
		
		Storage:C1525.httpServer:=New shared object:C1526()
		Use (Storage:C1525.httpServer)
			
			  //*****
			  //* Properties
			  //*****
			
			Storage:C1525.httpServer.type:="HttpServer"
			
			  //*****
			  //* Methods
			  //*****
			
			  // web server configuration
			Storage:C1525.httpServer.configtest:=Formula:C1597(HS_configTest )
			
			  // start or stop web server
			Storage:C1525.httpServer.restart:=Formula:C1597(HS_restart )
			Storage:C1525.httpServer.start:=Formula:C1597(HS_start )
			Storage:C1525.httpServer.stop:=Formula:C1597(HS_stop )
			
			  // add route to the server
			Storage:C1525.httpServer.all:=Formula:C1597(HS_all )
			Storage:C1525.httpServer.delete:=Formula:C1597(HS_delete )
			Storage:C1525.httpServer.get:=Formula:C1597(HS_get )
			Storage:C1525.httpServer.post:=Formula:C1597(HS_post )
			Storage:C1525.httpServer.put:=Formula:C1597(HS_put )
			Storage:C1525.httpServer.route:=Formula:C1597(HS_route )
			Storage:C1525.httpServer.use:=Formula:C1597(HS_use )
			
			  // virtual host
			Storage:C1525.httpServer.VHost:=Formula:C1597(HS_vhost )
			
		End use   // Use (Storage.httpServer)
		
	End if   // If (Storage.httpServer=Null)
	
	  //*****
	  // Initialize Hosts
	  //*****
	If (Storage:C1525.hosts=Null:C1517)
		
		Storage:C1525.hosts:=New shared collection:C1527(New object:C1471(\
			"hostname";".*";\
			"routes";New shared collection:C1527()\
			))
		
	End if   // If (Storage.hosts=Null)
	
End use   // Use (Storage)

$0:=Storage:C1525.httpServer
