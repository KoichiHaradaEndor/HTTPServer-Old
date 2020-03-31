//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns true if error was generated
* after calling error_try method.
*
* @return {Boolean} $0 true: error had occured, otherwise false
* @author HARADA Koichi
*/

C_BOOLEAN:C305($0;$result_b)

C_OBJECT:C1216(error_o)

$result_b:=False:C215
Case of 
	: (error_o=Null:C1517)
		
	: (error_o.message=Null:C1517)
		
	Else 
		
		$result_b:=True:C214
		
End case 

$0:=$result_b
