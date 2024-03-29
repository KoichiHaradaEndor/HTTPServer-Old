//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method tests if configuration names and values are valid.
* It returns "Syntax OK" when there're no errors or warnings,
* otherwise it returns text that describes what are wrong.
* 
* @return {Text} $0 The result of the test
* @author: HARADA Koichi
*/

C_TEXT:C284($0;$result_t)

C_OBJECT:C1216($config_o)
C_TEXT:C284($value_t;$pattern_t;$resultCode_t)
C_REAL:C285($value_r)
C_BOOLEAN:C305($match_b)

$config_o:=Config_read 
$result_t:=""

  //###
  //# Test the config file existence
  //###
$resultCode_t:=$config_o.resultCode
Case of 
	: ($resultCode_t=Storage:C1525.messages.configDoesNotExist)
		
		$result_t:=$result_t+"ERROR\t\tConfig file does not exist.\n"
		
	: ($resultCode_t="")
		
		  //###
		  //# DocumentRootStatic
		  //###
		$value_t:=$config_o["DocumentRootStatic"]
		Case of 
			: (OB Is defined:C1231($config_o;"DocumentRootStatic")=False:C215)
				$result_t:=$result_t+"WARNING\tDocumentRootStatic\tDefining root folder is strongly recommended.\n"
				
			: ($value_t="")
				$result_t:=$result_t+"WARNING\tDocumentRootStatic\tDefining root folder is strongly recommended.\n"
				
			: (Folder:C1567(fk database folder:K87:14;*).folder($value_t).exists=False:C215)
				$result_t:=$result_t+"WARNING\tDocumentRootStatic\tThe folder does not exist.\n"
				
		End case 
		
		  //###
		  //# DocumentRootDynamic
		  //###
		$value_t:=$config_o["DocumentRootDynamic"]
		Case of 
			: (OB Is defined:C1231($config_o;"DocumentRootDynamic")=False:C215)
				
			: ($value_t="")
				
			: (Folder:C1567(fk database folder:K87:14;*).folder($value_t).exists=False:C215)
				$result_t:=$result_t+"WARNING\tDocumentRootDynamic\tThe folder does not exist.\n"
				
		End case 
		
		  //###
		  //# ListenIPAddress
		  //###
		$value_t:=$config_o["ListenIPAddress"]
		Case of 
			: (OB Is defined:C1231($config_o;"ListenIPAddress")=False:C215)
				
			: ($value_t="") | ($value_t="0.0.0.0")
				
			Else 
				
				  // IPv4
				$pattern_t:="(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"
				$match_b:=Match regex:C1019($pattern_t;$value_t;1)
				If ($match_b=False:C215)
					
					$pattern_t:="::|(?:[0-9a-fA-F]{1,4}:){1,7}:|:(?::[0-9a-fA-F]{1,4}){1,7}|(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}"
					$match_b:=Match regex:C1019($pattern_t;$value_t;1)
					
					If ($match_b=False:C215)
						
						$result_t:=$result_t+"ERROR\tListenIPAddress\tThe value is not valid.\n"
						
					End if 
					
				End if 
				
		End case 
		
		  //###
		  //# ListenPort
		  //###
		$value_r:=$config_o["ListenPort"]
		Case of 
			: (OB Is defined:C1231($config_o;"ListenPort")=False:C215)
				
			: ($value_r=0)
				
		End case 
		
		  //###
		  //# ListenSSLPort
		  //###
		$value_r:=$config_o["ListenSSLPort"]
		Case of 
			: (OB Is defined:C1231($config_o;"ListenSSLPort")=False:C215)
				
			: ($value_r=0)
				
		End case 
		
		  //###
		  //# CharacterSet
		  //###
		$value_t:=$config_o["CharacterSet"]
		Case of 
			: (OB Is defined:C1231($config_o;"CharacterSet")=False:C215)
			: ($value_t="") | ($value_t="ISO-8859-1") | ($value_t="ISO-8859-9")
			: ($value_t="ISO-8859-10") | ($value_t="Shift_JIS") | ($value_t="Windows-31J")
			: ($value_t="Big5") | ($value_t="euc-kr") | ($value_t="UTF-8")
			: ($value_t="Windows-1250") | ($value_t="Windows-1251") | ($value_t="Windows-1253")
			: ($value_t="Windows-1255") | ($value_t="Windows-1256") | ($value_t="x-mac-japanese")
			Else 
				
				$result_t:=$result_t+"ERROR\tCharacterSet\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# HSTSMode
		  //###
		$value_t:=$config_o["HSTSMode"]
		Case of 
			: (OB Is defined:C1231($config_o;"HSTSMode")=False:C215)
			: ($value_t="") | ($value_t="on") | ($value_t="off")
			Else 
				
				$result_t:=$result_t+"ERROR\tHSTSMode\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# HSTSMaxAge
		  //###
		$value_r:=$config_o["HSTSMaxAge"]
		Case of 
			: (OB Is defined:C1231($config_o;"HSTSMaxAge")=False:C215)
				
			Else 
				
		End case 
		
		  //###
		  //# MaxRequestSize
		  //###
		$value_r:=$config_o["MaxRequestSize"]
		Case of 
			: (OB Is defined:C1231($config_o;"MaxRequestSize")=False:C215)
			: ($value_r>=500000) & ($value_r<=2147483648)
			Else 
				
				$result_t:=$result_t+"ERROR\tMaxRequestSize\tThe value must between 500,000 ~ 2,147,483,648 bytes.\n"
				
		End case 
		
		  //###
		  //# MaxConcurrentProcess
		  //###
		$value_r:=$config_o["MaxConcurrentProcess"]
		Case of 
			: (OB Is defined:C1231($config_o;"MaxConcurrentProcess")=False:C215)
			: ($value_r>=10) & ($value_r<=32000)
			Else 
				
				$result_t:=$result_t+"ERROR\tMaxConcurrentProcess\tThe value must between 10 ~ 32,000.\n"
				
		End case 
		
		  //###
		  //# AutoSessionManagement
		  //###
		$value_t:=$config_o["AutoSessionManagement"]
		Case of 
			: (OB Is defined:C1231($config_o;"AutoSessionManagement")=False:C215)
			: ($value_t="") | ($value_t="on") | ($value_t="off")
			Else 
				
				$result_t:=$result_t+"ERROR\tAutoSessionManagement\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# SessionProcessTimeout
		  //###
		$value_r:=$config_o["SessionProcessTimeout"]
		Case of 
			: (OB Is defined:C1231($config_o;"SessionProcessTimeout")=False:C215)
				
			Else 
				
		End case 
		
		  //###
		  //# SessionCookieTimeout
		  //###
		$value_r:=$config_o["SessionCookieTimeout"]
		Case of 
			: (OB Is defined:C1231($config_o;"SessionCookieTimeout")=False:C215)
				
			Else 
				
		End case 
		
		  //###
		  //# MaxSession
		  //###
		$value_r:=$config_o["MaxSession"]
		Case of 
			: (OB Is defined:C1231($config_o;"MaxSession")=False:C215)
				
			Else 
				
		End case 
		
		  //###
		  //# SessionCookieName
		  //###
		$value_t:=$config_o["SessionCookieName"]
		Case of 
			: (OB Is defined:C1231($config_o;"SessionCookieName")=False:C215)
				
			Else 
				
		End case 
		
		  //###
		  //# SessionIPAddressValidation
		  //###
		$value_t:=$config_o["SessionIPAddressValidation"]
		Case of 
			: (OB Is defined:C1231($config_o;"SessionIPAddressValidation")=False:C215)
			: ($value_t="") | ($value_t="on") | ($value_t="off")
			Else 
				
				$result_t:=$result_t+"ERROR\tSessionIPAddressValidation\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# AccessLog
		  //###
		$value_t:=$config_o["AccessLog"]
		Case of 
			: (OB Is defined:C1231($config_o;"AccessLog")=False:C215)
			: ($value_t="") | ($value_t="off") | ($value_t="CLF")
			: ($value_t="DLF") | ($value_t="ELF") | ($value_t="WLF")
			Else 
				
				$result_t:=$result_t+"ERROR\tAccessLog\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# DebugLog
		  //###
		$value_t:=$config_o["DebugLog"]
		Case of 
			: (OB Is defined:C1231($config_o;"DebugLog")=False:C215)
			: ($value_t="") | ($value_t="Without body") | ($value_t="With response body")
			: ($value_t="With request body") | ($value_t="With all body") | ($value_t="off")
			Else 
				
				$result_t:=$result_t+"ERROR\tDebugLog\tThe given value is not supported.\n"
				
		End case 
		
End case 

$0:=Choose:C955($result_t="";"Syntax OK";$result_t)
