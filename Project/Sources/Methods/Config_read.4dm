//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method reads HTTPServer configuration from file and extract it to object.
* 
* @return {Object} $0 The configuration that was read from file
* @author: HARADA Koichi
*/

C_OBJECT:C1216($0;$config_o)

C_OBJECT:C1216($configFile_o)

$config_o:=New object:C1471()

  // Configuration file must be placed in database folder of the host application
  // and the file name must be "httpServer.conf".
$configFile_o:=Folder:C1567(fk database folder:K87:14;*).file("httpServer.conf")

If ($configFile_o.exists=False:C215)
	
	$config_o.resultCode:=Storage:C1525.messages.configDoesNotExist
	
Else 
	
	$config_o.resultCode:=""
	
	$config_t:=$configFile_o.getText("UTF-8";Document with LF:K24:22)
	$configLines_c:=New collection:C1472()
	$configLines_c:=Split string:C1554($config_t;"\n";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	For each ($aLine_t;$configLines_c)
		
		Case of 
			: (Length:C16($aLine_t)=0)
				  // Empty line
				
			: ($aLine_t[[1]]="#")
				  // Comment line
				
			Else 
				
				$configName_t:=""
				$configValue_t:=""
				
				$space_t:=Char:C90(Space:K15:42)
				$position_l:=Position:C15($space_t;$aLine_t)
				If ($position_l=0)
					
					$configName_t:=$aLine_t
					
				Else 
					
					$configName_t:=Substring:C12($aLine_t;1;$position_l-1)
					$configValue_t:=Substring:C12($aLine_t;$position_l+1)
					
				End if 
				
				Case of 
					: ($configName_t="DocumentRootStatic") | ($configName_t="DocumentRootDynamic")
						
						  // If configValue starts with "/", remove it.
						While ($configValue_t="/@")
							
							$configValue_t:=Substring:C12($configValue_t;2)
							
						End while 
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="ListenPort") | ($configName_t="ListenSSLPort")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="CharacterSet")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="HSTSMode")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="HSTSMaxAge") | ($configName_t="MaxRequestSize")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="MaxConcurrentProcess")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="AutoSessionManagement") | ($configName_t="SessionIPAddressValidation")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="SessionProcessTimeout") | ($configName_t="SessionCookieTimeout") | ($configName_t="MaxSession")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="AccessLog") | ($configName_t="DebugLog")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
				End case 
				
		End case 
		
	End for each   // For each ($aLine_t;$configLines_c)
	
End if   // If (Test path name($configPath_t)#Is a document)

$0:=$config_o
