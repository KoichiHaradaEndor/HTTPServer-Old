//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$app_o)

C_OBJECT:C1216($router_o)

$app_o:=$1

  // API v1
$router_o:=new Router 
$router_o.get("/func1";Formula:C1597(Test6_1_Func1 ))
$router_o.get("/func2";Formula:C1597(Test6_1_Func2 ))

$app_o.use("/v1";$router_o)

  // API v2
$router_o:=new Router 
$router_o.get("/func1";Formula:C1597(Test6_1_Func1 ))
$router_o.get("/func2";Formula:C1597(Test6_1_Func2New ))

$app_o.use("/v2";$router_o)
