//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method creates and returns an SingleRoute object,
* which you can then add handlers subsequently.
* 
* @param {Text} $1 The path for which the callback function is invoked
* @return {Object} SingleRoute object.
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$path_t)
C_OBJECT:C1216($0;$route_o)

$path_t:=$1
$route_o:=New object:C1471()

  //*****
  //* Properties
  //*****

$route_o.__type__:="SingleRoute"
$route_o.host:=This:C1470  // HttpServer, VirtualHost or Router
$route_o.path:=$path_t

  //*****
  //* Methods
  //*****

  // add route to the server
$route_o.all:=Formula:C1597(HS_all )
$route_o.delete:=Formula:C1597(HS_delete )
$route_o.get:=Formula:C1597(HS_get )
$route_o.method:=Formula:C1597(HS_method )
$route_o.post:=Formula:C1597(HS_post )
$route_o.put:=Formula:C1597(HS_put )
$route_o.use:=Formula:C1597(HS_use )

$0:=$route_o