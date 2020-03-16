//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method reads HTTPServer configuration from file and extract it to object.
  //* 
  //* @author: HARADA Koichi
  //* @param {Object} $1 Object that receives extracted configurtions. 
  //* @return {Longint} Result code.
  //*/

C_OBJECT:C1216($1;$config_o)
C_LONGINT:C283($0;$resultCode_l)

C_TEXT:C284($configPath_t;$config_t;$aLine_t;$configName_t;$configValue_t)
C_TEXT:C284($databaseFolderPath_t;$propertyName_t)
C_LONGINT:C283($position_l)
C_COLLECTION:C1488($configLines_c)

$config_o:=$1
$resultCode_l:=0

  // Empties config object
For each ($propertyName_t;$config_o)
	
	OB REMOVE:C1226($config_o;$propertyName_t)
	
End for each 

$configPath_t:=Get 4D folder:C485(Database folder:K5:14)+"httpServer.conf"

If (Test path name:C476($configPath_t)#Is a document:K24:1)
	
	$resultCode_l:=Config_does_not_exist
	
Else 
	
	$config_t:=Document to text:C1236($configPath_t;"UTF-8";Document with LF:K24:22)
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
				$position_l:=Position:C15(" ";$aLine_t)
				If ($position_l=0)
					
					$configName_t:=$aLine_t
					
				Else 
					
					$configName_t:=Substring:C12($aLine_t;1;$position_l-1)
					$configValue_t:=Substring:C12($aLine_t;$position_l+1)
					
				End if 
				
				Case of 
					: ($configName_t="DocumentRootStatic") | ($configName_t="DocumentRootDynamic")
						
						If (Position:C15("{Database folder}";$configValue_t)>0)
							
							$databaseFolderPath_t:=Get 4D folder:C485(Database folder:K5:14)
							$databaseFolderPath_t:=Convert path system to POSIX:C1106($databaseFolderPath_t)
							If ($databaseFolderPath_t="@/")
								
								  // Removes last slash ("/")
								$databaseFolderPath_t:=Substring:C12($databaseFolderPath_t;1;Length:C16($databaseFolderPath_t)-1)
								
							End if 
							$configValue_t:=Replace string:C233($configValue_t;"{Database folder}";$databaseFolderPath_t)
							
						End if 
						
						If ($configValue_t="\"@\"")
							
							  // Removes double quotes
							$configValue_t:=Substring:C12($configValue_t;2;Length:C16($configValue_t)-2)
							
						End if 
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="ListenPort") | ($configName_t="ListenSSLPort")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="CharacterSet")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t)
						
					: ($configName_t="HSTSMode")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t="on")
						
					: ($configName_t="HSTSMaxAge") | ($configName_t="MaxRequestSize")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="MaxConcurrentProcess")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="AutoSessionManagement") | ($configName_t="SessionIPAddressValidation")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t="on")
						
					: ($configName_t="SessionProcessTimeout") | ($configName_t="SessionCookieTimeout") | ($configName_t="MaxSession")
						
						OB SET:C1220($config_o;$configName_t;Num:C11($configValue_t))
						
					: ($configName_t="AccessLog") | ($configName_t="DebugLog")
						
						OB SET:C1220($config_o;$configName_t;$configValue_t="on")
						
				End case 
				
		End case 
		
	End for each 
	
End if 
