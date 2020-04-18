//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets response HTTP status code and send its
* text representation as the response body.
*
* @param {Longint} $1 HTTP status code
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_LONGINT:C283($1;$statusCode_l)
C_OBJECT:C1216($0)

C_TEXT:C284($statusText_t)

$statusCode_l:=$1

$statusText_t:=RS_getStatusText ($statusCode_l)

This:C1470.status($statusCode_l).send($statusText_t)

$0:=This:C1470
