//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This is generic method intended to use by CallerObject.METHOD method.
* Additionally using this method, you can register routes that respond
* to any method like "mkcol", "purge", "unsubscribe" and so on.
*
* This method has two forms:
*
* <h3>CallerObj.method(method; path; callback)</h3>
* 
* In this form, CallerObj can be HttpServer or VirtualHost object.
* The path parameter is for which the callback function is invoked.
* The callback parameter can be object (single formula),
* collection (list of formula object) or combination of them.
*
* @param {Text} $1 HTTP verb or all or use
* @param {Text} $2 The path for which the callback function is invoked
* @param {Variant} ${3} Callback functions
*
* <h3>CallerObj.method(method; callback)</h3>
* 
* In this form, CallerObj can be SingleRoute object.
* In this case, path parameter is stored in the object,
* so only callback parameter is needed.
*
* @param {Text} $1 HTTP verb or all or use
* @param {Variant} ${2} Callback functions
* @return {Object} This object
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$method_t)
C_VARIANT:C1683(${2})
C_OBJECT:C1216($0)

C_LONGINT:C283($i)
C_TEXT:C284($thisType_t;$path_t)
C_COLLECTION:C1488($params_c)
C_OBJECT:C1216($formula_o;$this_o)

$method_t:=$1
$thisType_t:=This:C1470.__type__

Case of 
	: ($thisType_t="HttpServer") | ($thisType_t="VirtualHost")
		
		  // CallerObj.METHOD(method; path; callback)
		$path_t:=$2
		
		$params_c:=New collection:C1472()
		$params_c.push($method_t)
		$params_c.push($path_t)
		
		For ($i;3;Count parameters:C259)
			
			$params_c.push(${$i})
			
		End for 
		
		$this_o:=This:C1470
		
	: ($thisType_t="SingleRoute")
		
		  // CallerObj.METHOD(method; callback)
		$params_c:=New collection:C1472()
		$params_c.push($method_t)
		$params_c.push(This:C1470.path)
		
		For ($i;2;Count parameters:C259)
			
			$params_c.push(${$i})
			
		End for 
		
		$this_o:=This:C1470.host  // Parent object (HttpServer or VirtualHost)
		
End case 

$formula_o:=Formula:C1597(HS_addRoute )
$formula_o.apply($this_o;$params_c)

If ($thisType_t="SingleRoute")
	
	$0:=This:C1470
	
End if 
