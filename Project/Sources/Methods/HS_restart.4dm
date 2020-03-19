//%attributes = {"invisible":true,"preemptive":"capable"}
  //**
  //* This method is called to restart HTTP server.
  //* 
  //* @author: HARADA Koichi
  //* @return {Longint} Result code.
  //*/

C_LONGINT:C283($0;$resultCode_l)

$resultCode_l:=HS_stop ()
$resultCode_l:=HS_start ()

$0:=$resultCode_l
