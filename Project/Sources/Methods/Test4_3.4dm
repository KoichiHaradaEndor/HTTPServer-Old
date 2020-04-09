//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$app_o)

C_OBJECT:C1216($vhost_o)

$app_o:=$1

$app_o.get("/users/:userId/books/:bookId";Formula:C1597(Test4_3_1 ))

$vhost_o:=$app_o.vhost("test.mycompany.com")
$vhost_o.get("/users/:userId/books/:bookId";Formula:C1597(Test4_3_1 ))
$app_o.use($vhost_o)

