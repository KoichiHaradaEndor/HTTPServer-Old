//%attributes = {}
/*********************
* This does not work.
**********************/


C_TEXT:C284($message_t)
C_TEXT:C284($key_t)
C_LONGINT:C283($algorithm_l)
C_TEXT:C284($hmac_t)

C_BLOB:C604($key_x;$ipadKey_x;$opadKey_x;$message_x;$firstDigest_x)
C_LONGINT:C283($keyLength_l;$realKeyLength_l;$i)
C_TEXT:C284($firstDigest_t)

$message_t:="what do ya want for nothing?"
$key_t:="Jefe"
$algorithm_l:=MD5 digest:K66:1

Case of 
	: ($algorithm_l=SHA256 digest:K66:4)
		$keyLength_l:=64
		
End case 

CONVERT FROM TEXT:C1011($message_t;"UTF-8";$message_x)
CONVERT FROM TEXT:C1011($key_t;"UTF-8";$key_x)

  // Key preprocess
If (BLOB size:C605($key_x)>$keyLength_l)
	
	  // When the given key length is greater than recommended key length,
	  // calculate hash
	$key_t:=Generate digest:C1147($key_x;$algorithm_l)
	CONVERT FROM TEXT:C1011($key_t;"UTF-8";$key_x)
	
End if 

SET BLOB SIZE:C606($key_x;$keyLength_l;0x0000)
COPY BLOB:C558($key_x;$ipadKey_x;0;0;$keyLength_l)
COPY BLOB:C558($key_x;$opadKey_x;0;0;$keyLength_l)

For ($i;0;$keyLength_l-1)
	
	$ipadKey_x{$i}:=$ipadKey_x{$i} ^| 0x0036
	$opadKey_x{$i}:=$opadKey_x{$i} ^| 0x005C
	
End for 

  // The first hash
  // H(K XOR ipad, M)
COPY BLOB:C558($message_x;$ipadKey_x;0;BLOB size:C605($ipadKey_x);BLOB size:C605($message_x))
$firstDigest_t:=Generate digest:C1147($ipadKey_x;$algorithm_l)
CONVERT FROM TEXT:C1011($firstDigest_t;"UTF-8";$firstDigest_x)

  // The second digest
  // H(K XOR opad, FirstDigest)
COPY BLOB:C558($firstDigest_x;$opadKey_x;0;BLOB size:C605($opadKey_x);BLOB size:C605($firstDigest_x))
$hmac_t:=Generate digest:C1147($opadKey_x;$algorithm_l)

ASSERT:C1129($hmac_t="5bdcc146bf60754e6a042426089575c7\n5a003f089d2739839dec58b964ec3843")