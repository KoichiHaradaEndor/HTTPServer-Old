//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  //**
  //* This method creates Request object and return it.
  //* 
  //* @author: HARADA Koichi
  //* @return {Object} Request object.
  //*/

C_OBJECT:C1216($0;$request_o)

C_LONGINT:C283($i)

$request_o:=New object:C1471()

  // Retrieves request header information
ARRAY TEXT:C222($headerNames_at;0)
ARRAY TEXT:C222($headerValues_at;0)
WEB GET HTTP HEADER:C697($headerNames_at;$headerValues_at)

$request_o.headers:=New collection:C1472()
For ($i;1;Size of array:C274($headerNames_at))
	
	$request_o.headers.push(New object:C1471($headerNames_at{$i};$headerValues_at{$i}))
	
End for 

  // Retrieves query parameters and/or posted data
ARRAY TEXT:C222($dataNames_at;0)
ARRAY TEXT:C222($dataValues_at;0)
WEB GET VARIABLES:C683($dataNames_at;$dataValues_at)

$request_o.data:=New collection:C1472()
For ($i;1;Size of array:C274($dataNames_at))
	
	$request_o.data.push(New object:C1471($dataNames_at{$i};$dataValues_at{$i}))
	
End for 

$0:=$request_o
