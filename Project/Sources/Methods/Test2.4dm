//%attributes = {"invisible":true,"preemptive":"capable"}
/*
* This code registers route handlers for path="/test2".
* The request method can be GET or POST.
* But there are the same pre-process and post-process.
*/

C_OBJECT:C1216($1;$app_o)

C_LONGINT:C283($selector_l)

$app_o:=$1

$selector_l:=1

Case of 
	: ($selector_l=1)
		
		$app_o.all("/test2";Formula:C1597(Test2_1 ))  // pre-process function
		$app_o.get("/test2";Formula:C1597(Test2_2_GET ))  // only for GET
		$app_o.post("/test2";Formula:C1597(Test2_2_POST ))  // only for POST
		$app_o.all("/test2";Formula:C1597(Test2_3 ))  // post-process function
		
	: ($selector_l=2)
		
		$app_o.route("/test2")\
			.all(Formula:C1597(Test2_1 ))\
			.get(Formula:C1597(Test2_2_GET ))\
			.post(Formula:C1597(Test2_2_POST ))\
			.all(Formula:C1597(Test2_3 ))
		
End case 
