//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method takes a text parameter, encode with URL safe Base64, then return it.
* URL safe Base64 is similar with Base64 except,
* no padding "="
* "+" => "-", "/" => "_"
* Charset is fixed to UTF-8.
*
* @param {Text} $1 Text to endcode
* @return {Text} $0 Encoded text
* @author HARADA Koichi
*/

C_TEXT:C284($1;$textToEncode_t)
C_TEXT:C284($0;$encodedText_t)

C_BLOB:C604($blobToEncode_x)
C_LONGINT:C283($position_l)

$textToEncode_t:=$1
$encodedText_t:=""

CONVERT FROM TEXT:C1011($textToEncode_t;"UTF-8";$blobToEncode_x)

BASE64 ENCODE:C895($blobToEncode_x;$encodedText_t)

  // Remove any trailing '='s
$position_l:=Position:C15("=";$encodedText_t;*)
If ($position_l>0)
	
	$encodedText_t:=Substring:C12($encodedText_t;1;$position_l-1)
	
End if 

$encodedText_t:=Replace string:C233($encodedText_t;"+";"-")
$encodedText_t:=Replace string:C233($encodedText_t;"/";"_")

$0:=$encodedText_t
