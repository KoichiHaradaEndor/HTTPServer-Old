//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method loads 4D HTTP server configuration.
  //* 
  //* @author: HARADA Koichi
  //*/

C_OBJECT:C1216($config_o)
C_LONGINT:C283($resultCode_l;$platform_l;$value_l)
C_TEXT:C284($value_t)
C_REAL:C285($value_r)

$config_o:=New object:C1471()
$resultCode_l:=HS_configRead ($config_o)

Case of 
	: ($resultCode_l=Config_does_not_exist)
		
	Else 
		
		  //###
		  //# DocumentRootStatic
		  //###
		If (OB Is defined:C1231($config_o;"DocumentRootStatic"))
			
			$value_t:=$config_o["DocumentRootStatic"]
			WEB SET ROOT FOLDER:C634($value_t)
			
		End if 
		
		  //###
		  //# DocumentRootDynamic
		  //###
		If (OB Is defined:C1231($config_o;"DocumentRootDynamic"))
			
			$value_t:=$config_o["DocumentRootDynamic"]
			
		End if 
		
		  //###
		  //# ListenIPAddress
		  //###
		If (OB Is defined:C1231($config_o;"ListenIPAddress"))
			
			$platform_l:=Application type:C494
			$value_t:=$config_o["ListenIPAddress"]
			If ($platform_l=4D Remote mode:K5:5)
				
				WEB SET OPTION:C1210(Web Client IP address to listen:K73:25;$value_t)
				
			Else 
				
				WEB SET OPTION:C1210(Web IP address to listen:K73:5;$value_t)
				
			End if 
			
		End if 
		
		  //###
		  //# ListenPort
		  //###
		If (OB Is defined:C1231($config_o;"ListenPort"))
			
			$value_r:=$config_o["ListenPort"]
			WEB SET OPTION:C1210(Web Port ID:K73:14;$value_r)
			
		End if 
		
		  //###
		  //# ListenSSLPort
		  //###
		If (OB Is defined:C1231($config_o;"ListenSSLPort"))
			
			$value_r:=$config_o["ListenSSLPort"]
			WEB SET OPTION:C1210(Web HTTPS port ID:K73:10;$value_r)
			
		End if 
		
		  //###
		  //# CharacterSet
		  //###
		If (OB Is defined:C1231($config_o;"CharacterSet"))
			
			$value_t:=$config_o["CharacterSet"]
			WEB SET OPTION:C1210(Web character set:K73:6;$value_t)
			
		End if 
		
		  //###
		  //# HSTSMode
		  //###
		If (OB Is defined:C1231($config_o;"HSTSMode"))
			
			$value_t:=$config_o["HSTSMode"]
			Case of 
				: ($value_t="on")
					WEB SET OPTION:C1210(Web HSTS enabled:K73:26;1)
					
				: ($value_t="off")
					WEB SET OPTION:C1210(Web HSTS enabled:K73:26;0)
					
			End case 
			
		End if 
		
		  //###
		  //# HSTSMaxAge
		  //###
		If (OB Is defined:C1231($config_o;"HSTSMaxAge"))
			
			$value_r:=$config_o["HSTSMaxAge"]
			WEB SET OPTION:C1210(Web HSTS max age:K73:27;$value_r)
			
		End if 
		
		  //###
		  //# MaxRequestSize
		  //###
		If (OB Is defined:C1231($config_o;"MaxRequestSize"))
			
			$value_r:=$config_o["MaxRequestSize"]
			WEB SET OPTION:C1210(Web maximum requests size:K73:8;$value_r)
			
		End if 
		
		  //###
		  //# MaxConcurrentProcess
		  //###
		$value_r:=$config_o["MaxConcurrentProcess"]
		Case of 
			: (OB Is defined:C1231($config_o;"MaxConcurrentProcess")=False:C215)
			: ($value_r>=10) & ($value_r<=32000)
			Else 
				
				$result_t:=$result_t+"MaxConcurrentProcess\tERROR\tThe value must between 10 ~ 32,000.\n"
				
		End case 
		
		  //###
		  //# AutoSessionManagement
		  //###
		$value_t:=$config_o["AutoSessionManagement"]
		Case of 
			: (OB Is defined:C1231($config_o;"AutoSessionManagement")=False:C215)
			: ($value_t="") | ($value_t="on") | ($value_t="off")
			Else 
				
				$result_t:=$result_t+"AutoSessionManagement\tERROR\tThe given value is not supported.\n"
				
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
				
				$result_t:=$result_t+"SessionIPAddressValidation\tERROR\tThe given value is not supported.\n"
				
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
				
				$result_t:=$result_t+"AccessLog\tERROR\tThe given value is not supported.\n"
				
		End case 
		
		  //###
		  //# DebugLog
		  //###
		$value_t:=$config_o["DebugLog"]
		Case of 
			: (OB Is defined:C1231($config_o;"DebugLog")=False:C215)
			: ($value_t="") | ($value_t="Without body") | ($value_t="With response body")
			: ($value_t="With request body") | ($value_t="With all body")
			Else 
				
				$result_t:=$result_t+"DebugLog\tERROR\tThe given value is not supported.\n"
				
		End case 
		
End case 

$0:=Choose:C955($result_t="";"Syntax OK";$result_t)