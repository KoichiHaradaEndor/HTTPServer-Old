//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sends JSON response.
* The content will be converted JSON string
* by using JSON Stringify command.
* The Content-Type header is set by Resonse.type("json")
*
* @param {Variant} $1 Any value that can be converted to JSON
* @return {Object} $0 Response object
* @author: HARADA Koichi
*/

C_VARIANT:C1683($1)
C_OBJECT:C1216($0)

C_TEXT:C284($response_t)

$response_t:=JSON Stringify:C1217($1)

This:C1470.type("json").send($response_t)

$0:=This:C1470
