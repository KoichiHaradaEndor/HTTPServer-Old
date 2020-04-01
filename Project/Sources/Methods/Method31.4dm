//%attributes = {}
C_COLLECTION:C1488($c;$q)
$c:=New collection:C1472()
$c.push(New object:C1471("name";"name1";"value";"value1"))
$c.push(New object:C1471("name";"name2";"value";"value2"))
$c.push(New object:C1471("name";"name3";"value";"value3"))
$c.push(New object:C1471("name";"name4";"value";"value4"))

$q:=$c.query("name = :1";"name3")
$q[0].value:="mod"

TRACE:C157
