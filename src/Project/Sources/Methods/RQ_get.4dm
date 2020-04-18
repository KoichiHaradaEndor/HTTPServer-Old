//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns http request header field
* value.
*
* @param {Text} $1 Request header field name
* @return {Text} $0 Request header field value
*/

C_TEXT:C284($1;$name_t)
C_TEXT:C284($0;$value_t)

C_COLLECTION:C1488($queryResult_c)

$name_t:=$1
$value_t:=""

$queryResult_c:=This:C1470.__headers__.query("name = :1";$name_t)
If ($queryResult_c.length>0)
	
	$value_t:=$queryResult_c[0].value
	
End if 

$0:=$value_t
