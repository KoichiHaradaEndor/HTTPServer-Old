//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/**
* This method creates and return HMAC object.
* 
* For digest parameter, only "sha256" (SHA256 digest) or
* "sha512" (SHA512 digest) are supported.
*
* @param {Text} $1 Message to hash
* @param {Text} $2 Key
* @param {Variant} $3 Digest algorithm SHA256 and SHA512 can be used
* @return {Object} $0 HMAC object
* @author: HARADA Koichi
*/

C_TEXT:C284($1)  //Message
C_TEXT:C284($2)  // Key
C_VARIANT:C1683($3)  // Algorithm
C_OBJECT:C1216($0;$hmac_o)

C_LONGINT:C283($numParam_l)

$hmac_o:=New object:C1471()
$numParam_l:=Count parameters:C259

  //#####
  // Methods
  //#####

$hmac_o.algorithm:=Formula:C1597(HM_algorithm )
$hmac_o.hexDigest:=Formula:C1597(HM_hexDigest )
$hmac_o.message:=Formula:C1597(HM_message )
$hmac_o.key:=Formula:C1597(HM_key )

  //#####
  // Properties
  //#####
$hmac_o.data:=New object:C1471()

If ($numParam_l>=1)
	
	$hmac_o.message($1)
	
End if 

If ($numParam_l>=2)
	
	$hmac_o.key($2)
	
End if 

If ($numParam_l>=3)
	
	$hmac_o.algorithm($3)
	
End if 

$0:=$hmac_o
