//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method adds route directive to Router object.
  //* 
  //* @author: HARADA Koichi
  //* @param {Text} $1 Request path to handle
  //* @param {Object} $2 Formula object which will be called to handle the request
  //*/

C_TEXT:C284($1;$path_t)
C_OBJECT:C1216($2;$formula_o)

$path_t:=$1
$formula_o:=$2

Use (This:C1470)
	
	Use (This:C1470.route)
		
		This:C1470.route.push(New object:C1471("path";$path_t;"formula";$formula_o))
		
	End use   // Use (This.route)
	
End use   // Use (This)
