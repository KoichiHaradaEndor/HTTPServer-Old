//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method has three forms:
*
* <h3>CallerObj.use({path;} callback)</h3>
*
* In this form, CallerObj can be HttpServer, VirtualHost or SingleRoute object.
* The path parameter is for which the callback function is invoked.
*
* When the path parameter is omitted, the path is defined as follows:
* 1) When CallerObj is SingleRoute object, path parameter is stored in it.
* So it is used.
* 2) When CallerObj is HttpServer or VirtualHost object, the path defaults to
* "/" which means the callback function will be invoked for any path.
*
* The callback parameter can be an object (single formula),
* collection (list of formula object) or combination of them.
*
* @param {Text} $1 The path for which the callback function is invoked (forward match)
* @param {Variant} ${2} Callback functions
*
* <h3>CallerObj.use(vhost)</h3>
*
* When VirtualHost object is passed to this method,
* the routes defined in VirtualHost object is added to
* HttpServer object.
*
* @param {Variant} $1 VirtualHost object
*
* @author: HARADA Koichi
*/

C_VARIANT:C1683(${1})
C_OBJECT:C1216($0)

C_TEXT:C284($method_t;$pathParam_t)
C_LONGINT:C283($type_l;$insertionPosition_l;$index_l;$numParam_l)
C_BOOLEAN:C305($vhost_b;$insertDefaultPath_b)
C_OBJECT:C1216($route_o)
C_COLLECTION:C1488($routes_c)

$numParam_l:=Count parameters:C259
ASSERT:C1129($numParam_l>0;Current method name:C684+" : Lack of parameters")

$vhost_b:=False:C215
$insertDefaultPath_b:=False:C215
$type_l:=Value type:C1509($1)

  // Determines if the first parameter is vhost object
  // and it is the only parameter passed
Case of 
	: ($numParam_l>1)
		
	: ($type_l#Is object:K8:27)
		
	: ($1.__type__=Null:C1517)
		
	: ($1.__type__="VirtualHost")
		
		  // The first paramter is VirtualHost object
		$vhost_b:=True:C214
		
End case 

If ($vhost_b)
	
	Use (Storage:C1525.hosts)
		
		  // Search for hostname inside Storage.hosts to find if it is already registered
		$index_l:=Storage:C1525.hosts.findIndex("HS_findVhost";$1.hostname)
		
		If ($index_l=-1)
			
			  // Such hostname was not previously registered, so add one
			  // To make default host is always the last element,
			  // insert vhost at second from the last.
			$insertionPosition_l:=Storage:C1525.hosts.length-1
			
			  // $1 vhost object is standard object. So it cannot be inserted directly into Storge.
			Storage:C1525.hosts.insert($insertionPosition_l;New shared object:C1526())
			Storage:C1525.hosts[$insertionPosition_l].hostname:=$1.hostname
			Storage:C1525.hosts[$insertionPosition_l].routes:=New shared collection:C1527()
			
		Else 
			
			  // match hostname was found
			$insertionPosition_l:=$index_l
			
		End if 
		
		For each ($route_o;$1.routes)
			
			Storage:C1525.hosts[$insertionPosition_l].routes.push(New shared object:C1526("method";$route_o.method;"path";$route_o.path))
			  // Formula object cannot be added to Storage with New shared object because the command creates a group before adding the object.
			Storage:C1525.hosts[$insertionPosition_l].routes[Storage:C1525.hosts[$insertionPosition_l].routes.length-1]["callback"]:=$route_o.callback
			If ($route_o.params#Null:C1517)
				Storage:C1525.hosts[$insertionPosition_l].routes[Storage:C1525.hosts[$insertionPosition_l].routes.length-1]["params"]:=New shared collection:C1527()
				For each ($pathParam_t;$route_o.params)
					Storage:C1525.hosts[$insertionPosition_l].routes[Storage:C1525.hosts[$insertionPosition_l].routes.length-1]["params"].push($pathParam_t)
				End for each 
			End if 
			
		End for each 
		
	End use 
	
Else 
	
	  // If the first parameter is of type object
	  // and it's not vhost object, then
	  // determines caller object type
	Case of 
		: ($type_l#Is object:K8:27)
			
		: (This:C1470.__type__=Null:C1517)
			
		: (This:C1470.__type__="HttpServer") | (This:C1470.__type__="VirtualHost")
			
			  // The path parameter is omitted and the caller
			  // object is of type HttpServer or VirtualHost
			$insertDefaultPath_b:=True:C214
			
	End case 
	
	$method_t:="use"
	
	$params_c:=New collection:C1472()
	$params_c.push($method_t)
	If ($insertDefaultPath_b)
		
		$params_c.push("/")
		
	End if 
	For ($i;1;Count parameters:C259)
		
		$params_c.push(${$i})
		
	End for 
	
	$formula_o:=Formula:C1597(HS_method )
	$0:=$formula_o.apply(This:C1470;$params_c)
	
End if 
