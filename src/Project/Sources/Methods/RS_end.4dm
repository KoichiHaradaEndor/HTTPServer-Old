//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to end the response process.
* Use this method when no data is sent as response body
* but only headers are sent.
*
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($response_t)

$response_t:=""
This:C1470.send($response_t)

$0:=This:C1470
