//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns MimeType text that corrensponds
* to the gives file extension.
*
* @param {Text} $1 File extension
* @return {Text} $0 MimeType
* @author HARADA Koichi
*/

C_TEXT:C284($1;$extension_t)
C_TEXT:C284($0;$mimetype_t)

C_COLLECTION:C1488($queryResult_c)

$extension_t:=$1
$mimetype_t:=""

If (Storage:C1525.__mimeTypes__=Null:C1517)
	
	MT_init 
	
End if 

Case of 
	: (Length:C16($extension_t)=0)
		
	: ($extension_t[[1]]#".")
		
	Else 
		
		  // removes the first period.
		$extension_t:=Substring:C12($extension_t;2)
		
End case 

$queryResult_c:=Storage:C1525.__mimeTypes__.query("extension = :1";$extension_t)
If ($queryResult_c.length=1)
	
	$mimetype_t:=$queryResult_c[0].mimetype
	
End if 

$0:=$mimetype_t
