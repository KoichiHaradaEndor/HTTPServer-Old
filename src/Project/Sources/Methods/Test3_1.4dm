//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$app_o)

C_OBJECT:C1216($vhost_o)

$app_o:=$1

$app_o.get("/test3-1";Formula:C1597(Test3_1_1_main ))

$vhost_o:=new VirtualHost ("test.mycompany.com")
$vhost_o.get("/test3-1";Formula:C1597(Test3_1_1_vhost ))
$app_o.use($vhost_o)
