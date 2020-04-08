//%attributes = {"invisible":true,"preemptive":"capable"}
If (Count parameters:C259=0)
	
	C_LONGINT:C283($pid_l)
	
	$pid_l:=New process:C317(Current method name:C684;0;"Initializing app...";"")
	
Else 
	
	C_OBJECT:C1216($app_o)
	
	  // For testing purpose,
	  // clear Storage.hosts
	Use (Storage:C1525)
		Storage:C1525.hosts:=Null:C1517
	End use 
	
	$app_o:=new HttpServer 
	
	Test1 ($app_o)
	Test2 ($app_o)
	Test3 ($app_o)
	Test4 ($app_o)
	Test5 ($app_o)
	Test6 ($app_o)
	Test7 ($app_o)
	
	  // load http server configuration and
	  // start web server
	$app_o.start()
	
End if 
