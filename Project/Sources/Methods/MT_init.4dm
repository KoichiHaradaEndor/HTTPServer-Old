//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method reads MimeType list from file and extract it to collection.
* Using mime.types file distributed by Apache.
* 
* @author: HARADA Koichi
*/

C_TEXT:C284($filePath_t;$content_t;$aLine_t;$mimeType_t;$extension_t)
C_COLLECTION:C1488($mimetypes_c;$configLines_c;$aLine_c;$extensions_c)

Use (Storage:C1525)
	
	If (Storage:C1525.__mimeTypes__=Null:C1517)
		
		Storage:C1525.__mimeTypes__:=New shared collection:C1527()
		
	End if 
	
End use 

$mimetypes_c:=Storage:C1525.__mimeTypes__

  // mime.types file must be placed in database folder of the component 
  // and the file name must be "mime.types".
$filePath_t:=Get 4D folder:C485(Database folder:K5:14)+"mime.types"

If (Test path name:C476($filePath_t)=Is a document:K24:1)
	
	$content_t:=Document to text:C1236($filePath_t;"UTF-8";Document with LF:K24:22)
	$configLines_c:=New collection:C1472()
	$configLines_c:=Split string:C1554($content_t;"\n";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	For each ($aLine_t;$configLines_c)
		
		Case of 
			: (Length:C16($aLine_t)=0)
				  // Empty line
				
			: ($aLine_t[[1]]="#")
				  // Comment line
				
			Else 
				
				  // MimeType and its extensions are seperated with
				  // arbitrary number of tabs, so make it single tab
				While (Position:C15("\t\t";$aLine_t)>0)
					
					$aLine_t:=Replace string:C233($aLine_t;"\t\t";"\t";*)
					
				End while 
				
				$aLine_c:=Split string:C1554($aLine_t;"\t")
				If ($aLine_c.length>=2)
					
					$mimeType_t:=$aLine_c[0]
					$extensions_c:=Split string:C1554($aLine_c[1];Char:C90(Space:K15:42);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
					For each ($extension_t;$extensions_c)
						
						If ($extension_t#"")
							
							$mimetypes_c.push(New shared object:C1526("extension";$extension_t;"mimetype";$mimeType_t))
							
						End if 
						
					End for each 
					
				End if 
				
		End case 
		
	End for each   // For each ($aLine_t;$configLines_c)
	
End if   // If (Test path name($configPath_t)#Is a document)