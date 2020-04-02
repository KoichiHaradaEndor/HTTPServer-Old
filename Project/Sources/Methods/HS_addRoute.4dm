//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This is a generic method used to add a route to the host object.
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

Case of 
	: (This:C1470.__type__="HttpServer")
		$path_t:=$2
		$indices_c:=Storage:C1525.hosts.indices("hostname = :1";Storage:C1525.__constants__.defaultHostPattern)
		$host_o:=Storage:C1525.hosts[$indices_c[0]]
		  // This must be present since it is declared when HttpServer
		  // is created.
		
	: (This:C1470.__type__="VirtualHost")  // created with HS_vhost
		$path_t:=$2
		$host_o:=This:C1470
		
	: (This:C1470.__type__="SingleRoute")  // created with HS_route
		$path_t:=This:C1470.path
		
		Case of 
			: (This:C1470.host.__type__="HttpServer")
				$indices_c:=Storage:C1525.hosts.indices("hostname = :1";Storage:C1525.__constants__.defaultHostPattern)
				$host_o:=Storage:C1525.hosts[$indices_c[0]]
				
			: (This:C1470.host.__type__="VirtualHost")
				$host_o:=This:C1470.host
				
		End case 
		
End case 

  // complete path parameter as Regex
Case of 
	: ($method_t="use")
		$path_t:="^"+$path_t+"(?:/[^/]*)*$"
		
	Else 
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
