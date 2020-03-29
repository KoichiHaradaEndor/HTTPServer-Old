//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method loads 4D HTTP server configuration.
  //* 
  //* @author: HARADA Koichi
  //*/

C_OBJECT:C1216($config_o)
C_LONGINT:C283($platform_l;$value_l)
C_TEXT:C284($value_t)
C_REAL:C285($value_r)

$config_o:=HS_configRead 

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
	
	$value_l:=Trunc:C95($config_o["ListenPort"];0)
	If ($value_l#0)
		
		WEB SET OPTION:C1210(Web Port ID:K73:14;$value_l)
		
	End if 
	
End if 

  //###
  //# ListenSSLPort
  //###
If (OB Is defined:C1231($config_o;"ListenSSLPort"))
	
	$value_l:=Trunc:C95($config_o["ListenSSLPort"];0)
	If ($value_l#0)
		
		WEB SET OPTION:C1210(Web HTTPS port ID:K73:10;$value_l)
		
	End if 
	
End if 

  //###
  //# CharacterSet
  //###
If (OB Is defined:C1231($config_o;"CharacterSet"))
	
	$value_t:=$config_o["CharacterSet"]
	If ($value_t#"")
		
		WEB SET OPTION:C1210(Web character set:K73:6;$value_t)
		
	End if 
	
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
If (OB Is defined:C1231($config_o;"MaxConcurrentProcess"))
	
	$value_r:=$config_o["MaxConcurrentProcess"]
	WEB SET OPTION:C1210(Web max concurrent processes:K73:7;$value_r)
	
End if 

  //###
  //# AutoSessionManagement
  //###
If (OB Is defined:C1231($config_o;"AutoSessionManagement"))
	
	$value_t:=$config_o["AutoSessionManagement"]
	Case of 
		: ($value_t="on")
			WEB SET OPTION:C1210(Web keep session:K73:1;1)
			
		: ($value_t="off")
			WEB SET OPTION:C1210(Web keep session:K73:1;0)
			
	End case 
	
End if 

  //###
  //# SessionProcessTimeout
  //###
If (OB Is defined:C1231($config_o;"SessionProcessTimeout"))
	
	$value_r:=$config_o["SessionProcessTimeout"]
	WEB SET OPTION:C1210(Web inactive process timeout:K73:13;$value_r)
	
End if 

  //###
  //# SessionCookieTimeout
  //###
If (OB Is defined:C1231($config_o;"SessionCookieTimeout"))
	
	$value_r:=$config_o["SessionCookieTimeout"]
	WEB SET OPTION:C1210(Web inactive session timeout:K73:3;$value_r)
	
End if 

  //###
  //# MaxSession
  //###
If (OB Is defined:C1231($config_o;"MaxSession"))
	
	$value_r:=$config_o["MaxSession"]
	WEB SET OPTION:C1210(Web max sessions:K73:2;$value_r)
	
End if 

  //###
  //# SessionCookieName
  //###
If (OB Is defined:C1231($config_o;"SessionCookieName"))
	
	$value_t:=$config_o["SessionCookieName"]
	If ($value_t#"")
		
		WEB SET OPTION:C1210(Web session cookie name:K73:4;$value_t)
		
	End if 
	
End if 

  //###
  //# SessionIPAddressValidation
  //###
If (OB Is defined:C1231($config_o;"SessionIPAddressValidation"))
	
	$value_t:=$config_o["SessionIPAddressValidation"]
	Case of 
		: ($value_t="on")
			WEB SET OPTION:C1210(Web Session IP address validation enabled:K73:17;1)
			
		: ($value_t="off")
			WEB SET OPTION:C1210(Web Session IP address validation enabled:K73:17;0)
			
	End case 
	
End if 

  //###
  //# AccessLog
  //###
If (OB Is defined:C1231($config_o;"AccessLog"))
	
	$value_t:=$config_o["AccessLog"]
	WEB SET OPTION:C1210(Web log recording:K73:9;$value_t)
	
End if 

  //###
  //# DebugLog
  //###
If (OB Is defined:C1231($config_o;"DebugLog"))
	
	$value_t:=$config_o["DebugLog"]
	WEB SET OPTION:C1210(Web debug log:K73:18;$value_t)
	
End if 
