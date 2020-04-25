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
* In this form, CallerObj can be HttpServer, VirtualHost or Router object.
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

C_TEXT:C284($thisType_t)
C_OBJECT:C1216($param_o;$callback_o;$formula_o)
C_COLLECTION:C1488($callbacks_c)
C_LONGINT:C283($i;$type_l;$start_l)

$method_t:=$1
$thisType_t:=This:C1470.__type__

  //#####
  // path and this object to path
  //#####
Case of 
	: ($thisType_t="HttpServer") | ($thisType_t="VirtualHost") | ($thisType_t="Router")
		
		  // CallerObj.METHOD(method; path; callback)
		$path_t:=$2
		$this_o:=This:C1470
		$start_l:=3
		
	: ($thisType_t="SingleRoute")
		
		  // CallerObj.METHOD(method; callback)
		$path_t:=This:C1470.path
		$this_o:=This:C1470.host  // Parent object (HttpServer, VirtualHost or Router)
		$start_l:=2
		
End case 

  //#####
  // callback to collection
  //#####
$callbacks_c:=New collection:C1472()

For ($i;$start_l;Count parameters:C259)
	
	$type_l:=Value type:C1509(${$i})
	
	Case of 
		: ($type_l=Is object:K8:27)
			
			$callbacks_c.push(${$i})
			
		: ($type_l=Is collection:K8:32)
			
			For each ($callback_o;${$i})
				
				$callbacks_c.push($callback_o)
				
			End for each 
			
	End case 
	
End for 

$param_o:=New object:C1471()
$param_o.method:=$method_t
$param_o.path:=$path_t
$param_o.callbacks:=$callbacks_c

$formula_o:=Formula:C1597(HS_addRoute )
$formula_o.call($this_o;$param_o)

If ($thisType_t="SingleRoute")
	
	$0:=This:C1470
	
End if 
