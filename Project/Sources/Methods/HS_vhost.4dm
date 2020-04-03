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

$hostname_t:=$1
$vhost_o:=New object:C1471()

  //*****
  //* Properties
  //*****

$vhost_o.__type__:="VirtualHost"
$vhost_o.hostname:=$hostname_t
$vhost_o.routes:=New shared collection:C1527()

  //*****
  //* Methods
  //*****

  // add route to the server
$vhost_o.all:=Formula:C1597(HS_all )
$vhost_o.delete:=Formula:C1597(HS_delete )
$vhost_o.get:=Formula:C1597(HS_get )
$vhost_o.post:=Formula:C1597(HS_post )
$vhost_o.put:=Formula:C1597(HS_put )
$vhost_o.route:=Formula:C1597(HS_route )
$vhost_o.use:=Formula:C1597(HS_use )

$0:=$vhost_o
