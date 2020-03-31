//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method installs versatile error handler method.
* It should be called before any code that may 
* generate error.
*
* @author HARADA Koichi
*/

C_OBJECT:C1216(error_o)

error_o:=Null:C1517

ON ERR CALL:C155("error_handler")
