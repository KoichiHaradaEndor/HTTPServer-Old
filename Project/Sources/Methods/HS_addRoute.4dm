//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This is a generic method used to add a route to the host object.
*
* Storage.hosts is a collection that consists of the host objects.
* <pre>
* Storage.hosts[{host object}]
* </pre>
*
* The sructure of the host object is as follow:
* <pre>
* {
*     hostname : {Text} regular expression pattern used to search by Host request header value
*     routes : [{
*         method : {Text} used to search by HTTP method value 
*         path : {Text} regular expression pattern used to search by request path
*         callback : {Object} formula reference which is called when above conditions are match
*     }]
* }
* </pre>
*  
* @param {Text} $1 HTTP method or flag
* @param {Text} $2 The path for which the callback function is invoked
* @param {Variant} ${3} Callback functions
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$method_t)
C_TEXT:C284($2;$path_t)
C_VARIANT:C1683(${3})  // callback functions

C_COLLECTION:C1488($indices_c)
C_OBJECT:C1216($host_o;$formula_o)
C_LONGINT:C283($i;$valueType_l)

$method_t:=$1
$path_t:=$2

Case of 
	: (This:C1470.__type__="HttpServer")
		
		  // When the caller object is HttpServer, add the route
		  // directly to Storage.hosts.
		
		$indices_c:=Storage:C1525.hosts.indices("hostname = :1";Storage:C1525.__constants__.defaultHostPattern)
		$host_o:=Storage:C1525.hosts[$indices_c[0]]
		  // This must be present since it is declared when HttpServer
		  // is created.
		
	: (This:C1470.__type__="VirtualHost")  // created with HS_vhost
		
		  // When the caller object is VirtualHost, add the route
		  // to This (thus VirtualHost object) object.
		
		$host_o:=This:C1470
		
End case 

  // complete path parameter as Regex
Case of 
	: ($method_t="use")
		
		  // forward match
		$path_t:="^"+$path_t+"(?:/[^/]*)*$"
		
	Else 
		
		  // full match
		$path_t:="^"+$path_t+"$"
		
End case 

Use ($host_o.routes)
	
	For ($i;3;Count parameters:C259)
		
		$valueType_l:=Value type:C1509(${$i})
		
		Case of 
			: ($valueType_l=Is object:K8:27)
				  // This must be Formula object.
				  // Currently there's no way to identify if its a formula.
				
				$host_o.routes.push(New object:C1471(\
					"method";$method_t;\
					"path";$path_t\
					"callback";${$i}\
					))
				
			: ($valueType_l=Is collection:K8:32)
				  // This must be collection of Formula object.
				  // Currently there's no way to identify if they're formulas.
				
				For each ($formula_o;${$i})
					
					$host_o.routes.push(New object:C1471(\
						"method";$method_t;\
						"path";$path_t\
						"callback";$formula_o\
						))
					
				End for each 
				
		End case 
		
	End for 
	
End use 
