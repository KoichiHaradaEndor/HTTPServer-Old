//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method throws an error.
*
* @author HARADA Koichi
*/

C_TEXT:C284($1;$errorMessage_t)

C_OBJECT:C1216(error_o)

$errorMessage_t:=$1

error_o:=new Error ($errorMessage_t)
