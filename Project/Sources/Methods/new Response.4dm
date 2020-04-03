//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method creates Response object and return it.
*
* For more details, please refer to {@link Response.About Response Object}.
*
* @return {Object} $0 Response object
* @author: HARADA Koichi
*/

C_OBJECT:C1216($0;$response_o)

$response_o:=New object:C1471()
$response_o.__type__:="Response"

  //#####
  // Properties
  //#####
$response_o.locals:=New object:C1471()
$response_o.__headers__:=New collection:C1472()

  //#####
  // Methods
  //#####
$response_o.append:=Formula:C1597(RS_append )
$response_o.attachment:=Formula:C1597(RS_attachment )
$response_o.cookie:=Formula:C1597(RS_cookie )
$response_o.clearCookie:=Formula:C1597(RS_clearCookie )
$response_o.download:=Formula:C1597(RS_download )
$response_o.get:=Formula:C1597(RS_get )

$response_o.set:=Formula:C1597(RS_set )

$response_o.type:=Formula:C1597()

$0:=$response_o
