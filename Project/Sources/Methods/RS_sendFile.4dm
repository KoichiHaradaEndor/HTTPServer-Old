//%attributes = {"invisible":true,"preemptive":"capable"}
/*
* This method send the file at the given path.
* Content-Type header will be set based on the file extension
* if it is not previously set (when calling Response.download
* function is the case).
*
* The file path accepts POSIX format, relative from
* the path set in"DocumentRootDynamic".It must not
* contain "../" to prevent path traversal,  otherwise
* response won't be made.
*
* The optional options parameter can have following attributes:
* <h3>maxAge</h3>
* Longint
* Sets the max-age property of the Cache-Control header in second.
* Defaults to 0.
*
* <h3>lastModified</h3>
* Boolean
* If true, sets the Last-Modified header to the last modified
* date and time on the OS. Defaults to true.
* 
* <h3>headers</h3>
* Object
* Object containing HTTP headers to serve with the file.
*
* <h3>immutable</h3>
* Boolean
* Enables or disables immutable directive in Cache-Control
* header. When enabled by passing true, maxAge option should
* be specified. Defaults to false.
*
* After this function is executed with or without error,
* post process handler function will be called if it is passed.
* If an error had run out, the function receives an error
* collection whose structure is
* [{"message":"error message";"date":"date and time in ISO 8601 format"}].
*
* @param {Text} $1 Path to the file to be sent
* @param {Object} $2 Options (optional)
* @param {Object} $3 Reference to post process handler function (optional)
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$path_t)
C_OBJECT:C1216($2;$options_o)
C_OBJECT:C1216($3;$callback_o)
C_OBJECT:C1216($0)

C_TEXT:C284($errorHandler_t;$dynamicFolderPath_t;$systemPath_t;$headerValue_t;$attName_t)
C_LONGINT:C283($numParam_l)
C_OBJECT:C1216($callback_o;$filePath_o;$formula_o;$file_o;$folder_o)
C_COLLECTION:C1488($error_c)

  //#####
  // Checks prerequisite
  // Target file MUST be searched from inside of DocumentRootDynamic
  // folder to prevent path traversal.
  //#####
$errorHandler_t:=error_try 

$path_t:=$1

  // The file path MUST not contain "../"
ASSERT:C1129(Position:C15("../";$path_t)=0;Current method name:C684+" : File path cannot contain \"../\".")

  // Do not use USE statement here because don't want to block other web processes
$dynamicFolderPath_t:=Storage:C1525.__configuration__["DocumentRootDynamic"]

  // DocumentRootDynamic folder MUST not empty string and MUST present
$folder_o:=Folder:C1567(fk database folder:K87:14;*).folder($dynamicFolderPath_t)
ASSERT:C1129($dynamicFolderPath_t#"";Current method name:C684+" : Template path value cannot be empty.")
ASSERT:C1129($folder_o.exists;Current method name:C684+" : DocumentRootDynamic folder must exist.")

  // If file path starts with "/", remove it
While ($path_t="/@")
	
	$path_t:=Substring:C12($path_t;2)
	
End while 

$file_o:=$folder_o.file($path_t)

$dynamicFolderPath_t:=$folder_o.platformPath
$path_t:=$file_o.platformPath

  // Again make sure the path still inside DocumentRootDynamic folder
ASSERT:C1129(Position:C15($dynamicFolderPath_t;$path_t)=1;Current method name:C684+"File path is out of DocumentRootDynamic folder.")

  // Make sure the file present
ASSERT:C1129($file_o.exists;Current method name:C684+"Template file cannot be found.")

$numParam_l:=Count parameters:C259
If (error_catch ($errorHandler_t))
	
	If ($numParam_l>=3)
		
		$callback_o:=$3
		$error_c:=error_get 
		$callback_o.call(Null:C1517;$error_c)
		
	End if 
	
Else 
	
	  // Prerequisite passed
	
	  // Sets Content-Type header if it's not previously set
	If (This:C1470.get("Content-Type")="")
		
		If ($file_o.extension#"")
			
			This:C1470.type($file_o.extension)
			
		End if 
		
	End if 
	
	  // Set options
	If ($numParam_l>=2)
		
		$options_o:=$2
		
		If ($options_o.maxAge#Null:C1517)
			
			$headerValue_t:="max-age="+String:C10($options_o.maxAge)
			
			Case of 
				: ($options_o.immutable=Null:C1517)
				: ($options_o.immutable=False:C215)
				Else 
					
					$headerValue_t:=$headerValue_t+", immutable"
					
			End case 
			
			This:C1470.set("Cache-Control";$headerValue_t)
			
		End if 
		
		Case of 
			: ($options_o.lastModified=Null:C1517)
			: ($options_o.lastModified=False:C215)
			Else 
				
				$headerValue_t:=String:C10($file_o.modificationDate;Date RFC 1123:K1:11;Time:C179($file_o.modificationTime))
				This:C1470.set("Last-Modified";$headerValue_t)
				
		End case 
		
		If ($options_o.headers#Null:C1517)
			
			For each ($attName_t;$options_o.headers)
				
				This:C1470.set($attName_t;$options_o[$attName_t])
				
			End for each 
			
		End if 
		
	End if 
	
	  // Set http headers
	$formula_o:=Formula:C1597(RS_setHeaders )
	$formula_o.call(This:C1470)
	
	  // Then send the file
	  // It seems WEB SEND FILE command now accepts
	  // absolute path that points outside of
	  // HTML root folder set in 4D preferences.
	$errorHandler_t:=error_try 
	WEB SEND FILE:C619($path_t)
	
	If (error_catch ($errorHandler_t))
		
		If ($numParam_l>=3)
			
			$callback_o:=$3
			$error_c:=error_get 
			$callback_o.call(Null:C1517;$error_c)
			
		End if 
		
	Else 
		
		If ($numParam_l>=3)
			
			$callback_o:=$3
			$callback_o.call(Null:C1517)
			
		End if 
		
	End if 
	
End if 

$0:=This:C1470
