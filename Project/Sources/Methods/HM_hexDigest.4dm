//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns HMAC digest.
* Currently it works on macOS only.
*
* @return {Text} Digest text
* @author HARADA Koichi
*/

C_TEXT:C284($0;$hmac_t)

C_TEXT:C284($message_t;$key_t;$algorithm_t;$command_t;$error_t)
C_LONGINT:C283($length_l)

Case of 
	: (This:C1470.data.message=Null:C1517)
	: (This:C1470.data.key=Null:C1517)
	: (This:C1470.data.key="")
	: (This:C1470.data.algorithm=Null:C1517)
	: (This:C1470.data.algorithm="")
	Else 
		
		$message_t:=This:C1470.data.message
		$key_t:=This:C1470.data.key
		$algorithm_t:=This:C1470.data.algorithm
		
		Case of 
			: (Is macOS:C1572)
				
				$command_t:="openssl dgst -"+$algorithm_t+" -hmac \""+$key_t+"\""
				LAUNCH EXTERNAL PROCESS:C811($command_t;$message_t;$hmac_t;$error_t)
				
				  // remove last linefeed
				$length_l:=Length:C16($hmac_t)
				Case of 
					: ($length_l=0)
					: ($hmac_t[[$length_l]]="\n")
						
						$hmac_t:=Substring:C12($hmac_t;1;$length_l-1)
						
				End case 
				
				If ($error_t="") & (Length:C16($hmac_t)#0)
					
					$0:=$hmac_t
					
				End if 
				
			: (Is Windows:C1573)
				
				
		End case 
		
End case 
