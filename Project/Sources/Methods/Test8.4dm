//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$app_o)

C_OBJECT:C1216($vhost_o)

$app_o:=$1

$app_o.get("/test8";Formula:C1597(Test8_1_main ))

$vhost_o:=$app_o.vhost("test.mycompany.com")
$vhost_o.get("/test8";Formula:C1597(Test8_1_vhost ))
$app_o.use($vhost_o)
