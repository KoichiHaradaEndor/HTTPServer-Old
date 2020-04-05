//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method is called in On Web Connection database method
* of the host database. Please pass $3 and $4 arguments
* of the database method to this method:
* {@code
* // On Web Connection database method
* C_TEXT($1;$2;$3;$4;$5;$6)
* OnWebConnection($3;$4)
* }
*
* Then this method does:
* - initialize Request and Response objects
* - find routes that matches the incoming request host, method and path
* - calls route handler method with passing Request and Response objects
*
* @param {Text} $1 IP address of the request sender
* @param {Text} $2 IP address of the server that receives the request
*/

C_TEXT:C284($1;$ipClient_t)
C_TEXT:C284($2;$ipServer_t)

C_OBJECT:C1216($request_o;$response_o)
C_COLLECTION:C1488($hosts_c;$queriedHosts_c)
C_TEXT:C284($host_t;$method_t;$path_t)

$ipClient_t:=$1
$ipServer_t:=$2

$request_o:=new Request ($ipClient_t;$ipServer_t)
$response_o:=new Response 

$hosts_c:=Storage:C1525.hosts

$host_t:=$request_o.hostname
$method_t:=$request_o.method
$path_t:=$request_o.path

If ($hosts_c.length=1)
	
	  // only default host is present, use it
	$queriedHosts_c:=$hosts_c[0]
	
Else 
	
	
End if 
