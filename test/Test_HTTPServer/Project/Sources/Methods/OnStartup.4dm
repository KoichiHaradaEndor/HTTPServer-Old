//%attributes = {"invisible":true,"preemptive":"capable"}
If (Count parameters:C259=0)
	
	C_LONGINT:C283($pid_l)
	
	$pid_l:=New process:C317(Current method name:C684;0;"Initializing app...";"")
	
Else 
	
	C_OBJECT:C1216($app_o)
	
	$app_o:=new HttpServer 
	
	Test1_1 ($app_o)
	Test1_2 ($app_o)
	Test1_3 ($app_o)
	Test2_1 ($app_o)
	Test2_2 ($app_o)
	Test2_3 ($app_o)
	Test2_4 ($app_o)
	Test2_5 ($app_o)
	Test3_1 ($app_o)
	Test4_1 ($app_o)
	Test4_2 ($app_o)
	Test4_3 ($app_o)
	Test6_1 ($app_o)
	Test5_1 ($app_o)  // Auth Test must be bottom
	
	  // load http server configuration and
	  // start web server
	$app_o.start()
	
End if 
