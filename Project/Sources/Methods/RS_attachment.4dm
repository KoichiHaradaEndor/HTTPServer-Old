//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets HTTP response "Content-Disposition"
* header field to "attachement". If optional filename
* parameter is given, it adds Content-Disposition
* "filename" parameter and sets "Content-Type" header
* field using Response.type(). Note it accepts system
* path for filename parameter, not posix path. Also 
* it does not check the validity of the filename.
*
* @param {Text} $1 Filename (optional)
* @return {Object} $0 Request object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$filename_t)
C_OBJECT:C1216($0)

C_TEXT:C284($headerValue_t)
C_OBJECT:C1216($filename_o)

$headerValue_t:="attachment"
If (Count parameters:C259>0)
	
	$filename_t:=$1
	
	$filename_o:=Path to object:C1547($filename_t;Path is system:K24:25)
	$headerValue_t:=$headerValue_t+"; filename=\""+$filename_o.name+$filename_o.extension+"\""
	
	This:C1470.type($filename_o.extension)
	
End if 

This:C1470.set("Content-Disposition";$headerValue_t)

$0:=This:C1470
