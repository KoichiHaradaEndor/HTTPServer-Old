//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($app_o)
C_TEXT:C284($configtest_t)

$app_o:=new HttpServer 

$configtest_t:=$app_o.configtest()



$app_o.start()
