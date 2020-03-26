//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method creates RequestHandler object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @return {Object} RequestHandler object.
  //*/

C_OBJECT:C1216($0;$handler_o)

$handler_o:=New shared object:C1526()
Use ($handler_o)
	
	$handler_o.route:=New shared collection:C1527()
	
End use 

$0:=$handler_o
