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
* - calls route handler methods with passing Request and Response objects
*
* @param {Text} $1 IP address of the request sender
* @param {Text} $2 IP address of the server that receives the request
*/

  // Note that do not use USE clause in this method since
  // * I don't want to block other web processes
  // * HttpServer configuration phase has already been finishied

C_TEXT:C284($1;$ipClient_t)
C_TEXT:C284($2;$ipServer_t)

C_OBJECT:C1216($request_o;$response_o;$host_o;$route_o;$formula_o)
C_COLLECTION:C1488($hosts_c;$routes_c)
C_TEXT:C284($requestHost_t;$requestMethod_t;$requestPath_t)
C_TEXT:C284($routeHost_t;$routeMethod_t;$routePath_t)
C_BOOLEAN:C305($match_b)

$ipClient_t:=$1
$ipServer_t:=$2

$request_o:=new Request ($ipClient_t;$ipServer_t)
$response_o:=new Response 

$hosts_c:=Storage:C1525.hosts

$requestHost_t:=$request_o.hostname
$requestMethod_t:=$request_o.method
$requestPath_t:=$request_o.path

  // Find a Host that matches Host request header
If ($hosts_c.length=1)
	
	  // only default host is present, use it
	$host_o:=$hosts_c[0]
	
Else 
	
	$matchHost_b:=False:C215
	For each ($host_o;$hosts_c) Until ($match_b)
		
		$match_b:=Match regex:C1019($host_o.hostname;$requestHost_t;1)
		
	End for each 
	
End if 

  // Find routes that matches HTTP method and path
$formula_o:=New object:C1471()
$formula_o.index:=0
$formula_o.formulas:=New collection:C1472()
$formula_o.request:=$request_o
$formula_o.response:=$response_o
$formula_o.next:=Formula:C1597(callNextCallback )

$routes_c:=$host_o.routes
For each ($route_o;$routes_c)
	
	$routeMethod_t:=$route_o.method
	$routePath_t:=$route_o.path
	
	If ($routeMethod_t="all") | ($routeMethod_t="use") | ($routeMethod_t=$requestMethod_t)
		
		$match_b:=Match regex:C1019($routePath_t;$requestPath_t;1)
		If ($match_b)
			
			$formula_o.formulas.push($route_o.callback)
			
		End if 
		
	End if 
	
End for each 

  // Then call first callback
If ($formula_o.length>0)
	
	$formula_o.formulas[$formula_o.index].call(Null:C1517;$request_o;$response_o;$formula_o.next)
	
End if 
