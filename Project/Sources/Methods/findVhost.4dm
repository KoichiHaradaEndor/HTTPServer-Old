//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method finds vhost that matches given host name
*
* @param {Object} $1 Given by collection.find function
* @param {Text} $2 Host name sent via HTTP request
* @author HARADA Koichi
*/

C_OBJECT:C1216($1)
C_TEXT:C284($2;$requestHost_t)

C_OBJECT:C1216($host_o)

$requestHost_t:=$2

ASSERT:C1129(Value type:C1509($1.value)=Is object:K8:27)

$host_o:=$1.value

$1.result:=Match regex:C1019($host_o.hostname;$requestHost_t;1)
