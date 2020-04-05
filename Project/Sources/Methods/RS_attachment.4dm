//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets HTTP response "Content-Disposition"
* header field to "attachement". If optional filename
* parameter is given, it adds Content-Disposition
* "filename" parameter and sets "Content-Type" header
* field using Response.type(). Note it accepts POSIX
* path for filename parameter, not system path. Also 
* it does not check the validity of the filename.
* Note it does not send file as response. Using
* Response.download function does setting headers
* and sending a file.
*
* @param {Text} $1 Filename (optional)
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$filename_t)
C_OBJECT:C1216($0)

C_TEXT:C284($headerValue_t)
C_OBJECT:C1216($file_o)

$headerValue_t:="attachment"
If (Count parameters:C259>0)
	
	$filename_t:=$1
	
	$file_o:=File:C1566($filename_t)
	$headerValue_t:=$headerValue_t+"; filename=\""+$file_o.fullname+"\""
	
	This:C1470.type($file_o.extension)
	
End if 

This:C1470.set("Content-Disposition";$headerValue_t)

$0:=This:C1470
