//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method takes a text parameter which was encoded with URL safe Base64, then decode it.
* Charset is fixed to UTF-8.
*
* @param {Text} $1 Text to decode
* @return {Text} $0 Decoded text
* @author HARADA Koichi
*/

C_TEXT:C284($1;$textToDecode_t)
C_TEXT:C284($0;$decodedText_t)

C_BLOB:C604($blobToDecode_x)

$textToDecode_t:=$1
$decodedText_t:=""

$textToDecode_t:=Replace string:C233($textToDecode_t;"-";"+")
$textToDecode_t:=Replace string:C233($textToDecode_t;"_";"/")
$textToDecode_t:=$textToDecode_t+("="*(4-(Length:C16($textToDecode_t)%4)))

BASE64 DECODE:C896($textToDecode_t;$blobToDecode_x)

$decodedText_t:=Convert to text:C1012($blobToDecode_x;"UTF-8")

$0:=$decodedText_t
