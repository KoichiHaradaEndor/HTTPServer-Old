//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This function is used to add middleware to the CallerObj.
*
* <h3>CallerObj.use({path;} middleware)</h3>
*
* - path parameter
* Path parameter can be passed when the middleware is Function or Router object.
* In this case, if it is ommited, it defaults to "/".
* When the middleware is VirtualHost, path parameter is ignored even
* it is present.
*
* - middleware
* "middleware" can be Function, VirtualHost or Router object.
* It can be single middleware, multiple arguments, collection or combination of them.
*
* -- VirtualHost
* When the middleware is VirtulaHost object, the path parameter is ignored
* and the CallerObj must be of type HttpServer. In this case, this funcion
* is used to register and activate VirtualHost.
*
* -- Router
* When the middleware is Router object, this function connects it to
* CallerObj under the path. The path of CallerObj and the path of Router
* are concatenated. Full match is used when searching routes
*
* When the path parameter is omitted, it defaults to "/" which means
* the Router's paths are connected to CallerObj's root.
*
* The CallObj could be HttpServer or VirtualHost.
*
* -- Function
*
* Any other cases to the above, middleware is considered as Function
* and it is connected to CallerObj under the path.
*
* Unlike in the case of other route functions like method, get and post,
* the forward path match is used when searching routes.
*
* In this form, CallerObj can be HttpServer, VirtualHost, Router or SingleRoute object.
*
* When the CallerObj is of type SingleRoute, path parmeter should be omitted
* since path information is already stored in the object. If path paramter is present
* it is ignored.
*
* When the CallerObj is either HttpServer, VirtualHost or Router object,
* and the path parameter is omitted, the path defaults to "/".
*
* The callback parameter can be an object (single formula),
* collection (list of formula object) or combination of them.
*
* @author: HARADA Koichi
*/

C_VARIANT:C1683(${1})
C_OBJECT:C1216($0)

C_LONGINT:C283($numParam_l;$startPos_l;$i;$typeFirstParam_l;$typeMiddleware_l)
C_BOOLEAN:C305($useParamPath_b)
C_TEXT:C284($callerObjType_t;$middlewareType_t;$path_t)
C_COLLECTION:C1488($middlewares_c)
C_OBJECT:C1216($middleware_o)

$numParam_l:=Count parameters:C259
ASSERT:C1129($numParam_l>0;Current method name:C684+" : Lack of parameters")

$typeFirstParam_l:=Value type:C1509($1)

  // Type of caller object
If (This:C1470.__type__#Null:C1517)
	
	$callerObjType_t:=This:C1470.__type__
	
End if 

  // If the first parameter is path, middleware starts from 2, else 1
If ($typeFirstParam_l=Is text:K8:3)
	
	$path_t:=$1
	$startPos_l:=2
	
Else 
	
	$path_t:="/"
	$startPos_l:=1
	
End if 

  // however if callerobj is SingleRoute, use This.path
If ($callerObjType_t="SingleRoute")
	
	$path_t:=This:C1470.path
	
End if 

For ($i;$startPos_l;$numParam_l)
	
	  // Loop through middleware parameters
	  // It can be single middle ware (Function or object) or colloction of middlewares.
	  // So make it collection
	
	$typeMiddleware_l:=Value type:C1509(${$i})
	
	Case of 
		: ($typeMiddleware_l=Is collection:K8:32)
			
			  // the parameter is a collection of middlewares
			$middlewares_c:=${$i}
			
		: ($typeMiddleware_l=Is object:K8:27)
			
			  // the parameter is single middleware that is Function object, vhost, or router
			$middlewares_c:=New collection:C1472(${$i})
			
		Else 
			
			$middlewares_c:=Null:C1517
			
	End case 
	
	If ($middlewares_c#Null:C1517)
		
		For each ($middleware_o;$middlewares_c)
			
			  // Loop through middleware collection
			  // middleware can be VirtualHost, Router or Function
			If ($middleware_o.__type__#Null:C1517)
				
				$middlewareType_t:=$middleware_o.__type__
				
			Else 
				
				$middlewareType_t:="Function"
				
			End if 
			
			Case of 
				: ($callerObjType_t="HttpServer") & ($middlewareType_t="VirtualHost")
					
					HS_addRouteVhost (This:C1470;$middleware_o)
					
				: (($callerObjType_t="HttpServer") | ($callerObjType_t="VirtualHost")) & ($middlewareType_t="Router")
					
					HS_addRouteRouter (This:C1470;$path_t;$middleware_o)
					
				: ($middlewareType_t="Function")
					
					HS_addRouteFunction (This:C1470;$path_t;$middleware_o)
					
			End case 
			
		End for each 
		
	End if 
	
End for 

If ($callerObjType_t="SingleRoute")
	
	$0:=This:C1470
	
End if 
