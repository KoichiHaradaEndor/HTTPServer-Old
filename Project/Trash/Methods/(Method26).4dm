//%attributes = {}
  //$pattern_t:="^(?:.*?)(?:\\?.*)+(?:#.*)?$"
$pattern_t:="^(.+)\\[(.*)\\]$"
$path_t:="abc[ddd]"
ARRAY LONGINT:C221($pos_al;0)
ARRAY LONGINT:C221($len_al;0)
$matched_b:=Match regex:C1019($pattern_t;$path_t;1;$pos_al;$len_al)

$msg_t:="mached: "+String:C10($matched_b)+"\r"
If (Size of array:C274($pos_al)>0)
	
	$msg_t:=$msg_t+"1: "+Substring:C12($path_t;$pos_al{1};$len_al{1})+"\r"
	
	If (Size of array:C274($pos_al)>1)
		
		$msg_t:=$msg_t+"2: "+Substring:C12($path_t;$pos_al{2};$len_al{2})
		
	End if 
	
End if 

ALERT:C41($msg_t)
