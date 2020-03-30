//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns true if error occured
* after calling error_try method.
*
* @return {Boolean} $0 true: error had occured, otherwise false
* @author HARADA Koichi
*/

C_BOOLEAN:C305($0;$result_b)

C_OBJECT:C1216(error_o)

$result_b:=False:C215
Case of 
	: (OB Is defined:C1231(error_o)=False:C215)
		
	: (OB Is defined:C1231(error_o;"message")=False:C215)
		
	Else 
		
		$result_b:=True:C214
		
End case 

$0:=$result_b
