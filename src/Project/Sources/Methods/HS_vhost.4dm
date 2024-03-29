//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method creates VirtualHost object and return it.
* 
* @param {Text} $1 Host name.
* @return {Object} $0 VirtualHost object.
* @author: HARADA Koichi
*/

C_TEXT:C284($1;$hostname_t)
C_OBJECT:C1216($0;$vhost_o)

C_LONGINT:C283($numHosts_l;$insertionPosition_l)

$hostname_t:=$1
$vhost_o:=New object:C1471()

  //*****
  //* Properties
  //*****

$vhost_o.__type__:="VirtualHost"
$vhost_o.hostname:="^"+$hostname_t+"$"
$vhost_o.routes:=New collection:C1472()

  //*****
  //* Methods
  //*****

  // add route to the server
$vhost_o.all:=Formula:C1597(HS_all )
$vhost_o.delete:=Formula:C1597(HS_delete )
$vhost_o.get:=Formula:C1597(HS_get )
$vhost_o.method:=Formula:C1597(HS_method )
$vhost_o.post:=Formula:C1597(HS_post )
$vhost_o.put:=Formula:C1597(HS_put )
$vhost_o.use:=Formula:C1597(HS_use )
$vhost_o.route:=Formula:C1597(HS_route )

$0:=$vhost_o
