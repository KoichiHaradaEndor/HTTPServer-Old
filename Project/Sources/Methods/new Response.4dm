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
$response_o.local:=New object:C1471()
$response_o.__headers__:=New collection:C1472()

  //#####
  // Methods
  //#####
$response_o.append:=Formula:C1597(RS_append )
$response_o.attachment:=Formula:C1597()
$response_o.cookie:=Formula:C1597()

$response_o.set:=Formula:C1597(RS_set )

$0:=$response_o
