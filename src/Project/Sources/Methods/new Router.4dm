//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  //%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates Router object and return it.
* 
* @return {Object} $0 Router object.
* @author: HARADA Koichi
*/

C_OBJECT:C1216($0;$router_o)

$router_o:=New object:C1471()

  //#####
  // Properties
  //#####

$router_o.__type__:="Router"
$router_o.routes:=New collection:C1472()

  //#####
  // Methods
  //#####

  // add route to the server
$router_o.all:=Formula:C1597(HS_all )
$router_o.delete:=Formula:C1597(HS_delete )
$router_o.get:=Formula:C1597(HS_get )
$router_o.method:=Formula:C1597(HS_method )
$router_o.post:=Formula:C1597(HS_post )
$router_o.put:=Formula:C1597(HS_put )
$router_o.route:=Formula:C1597(HS_route )
$router_o.use:=Formula:C1597(HS_use )

$0:=$router_o
