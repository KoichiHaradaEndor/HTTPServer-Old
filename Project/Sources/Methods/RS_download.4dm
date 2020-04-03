//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets "Content-Disposition" header value
* to "attachment" and "Content-Type" header value
* according to the file extension specified, then
* send the file.
*
* The file name that appears on browser side is set as
* filename parameter of Content-Disposition. By default
* actual filename is used for this parameter. However
* if its unfavorable (ex. filename is "temp-012345.pdf"),
* it can be overwritten by specifying second filename
* parameter. If it's empty or omitted, then original name
* is used.
*
* The options parameter will be passed to Response.sendFile
* function. So it takes the same parameters. 
*
* After this function is executed with or without error,
* post process handler function will be called if it is passed.
* If an error had run out, the function receives an object
* that contains error message (error.message).
*
* It is equivalent to following call:
* {@code
* Response.attachement() // set headers
* Response.sendFile() // send file
* }
* 
* @param {Text} $1 Absolute file path to send
* @param {Text} $2 Filename used to override actual file name (optional)
* @param {Object} $3 Options to be passed to Response.sendFile() (optional)
* @param {Object} $4 Reference to post process handler function (optional)
* @return {Object} $0 Response object
*/

C_TEXT:C284($1;$path_t)
C_TEXT:C284($2;$filename_t)
C_OBJECT:C1216($3;$options_o)
C_OBJECT:C1216($4;$callback_o)
C_OBJECT:C1216($0)

C_LONGINT:C283($numParam_l)

$numParam_l:=Count parameters:C259

$path_t:=$1

If ($numParam_l>=2)
	
	$filename_t:=$2
	
Else 
	
	$filename_t:=""
	
End if 

If ($numParam_l>=3)
	
	$options_o:=$3
	
Else 
	
	$options_o:=Null:C1517
	
End if 

If ($numParam_l>=4)
	
	$callback_o:=$4
	
Else 
	
	$callback_o:=Null:C1517
	
End if 

  // sets Content-Disposition and Content-Type headers
This:C1470.attachement(Choose:C955($filename_t="";$path_t;$filename_t))
This:C1470.sendFile($path_t;$options_o;$callback_o)

$0:=This:C1470
