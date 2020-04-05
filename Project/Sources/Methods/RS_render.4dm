//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method renders response text from template 
* and send it.
* 
* The path parameter is the file path to the template.
* It may contain 4D tags (4DTEXT, 4DIF adn so on) that will
* be parsed by PROCESS 4D TAGS command.
*
* The file path accepts POSIX format, relative from
* the path set in"DocumentRootDynamic". It must not
* contain "../" to prevent path traversal, otherwise
* response won't be made.
*
* The Content-Type header is set automatically when the
* template path ends with file extension. When the path
* does not contain extension, you should specify it by calling
* Response.set("Content-Type";"content type") or
* Response.type("file extension or content type").
* 
* Object type second parameter may contain any data that
* you want to pass to PROCESS 4D TAGS command. Then it is
* accesible in the template using $1 directive.
*
* After this function is executed with or without error,
* post process handler function will be called if it is passed.
* If an error had run out, the function receives an error
* collection whose structure is
* [{"message":"error message";"date":"date and time in ISO 8601 format"}].
*
* @param {Text} $1 Path to the template file
* @param {Object} $2 Object that will be passed to PROCESS 4D TAGS (optional)
* @param {Object} $3 Reference to post process handler function (optional)
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$path_t)
C_OBJECT:C1216($2;$locals_o)
C_OBJECT:C1216($3;$callback_o)
C_OBJECT:C1216($0)

C_TEXT:C284($dynamicFolderPath_t;$errorHandler_t;$systemPath_t;$content_t;$mime_t)
C_LONGINT:C283($numParam_l)
C_OBJECT:C1216($folder_o;$filePath_o;$file_o)
C_COLLECTION:C1488($error_c)

  //#####
  // Checks prerequisite
  // Target template MUST be searched from inside of DocumentRootDynamic
  // folder to prevent path traversal.
  //#####

$errorHandler_t:=error_try 

$path_t:=$1

  // The template path MUST not contain "../"
ASSERT:C1129(Position:C15("../";$path_t)=0;Current method name:C684+" : Template path cannot contain \"../\".")

  // Do not use USE statement here because don't want to block other web processes
$dynamicFolderPath_t:=Storage:C1525.__configuration__["DocumentRootDynamic"]

  // DocumentRootDynamic folder MUST not empty string and MUST present
$folder_o:=Folder:C1567(fk database folder:K87:14;*).folder($dynamicFolderPath_t)
ASSERT:C1129($dynamicFolderPath_t#"";Current method name:C684+" : Template path value cannot be empty.")
ASSERT:C1129($folder_o.exists;Current method name:C684+" : DocumentRootDynamic folder must exist.")

  // If template file path starts with "/", remove it
While ($path_t="/@")
	
	$path_t:=Substring:C12($path_t;2)
	
End while 

$file_o:=$folder_o.file($path_t)

$dynamicFolderPath_t:=$folder_o.platformPath
$path_t:=$file_o.platformPath

  // Again make sure the path still inside DocumentRootDynamic folder
ASSERT:C1129(Position:C15($dynamicFolderPath_t;$path_t)=1;Current method name:C684+"Template path is out of DocumentRootDynamic folder.")

  // Make sure the template file present
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
	
	$errorHandler_t:=error_try 
	
	$content_t:=$file_o.getText("UTF-8")
	
	Case of 
		: ($numParam_l=1)
			
			PROCESS 4D TAGS:C816($content_t;$content_t)
			
		: ($numParam_l>=2)
			
			$locals_o:=$2
			PROCESS 4D TAGS:C816($content_t;$content_t;$locals_o)
			
	End case 
	
	This:C1470.type($file_o.extension).send($content_t)
	
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
