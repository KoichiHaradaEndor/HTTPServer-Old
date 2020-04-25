//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method routes HTTP requests for the caller host
* to the speified path with the specified callbacks.
* It will match all HTTP verbs.
* 
* This method has two forms:
*
* <h3>CallerObj.all(path; callback)</h3>
* 
* In this form, CallerObj can be HttpServer, VirtualHost or Router object.
* The path parameter is for which the callback function is invoked.
* The callback parameter can be object (single formula),
* collection (list of formula object) or combination of them.
*
* @param {Text} $1 The path for which the callback function is invoked
* @param {Variant} ${2} Callback functions
*
* <h3>CallerObj.all(callback)</h3>
* 
* In this form, CallerObj can be SingleRoute object.
* In this case, path parameter is stored in the object,
* so only callback parameter is needed.
*
* @param {Variant} ${1} Callback functions
* @return {Object} This object
* @author: HARADA Koichi
*/

C_VARIANT:C1683(${1})
C_OBJECT:C1216($0)

C_TEXT:C284($method_t)

$method_t:="all"

$params_c:=New collection:C1472()
$params_c.push($method_t)
For ($i;1;Count parameters:C259)
	
	$params_c.push(${$i})
	
End for 

$formula_o:=Formula:C1597(HS_method )
$0:=$formula_o.apply(This:C1470;$params_c)
