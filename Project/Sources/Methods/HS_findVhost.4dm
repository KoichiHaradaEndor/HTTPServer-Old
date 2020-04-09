//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to find vhost in Storage.hosts collection
*/

C_OBJECT:C1216($1)
C_TEXT:C284($2;$hostname_t)

C_OBJECT:C1216($host_o)

$host_o:=$1.value
$hostname_t:=$2

$1.result:=($host_o.hostname=$hostname_t)
