//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets the HTTP status code for the response.
*
* @param {Longint} $1 Status code
* @return {Object} $0 Response object
* @arthor HARADA Koichi
*/

C_LONGINT:C283($1;$statusCode_l)
C_OBJECT:C1216($0)

C_TEXT:C284($statusText_t)

$statusCode_l:=$1

$statusText_t:=RS_getStatusText ($statusCode_l)

This:C1470.set("X-STATUS";String:C10($statusCode_l)+" "+$statusText_t)

$0:=This:C1470
