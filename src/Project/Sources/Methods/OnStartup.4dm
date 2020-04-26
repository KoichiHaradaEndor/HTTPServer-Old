//%attributes = {"invisible":true,"preemptive":"capable"}
If (Count parameters:C259=0)
	
	C_LONGINT:C283($pid_l)
	
	$pid_l:=New process:C317(Current method name:C684;0;"Initializing app...";"")
	
Else 
	
	C_OBJECT:C1216($app_o)
	
	$app_o:=new HttpServer 
	
	
	  // load http server configuration and
	  // start web server
	$app_o.start()
	
End if 
