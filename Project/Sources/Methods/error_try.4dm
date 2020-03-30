//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method installs versatile error handler method.
* It should be called before any processing that may 
* generate error(s).
*
* @author HARADA Koichi
*/

C_OBJECT:C1216(error_o)

error_o:=New object:C1471()

ON ERR CALL:C155("error_handler")
