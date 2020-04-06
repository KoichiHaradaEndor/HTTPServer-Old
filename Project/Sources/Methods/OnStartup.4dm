//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($app_o)
C_TEXT:C284($configtest_t)

$app_o:=new HttpServer 

  // Just to make sure the config is valid.
  // If you know it's valid, this code is not needed.
$configtest_t:=$app_o.configtest()
ASSERT:C1129($configtest_t="Syntax OK";"httpServer.conf is not valid")

  // Test1
$app_o.get("/test1";Formula:C1597(Test1 );Formula:C1597(Test2 ))

$app_o.restart()
