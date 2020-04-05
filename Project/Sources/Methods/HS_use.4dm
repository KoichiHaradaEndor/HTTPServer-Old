//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method has three forms:
*
* <h3>CallerObj.use(path; callback)</h3>
*
* In this form, CallerObj can be HttpServer or VirtualHost object.
* The path parameter is for which the callback function is invoked.
* The callback parameter can be object (single formula),
* collection (list of formula object) or combination of them.
*
* @param {Text} $1 The path for which the callback function is invoked (forward match)
* @param {Variant} ${2} Callback functions
*
* <h3>CallerObj.use(callback)</h3>
* 
* In this form, CallerObj can be SingleRoute object.
* In this case, path parameter is stored in the object,
* so only callback parameter is needed.
*
* @param {Variant} ${1} Callback functions
* @return {Object} This object
*
* <h3>CallerObj.use(vhost)</h3>
*
* When VirtualHost object is passed to this method,
* the routes defined in VirtualStore object is added to
* HttpServer object.
* In this case, CallerObj must be HttpServer object.
*
* @param {Variant} $1 VirtualHost object
*
* @author: HARADA Koichi
*/

C_VARIANT:C1683(${1})
C_OBJECT:C1216($0)

C_TEXT:C284($method_t)
C_LONGINT:C283($type_l;$insertionPosition_l)
C_BOOLEAN:C305($addVhost_b)

ASSERT:C1129(Count parameters:C259>0;Current method name:C684+" : Lack of parameters")

$addVhost_b:=False:C215
$type_l:=Value type:C1509($1)

Case of 
	: ($type_l#Is object:K8:27)
		
	: ($1.__type__=Null:C1517)
		
	: ($1.__type__#"VirtualHost")
		
	Else 
		
		  // Third paramter is VirtualHost object
		$addVhost_b:=True:C214
		
End case 

If ($addVhost_b)
	
	Use (Storage:C1525.hosts)
		
		  // To make default host is always the last element,
		  // insert vhost at second from the last.
		$insertionPosition_l:=Storage:C1525.hosts.length-1
		Storage:C1525.hosts.insert($insertionPosition_l;$1)
		
	End use 
	
Else 
	
	$method_t:="use"
	
	$params_c:=New collection:C1472()
	$params_c.push($method_t)
	For ($i;1;Count parameters:C259)
		
		$params_c.push(${$i})
		
	End for 
	
	$formula_o:=Formula:C1597(HS_method )
	$0:=$formula_o.apply(This:C1470;$params_c)
	
End if 
